require 'rubygems'
require 'rmodbus'
require 'websocket-client-simple'
require 'json'
require 'active_record'
require 'mysql2'
require './app/models/application_record'
require './app/models/product_tank'
require './app/models/tank_log'

LOG = false

def connect_websocket
  WebSocket::Client::Simple.connect('ws://127.0.0.1:3001/cable')
end

def subscribe_channel(ws)
  ws.on :open do
    ws.send({"command":"subscribe","identifier":"{\"channel\":\"ModbusChannel\"}"}.to_json)
  end
end

def send_message(ws, action, value)
  message = {
    command: 'message',
    identifier: '{"channel":"ModbusChannel"}',
    data: {
      action: action,
      value: value
    }.to_json
  }

  ws.send(message.to_json)
end

def close_open_files
  ObjectSpace.each_object(File) do |file|
    file.close unless file.closed?
  end
end

is_start = false

while true
  begin
    ws = connect_websocket

    subscribe_channel(ws)


    loop do
      digital = ""
      analog = Array.new

      begin
        ModBus::TCPClient.connect("192.168.20.10", 502) do |cl|
          cl.with_slave(1) do |slave|
            slave.debug = false
            regs = slave.holding_registers

            i = 3

            puts "Modbus Value: #{regs[0..i]}" if LOG

            ( i + 1 ).times do |index|
              digital += regs[index][0].to_i.to_s(2).rjust(16,'0').reverse
            end

            puts "DIGITAL: #{digital}" if LOG

            i = 100
            3.times do
              analog << regs[i][0].to_i
              i += 1
            end
            puts "ANALOG: #{analog}" if LOG

            # start serial number with product tank
            # start serial number with product tank
            # start serial number with product tank
            # start serial number with product tank
            # start serial number with product tank
            ActiveRecord::Base.establish_connection(
              :adapter  => "mysql2",
              :host     => "127.0.0.1",
              :port     => 33306,
              :username => "root",
              :password => "98010~!@",
              :database => "psg-dma"
            )

            is_start = false if digital[7].to_i == 0


            if digital[7].to_i == 1 && is_start == false
              is_start = true
              i = 200
              serial = regs[i..i+7]
              # 배열의 각 요소를 16진수로 변환하여 문자열로 합치기
              result_string = serial.map { |value| value.to_s(16).rjust(4, '0') }.join
              # 16진수 문자열을 ASCII 문자열로 변환하기
              ascii_string = [result_string].pack('H*')
              puts "READING SERIAL FROM PLC: #{ascii_string}"
              @tank = ProductTank.where(["serial = ?", ascii_string ]).first
              # puts @tank.inspect
              byte_array = "#{@tank.weight.rjust(6,"0")}#{@tank.capacity.rjust(4, "0")}".unpack('C*')

              puts "WRITING WEIGHT & CAPACITY TO PLC: #{byte_array.map(&:chr).join}"

              i = 300

              regs[i..i+9] = byte_array

              regs[10] = 1

            end

            if digital[8].to_i == 1 && is_start == true

              i = 500
              serial = regs[i..i+1]
              # 배열의 각 요소를 16진수로 변환하여 문자열로 합치기
              result_string = serial.map { |value| value.to_s(16).rjust(4, '0') }.join
              # 16진수 문자열을 ASCII 문자열로 변환하기
              ascii_string = [result_string].pack('H*')

              puts "SAVE SERIAL: #{@tank.serial}"
              puts "SAVE VALUE: #{ascii_string}"
              puts "SAVE TIME: #{Time.now}"

              @tank_logs = TankLog.new

              @tank_logs.serial = @tank.serial
              @tank_logs.capacity_filled = ascii_string
              @tank_logs.save

              regs[0] = regs[0][0].to_i - 128 - 256

              is_start = false
            end

            # end serial number with product tank
            # end serial number with product tank
            # end serial number with product tank
            # end serial number with product tank
            # end serial number with product tank
          end
        end
      rescue
        puts "ERROR!!!!!!!!!!#{$!}"
      end
      send_message(ws, 'digital', digital)
      send_message(ws, 'analog', analog)
      sleep(1)

      if Time.now.sec % 10 == 0
        # 강제로 에러 발생
        raise
      end

    end
  rescue
    begin
      ws.close
    rescue
      puts "No ws"
    end
    close_open_files  # 열린 파일 닫기
    puts $!
    # sleep(0.25)
  end
end
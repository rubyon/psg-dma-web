require 'rubygems'
require 'rmodbus'
require 'websocket-client-simple'
require 'json'
require 'active_record'
require 'mysql2'
require './app/models/application_record'
require './app/models/product_tank'
require './app/models/tank_log'
require './app/models/analog_value'
require './app/models/digital_value'

LOG = true

$time_now = DateTime.now
$old_time = $time_now
$old_digital = "0"

def connect_websocket
  WebSocket::Client::Simple.connect('ws://127.0.0.1:3030/cable')
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

def filling_func( fill_start, fill_end, serial_start, serial_end, weight_start, weight_end, regs, regs_put, analog_value, type )

  is_start = $is_start_f1 if type == "f1"
  is_start = $is_start_f2 if type == "f2"

  if fill_start.to_i == 1 && is_start == false

    puts "Start #{type} Process"

    $is_start_f1 = true if type == "f1"
    $is_start_f2 = true if type == "f2"

    # PLC 에서 값 읽기 (시리얼)
    serial = regs[serial_start..serial_end]
    # 레지스터 값들을 16진수 문자열로 변환 후 역순으로 합치기
    reversed_string = serial.map { |value| format('%04X', value) }.reverse.join
    result_serial = [reversed_string].pack('H*').reverse
    puts "READING SERIAL FROM #{type} PLC: #{result_serial}"

    @tank = ProductTank.where(["serial = ?", result_serial ]).first

    puts @tank.inspect

    if @tank.nil?

      # 1 2 4 8

      # 16 32 64 128

      regs_put[0] = 2 if type == "f1"
      regs_put[0] = 32 if type == "f2"

      $is_start_f1 = false if type == "f1"
      $is_start_f2 = false if type == "f2"
    else
      # PLC 에 값 쓰기 (용기중량과 충전량)
      ascii_code = "#{@tank.weight.rjust(8," ")}#{@tank.capacity.rjust(8, " ")}"
      # 레지스터에 정수값 저장 (16비트)
      (weight_start..weight_end).each do |i|
        part = ascii_code[(i - serial_start) * 2, 2]
        combined_value = (part[1].ord << 8) | part[0].ord
        regs_put[i] = combined_value
      end
      puts "WRITING WEIGHT & CAPACITY TO #{type} PLC: #{ascii_code}"
      regs_put[0] = 1 if type == "f1"
      regs_put[0] = 16 if type == "f2"
    end

  end

  is_start = $is_start_f1 if type == "f1"
  is_start = $is_start_f2 if type == "f2"

  if fill_end.to_i == 1 && is_start == true

    puts "End #{type} Process"

    filled_value = analog_value

    puts "SAVE SERIAL: #{@tank.serial}"
    puts "SAVE VALUE: #{filled_value}"

    @tank_logs = TankLog.new
    @tank_logs.serial = @tank.serial
    @tank_logs.capacity_filled = filled_value.to_s

    if @tank_logs.save
      regs_put[0] = 4 if type == "f1"
      regs_put[0] = 64 if type == "f2"
    else
      regs_put[0] = 8 if type == "f1"
      regs_put[0] = 128 if type == "f2"
    end

    $is_start_f1 = false if type == "f1"
    $is_start_f2 = false if type == "f2"

  end

end

$is_start_f1 = false
$is_start_f2 = false

while true
  begin
    ws = connect_websocket

    subscribe_channel(ws)

    loop do
      digital = ""
      analog = Array.new

      begin
        ModBus::TCPClient.connect("192.168.20.10", 502) do |cl|
        # ModBus::TCPClient.connect("172.18.0.97", 502) do |cl|
          cl.with_slave(1) do |slave|
            slave.debug = false
            regs = slave.input_registers
            regs_put = slave.holding_registers

            # # PLC 에 값 쓰기 (용기중량과 충전량)
            # ascii_code = "     156     170"
            # # 레지스터에 정수값 저장 (16비트)
            # (59..66).each do |i|
            #   part = ascii_code[(i - 59) * 2, 2]
            #   combined_value = (part[1].ord << 8) | part[0].ord
            #   regs_put[i] = combined_value
            # end
            # puts "WRITING TO PLC: #{ascii_code}"

            # # PLC 에서 값 읽기 (시리얼)
            # serial = regs[9..18]
            # # 레지스터 값들을 16진수 문자열로 변환 후 역순으로 합치기
            # reversed_string = serial.map { |value| format('%04X', value) }.reverse.join
            # result_serial = [reversed_string].pack('H*').reverse
            # puts "READING SERIAL FROM PLC: #{result_serial}"

            i = 10

            ( i + 1 ).times do |index|
              digital += regs[index][0].to_i.to_s(2).rjust(16,'0').reverse
            end

            puts "DIGITAL: #{digital}" if LOG

            if digital[68].to_i == 1
              $is_start_f1 = false
              $is_start_f2 = false
            end

            i = 9
            18.times do
              analog << regs[i..i+1].to_32f.to_s.gsub("[","").gsub("]","").to_f.round(1)
              i += 2
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

            if $old_digital != digital[32..63]
              value_index = 0
              @digital_value = DigitalValue.new
              32.times do
                @digital_value.public_send("value#{value_index + 1}=", digital[32 + value_index])
                value_index += 1
              end
              @digital_value.save
              $old_digital = digital[32..63]
            end

            $time_now = DateTime.now
            if ( $old_time.to_i + 60 ) <= $time_now.to_i
              value_index = 0
              @analog_value = AnalogValue.new
              18.times do
                @analog_value.public_send("value#{value_index + 1}=", analog[value_index])
                value_index += 1
              end
              @analog_value.save
              $old_time = $time_now
            end

            filling_func( digital[64], digital[65], 59, 68, 59, 66, regs, regs_put,  analog[16], "f1" )

            filling_func( digital[66], digital[67], 69, 78, 69, 76, regs, regs_put, analog[17], "f2" )


            # if digital[64].to_i == 1 && is_start == false
            #
            #   is_start = true
            #
            #   # PLC 에서 값 읽기 (시리얼)
            #   serial = regs[59..68]
            #   # 레지스터 값들을 16진수 문자열로 변환 후 역순으로 합치기
            #   reversed_string = serial.map { |value| format('%04X', value) }.reverse.join
            #   result_serial = [reversed_string].pack('H*').reverse
            #   puts "READING SERIAL FROM PLC: #{result_serial}"
            #
            #   @tank = ProductTank.where(["serial = ?", result_serial ]).first
            #
            #   puts @tank.inspect
            #
            #   if @tank.nil?
            #     regs_put[0] = 2
            #     is_start = false
            #   else
            #     # PLC 에 값 쓰기 (용기중량과 충전량)
            #     ascii_code = "#{@tank.weight.rjust(8," ")}#{@tank.capacity.rjust(8, " ")}"
            #     # 레지스터에 정수값 저장 (16비트)
            #     (59..66).each do |i|
            #       part = ascii_code[(i - 59) * 2, 2]
            #       combined_value = (part[1].ord << 8) | part[0].ord
            #       regs_put[i] = combined_value
            #     end
            #     puts "WRITING WEIGHT & CAPACITY TO PLC: #{ascii_code}"
            #     regs_put[0] = 1
            #   end
            #
            # end
            #
            # if digital[65].to_i == 1 && is_start == true
            #
            #   if digital[66].to_i == 1
            #     filled_value = analog[16]
            #   elsif digital[67].to_i == 1
            #     filled_value = analog[17]
            #   end
            #   filled_value.strip!
            #
            #   puts "SAVE SERIAL: #{@tank.serial}"
            #   puts "SAVE VALUE: #{filled_value}"
            #
            #   @tank_logs = TankLog.new
            #   @tank_logs.serial = @tank.serial
            #   @tank_logs.capacity_filled = filled_value
            #   @tank_logs.save
            #
            #   is_start = false
            # end

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
      sleep(0.25)

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

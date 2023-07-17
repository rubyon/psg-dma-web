require 'rubygems'
require 'rmodbus'
require 'websocket-client-simple'
require 'json'

def connect_websocket
  WebSocket::Client::Simple.connect('ws://127.0.0.1:3001/cable')
end

def subscribe_channel(ws)
  ws.on :open do
    # Send command to subscribe to ActionCable's specific channel after connect to socket
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
    file.close if !file.closed?
  end
end

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

            puts "Modbus Value: #{regs[0..i]}"

            ( i + 1 ).times do |i|
              digital += regs[i][0].to_i.to_s(2).rjust(16,'0').reverse
            end

            puts "DIGITAL: #{digital}"

            i = 100
            3.times do
              analog << regs[i][0].to_i
              i += 1
            end
            puts "ANALOG: #{analog}"

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
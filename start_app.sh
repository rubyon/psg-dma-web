#!/bin/bash

rm -rf /app/tmp/pids/server.pid

# 함수를 정의하여 시그널을 받았을 때 종료할 프로세스를 종료하는 로직을 추가합니다.
function cleanup {
    kill -TERM $PID
}

# 터미널 시그널을 처리할 함수를 등록합니다.
trap cleanup TERM INT

# 프로세스들을 백그라운드로 실행하고 해당 프로세스들의 PID를 변수에 저장합니다.
rails server -b 0.0.0.0 &
RAILS_PID=$!

ruby modbus.rb &
MODBUS_PID=$!

# 프로세스들이 모두 종료될 때까지 대기합니다.
wait $RAILS_PID
wait $MODBUS_PID

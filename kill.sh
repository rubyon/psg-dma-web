#!/bin/bash

# Puma 프로세스를 찾아 강제 종료하는 함수
function kill_puma() {
  # `ps -ef` 명령어를 이용하여 Puma 프로세스를 찾습니다.
  # 출력 결과 중 "puma"와 "tcp://0.0.0.0:3000"이 모두 포함된 라인을 찾습니다.
  # 그리고 해당 라인의 첫 번째 열에 있는 PID를 추출합니다.
  # PID를 이용하여 `kill -9` 명령어로 Puma 프로세스를 강제 종료합니다.
  ps -ef | grep "puma" | grep -v grep | awk '{print $2}' | xargs kill -9
}

function kill_sidekiq() {
  ps -ef | grep "sidekiq" | grep -v grep | awk '{print $2}' | xargs kill -9
}

# kill_puma 함수를 실행합니다.
kill_puma

kill_sidekiq


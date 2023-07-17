#!/bin/bash
export APP_ROOT="/home/rubyon/psg-dma-web"

export RBENV_ROOT="/home/rubyon/.rbenv"

export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# Redis가 실행될 때까지 기다리는 함수를 정의합니다.
#wait_for_redis() {
#    while ! docker ps | grep -q "prompts-redis"; do
#        sleep 1
#        echo "not ready"
#    done
#}

# Redis가 실행될 때까지 기다립니다.
#wait_for_redis

echo "start!"

cd $APP_ROOT
foreman start -f Procfile.dev

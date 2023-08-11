# Base 이미지 설정
FROM ruby:3.2.2

# 작업 디렉토리 설정
WORKDIR /app

# Gem 설치
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# 포트 노출
EXPOSE 3000

# 컨테이너 실행 시 애플리케이션 실행
COPY start_app.sh /app/

RUN chmod +x /app/start_app.sh

CMD ["/app/start_app.sh"]

# docker run --rm -p 3000:3000 -v /Users/rubyon/NTC/psg-dma-web:/app hub.rubyon.co.kr/psg-dma

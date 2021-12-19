FROM ruby:3.0.3-buster

ENV LANG=C.UTF-8

WORKDIR /var/apps/web

RUN groupadd -g 2000 app
RUN adduser --disabled-login --shell /sbin/nologin --gid 2000 --uid 2000 app
RUN chown app:app /var/apps/web

USER 2000

COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries \
    && bundle config set jobs $(nproc) \
    && bundle  install

CMD ["sh", "-c", "bundle install && rm -f tmp/pids/server.pid && rails s -p 3000 -b '0.0.0.0'"]

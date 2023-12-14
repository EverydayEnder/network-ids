FROM alpine:latest

RUN apk --no-cache add \
snort \
sqlite \
sqlite-dev \
ruby \
ruby-dev \
ruby-bundler \
libxml2-dev \
libxslt-dev \
make \
g++ \
tzdata \
bash \
&& gem install snorby

WORKDIR /etc

RUN wget https://raw.githubusercontent.com/EverydayEnder/network-ids/main/snort.conf -O snort.conf
RUN wget https://raw.githubusercontent.com/EverydayEnder/network-ids/main/rules/local.rules -O snort/rules/local.rules
RUN wget https://raw.githubusercontent.com/EverydayEnder/network-ids/main/snorby/database.yml -O snorby/database.yml
RUN wget https://raw.githubusercontent.com/EverydayEnder/network-ids/main/snorby/snorby_config.rb -O snorby/snorby_config.rb

WORKDIR /etc/snort
COPY rules/local.rules .

WORKDIR /etc/snorby
RUN snorby setup -d /etc/snorby -u sqlite3:///snorby_production.db

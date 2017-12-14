FROM ruby:2.4-alpine3.6
LABEL maintainer="Maxmilian Mayer <mayer.maximilian@googlemail.com>"

# Environment settings
ENV PORT 3000
ENV PUPPET_URL http://puppet:3030
ENV CACHE_SECONDS 300

RUN apk add --no-cache ruby-bundler ruby-json
# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY ./puppetdb-rundeck.rb $APP_HOME
COPY ./config.ru $APP_HOME
COPY start.sh $APP_HOME

# Start server

EXPOSE 3000
#CMD ["ruby", "puppetdb-rundeck.rb"] 
#CMD ["rackup", "-s" , "puma" , "-p", "3000"]
ENTRYPOINT ["./start.sh"]

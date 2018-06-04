FROM ruby:2.5-alpine
LABEL maintainer="Maxmilian Mayer <mayer.maximilian@googlemail.com>"
LABEL version="0.2.1"

# Environment settings
ENV PORT 3000
ENV PUPPET_URL http://puppet:3030
ENV CACHE_SECONDS 300


# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN apk add --no-cache build-base && \
	bundle config --global silence_root_warning 1 && \
	bundle install  --clean -j4  --no-cache && \
	apk del build-base

# Upload source
COPY ./puppetdb-rundeck.rb $APP_HOME
COPY ./config.ru $APP_HOME
COPY start.sh $APP_HOME

# Start server

EXPOSE 3000
#CMD ["ruby", "puppetdb-rundeck.rb"]
#CMD ["rackup", "-s" , "puma" , "-p", "3000"]
ENTRYPOINT ["./start.sh"]

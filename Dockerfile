FROM ruby:2.3.4
MAINTAINER Maxmilian Mayer <mayer.maximilian@googlemail.com>

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
ENV PORT 3000
ENV PUPPET_URL http://puppet:3030
ENV CACHE_SECONDS 300

EXPOSE 3000
#CMD ["ruby", "puppetdb-rundeck.rb"]
CMD ["rackup", "-s" , "puma" , "-p", "3000"]

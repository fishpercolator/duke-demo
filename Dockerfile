FROM ruby:2.3
MAINTAINER Rich Daley <rich@fishpercolator.co.uk>
ENV REFRESHED_AT 2016-06-01

RUN adduser --uid 1001 --disabled-password --gecos "" rails

RUN gem install bundler

ENV APP_HOME /usr/src/example
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile BUNDLE_JOBS=2 BUNDLE_PATH=/bundle

RUN bundle install

ENV RAILS_ENV       production
ENV DOMAIN_NAME     localhost
# NOTE: ALWAYS override this or your sessions will be insecure!
ENV SECRET_KEY_BASE 3e7139bcf406d9d47644c4858558ccd540153219b07d787351df71b23c14d91ed270edd63e85293be71a1e1d24f5c93060d0be6df2f90168a0a9932819a53e8e

ADD . $APP_HOME

RUN RAILS_ENV=production bundle exec rake assets:precompile

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

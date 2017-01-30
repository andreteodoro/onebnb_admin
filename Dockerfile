FROM ruby:2.3-slim

# Install dependencies
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev imagemagick git

ENV INSTALL_PATH /onebnb_api
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# Copy the Gemfile inside the container
COPY Gemfile Gemfile.lock ./

RUN bundle install --system

# Copy the code inside the container
COPY . .

CMD puma -C config/puma.rb

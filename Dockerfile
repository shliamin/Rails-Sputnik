# Use the official Ruby image from Docker Hub
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y curl gnupg build-essential libpq-dev

# Install Node.js and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y nodejs yarn \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the working directory
WORKDIR /myapp

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem update --system 3.3.22 && bundle install

# Clear Yarn cache and install dependencies
RUN yarn cache clean && yarn install

# Copy the main application
COPY . .

# Copy master key for Rails credentials
COPY config/master.key /myapp/config/master.key

# Ensure the log directory exists and is writable
RUN mkdir -p /myapp/log && chmod -R 777 /myapp/log

# Set Node.js options for OpenSSL
ENV NODE_OPTIONS="--openssl-legacy-provider"

# Clean Rails cache to save space
RUN rm -rf /myapp/tmp/cache

# Precompile assets
RUN RAILS_ENV=production bundle exec rails assets:precompile

# Set the command to run the application
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
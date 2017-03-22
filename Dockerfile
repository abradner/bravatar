FROM ruby:2.4-onbuild

# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#         postgresql-client \
#     && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile* ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . .

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0"]
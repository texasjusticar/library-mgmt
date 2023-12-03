# Library Management API

HTTP API for managing a library's collection of books and handling various operations.

### Install

```ruby
> git clone git@github.com:texasjusticar/library-mgmt.git
> cd library-mgmt
> bundle install
```

### Initial Setup

Before use, a librarian account with an api key must be setup.  Run the following rake tasks to accomplish this.

```ruby
> bundle exec rails db:setup
> bundle exec rails db:migrate
> bundle exec rails librarian:setup
```

### Usage

```ruby
> bundle exec rails s
```

All api requests must include the provided API token in the header as a Bearer Authentication.  Use Postman or CURL (or any http client) to access localhost:3000/ (Intention was to also include swagger documentation via rswag but ran out of time.  See the spec/requests folder or `rails routes` for relevant endpoints)

### Run Tests

```ruby
> rails db:test:prepare
> bundle exec rspec
```

### TODO

[EdgeCases / TODO](EDGECASES.md) lists several items TODO to improve on this api.
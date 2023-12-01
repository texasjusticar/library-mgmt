# Library Management API

HTTP API for managing a library's collection of books and handling various operations.

### Install

```ruby
> git clone git@github.com:texasjusticar/library-mgmt.git
> cd library-mgmt
> bundle install
```

### Initial Setup

Before use, a librarian account with an api key must be setup.

```ruby
> bundle exec rails librarian:setup
```

### Usage

All api requests must include the provided API token in the header as a Bearer Authentication.

### Run Tests

```ruby
> bundle exec rspec
```
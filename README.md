# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
3.2.2
* Rails version
Rails 7.1.2

* System dependencies
docker or postgres

* Configuration
move to app folder
```
$ cd Exchange-rates
$ bundle install
```

* Database creation
simple start postgresql with docker
```
$ docker run --name currency-postgres -e POSTGRES_PASSWORD=password -p 127.0.0.1:5432:5432 -d postgres
```
```
$ db:create db:migrate
```

* Database initialization
```
$ db:migrate
```

```
$ db:seed
```

* Run application
```
$ bin/rails s
or
$ bundle exec rails s
```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
parse currencies rates for today: 
```
rake exchange_rates:parse
```

* Deployment instructions

* ...

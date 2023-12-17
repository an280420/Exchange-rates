# README

This README provides essential information for setting up and running the Exchange-rates application.

## Application Details

- Ruby version: 3.2.2
- Rails version: 7.1.2

## System Dependencies

- Docker or PostgreSQL

## Configuration

Move to the app folder and install dependencies:

```bash
$ cd Exchange-rates
$ bundle install
```

## Database Setup

Start PostgreSQL with Docker:

```bash
$ docker run --name currency-postgres -e POSTGRES_PASSWORD=password -p 127.0.0.1:5432:5432 -d postgres
```

Create and initialize the database:

```bash
$ bin/rails db:create db:migrate
```
Seed the database with currency rates for the last month:
```bash
$ bin/rails db:seed
```

## Run Application

Start the Rails server:

```bash
$ bin/rails s
```
or
```bash
$ bundle exec rails s
```

## Currency Rates Update

To parse currency rates for today, use the rake task:

```bash
$ rake exchange_rates:parse
```

To schedule the rake task to run daily, consider using system utilities like cron. Open the crontab editor:

```bash
$ crontab -e
```

Add a line to run your rake task daily at a convenient time. For example:

```bash
0 3 * * * /path/to/your/project/bin/rake exchange_rates:parse RAILS_ENV=production
```

Save the changes and close the editor. This setup will run the rake task every day at 3 AM. Replace `/path/to/your/project` with the actual path to your project.

## Deployment Instructions

Follow your preferred deployment strategy for Rails applications.

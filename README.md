[![Dependency Status](https://beta.gemnasium.com/badges/github.com/eonu/simplatra-mvc.svg)](https://beta.gemnasium.com/projects/github.com/eonu/simplatra-mvc)

# Simplatra MVC

An extended version of the static website template [Simplatra](https://github.com/eonu/simplatra) including ActiveRecord and Rake for models and databases, to turn Simplatra into a template for a complete and dynamic Model-View-Controller architecture.

## Features

Simplatra MVC consists of the following features:

| <u>Type</u>          | <u>Name</u>                              |
| -------------------- | ---------------------------------------- |
| Deployment           | [Heroku](https://www.heroku.com/)        |
| Web framework        | [Sinatra](http://sinatrarb.com/)         |
| ORM                  | *Rails* [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord) |
| ORDBMS (Production)  | [PostgreSQL](https://www.postgresql.org/) |
| ORDBMS (Development) | [SQLite3](https://www.sqlite.org/)       |
| Asset pipeline       | *Rails* [Sprockets](https://github.com/rails/sprockets) |
| HTML templating      | [ERB](https://ruby-doc.org/stdlib-2.5.0/libdoc/erb/rdoc/ERB.html) |
| HTML helpers         | [Hanami](https://github.com/hanami/helpers) |
| Task automation      | [Rake](https://github.com/ruby/rake)     |
| CSS preprocessing    | [SCSS](http://sass-lang.com/)            |

## Installation

To to prepare this template for usage in your application:

```bash
# Clone into the repository
$ git clone https://github.com/eonu/simplatra-mvc.git

# Change directory
$ cd simplatra-mvc

# Remove the .git directory (recommended)
$ rm -rf .git

# Remove all .gitkeep files recursively (optional)
$ find . -name ".gitkeep" -exec rm -rf {} \;

# Remove the README.md file (optional)
$ rm README.md

# Install all required gems specified in Gemfile
$ bundle install

# Rename the application directory (optional)
$ cd .. && mv simplatra-mvc your-app-name
```

## Demonstration

[View the demo application here](https://github.com/eonu/simplatra-mvc-demo).

This demo only showcases new MVC features which were not present in Simplatra such as models and database migrations & configuration. For a general demo on Simplatra, [click here](https://github.com/eonu/simplatra-demo).

## Structure

### Models - `app/models`

To generate a new model, use the following `rake` task:

```bash
# Generates a new model class file in app/models (parameters: NAME)
$ rake generate:model NAME=ModelName
```

### Views `app/views`

The `app/views` directory should contain all of the `HTML`/`ERB`-related view files of the application, including templates, partials etc.

### Controllers - `app/controllers`

Multiple routes can be declared in a single controller file. However, you may have multiple controller files with their own routes.

To generate a new route file, use the following `rake` task:

```bash
# Generates a new route class file in app/routes (parameters: NAME)
$ rake generate:route NAME=RouteName
```

### Static data - `app/yaml`

Static data can be stored in `YAML` files in the `app/yaml` directory. This works the same way as the static version of Simplatra. For more information [read here](https://github.com/eonu/simplatra).

## Running the application

To run the application, simply use:

```bash
$ rackup
```

All files located within directories of the asset pipeline are constantly being watched, and will update without having to restart the server with `rackup` again.

## Deploying to [Heroku](https://www.heroku.com/)

**NOTE:** Simplatra MVC has only been tested in local development/test mode and not yet production mode, so proceed with caution.

If you plan to deploy your Sinatra application with Heroku, there is already a `Procfile` included with the following process type:

```
web: bundle exec rackup config.ru -p $PORT
```

### Buildpack

You will need to use the `heroku/ruby` buildpack. This can be changed in your application's Heroku settings.

### Environment variables

Ensure that you set the environment variables present in `app/database.yml`:

- `DATABASE_HOST` - The database host
- `DATABASE_NAME` - The database name/url
- `DATABASE_USER` - The database username
- `DATABASE_PASSWORD` - The database password

These are only required for production, and can be set in your application's Heroku settings.
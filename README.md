[![Dependency Status](https://beta.gemnasium.com/badges/github.com/eonu/simplatra-mvc.svg)](https://beta.gemnasium.com/projects/github.com/eonu/simplatra-mvc)
[![Release](https://img.shields.io/github/release/simplatra/simplatra-mvc.svg)](https://github.com/simplatra/simplatra-mvc/releases)
[![License](https://img.shields.io/github/license/simplatra/simplatra-mvc.svg)](https://github.com/simplatra/simplatra-mvc/blob/master/LICENSE)

# Simplatra MVC

An extended version of [Simplatra](https://github.com/simplatra/simplatra) including ActiveRecord and Rake for creating more complete and dynamic web applications based on the Model-View-Controller architecture.

## Features

Simplatra MVC utilises the following features, gem dependencies and services:

- **Deployment**: Heroku (https://www.heroku.com/)
- **Web framework**: Sinatra (http://sinatrarb.com/)
- **ORM**: *Rails* ActiveRecord (https://github.com/rails/rails/tree/master/activerecord)
- **ORDBMS (production)**: PostgreSQL (https://www.postgresql.org/)
- **ORDBMS (development)**: SQLite3 (https://www.sqlite.org/)
- **Asset pipeline**: *Rails* Sprockets (https://github.com/rails/sprockets)
- **HTML templating**: ERB (https://ruby-doc.org/stdlib-2.5.0/libdoc/erb/rdoc/ERB.html)
- **HTML helpers**: Hanami (https://github.com/hanami/helpers)
- **CSS preprocessing**: SCSS (http://sass-lang.com/)
- **Task automation**: Rake (https://github.com/ruby/rake)
- **Static site data**: YAML (http://yaml.org/)
- **Performance monitoring**: New Relic RPM (https://github.com/newrelic/rpm)

## Structure

The template's directory is currently structured as follows:

>  **NOTE**: SCSS partials and the view + `README.md` files are not displayed in this tree.

```ruby
.
├── Gemfile				# Gemfile for dependencies and versions
├── Procfile				# Process types for Heroku deployment
├── Rakefile				# Rakefile for task automation
├── app
│   ├── assets				# Assets for pipelining
│   │   ├── fonts
│   │   ├── images
│   │   ├── scripts
│   │   └── stylesheets
│   │       └── partials
│   ├── controllers			# Controllers and routes
│   │   └── application.rb
│   ├── helpers             # Helper methods for the application
│   │   └── application.rb
│   ├── models				# Database models
│   ├── views				# HTML views, partials and templates
│   │   ├── partials
│   │   └── templates
│   └── yaml				# Static site data
├── app.rb				# CORE APPLICATION FILE
├── config				# Database, asset and static data config
│   ├── assets.rb
│   ├── data.rb
│   ├── newrelic.yml
│   └── database.yml
└── config.ru				# config.ru for rack-based deployment
```

---

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

The core application controller is named `application.rb`. It should contain routes which are core to the application, such as 404 routes and index routes.

To generate a new route file, use the following `rake` task:

```bash
# Generates a new route class file in app/routes (parameters: NAME)
$ rake generate:route NAME=RouteName
```

### Helpers - `app/helpers`

Similarly to routes, multiple helper methods can be declared in a single helper file. But you can also have multiple helper files.

The core application helper file is named `application.rb`.

To generate a new helper file, use the following `rake` task:

```bash
# Generates a new helper class file in app/helpers (parameters: NAME)
$ rake generate:helper NAME=HelperName
```

### Static data - `app/yaml`

Static data can be stored in `YAML` files in the `app/yaml` directory. This works the same way as the static version of Simplatra. For more information [read here](https://github.com/simplatra/simplatra).

## Installation

To to prepare this template for usage in your application:

```bash
# Clone into the repository
$ git clone https://github.com/simplatra/simplatra-mvc.git

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

## Running the application

To run the application, simply use:

```bash
$ rackup
```

All files located within directories of the asset pipeline are constantly being watched, and will update without having to restart the server with `rackup` again.

## Demonstration

[View the demo application here](https://github.com/simplatra/simplatra-mvc-demo).

This demo only showcases new MVC features which were not present in Simplatra such as models and database migrations & configuration. For a general demo on Simplatra, [click here](https://github.com/simplatra/simplatra-demo).

## Deployment

Simplatra MVC is bundled and set up to be deployed on Heroku, so this would probably be the easiest way to deploy your application. Although this README won't explain other methods of deployment, feel free to deploy however you like!

### Deploying to [Heroku](https://www.heroku.com/)

If you plan to deploy your Sinatra application with Heroku, there is already a `Procfile` included with the following process type:

```
web: bundle exec rackup config.ru -p $PORT
```

#### Buildpack

You will need to use the `heroku/ruby` buildpack. This can be changed in your application's Heroku settings.

#### Environment variables

Ensure that you set the `DATABASE_URL` environment variable in your Heroku settings if you don't wish to use the default database given by Heroku.

## Performance monitoring with [New Relic RPM](https://github.com/newrelic/rpm) and Heroku

New Relic RPM can be used for monitoring the performance of your application once deployed. Heroku has an add-on for New Relic RPM with free and paid plans. To use New Relic RPM:

1. Configure your New Relic settings in the configuration file `config/newrelic.yml` of your application. For more information on configuring the `newrelic.yml` file, [read this document](https://docs.newrelic.com/docs/agents/ruby-agent/configuration/ruby-agent-configuration)
2. Deploy your application as normal on Heroku
3. Open the application page of your newly-made application from your [Heroku dashboard](https://dashboard.heroku.com/apps)
4. Search for the `New Relic APM` add-on, select a plan and add it to your app
5. Set the `NEW_RELIC_LICENSE_KEY` environment variable in your Heroku application settings to your license key

---

Special thanks to the authors of the following documents, articles, posts and repositories - a lot of inspiration for Simplatra was drawn from them.

The following blog posts and blog authors:

- [Designing with Class: Sinatra + PostgreSQL +  Heroku](http://mherman.org/blog/2013/06/08/designing-with-class-sinatra-plus-postgresql-plus-heroku/#.Wk_oxEuYPox) - **Michael Herman**
- [How to set up Sinatra with ActiveRecord](http://coding.jandavid.de/2016/02/08/how-to-set-up-sinatra-with-activerecord/) - **Jan David**

The following pages on the official Sinatra website:

- [Sinatra - Frequently Asked Questions](http://sinatrarb.com/faq.html#helpview)
- [Sinatra - PostgreSQL and database connections](http://recipes.sinatrarb.com/p/databases/postgresql-activerecord)

The following GitHub repositories:

- [shannonjen/**sinatra_crud_tutorial**](https://github.com/shannonjen/sinatra_crud_tutorial)
- [tkellen/**sinatra-template**](https://github.com/tkellen/sinatra-template)
- [zencephalon/**sinatra-mvc-skeleton**](https://github.com/zencephalon/sinatra-mvc-skeleton)

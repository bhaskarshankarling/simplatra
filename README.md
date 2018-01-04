# Simplatra MVC

An extended version of the static website template [Simplatra](https://github.com/eonu/simplatra) including ActiveRecord and Rake for models and databases, to turn Simplatra into a template for a complete and dynamic Model-View-Controller architecture.

## Demonstration

[View the demo application here](https://github.com/eonu/simplatra-mvc-demo).

This demo only showcases new MVC features which were not present in Simplatra such as models and database migrations & configuration. For a general demo on Simplatra, [click here](https://github.com/eonu/simplatra-demo).

## Installation

To to prepare this template for usage in your application:

```bash
# Clone into the repository
$ git clone https://github.com/eonu/simplatra-mvc.git

# Change directory
$ cd simplatra-mvc

# Remove the .git directory (recommended)
$ rm -rf .git

# Install all required gems specified in Gemfile
$ bundle install

# Remove all .gitkeep files recursively (optional)
$ find . -name ".gitkeep" -exec rm -rf {} \;

# Remove the README.md file (optional)
$ rm README.md

# Rename the application directory (optional)
$ cd .. && mv simplatra-mvc your-app-name
```

## Usage

TODO

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

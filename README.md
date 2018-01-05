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

# Remove all .gitkeep files recursively (optional)
$ find . -name ".gitkeep" -exec rm -rf {} \;

# Remove the README.md file (optional)
$ rm README.md

# Install all required gems specified in Gemfile
$ bundle install

# Rename the application directory (optional)
$ cd .. && mv simplatra-mvc your-app-name
```

## Structure

### Models - `app/models`

To generate a new model, use the following `rake` task:

```bash
# Generates a new model class file in app/models (parameters: NAME)
$ rake generate:model NAME=ModelName
```

### Views `app/views`

The `app/views` directory should contain all of the `HTML`/`ERB`-related view files of the application, including templates, partials etc.

### Controllers/Routes - `app/routes`

Multiple controllers/routes can be declared in a single file, or multiple files. Multiple files is recommended to avoid cluttering.

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

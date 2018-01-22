[![Dependency Status](https://beta.gemnasium.com/badges/github.com/simplatra/simplatra.svg)](https://beta.gemnasium.com/projects/github.com/simplatra/simplatra)
[![Release](https://img.shields.io/github/release/simplatra/simplatra.svg)](https://github.com/simplatra/simplatra/releases)
[![License](https://img.shields.io/github/license/simplatra/simplatra.svg)](https://github.com/simplatra/simplatra/blob/master/LICENSE)

# Simplatra

A simple Model-View-Controller Sinatra template for creating more complete and dynamic web applications. Bundled with an asset pipeline, view helpers, stylesheet preprocessing, ActiveRecord and easy management of static data.

## Features

Simplatra utilises the following features, gem dependencies and services:

- **Deployment**: Heroku (https://www.heroku.com/)
- **Web framework/DSL**: Sinatra (http://sinatrarb.com/)
- **ORM**: *Rails* ActiveRecord (https://github.com/rails/rails/tree/master/activerecord)
- **ORDBMS (production)**: PostgreSQL (https://www.postgresql.org/)
- **ORDBMS (development)**: SQLite3 (https://www.sqlite.org/)
- **Asset pipeline**: *Rails* Sprockets (https://github.com/rails/sprockets)
- **HTML templating**: ERB (https://ruby-doc.org/stdlib-2.5.0/libdoc/erb/rdoc/ERB.html)
- **HTML helpers**: Hanami (https://github.com/hanami/helpers)
- **CSS preprocessing**: SCSS (http://sass-lang.com/)
- **Static site data**: YAML (http://yaml.org/)
- **Performance monitoring**: New Relic RPM (https://github.com/newrelic/rpm)
- **Tests/Specs**:
    - RSpec (http://rspec.info/)
    - Rack-Test (https://github.com/rack-test/rack-test)
    - Shoulda-Matchers (http://matchers.shoulda.io/)

## Structure

### Directory tree

The template's directory is currently structured as follows:

>  **NOTE**: Not all files are not displayed in this tree.

```ruby
.
├── Gemfile                #=> Gemfile for dependencies and versions
├── Procfile               #=> Process types for Heroku deployment
├── Rakefile               #=> Rakefile for task automation
├── app                    #
│   ├── assets             #=> Assets for pipelining
│   │   ├── fonts          #
│   │   ├── images         #
│   │   ├── scripts        #
│   │   └── stylesheets    #
│   │       └── partials   #=> SCSS partials
│   ├── controllers        #=> Controllers/routes
│   ├── helpers            #=> Helper methods
│   ├── models             #=> Database models
│   ├── views              #=> HTML views, partials and templates
│   │   ├── partials       #
│   │   └── templates      #
│   └── yaml               #=> Static site data
├── app.rb                 #=> Core application data
├── config                 #=> YAML configuration files
│   ├── newrelic.yml       #=> NewRelic RPM configuration
│   └── database.yml       #=> Database configuration
├── config.ru              #=> config.ru for rack-based deployment
└── spec                   #=> RSpec test files
    ├── controllers        #=> Controller specs
    ├── models             #=> Model specs
    └── spec_helper.rb     #=> Spec helper
```

### Template structure and file generation

#### Models: `app/models`

To generate a new `ActiveRecord` model, use the following rake task:

```bash
# Generates a new model class file app/models/test.rb (parameters: NAME)
$ rake generate:model NAME=Test
```

> Of course replacing `Test` with the desired name of the model.

This rake task will also generate a spec file for this controller at `spec/model/test_spec.rb`.

#### Views: `app/views`

The `app/views` directory should contain all of the `HTML`/`ERB`-related view files of the application, including templates, partials etc.

#### Controllers: `app/controllers`

Multiple routes can be declared in a single controller file. However, you may have multiple controller files with their own routes.

The core application controller is named `application_controller.rb`. It should contain routes which are core to the application, such as 404 routes and index routes.

To generate a new controller file, use the following rake task:

```bash
# Generates a new controller class file app/controllers/test_controller.rb (parameters: NAME)
$ rake generate:controller NAME=Test
```

> Of course replacing `Test` with the desired name of the controller.

This rake task will also generate a spec file for this controller at `spec/controllers/test_controller_spec.rb`.

#### Helpers: `app/helpers`

Similarly to routes, multiple helper methods can be declared in a single helper file. But you can also have multiple helper files.

The core application helper file is named `application_helper.rb`.

To generate a new helper file, use the following rake task:

```bash
# Generates a new helper class file app/helpers/test_helper.rb (parameters: NAME)
$ rake generate:helper NAME=Test
```

> Of course replacing `Test` with the desired name of the helper.

---

#### Scaffolding

Rather than running each rake task separately to generate the above files, it is possible to generate them together with the `generate:scaffold` task:

```bash
# Generates a scaffold (parameters: NAME, CONTROLLER, HELPER, MODEL)
$ rake generate:scaffold NAME=Test
```

> Of course replacing `Test` with the desired name of the scaffold.

This in turn will run the following rake tasks in order:

1. `rake generate:helper NAME=Test`
2. `rake generate:controller NAME=Test`
3. `rake generate:model NAME=Test`

Alternatively if you don't want to generate all three of these, you can use flags to toggle them.

> Example: To generate a model and helper, but no controller:
>
> `rake generate:scaffold NAME=Test CONTROLLER=false`

> Example: To generate only a controller:
>
> `rake generate:scaffold NAME=Test MODEL=false HELPER=false`

---

#### Static data: `app/yaml`

Static site data can be stored in YAML files in the `app/yaml` directory. File extensions can be either `.yml` or `.yaml`.

- It is essential that the file name is a valid Ruby method name (the reason for this is that a method is dynamically created to allow access to data within this YAML file)

##### Example

YAML data can be accessed with the `data` application helper method, followed by calling the dynamically defined method with the same name as the YAML file - so in this case, `data.index`.

```yaml
# app/yaml/index.yml
features:
  - "Sinatra"
  - "Sprockets"
  - "SASS"
  - "Hanami"
```

```erb
<!-- app/views/index.erb -->
<html>
    <body>
        <% data.index['features'].each do |feature| %>
        <h1><%= feature %></h1>
        <% end %>
    </body>
</html>
```

This generates the following `HTML`:

```html
<html>
    <body>
        <h1>Sinatra</h1>
      	<h1>Sprockets</h1>
      	<h1>SASS</h1>
        <h1>Hanami</h1>
    </body>
</html>
```

### Asset pipeline

All the configuration for the asset pipeline is already done, including directories for `stylesheets`, `scripts`, `images` and `fonts`.

If you would like to add more directories to be included in the asset pipeline, simply add them to this section in the `app.rb` file:

```ruby
# Prepare asset pipeline
set :environment, Sprockets::Environment.new
environment.append_path './app/assets/stylesheets'
environment.append_path './app/assets/scripts'
environment.append_path './app/assets/images'
environment.append_path './app/assets/fonts'
environment.css_compressor = :scss
get '/assets/*' do
    env["PATH_INFO"].sub!('/assets','')
    settings.environment.call(env)
end
```

The default stylesheet preprocessor is set as `scss`, but this can also be changed.

#### Examples

When using any asset within the asset pipeline, simply use the reference `/assets/asset.ext` where `asset` is the specific asset with the extension `ext`.

There is no need to include the subdirectory in `assets` where the asset is located, as this is the purpose of the asset pipeline.

> Example: Don't do `/assets/images/img.png`, instead do `/assets/img.png`.

For example:

```html
<!-- index.html -->
<html>
    <head>
      	<link rel="icon" href="/assets/favicon.png" sizes="16x16 32x32" type="image/png">
      	<link rel="stylesheet" href="/assets/index.css">
    </head>
    <body>
        <img src="/assets/sss.png"
    </body>
</html>
```

```scss
/* index.scss */
body {
	background-image: url('/assets/bg.gif');
}
```

## Installation

To to prepare this template for usage in your application:

```bash
# Clone into the repository
$ git clone https://github.com/simplatra/simplatra.git

# Change directory and install dependencies
$ cd simplatra && bundle install

# Set up the application
$ rake setup NAME=your-app-name && cd .
```

Alternatively for the last step, if you want to recursively delete all `.gitkeep` files in the application subdirectories:

```bash
# Sets up the application and recursively deletes all .gitkeep files
$ rake setup NAME=your-app-name GITKEEP=true && cd .
```

In this template, the `.gitkeep` files serve no purpose other than to preserve folder structure and empty folders in the Git repository.

## Running the application

To run the application, simply use:

```bash
$ rackup
```

All files located within directories of the asset pipeline are constantly being watched, and will update without having to restart the server with `rackup` again.

### Tests

To run all of specs in the `spec` directory, run:

```bash
$ rake
```

Or:

```bash
$ rspec spec
```

### Interactive shell sessions

To run the application in a way akin to `rails console` for Rails applications, you can run the following command in the base directory of the application:

```bash
$ irb -r app.rb
```

As the majority of `require` statements are made in `app.rb`, this will load in all of your classes (such as models) into the new IRB shell session, allowing you to use this session in the same way as `rails console`.

## Demonstration

[View the demo application here](https://github.com/simplatra/simplatra-demo).

## Deployment

Simplatra is bundled and set up to be deployed on Heroku, so this would probably be the easiest way to deploy your application. Although this README won't explain other methods of deployment, feel free to deploy however you like!

### Deploying to [Heroku](https://www.heroku.com/)

If you plan to deploy your Sinatra application with Heroku, there is already a `Procfile` included with the following process type:

```
web: bundle exec rackup config.ru -p $PORT
```

#### Buildpack

You will need to use the `heroku/ruby` buildpack.

This should be automatically be set when you make your first deployment. If not, this can be changed in your application's Heroku settings.

#### Environment variables

Ensure that you set the `DATABASE_URL` environment variable in your Heroku settings if you don't wish to use the default database given by Heroku.

## Performance monitoring with [New Relic RPM](https://github.com/newrelic/rpm) and Heroku

New Relic RPM can be used for monitoring the performance of your application once deployed. Heroku has an add-on for New Relic RPM with free and paid plans. To use New Relic RPM:

1. Configure your New Relic settings in the configuration file `config/newrelic.yml` of your application. For more information on configuring the `newrelic.yml` file, [read this document](https://docs.newrelic.com/docs/agents/ruby-agent/configuration/ruby-agent-configuration)
2. Deploy your application as normal on Heroku
3. Open the application page of your newly-made application from your [Heroku dashboard](https://dashboard.heroku.com/apps)
4. Search for the `New Relic APM` add-on, select a plan and add it to your app
5. Set the `NEW_RELIC_LICENSE_KEY` environment variable in your Heroku application settings to your license key (if it isn't already set)

Additionally, you can set up regular pinging for your Heroku application. If your application runs on [free dynos](https://devcenter.heroku.com/articles/free-dyno-hours#quota), ensure that New Relic isn't eating up your free dyno hours quota. You can alter the ping rate for your application in the settings on the New Relic website.

1. Go to your application's page on the New Relic website.
2. On the sidebar on the left, under the `Reports` section, select `Availability`.
3. In the URL text-box, enter the URL of your Heroku application (e.g. http://appname.herokuapp.com). Continue to the next screen and don't change any settings (unless you know what you're doing)!

## Compatibility and testing

This template (along with the [demo](https://github.com/simplatra/simplatra-demo) application) has been tested on:

- macOS Sierra (Version 10.12.6)
- Linux Debian 9

However, there shouldn't be any reason for this to not work on other UNIX systems, and versions of different Linux distributions or other OSX versions.

It may or may not require a bit of work to get this template working correctly on Windows.

# Notes and references

Special thanks to the authors of the following documents, blog posts and repositories - a lot of inspiration for Simplatra was drawn from them.

The following blog posts and blog authors:

- [Designing with Class: Sinatra + PostgreSQL + Heroku](http://mherman.org/blog/2013/06/08/designing-with-class-sinatra-plus-postgresql-plus-heroku/#.Wk_oxEuYPox) - **Michael Herman**
- [How to set up Sinatra with ActiveRecord](http://coding.jandavid.de/2016/02/08/how-to-set-up-sinatra-with-activerecord/) - **Jan David**
- [Structuring Sinatra Applications](https://nickcharlton.net/posts/structuring-sinatra-applications.html) - **Nick Charlton**

The following pages on the official Sinatra website:

- [Sinatra - Frequently Asked Questions](http://sinatrarb.com/faq.html#helpview)
- [Sinatra - PostgreSQL and database connections](http://recipes.sinatrarb.com/p/databases/postgresql-activerecord)

The following GitHub repositories:

- [shannonjen/**sinatra_crud_tutorial**](https://github.com/shannonjen/sinatra_crud_tutorial)
- [tkellen/**sinatra-template**](https://github.com/tkellen/sinatra-template)
- [zencephalon/**sinatra-mvc-skeleton**](https://github.com/zencephalon/sinatra-mvc-skeleton)

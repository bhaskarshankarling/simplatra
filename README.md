[![Ruby Version](https://img.shields.io/badge/ruby-2.5.0-red.svg)](https://github.com/simplatra/simplatra/blob/master/Gemfile#L2)
[![Release](https://img.shields.io/github/release/simplatra/simplatra.svg)](https://github.com/simplatra/simplatra/releases)
[![License](https://img.shields.io/github/license/simplatra/simplatra.svg)](https://github.com/simplatra/simplatra/blob/master/LICENSE)
[![Documentation](https://img.shields.io/badge/docs-gitbook-blue.svg)](https://simplatra.gitbook.io/simplatra)

# Simplatra

A simple MVC Sinatra template for creating dynamic web applications. Bundled with asset pipeline/preprocessing, view helpers, easy management of static data and options for blog-aware development.

### [View the GitBook for documentation of the template](https://simplatra.gitbook.io/simplatra/)

---

The template's directory is currently structured as follows (not all files are shown):

```ruby
.
├── Gemfile                        #=> Gemfile for dependencies and versions
├── LICENSE                        #=> MIT licensing
├── Procfile                       #=> Process types for Heroku deployment
├── Rakefile                       #
├── bin                            #=> Simplatra CLI
├── thor                           #=> Thor tasks for Simplatra CLI
├── app                            #
│   ├── assets                     #=> Assets for pipelining
│   │   ├── fonts                  #
│   │   ├── images                 #
│   │   ├── scripts                #
│   │   │   └── application.js     #=> Javascript manifest file
│   │   └── stylesheets            #
│   │       ├── application.scss   #=> Stylesheet manifest file
│   │       └── partials           #
│   ├── controllers                #=> Controllers/routes
│   ├── helpers                    #=> Helper methods
│   ├── models                     #=> Database models
│   ├── views                      #=> HTML views, partials and templates
│   │   ├── partials               #
│   │   └── templates              #
│   └── yaml                       #=> Static site data
├── app.rb                         #=> Core application data
├── config                         #
│   └── initializers               #=> Initializers file
├── config.ru                      #=> config.ru for rack instructions
├── log                            #=> Log files
└── spec                           #=> RSpec test files
    ├── controllers                #=> Controller specs
    └── models                     #=> Model specs
```
require './config/root'
require 'active_support'
require 'active_support/core_ext'
require 'bundler'
Bundler.require :thor

module Simplatra
    module Generators
        class MVC < Thor::Group
            include Thor::Actions
            desc 'Generate MVC architecture files'

            TEMPLATES =  "#{Simplatra::ROOT}/thor/generators/templates"

            def self.source_root() TEMPLATES end

            def model(spec: true, name:)
                name = name.to_s
                file_name = "#{name.singularize.underscore}.rb"
                file_path = "#{Simplatra::ROOT}/app/models/#{file_name}"
                spec_name = file_name.gsub('.rb','_spec.rb')
                spec_path = "#{Simplatra::ROOT}/spec/models/#{spec_name}"
                name = name.singularize.camelize

                config = {name: name}
                template("#{TEMPLATES}/mvc/model/model.tt", file_path, config)
                template("#{TEMPLATES}/mvc/model/spec.tt", spec_path, config) if spec
            end

            def controller(helper: true, spec: true, name:)
                name = name.to_s
                file_name = name.downcase.include?('controller') ? "#{name.underscore}.rb" : "#{name.singularize.underscore}_controller.rb"
                file_path = "#{Simplatra::ROOT}/app/controllers/#{file_name}"
                class_name = name.downcase.include?('controller') ? name.camelize : "#{name.singularize.camelize}Controller"
                spec_name = file_name.gsub('.rb','_spec.rb')
                spec_path = "#{Simplatra::ROOT}/spec/controllers/#{spec_name}"

                tokens = file_name.split(?_)
                route = "/#{tokens.first(tokens.size-1)*?-}"

                config = {route: route, class_name: class_name}
                helper(name: name) if helper
                template("#{TEMPLATES}/mvc/controller/controller.tt", file_path, config)
                template("#{TEMPLATES}/mvc/controller/spec.tt", spec_path, config) if spec
            end

            def helper(name:)
                name = name.to_s
                file_name = name.downcase.include?('helper') ? "#{name.underscore}.rb" : "#{name.singularize.underscore}_helper.rb"
                file_path = "#{Simplatra::ROOT}/app/helpers/#{file_name}"
                module_name = name.downcase.include?('helper') ? name.camelize : "#{name.singularize.camelize}Helper"

                config = {module_name: module_name}
                template("#{TEMPLATES}/mvc/helper/helper.tt", file_path, config)
            end

            def scaffold(model: true, model_spec: true, controller: true, controller_spec: true, helper: true, name:)
                model(spec: model_spec, name: name) if model
                if helper
                    helper(name: name)
                    controller(helper: false, spec: controller_spec, name: name) if controller
                elsif controller
                    controller(helper: helper, spec: controller_spec, name: name)
                end
            end

        end
    end
end
require 'simplatra/cli/error'
require 'front_matter_parser'
require 'active_support'
require 'active_support/core_ext'
require 'thor'

module Simplatra
  class Destroy < Thor
    include Thor::Actions

    desc "controller [NAME]", "Destroys a controller"
    def controller(name = nil)
      delete_mvc(:controller, name)
    end

    desc "helper [NAME]", "Destroys a helper"
    def helper(name = nil)
      delete_mvc(:helper, name)
    end

    desc "model [NAME]", "Destroys a model"
    def model(name = nil)
      delete_mvc(:model, name)
    end

    desc "scaffold [NAME]", "Destroys a scaffold"
    def scaffold(name = nil)
      directory = File.expand_path ?.
      if File.exist? File.join(directory, '.simplatra')
        scaffolds = Dir[File.join directory, 'app', '{controllers,models,helpers}', '*.rb'].map do |f|
          File.basename(f).split(?_).first.split(?.).first
        end
        scaffolds.reject{|f|f == 'application'}
        scaffolds.uniq!

        if scaffolds.empty?
          Simplatra::Error.no_scaffolds
          return
        end

        if name # If name given

          if scaffolds.include? name
            controller(name)
            helper(name)
            model(name)
          else
            Simplatra::Error.no_scaffolds
          end

        else # If name not given

          scaffolds_hash = {}
          scaffold_numbers = []

          scaffolds.each_with_index do |scaffold, i|
            scaffold_numbers << (i+1).to_s
            scaffolds_hash[(i+1).to_s.to_sym] = scaffold
            puts "\e[1m#{i+1}\e[0m: #{scaffold}"
          end

          scaffold_number = ask("\nEnter the number of the scaffold to delete:", limited_to: scaffold_numbers)
          scaffold_name = scaffolds_hash[scaffold_number.to_sym]

          controller(scaffold_name)
          helper(scaffold_name)
          model(scaffold_name)

        end

      else
        Simplatra::Error.wrong_directory
      end
    end

    no_tasks do

      def delete_mvc(mvc_file, name)
        directory = File.expand_path ?.
        if File.exist? File.join(directory, '.simplatra')
          files = Dir[File.join directory, "app/#{mvc_file}s/*.rb"]
          file_names = if mvc_file == :model
            files.map{|c| File.basename(c).split(?.).first}
          else
            files.map{|c| File.basename(c).split(?_).first}.reject{|n| n=='application'}
          end

          if files.empty?
            Simplatra::Error.no_mvc(mvc_file)
            return
          end

          if name # If name is given

            name = name.downcase
            if file_names.include? name
              file_name = mvc_file == :model ? "#{name}.rb" : "#{name}_#{mvc_file}.rb"
              # Deleting MVC file
              delete_file = ask("\e[1;93mWARNING\e[0m: Delete #{mvc_file} \e[1m#{file_name}\e[0m?", limited_to: %w[y Y Yes YES n N No NO])
              return unless %w[y Y Yes YES].include? delete_file
              remove_file(File.join directory, "app/#{mvc_file}s", file_name)

              # Deleting MVC file spec
              spec_file_name = mvc_file == :model ? "#{name}_spec.rb" : "#{name}_#{mvc_file}_spec.rb"
              spec_file_path = File.join(directory, "spec/#{mvc_file}s", spec_file_name)
              return unless File.exist? spec_file_path
              delete_file_spec = ask("\e[1;93mWARNING\e[0m: Delete #{mvc_file} spec \e[1m#{spec_file_name}\e[0m?", limited_to: %w[y Y Yes YES n N No NO])
              return unless %w[y Y Yes YES].include? delete_file_spec
              remove_file(spec_file_path)
            else
              Simplatra::Error.no_mvc(mvc_file)
              return
            end

          else # If name is not given

            files = Dir[File.join directory, 'app', "#{mvc_file}s", "*.rb"].reject{|f| File.basename(f).include? 'application'}
            if files.empty?
              Simplatra::Error.no_mvc(mvc_file)
              return
            end

            puts

            files_hash = {}
            file_numbers = []

            files.each_with_index do |file, i|
              file_numbers << (i+1).to_s
              files_hash[(i+1).to_s.to_sym] = File.basename file
              puts "\e[1m#{i+1}\e[0m: #{File.basename file}"
            end

            file_number = ask("\nEnter the number of the #{mvc_file} to delete:", limited_to: file_numbers)
            file = files_hash[file_number.to_sym]
            delete_file = ask("\e[1;93mWARNING\e[0m: Delete #{mvc_file} file \e[1m#{file}\e[0m?", limited_to: %w[y Y Yes YES n N No NO])
            return unless %w[y Y Yes YES].include? delete_file
            remove_file(File.join directory, 'app', "#{mvc_file}s", file)

            spec_file = file.gsub('.rb','_spec.rb')
            delete_spec_file = ask("\e[1;93mWARNING\e[0m: Delete #{mvc_file} spec file \e[1m#{spec_file}\e[0m?", limited_to: %w[y Y Yes YES n N No NO])
            return unless %w[y Y Yes YES].include? delete_file
            remove_file(File.join directory, 'spec', "#{mvc_file}s", spec_file)
          end
        else
          Simplatra::Error.wrong_directory
        end
      end

    end
  end

  class CLI < Thor
    register(Destroy, 'destroy', 'destroy [COMMAND]', 'Destroy models, controllers and helpers')
  end
end
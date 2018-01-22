require_relative 'app.rb'
Dir["#{File.dirname(__FILE__)}/app/controllers/*.rb"]
    .map{|f|File.basename(f,'.*').camelize}
    .reject(&'ApplicationController'.method(:==))
    .each{|c|use c.constantize}
run ApplicationController
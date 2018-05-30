require './app'
Dir["#$dir/app/controllers/*.rb"]
    .map{|f|File.basename(f,'.*').camelize}
    .reject(&'ApplicationController'.method(:==))
    .each{|c|use c.constantize}
run ApplicationController
desc 'Sets up the application. (parameters: NAME, GITKEEP=true/false)'
task :setup do
    unless ENV.has_key? 'NAME'
        message = "\n#{"ERR".colorize(:light_red)} » Application name must be specified e.g. rake setup NAME=my-application"
        puts message, ?=*(message.uncolorize.length-1)
        next
    end

    remove_gitkeeps = ENV['GITKEEP'] ? ENV['GITKEEP'].downcase == 'true' : false
    current_directory_name = File.basename Simplatra::ROOT
    parent_directory = File.dirname Simplatra::ROOT
    new_directory_path = "#{parent_directory}/#{ENV['NAME']}"

    if File.directory? new_directory_path
        message = "\n#{"ERR".colorize(:light_red)} » '#{new_directory_path}' already exists"
        puts message, ?=*(message.uncolorize.length-1)
    else
        sh %(rm -rf .git)
        sh %(find . -name ".gitkeep" -exec rm -rf {} \\;) if remove_gitkeeps
        sh %(rm README.md) if File.exist? 'README.md'
        Dir.chdir '..'
        sh %(mv #{current_directory_name} #{ENV['NAME']})
        Dir.chdir ENV['NAME']
        len = current_directory_name.length+ENV['NAME'].length+2
        puts "*#{?=*(len)}*".colorize(:white)
        puts "#{"Setup complete".colorize(:green).center(len+2)}"
    end
end
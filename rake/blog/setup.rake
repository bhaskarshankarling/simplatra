namespace :blog do

    desc 'Sets up the blog environment (parameters: ROUTE)'
    task :setup do
        route = ENV['ROUTE'] ||= 'blog'
        route = route.sub(?/,'') if route.start_with?(?/)

        sh "rake mvc:gen:helper NAME=blog"
        sh "rake blog:gen:controller ROUTE=#{route}"

        layout_path = "#{Simplatra::ROOT}/app/views/templates/post.erb"
        if File.exist? layout_path
            puts "\n#{"ERR".colorize(:light_red)} » Post layout '#{layout_path}' already exists."
        else
            File.open(layout_path, 'w+') do |f|
                f.write(<<-EOF.strip_heredoc)
                    <html>
                        <head>
                        <title></title>
                            <%= application :css, :js %>
                        </head>
                        <body>
                            <%= content %>
                        </body>
                    </html>
                EOF
            end
            puts "\n#{"Created post layout at".colorize(:light_black)} #{layout_path.colorize(:green)}"
        end

        blog_path = "#{Simplatra::ROOT}/app/views/blog.erb"
        if File.exist? blog_path
            puts "\n#{"ERR".colorize(:light_red)} » Blog view '#{blog_path}' already exists."
        else
            sh "touch #{blog_path}"
            puts "\n#{"Created blog view at".colorize(:light_black)} #{blog_path.colorize(:green)}"
        end

        blog_search_path = "#{Simplatra::ROOT}/app/views/blog_search.erb"
        if File.exist? blog_search_path
            message = "\n#{"ERR".colorize(:light_red)} » Blog search view '#{blog_search_path}' already exists."
            puts message, ?=*(message.uncolorize.length-1)
        else
            sh "touch #{blog_search_path}"
            message = "\n#{"Created blog search view at".colorize(:light_black)} #{blog_search_path.colorize(:green)}"
            puts message, ?=*(message.uncolorize.length-1)
        end
    end
end
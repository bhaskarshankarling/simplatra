namespace :blog do
    namespace :gen do
        using String::Builder

        desc 'Creates a new post (parameters: URLTITLE, HEADER)'
        task :post do
            unless ENV.has_key? 'URLTITLE'
                message = "\n#{"ERR".colorize(:light_red)} » Post urltitle must be specified e.g. rake blog:post:gen URLTITLE=simplatra-blog-aware"
                puts message, ?=*(message.uncolorize.length-1)
                next
            end

            urltitle = ENV['URLTITLE']

            dt = Hash.new
            dt[:full] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
            dt[:date] = dt[:full].split(' ').first

            # Assets file and path generation
            asset_base = "#{Simplatra::ROOT}/app/assets/images/posts"
            sh "mkdir #{asset_base}" unless File.directory? asset_base

            asset_path = String.build asset_base do |s|
                s << "/#{dt[:date].gsub(?-,?/)}"
                s << "/#{urltitle}"
            end

            y, m, d = dt[:date].split ?-
            sh "mkdir #{asset_base}/#{y}" unless File.directory? "#{asset_base}/#{y}"
            sh "mkdir #{asset_base}/#{y}/#{m}" unless File.directory? "#{asset_base}/#{y}/#{m}"
            sh "mkdir #{asset_base}/#{y}/#{m}/#{d}" unless File.directory? "#{asset_base}/#{y}/#{m}/#{d}"

            sh "mkdir #{asset_path}" unless File.directory? asset_path

            header = ENV['HEADER']
            unless (header == nil) || (header.downcase == 'false')
                header_file = (header.downcase == 'true') ? 'header' : header
                sh "touch #{asset_path}/#{header_file}.png"
            end

            # Markdown file and path generation
            post_base = String.build Simplatra::ROOT do |s|
                s << '/app/views/posts'
            end

            sh "mkdir #{post_base}" unless File.directory? post_base

            post_path = String.build post_base do |s|
                s << "/#{dt[:date].gsub(?-,?/)}"
                s << "/#{urltitle}.md"
            end

            y, m, d = dt[:date].split ?-
            sh "mkdir #{post_base}/#{y}" unless File.directory? "#{post_base}/#{y}"
            sh "mkdir #{post_base}/#{y}/#{m}" unless File.directory? "#{post_base}/#{y}/#{m}"
            sh "mkdir #{post_base}/#{y}/#{m}/#{d}" unless File.directory? "#{post_base}/#{y}/#{m}/#{d}"

            if File.exist? post_path
                message = "\n#{"ERR".colorize(:light_red)} » Post '#{post_path}' already exists."
                puts message, ?=*(message.uncolorize.length-1)
            else
                File.open(post_path, 'w+') do |f|
                    f.write(<<-EOF.strip_heredoc)
                        ---
                        title: "TODO"
                        desc: "TODO"
                        tags: ["TODO"]
                        # Changing `urltitle` or `time` will require changes to the asset and view directory structures, as well as the asset path below.
                        urltitle: "#{urltitle}"
                        time: "#{dt[:full]}"
                        assetpath: "/assets/posts/#{dt[:date].gsub(?-,?/)}/#{urltitle}/"
                        ---
                    EOF
                end
                message = "\n#{"Created a post at".colorize(:light_black)} #{post_path.colorize(:green)}"
                puts message, ?=*(message.uncolorize.length-1)
            end
        end

    end
end
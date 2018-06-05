namespace :blog do
    using String::Builder

    desc "Lists front-matter of all posts"
    task :list do
        CHARS = {corner: ?+, vertical: ?║, horizontal: ?═}

        files = Dir.glob("#{Simplatra::ROOT}/app/views/posts/**/*.md")
        next if files.empty?

        metadata = files.map{|md|FrontMatterParser::Parser.parse_file(md).front_matter}

        longest = 0
        metadata.each do |post|
            post.each do |k,v|
                next if k == 'desc'
                str = "#{k}: #{v.to_s}"
                longest = str.length if longest < str.length
            end
        end

        output = String.build "\n" do |s|
            s << (CHARS[:corner]+CHARS[:horizontal]*(longest+2)+CHARS[:corner]+"\n")
            metadata.each do |post|
                post.each do |k,v|
                    str = "#{k}: #{v.to_s}"
                    if k == 'desc'
                        value = v.to_s
                        rel = longest-(k.length+5) # 5 is from ": " and "..."
                        unless str.length <= longest
                            str = "#{k}: #{value.length > rel ? "#{value[0...rel]}..." : value}"
                        end
                    end
                    len = str.ljust(longest,' ').length-str.length
                    s << "#{CHARS[:vertical]} "
                    s << "#{k.colorize(:magenta)}: #{str[(k.length+2)..-1]}"
                    s << ' '*len
                    s << " #{CHARS[:vertical]}\n"
                end
                s << (CHARS[:corner]+CHARS[:horizontal]*(longest+2)+CHARS[:corner]+"\n")
            end
        end

        puts output
    end

end
require 'spec_helper'

describe Simplatra::CLI do
  describe "Blog" do
    describe "List" do
      before(:all) do
        args = %w[init tmp]
        @names = %w[test-1 test-2 test-3]
        @date = Time.now.strftime("%Y/%m/%d")
        Dir.chdir('spec') do
          silence { Simplatra::CLI.start(args) }
          Dir.chdir('tmp') do
            silence { Simplatra::CLI.start(%w[blog setup]) }
            @names.each do |name|
              silence { Simplatra::CLI.start(['blog','article',name]) }
            end
            @stdout = silence { Simplatra::CLI.start(%w[blog list]) }
          end
        end
        @root = File.join(File.dirname(__dir__),'tmp')
      end

      after(:all) do
        Dir.chdir('spec') do
          FileUtils.rm_rf('tmp')
        end
      end

      it "should display article titles" do
        @names.each do |name|
          title = "\e[95mtitle\e[0m: TODO"
          expect(@stdout).to include(title)
        end
      end

      it "should display article descriptions" do
        @names.each do |name|
          description = "\e[95mdesc\e[0m: TODO"
          expect(@stdout).to include(description)
        end
      end

      it "should display article tags" do
        @names.each do |name|
          tags = " \e[95mtags\e[0m: [\"TODO\"]"
          expect(@stdout).to include(tags)
        end
      end

      it "should display article urltitles" do
        @names.each do |name|
          urltitle = "\e[95murltitle\e[0m: #@name"
          expect(@stdout).to include(urltitle)
        end
      end

      it "should display article times" do
        @names.each do |name|
          time = "\e[95mtime\e[0m: #{@date.gsub(?/,?-)}"
          expect(@stdout).to include(time)
        end
      end

      it "should display article assetpaths" do
        @names.each do |name|
          assetpath = "\e[95massetpath\e[0m: /assets/blog/#@date/#@name"
          expect(@stdout).to include(assetpath)
        end
      end
    end
  end
end
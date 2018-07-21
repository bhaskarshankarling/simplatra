require 'spec_helper'

describe Simplatra::CLI do
  describe "Blog" do
    describe "Article" do
      before(:all) do
        args = %w[init tmp]
        @name = 'test-article'
        @date = Time.now.strftime("%Y/%m/%d")
        Dir.chdir('spec') do
          silence { Simplatra::CLI.start(args) }
          Dir.chdir('tmp') do
            silence { Simplatra::CLI.start(%w[blog setup]) }
            silence { Simplatra::CLI.start(['blog','article','generate',@name]) }
          end
        end
        @root = File.join(File.dirname(__dir__),'tmp')
      end

      after(:all) do
        Dir.chdir('spec') do
          FileUtils.rm_rf('tmp')
        end
      end

      it "should generate an article markdown file" do
        file = File.join(@root,'app/views/blog/markdown',@date,"#{@name}.md")
        expect(File.file? file).to be(true)
      end

      it "should generate an article image asset directory" do
        directory = File.join(@root,'app/assets/images/blog',@date,@name)
        expect(File.directory? directory).to be(true)
      end
    end
  end
end
require 'spec_helper'

describe Simplatra::CLI do
  describe "Blog" do
    describe "Setup" do
      before(:all) do
        args = %w[init tmp]
        Dir.chdir('spec') do
          silence { Simplatra::CLI.start(args) }
          Dir.chdir('tmp') do
            silence { Simplatra::CLI.start(%w[blog setup]) }
          end
        end
        @root = File.join(File.dirname(__dir__),'tmp')
      end

      after(:all) do
        Dir.chdir('spec') do
          FileUtils.rm_rf('tmp')
        end
      end

      it "should create a blog controller" do
        file = File.join(@root, 'app/controllers/blog_controller.rb')
        expect(File.file? file).to be(true)
      end

      it "should create a blog controller spec" do
        file = File.join(@root, 'spec/controllers/blog_controller_spec.rb')
        expect(File.file? file).to be(true)
      end

      it "should create a blog helper" do
        file = File.join(@root, 'app/helpers/blog_helper.rb')
        expect(File.file? file).to be(true)
      end

      it "should create a layout for displaying all articles " do
        file = File.join(@root, 'app/views/layouts/blog/articles.erb')
        expect(File.file? file).to be(true)
      end

      it "should create a layout for displaying one article" do
        file = File.join(@root, 'app/views/layouts/blog/article.erb')
        expect(File.file? file).to be(true)
      end

      it "should create a view for displaying all articles " do
        file = File.join(@root, 'app/views/blog/articles.erb')
        expect(File.file? file).to be(true)
      end

      it "should create a view for displaying one article" do
        file = File.join(@root, 'app/views/blog/article.erb')
        expect(File.file? file).to be(true)
      end

      it "should create a view for searching articles " do
        file = File.join(@root, 'app/views/blog/search.erb')
        expect(File.file? file).to be(true)
      end
    end
  end
end
require 'spec_helper'

describe Simplatra::CLI do
  before(:each) do
    args = %w[init tmp]
    Dir.chdir('spec') do
      silence { Simplatra::CLI.start(args) }
    end
    @root = File.join(File.dirname(__dir__),'tmp')
  end

  after(:each) do
    Dir.chdir('spec') do
      FileUtils.rm_rf('tmp')
    end
  end

  describe "MVC" do
    describe "Helper" do
      before(:each) do
        @name = 'test'
        @paths = {
          helper: File.join(@root, "app/helpers/#{@name}_helper.rb"),
        }
        @args = ['generate','helper',@name]
      end

      it "should generate a helper" do
        expect(File.file? @paths[:helper]).to be(false)
        Dir.chdir('spec/tmp') do
          silence { Simplatra::CLI.start(@args) }
        end
        expect(File.file? @paths[:helper]).to be(true)
      end
    end
  end
end
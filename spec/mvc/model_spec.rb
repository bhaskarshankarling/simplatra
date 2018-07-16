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
    describe "Model -" do
      describe "model + spec" do
        before(:each) do
          @name = 'test'
          @paths = {
            model: File.join(@root, "app/models/#{@name}.rb"),
            spec: File.join(@root, "spec/models/#{@name}_spec.rb")
          }
          @args = ['mvc','model',@name]
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "should generate a spec" do
          expect(File.file? @paths[:spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:spec]).to be(true)
        end
      end

      describe "model" do
        before(:each) do
          @name = 'test'
          @paths = {
            model: File.join(@root, "app/models/#{@name}.rb"),
            spec: File.join(@root, "spec/models/#{@name}_spec.rb")
          }
          @args = ['mvc','model',@name,'--no-spec']
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "shouldn't generate a spec" do
          expect(File.file? @paths[:spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:spec]).to be(false)
        end
      end
    end
  end
end
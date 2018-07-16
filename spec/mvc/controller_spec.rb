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
    describe "Controller -" do
      describe "controller + spec + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb"),
            spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb")
          }
          @args = ['mvc','controller',@name]
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end

        it "should generate a spec" do
          expect(File.file? @paths[:spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:spec]).to be(true)
        end
      end

      describe "controller + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb"),
            spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb")
          }
          @args = ['mvc','controller',@name,'--no-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end

        it "shouldn't generate a spec" do
          expect(File.file? @paths[:spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:spec]).to be(false)
        end
      end

      describe "controller + spec" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb"),
            spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb")
          }
          @args = ['mvc','controller',@name,'--no-helper']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end

        it "should generate a spec" do
          expect(File.file? @paths[:spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:spec]).to be(true)
        end
      end

      describe "controller" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb"),
            spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb")
          }
          @args = ['mvc','controller',@name,'--no-helper','--no-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
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
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
    describe "Scaffold -" do
      describe "controller + controller-spec + model + model-spec + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name]
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "should generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(true)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "should generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(true)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end
      end

      describe "controller + controller-spec + model + model-spec" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','helper']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "should generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(true)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "should generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(true)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end
      end

      describe "controller + controller-spec + model + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','model-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "should generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(true)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end
      end

      describe "controller + controller-spec + model" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','model-spec','helper']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "should generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(true)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end
      end

      describe "controller + controller-spec + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','model','model-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "should generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(true)
        end

        it "shouldn't generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(false)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end
      end

      describe "controller + controller-spec" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','model','model-spec','helper']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "should generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(true)
        end

        it "shouldn't generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(false)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end
      end

      describe "controller + model + model-spec + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "should generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(true)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end
      end

      describe "controller + model + model-spec" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller-spec','helper']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "should generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(true)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end
      end

      describe "controller + model + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller-spec','model-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end
      end

      describe "controller + model" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller-spec','helper','model-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end
      end

      describe "controller + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','model','model-spec','controller-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "shouldn't generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(false)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end
      end

      describe "controller" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','model','model-spec','helper','controller-spec']
        end

        it "should generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(true)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "shouldn't generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(false)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end
      end

      describe "model + model-spec + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller','controller-spec']
        end

        it "shouldn't generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(false)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "should generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(true)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end
      end

      describe "model + model-spec" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller','controller-spec','helper']
        end

        it "shouldn't generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(false)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "should generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(true)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end
      end

      describe "model + helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller','controller-spec','model-spec']
        end

        it "shouldn't generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(false)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "should generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(true)
        end
      end

      describe "model" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller','controller-spec','helper','model-spec']
        end

        it "shouldn't generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(false)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "should generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(true)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
        end

        it "shouldn't generate a helper" do
          expect(File.file? @paths[:helper]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:helper]).to be(false)
        end
      end

      describe "helper" do
        before(:each) do
          @name = 'test'
          @paths = {
            controller: File.join(@root, "app/controllers/#{@name}_controller.rb"),
            controller_spec: File.join(@root, "spec/controllers/#{@name}_controller_spec.rb"),
            model: File.join(@root, "app/models/#{@name}.rb"),
            model_spec: File.join(@root, "spec/models/#{@name}_spec.rb"),
            helper: File.join(@root, "app/helpers/#{@name}_helper.rb")
          }
          @args = ['mvc','scaffold',@name,'-n','controller','controller-spec','model','model-spec']
        end

        it "shouldn't generate a controller" do
          expect(File.file? @paths[:controller]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller]).to be(false)
        end

        it "shouldn't generate a controller spec" do
          expect(File.file? @paths[:controller_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:controller_spec]).to be(false)
        end

        it "shouldn't generate a model" do
          expect(File.file? @paths[:model]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model]).to be(false)
        end

        it "shouldn't generate a model spec" do
          expect(File.file? @paths[:model_spec]).to be(false)
          Dir.chdir('spec/tmp') do
            silence { Simplatra::CLI.start(@args) }
          end
          expect(File.file? @paths[:model_spec]).to be(false)
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
end
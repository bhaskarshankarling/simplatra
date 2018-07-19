require 'spec_helper'

describe Simplatra::CLI do
  before(:all) do
    args = %w[init tmp]
    Dir.chdir('spec') do
      silence { Simplatra::CLI.start(args) }
    end
    @root = File.join(File.dirname(__dir__),'tmp')
  end

  after(:all) do
    Dir.chdir('spec') do
      FileUtils.rm_rf('tmp')
    end
  end

  describe "__print_version" do
    it "should display the correct Simplatra verison" do
      Dir.chdir('spec/tmp') do
        stdout = silence { Simplatra::CLI.start(%w[--version]) }
        expect(stdout.chomp).to eq Simplatra::VERSION
      end
    end
  end
end
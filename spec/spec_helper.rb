$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "bundler/setup"
require "simplatra"
require "fileutils"
require 'stringio'

def silence
  $stdout = temp_out = StringIO.new
  yield
  temp_out.string
ensure
  $stdout = STDOUT
end
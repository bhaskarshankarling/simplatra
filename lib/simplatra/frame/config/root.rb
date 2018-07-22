module Simplatra
  # Specifies the root directory of the application (don't change this!)
  ROOT = File.dirname File.dirname(__FILE__)
  def self.root() ROOT end
  def self.path(*args) File.join(ROOT, *args) end
end
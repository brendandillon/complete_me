require 'SimpleCov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test

  def test_node_exists
    node = Node.new
    refute_nil node
  end

end

require 'SimpleCov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me.rb'

class CompleteMeTest < Minitest::Test

  def test_creates_head_node
    complete_me = CompleteMe.new
    my_head = complete_me.head
    assert_equal my_head.class, Node
  end

  def test_creates_other_nodes
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("a")
    assert_equal my_head.a.class, Node
  end

end

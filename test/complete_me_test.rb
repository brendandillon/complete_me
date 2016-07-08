require 'SimpleCov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me.rb'

class CompleteMeTest < Minitest::Test

  def test_creates_head_node
    complete_me = CompleteMe.new
    my_head = complete_me.head
    assert_equal Node, my_head.class
  end

  def test_creates_other_nodes
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("a")
    assert_equal Node, my_head.a.class
  end

  def test_creates_nested_nodes
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("aa")
    assert_equal Node, my_head.a.a.class
  end

  def test_can_insert_other_words
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("dog")
    assert_equal Node, my_head.d.o.g.class
  end

  def test_can_tell_whether_a_path_is_a_word
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("dog")
    assert my_head.d.o.g.is_word?
  end

  def test_can_tell_whether_a_path_is_not_a_word
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("dog")
    assert_equal false, my_head.d.is_word?
  end

  def test_can_import_newline_seperated_list_of_words
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.populate("dog\ncat\nfish")
    assert_equal Node, my_head.d.o.g.class
    assert_equal Node, my_head.c.a.t.class
    assert_equal Node, my_head.f.i.s.h.class
  end

  def test_can_find_words_in_dictionary
    complete_me = CompleteMe.new
    complete_me.insert("dog")
    assert_equal ["dog"], complete_me.suggest("dog")
  end

  def test_can_suggest_completions
    complete_me = CompleteMe.new
    complete_me.insert("dog")
    assert_equal ["dog"], complete_me.suggest("d")
  end

  def test_can_suggest_multiple_completions
    complete_me = CompleteMe.new
    complete_me.insert("dog")
    complete_me.insert("do")
    assert_equal ["do", "dog"], complete_me.suggest("d")
  end

  def test_can_count_words_in_dictionary
    complete_me = CompleteMe.new
    complete_me.insert("dog")
    complete_me.insert("cat")
    complete_me.insert("do")
    assert_equal 3, complete_me.count
  end

  def test_can_select_words
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("dog")
    complete_me.suggest("do")
    complete_me.select("do", "dog")
    assert_equal 1, my_head.d.o.g.weight
  end

  def test_selected_words_are_returned_first
    complete_me = CompleteMe.new
    complete_me.insert("dog")
    complete_me.insert("do")
    complete_me.insert("doggoneit")
    complete_me.suggest("do")
    complete_me.select("do", "doggoneit")
    assert_equal "doggoneit", complete_me.suggest("do")[0]
  end

  def test_can_remove_words
    complete_me = CompleteMe.new
    complete_me.insert("dog")
    complete_me.remove("dog")
    assert_equal "This doesn't match any words.", complete_me.suggest("do")
  end

  def test_can_prune_tree
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("dog")
    complete_me.insert("doggoneit")
    complete_me.remove("doggoneit")
    assert_equal nil, my_head.d.o.g.g
    assert_equal Node, my_head.d.o.g.class
  end

  def test_can_note_capitalized_words
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("Brendan")
    assert my_head.b.r.e.n.d.a.n.is_capitalized?
  end

  def test_can_suggest_capitalized_words
    complete_me = CompleteMe.new
    my_head = complete_me.head
    complete_me.insert("Brendan")
    assert_equal ["Brendan"], complete_me.suggest("B")
  end

end

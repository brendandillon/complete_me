require_relative 'node'

class CompleteMe
  attr_reader :head, :count

  def initialize
    @head = Node.new
    @count = 0
  end

  def insert(word)
    current_node = "@head"
    word.downcase.delete("-").each_char do |chr|
      current_node << ".#{chr}"
      if is_node?(current_node)
        next
      else
        eval(current_node + " = Node.new")
      end
    end
    create_word(current_node)
    set_capitalization(word)
  end

  def create_word(current_node)
    if eval(current_node).is_word? == false
      @count += 1
    end
    eval(current_node).is_word = true
  end

  def set_capitalization(word)
    if word == word.capitalize
      eval(convert_to_path(word)).is_capitalized = true
    end
  end

  def is_node?(path)
    eval(path).class == Node
  end

  def populate(list_of_words)
    words = list_of_words.split("\n")
    words.each do |word|
      insert(word)
    end
  end

  def convert_to_path(input)
    path = "@head"
    input.downcase.each_char do |chr|
      path << "." + chr
    end
    return path
  end

  def convert_from_path(path)
    word = path[6..-1]
    word.split(".").join
  end

  def suggest(input)
    @suggestions = {}
    current_node = convert_to_path(input)
    get_suggestions(current_node)
  end

  def get_suggestions(current_node)
    if is_node?(current_node)
      search_branches(current_node)
      sorted_suggestions = @suggestions.sort do |left, right|
        right[1].weight <=> left[1].weight
      end
      output = sorted_suggestions.map do |suggestion|
        suggestion[0]
      end
      return output
    else
      "This doesn't match any words."
    end
  end

  def search_branches(current_node)
    add_words_to_suggestions(current_node)
    find_branches(current_node)
  end

  def add_words_to_suggestions(node)
    to_add = convert_from_path(node)
    if eval(node).is_capitalized?
      to_add = to_add.capitalize
    end
    if eval(node).is_word?
      @suggestions[to_add] = eval(node)
    end
  end

  def find_branches(current_node)
    flagged_to_search = []
    ("a".."z").each do |letter|
      begin
        if is_node?(current_node + "." + letter)
          flagged_to_search << current_node + "." + letter
        end
      rescue
        next
      end
    end
    flagged_to_search.each do |subnode|
      search_branches(subnode)
    end
  end

  def select(input, selection)
    selection_path = eval(convert_to_path(selection))
    selection_path.weight += 1
  end

  def remove(input)
    path_to_remove = convert_to_path(input)
    eval(path_to_remove).is_word = false
    @count -= 1
    prune_tree(path_to_remove)
  end

  def prune_tree(path_to_remove)
    if path_to_remove[7] != nil
      word = convert_from_path(path_to_remove)
      suggest(word)
      remove_empty_node(path_to_remove)
    end
  end

  def remove_empty_node(path_to_remove)
    if @suggestions.length == 0
      eval(path_to_remove + " = nil")
      path_to_remove = path_to_remove[0..-3]
      prune_tree(path_to_remove)
    end
  end

end

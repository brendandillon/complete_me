require_relative 'node'

class CompleteMe
  attr_reader :head

  def initialize
    @head = Node.new
  end

  def insert(something)
    eval("@head." + something + " = Node.new")
  end

  # insert a word into dictionary

  #count words in the dictionary

  #insert list of newline seperated words into dictionary

  #suggest completions for a substring

  #mark a selection for a substring

  #weight subsequent selections based on previous selections

end

class Node
  attr_accessor :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k,
  :l, :m, :n, :o, :p, :q, :r, :s, :t, :u, :v, :w, :x, :y, :z, :weight
  attr_writer :is_word, :is_capitalized

  def initialize
    @is_word = false
    @is_capitalized = false
    @weight = 0
  end

  def is_word?
    @is_word
  end

  def is_capitalized?
    @is_capitalized
  end


end

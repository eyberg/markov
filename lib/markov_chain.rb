require File.dirname(__FILE__) + '/weighted_directed_graph'

class MarkovChain
  attr_accessor :graph

  def initialize
    @graph = WeightedDirectedGraph.new
  end

  # improve the chance of b coming after a
  def increment_probability(a,b)

    # are we tracking this yet?
    if @graph.words[a].nil? then
      @graph.add_node(a)
    end
    
    @graph.connect(a, b, 1)
  end

  # ensure that our word is still available
  # in our hash
  def addword(word)
    if @graph.words[word].nil? then
      @graph.words[word] = {}
    end
  end

  # return a 'random' word
  def get_word(word)
    chosen = ""

    if !@graph.words[word].nil? then
      
      # sum up all values in our word to get range
      total = 0
      @graph.words[word].map { |k,v| total += v }

      # grab some random val from said range
      sel = rand(total)

      # return the first word that has a
      # weight greater than our 'random number'
      # ensure we remove the weight from random
      # on each iteration
      @graph.words[word].each do |k,v|

        if v > sel then
          chosen = k
          break
        end

        sel -= v

      end

      return chosen
    end

  end

  # return a random word
  # we prob. hit punctuation
  # only needed if you want more than 1 sentence
  def pick_another
    return @graph.words.keys[rand(@graph.words.size)]
  end

  # return a 'random' array of words
  def random_walk(start = 'start')

    word = start

    num_sentences = 10

    # first word should be our seed
    retarr = [start]
   
    begin
      
      # we need at least 1 way out
      if @graph.out_degree_of(word) <= 0 then
        break
      end

      word = get_word(word)

      if word.nil? then
        num_sentences -= 1
        break
      end

      retarr << word

      # if we hit the end of the sentence we need
      # to pick another word cause we don't keep
      # track of next words to pass spec
      # this is only for if you want more than 1 sentence
      if word.split('').last.match(/\.|\?|\!/) then
        word = pick_another
        num_sentences -= 1
      end

    end while num_sentences > 0

    return retarr
  end

end

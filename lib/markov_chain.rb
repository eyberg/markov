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
    if !@graph.words[word].nil? then
      sel = rand(@graph.words[word].size)
      @graph.words[word].keys[sel]
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

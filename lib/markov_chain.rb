require File.dirname(__FILE__) + '/weighted_directed_graph'

class MarkovChain
  attr_accessor :graph
  attr_accessor :words

  def initialize
    @graph = WeightedDirectedGraph.new

    @words = {} # hash to hold our words
  end

  # improve the chance of b coming after a
  def increment_probability(a,b)
    
    # are we tracking this yet?
    if @words[a].nil? then
      freq = {}
      freq[b] = 1

      @words[a] = freq
    
    else

      # determine if b has been here before
      if @words[a][b].nil? then
        @words[a][b] = 1
      else
        @words[a][b] += 1
      end

    end

  end

  # ensure that our word is still available
  # in our hash
  def addword(word)
    if @words[word].nil? then
      @words[word] = {}
    end
  end

  # return a 'random' word
  def get_word(word)
    if !@words[word].nil? then
      sel = rand(@words[word].size)
      @words[word].keys[sel]
    end
  end

  # return a random word
  # we prob. hit punctuation
  def pick_another
    return @words.keys[rand(@words.size)]
  end

  # return a 'random' array of words
  def random_walk(start)

    word = start

    num_sentences = 10
    retarr = []
   
    begin
      word = get_word(word)
      retarr << word

      # if we hit the end of the sentence we need
      # to pick another word cause we don't keep
      # track of next words to pass spec
      if word.split('').last.match(/\.|\?|\!/) then
        word = pick_another
        num_sentences -= 1
      end

    end while num_sentences > 0

    return retarr
  end

end

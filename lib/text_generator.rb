require File.dirname(__FILE__) + '/markov_chain'

class TextGenerator
  attr_reader :markov_chain

  def initialize
    @markov_chain = MarkovChain.new
  end

  def seed(text)

    # not sure why we are splitting into sentences first
    sins = sentences(text)

    # split into words after joining 

    sins.each do |sin|
      subshit = sin.split

      # loop each keyword, index
      subshit.each_with_index do |word, index|
        nextword = subshit[index + 1]

        if !nextword.nil? then
          @markov_chain.increment_probability(word, nextword)
        end

      end
    
    end

  end
 
  # split sentences on punctuation
  # return array of sentences
  def sentences(text)
    shit = text.split(/(\.|\?|\!)/)

    rshit = []
    shit.each_with_index do |k,v|

      # need to keep our punctuation ... not sure about this
      if k.match(/(\.|\?|\!)/).nil? && !shit[v+1].nil? then
        rshit << k.lstrip + shit[v+1]
      end

    end

    rshit
  end

  def generate(start)
    @markov_chain.random_walk(start).join(" ")
  end
  
end

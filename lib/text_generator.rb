require File.dirname(__FILE__) + '/markov_chain'

class TextGenerator
  attr_reader :markov_chain

  def initialize
    @markov_chain = MarkovChain.new
  end

  # create our word hash from input text
  def seed(text)

    # not sure why we are splitting into sentences first
    sins = sentences(text)

    # split each sentence into words 
    sins.each do |sin|
      wordray = sin.split

      # loop each keyword, index
      wordray.each_with_index do |word, index|
        nextword = wordray[index + 1]

        if !nextword.nil? then
          @markov_chain.increment_probability(word, nextword)
        end

      end
    
    end

  end
 
  # split sentences on punctuation
  # return array of sentences
  def sentences(text)
    sentence = text.split(/(\.|\?|\!)/)

    rsentence = []
    sentence.each_with_index do |k,v|

      # need to keep our punctuation ... not sure about this
      if k.match(/(\.|\?|\!)/).nil? && !sentence[v+1].nil? then
        rsentence << k.lstrip + sentence[v+1]
      end

    end

    rsentence
  end

  # initiate spamming engine -- j/k
  def generate(start)
    @markov_chain.random_walk(start).join(" ")
  end
  
end

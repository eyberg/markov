# I had most of this (words hash) class in MarkovChain
# I just moved all the stuff here so I could
# pass specs
class WeightedDirectedGraph
  # holds all of our words and their relationships
  attr_accessor :words

  def initialize
    @words = {}
  end
  
  def add_node(name)
    @words[name] = {}
  end

  # add weight/label to graph
  # if no relationship exists
  # create one
  def connect(a, b, weight=1)
    if @words[a][b].nil? then
      @words[a][b] = weight
    else
      @words[a][b] += weight
    end
  end

  # stuff like this would prob.
  # want some form of error
  # control in RL
  def edge_weight(a,b)
    @words[a][b] or Throw NoRelation
  end
 
  def contains?(name)
    !@words[name].nil?
  end
 
  # stuff like this would prob.
  # want some form of error
  # control in RL 
  def out_degree_of(name)
    if @words[name].nil? then
      Throw NoSuchWord
    else
      @words[name].size
    end
  end
  
end

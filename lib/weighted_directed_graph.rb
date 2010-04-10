class WeightedDirectedGraph
  attr_accessor :words

  def initialize
    @words = {}
  end
  
  def add_node(name)
    @words[name] = {}
  end

  def connect(a, b, weight=1)
    if @words[a][b].nil? then
      @words[a][b] = weight
    else
      @words[a][b] += weight
    end
  end
  
  def edge_weight(a,b)
    @words[a][b] or Throw NoRelation
  end
  
  def contains?(name)
  end
  
  def out_degree_of(name)
    if @words[name].nil? then
      Throw NoNode
    else
      @words[name].size
    end
  end
  
end

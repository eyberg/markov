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

  # output a graphviz pic of
  # our graph
  def pretty_picture
    g = nil
    g = GraphViz::new( "G")

    @words.each do |k,v|
      blahnode = g.add_node(k)
    end

=begin
    main        = g.add_node( "main" )
    parse       = g.add_node( "parse" )
    execute     = g.add_node( "execute" )
    init        = g.add_node( "init" )
    cleanup     = g.add_node( "cleanup" )
    make_string = g.add_node( "make_string" )
    printf      = g.add_node( "printf" )
    compare     = g.add_node( "compare" )

    g.add_edge( main, parse )
    g.add_edge( parse, execute )
    g.add_edge( main, init )
    g.add_edge( main, cleanup )
    g.add_edge( execute, make_string )
    g.add_edge( execute, printf )
    g.add_edge( init, make_string )
    g.add_edge( main, printf )
    g.add_edge( execute, compare )
=end
    g.output( :output => "svg", :file => "graph.svg" )
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

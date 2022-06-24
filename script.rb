require 'pry-byebug'
# Create a method that takes two arrays of coordinates, start/finish, and returns the shortest path from start to finish
# First create a node for the starting coordinate
# If it's coordinate value is equal to the 2nd parameter, return it
# Otherwise, make children nodes out of all possible knight moves
# Push all-possible-move-children-nodes to an array and pass 
# If any of its children are equal to the 2nd parameter, return that child's coordinate value and its parents coordinate value
# If not, repeat on each child node, making more children nodes for all possible moves, then checking if their coordinate values are equal to the 2nd parameter
# If they are, return them and their parent
# Predecessor attribute holds the previous move
# Distance attribute value adds +1 each time a node is traversed away from source node
# possible moves
# [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
# @nodes[[1, 1]].adjacent_nodes

def possible_moves
  [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
end

class Node
  attr_accessor :value, :adjacent_nodes, :parent_obj

  def initialize(value, parent_obj = nil)
    @value = value
    @adjacent_nodes = []
    @parent_obj = parent_obj
  end

  def add_edge(adjacent_node)
    @adjacent_nodes << adjacent_node
  end

  def to_s
    "#{@value} -> Adjacent Nodes: #{@adjacent_nodes.map(&:value)}"
  end
end

class Graph
  attr_accessor :nodes

  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.value] = node
  end

  def add_edge(node1, node2)
    @nodes[node1].add_edge(@nodes[node2])
    @nodes[node2].add_edge(@nodes[node1])
  end

  # def add_adjacent_nodes(root)
  #   i = 0

  #   while i <= 7
  #     adjacent_node = [root[0] + possible_moves[i][0], root[1] + possible_moves[i][1]]

  #     unless adjacent_node[0] < 0 || adjacent_node[0] > 7 || adjacent_node[1] < 0 || adjacent_node[1] > 7
  #       add_node(Node.new(adjacent_node, @nodes[root]))
  #       add_edge(root, adjacent_node)
  #     end

  #     i = i + 1
  #   end
  # end

  def add_adjacent_nodes(root)
    i = 0

    while i <= 7
      adjacent_node = [root[0] + possible_moves[i][0], root[1] + possible_moves[i][1]]

      if adjacent_node[0] > 0 && adjacent_node[0] < 8 && adjacent_node[1] > 0 && adjacent_node[1] < 8
        add_node(Node.new(adjacent_node, @nodes[root]))
        add_edge(root, adjacent_node)
      end

      i = i + 1
    end
  end

def knight_moves(root, destination)
  add_node(Node.new(root))

  queue = []
  queue.push(@nodes[root])
  path = []
  moves = 0

  loop do
    if queue[0].value == destination
      current = queue[0]

      until current.parent_obj == nil
        path << current.value
        current = current.parent_obj
        moves = moves + 1
      end

      path << current.value

      puts "You made it in #{moves} moves! Here's your path: #{path.reverse}"

      break
    else
      add_adjacent_nodes(queue[0].value)
      @nodes[queue[0].value].adjacent_nodes.map(&:value).each { |coordinate| queue.push(@nodes[coordinate]) }
      queue.shift
    end
  end
end
end

graph = Graph.new
graph.knight_moves([0, 0], [2, 3])
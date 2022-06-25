# Array of the 8 possible moves a Knight can make
def possible_moves
  [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
end
# new Nodes will represent coordinates on an 8x8 chess board
# value holds an array with two integers representing coordinates
# adjacent_nodes holds specific possible moves a Knight/Node can move from, from their value coordinate
# parent object directs to move/node that came before that node
class Node
  attr_accessor :value, :adjacent_nodes, :predecessor

  def initialize(value, predecessor = nil)
    @value = value
    @adjacent_nodes = []
    @predecessor = predecessor
  end
# The add_edge method adds nodes with legal move coordinates that a Knight can make to an instance variable array 
  def add_edge(adjacent_node)
    @adjacent_nodes << adjacent_node
  end

  def to_s
    "#{@value} -> Adjacent Nodes: #{@adjacent_nodes.map(&:value)}"
  end
end
# Graph is where the nodes will be stored and manipulated
class Graph
  attr_accessor :nodes
  # Nodes are stored in a hash for easy traversal
  # Their key value is the coordinate that Node represents (I.E. [0, 0])
  def initialize
    @nodes = {}
  end
  # Since value holds the coordinate that Node represents, use this as the key, with the node itself as the key value
  def add_node(node)
    @nodes[node.value] = node
  end
  # add_edge calls the Node class add_edge method, passing two nodes and updating their @adjacent_nodes instance variable array to hold each other
  def add_edge(node1, node2)
    @nodes[node1].add_edge(@nodes[node2])
    @nodes[node2].add_edge(@nodes[node1])
  end
  # add_adjacent_nodes calculates the moves a Knight is allowed to make its coordinate
  def add_adjacent_nodes(root)
    i = 0
    # Loop 8 times using add_node on all allowed possible moves
    8.times do
      # The roots x,y coordinates are added to in order to create a potential adjacent node
      adjacent_node = [root[0] + possible_moves[i][0], root[1] + possible_moves[i][1]]
      # Throws out moves outside the 8x8 board
      if adjacent_node[0] > 0 && adjacent_node[0] < 8 && adjacent_node[1] > 0 && adjacent_node[1] < 8
        # The node passed as root is given as the predecessor
        add_node(Node.new(adjacent_node, @nodes[root]))
        # Edge is added between root and new adjacent node
        add_edge(root, adjacent_node)
      end

      i = i + 1
    end
  end

  def knight_moves(root, destination)
  # two queues, one to compare value, another to add children to value checking queue
  # a third array, checked, to store already visited nodes
  add_node(Node.new(root))
  queue = []
  queue.push(@nodes[root])
  path = []
  moves = 0
  next_queue = []
  checked = []

loop do
    until queue.empty?
      if queue[0].value == destination

        current = queue[0]

        until current.predecessor == nil
          path << current.value
          current = current.predecessor
          moves = moves + 1
        end

        path << current.value

        puts "You made it in #{moves} moves! Here's your path: #{path.reverse}"
        made_it = true
        break
      else
        next_queue.push(queue[0])
        queue.shift
      end
    end
    break if made_it == true
      # loop through next_queue, adding each items childrens (adjacent nodes) to the graph
      next_queue.each do |node|
        add_adjacent_nodes(node.value) unless checked.any?(node.value)
        checked.push(node.value)
        @nodes[node.value].adjacent_nodes.map(&:value).each { |coordinate| queue.push(@nodes[coordinate]) }
      end
      # once all children of items in next_queue are in the queue to check for value, clear the next_queue
      next_queue.clear
    end
  end
end

graph = Graph.new
graph.knight_moves([0, 0], [7, 7])
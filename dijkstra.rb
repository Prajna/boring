module Dijkstra
  class Edge
    attr_accessor :start_vertex, :end_vertex, :distance

    def initialize start_vertex, end_vertex, distance
      @start_vertex, @end_vertex, @distance = start_vertex, end_vertex, distance
    end
  end


  class MinimalPath
    attr_accessor :start_vertex, :path, :distance

    def initialize start_vertex, path, distance
      @start_vertex, @path, @distance = start_vertex, path, distance
    end

    class << self
      def build_from_edge edge
        new edge.start_vertex, [edge.end_vertex], edge.distance
      end
    end

    def merge edge
      MinimalPath.new @start_vertex, path.dup << edge.end_vertex, @distance + edge.distance
    end
  end


  class Graph
    def initialize edges
      @edges = edges.each_with_object([]) { |edge, r| r << Edge.new(edge[0], edge[1], edge[2]) }

      @visited = Hash.new false

      @minimal_paths = []
    end

    def find_minimal_path_from current_vertex
      mark_as_visited current_vertex

      update_minimal_paths

      @minimal_paths.select { |path| !@visited.has_key?(path.path.last) }.min_by { |path| path.distance }
    end

    private
    def mark_as_visited vertex
      @current_vertex = vertex
      @visited[vertex] = true
    end

    def update_minimal_paths
      all_edges_from_start_vertex_to_unvisited_vertices.each do |edge|
        original_minimal_path  = minimal_path_which_end_vertex_is(edge.start_vertex)
        candidate_minimal_path = original_minimal_path.nil? ? MinimalPath.build_from_edge(edge) : original_minimal_path.merge(edge)

        compare candidate_minimal_path, minimal_path_which_end_vertex_is(edge.end_vertex)
      end
    end

    def all_edges_from_start_vertex_to_unvisited_vertices
      @edges.select { |edge| edge.start_vertex == @current_vertex && !@visited.has_key?(edge.end_vertex) }
    end

    def minimal_path_which_end_vertex_is vertex
      @minimal_paths.select { |minimal_path| minimal_path.path.last == vertex }.first
    end

    def compare candidate, original
      if original.nil? || original.distance > candidate.distance
        @minimal_paths.delete original
        @minimal_paths << candidate
      end
    end
  end

  class Computation
    START_VERTEX = 1
    END_VERTEX   = 5

    class << self
      def go graph
        current_path = MinimalPath.new(START_VERTEX, [START_VERTEX], 0)

        begin
          current_path = graph.find_minimal_path_from(current_path.path.last)
        end while current_path.path.last != END_VERTEX

        current_path
      end
    end
  end
end

graph = Dijkstra::Graph.new [[1, 2, 7],
                             [1, 3, 9],
                             [1, 6, 14],
                             [2, 3, 10],
                             [2, 4, 15],
                             [3, 4, 11],
                             [3, 6, 2],
                             [4, 5, 6],
                             [6, 5, 9]]


p Dijkstra::Computation.go graph

defmodule Ep1Test do
  use ExUnit.Case
  doctest EP1

  test "reflexivo" do
    graph = Graph.new() |> Graph.add_edges([{0,1}, {0,2}, {1,2}, {2,3}])
    r_graph = Graph.new() |> Graph.add_edges([{0,1}, {0,2}, {1,2}, {2,3}, {0,0}, {1,1}, {2,2}, {3,3}])
    assert(EP1.reflexive(graph) == r_graph)
  end

  test "transitivo" do
    graph = Graph.new() |> Graph.add_edges([{0,1}, {1,2}, {2,3}])
    t_graph = Graph.new() |> Graph.add_edges([{0,1}, {1,2}, {2,3}, {0,2}, {0,3}, {1,3}])
    assert(EP1.transitive(graph) == t_graph)
  end

  test "transitivo reflexivo vazio" do
    graph = Graph.new()
    tr_graph = Graph.new()
    assert(EP1.transitive_reflexive(graph) == tr_graph)
  end

  test "transitivo 1 vértice" do
    graph = Graph.new() |> Graph.add_vertex(0)
    t_graph = Graph.new() |> Graph.add_vertex(0)
    assert(EP1.transitive(graph) == t_graph)
  end

  test "reflexivo 1 vértice" do
    graph = Graph.new() |> Graph.add_vertex(0)
    r_graph = Graph.new() |> Graph.add_edge(0,0)
    assert(EP1.reflexive(graph) == r_graph)
  end

  test "transitivo reflexivo" do
    graph = Graph.new() |> Graph.add_edges([{0,1}, {0,2}, {1,2}, {2,3}, {3,4}])
    tr_graph = Graph.new() |> Graph.add_edges([{1,3}, {1,4}, {1,2}, {3,4}, {2,3}, {2,4}, {0,1}, {0,3}, {0,4}, {0,2}, {1,1}, {0,0}, {2,2}, {3,3}, {4,4}])
    assert EP1.transitive_reflexive(graph) == tr_graph
  end

  test "transitivo reflexivo com loop" do
    graph = Graph.new() |> Graph.add_edges([{0,1}, {1,3}, {1,4}, {2,0}, {3,2}, {4,3}])
    tr_graph = Graph.new() |> Graph.add_edges([{1,1}, {1,3}, {1,4}, {1,2}, {1,0}, {3,1}, {3,3}, {3,4}, {3,2}, {3,0}, {4,1}, {4,3}, {4,4}, {4,2}, {4,0}, {2,1}, {2,3}, {2,4}, {2,2}, {2,0}, {0,1}, {0,3}, {0,4}, {0,2}, {0,0}])
    assert EP1.transitive_reflexive(graph) == tr_graph
  end

  test "transitivo reflexivo com vértice não ligado" do
    graph = Graph.new |> Graph.add_edges([{0,1}, {1,2}, {2,3}, {3,4}]) |> Graph.add_vertex(5)
    tr_graph = Graph.new |> Graph.add_edges([{0,1}, {1,2}, {2,3}, {3,4}, {0,2}, {0,3}, {0,4}, {1,3}, {1,4}, {2,4}, {0,0}, {1,1}, {2,2}, {3,3}, {4,4}, {5,5}])
    assert EP1.transitive_reflexive(graph) == tr_graph
  end
end

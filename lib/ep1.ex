defmodule EP1 do

  def transitive_reflexive(graph) do
    transitive(graph) |> reflexive
  end

  def reflexive(graph), do: reflexive(Graph.vertices(graph), graph)

  def transitive(graph), do: transitive(Graph.edges(graph), graph, [])

  defp reflexive([], graph) do
    graph
  end

  defp reflexive([current_vertex|other_vertices], graph) do
    reflexive(other_vertices, Graph.add_edge(graph, current_vertex, current_vertex))
  end

  defp closure([], current_vertex, new_edges, edges_done) do
    {new_edges, edges_done}
  end

  defp closure([current_edge|other_edges], current_vertex, new_edges, edges_done) do
    if Enum.member?(edges_done, [current_vertex, current_edge]) do
      {new_edges, edges_done}
    else
      new_edge = Graph.Edge.new(current_vertex, current_edge.v2)
      closure(other_edges, current_vertex, [new_edge|new_edges], [[current_vertex, current_edge]|edges_done])
    end
  end

  defp transitive([], graph, edges_done) do
    graph
  end

  defp transitive([current_edge|other_edges], graph, edges_done) do
    {new_edges, new_edges_done} = closure(Graph.out_edges(graph, current_edge.v2), current_edge.v1, [], edges_done)
    new_list = Enum.reduce(new_edges, other_edges, fn new_edge, acc ->
      [new_edge|acc]
    end)
    new_graph = Enum.reduce(new_edges, graph, fn new_edge, acc ->
      Graph.add_edge(acc, new_edge)
    end)
    transitive(new_list, new_graph, new_edges_done)
  end
end

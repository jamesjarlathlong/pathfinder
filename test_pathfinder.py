import pytest
from pathfinder.pathfinder import weight_builder, get_minweighted_unvisited_key, run_dijkstra
@pytest.fixture(scope="module")
def generate_dummy_graph():
	graph = {'a': {'c': 2},
	         'b': {'a': 3, 'd': 8},
	         'c': {'a': 2, 'd': 7, 'e': 5},
	         'd': {'e': 10, 'a': 6, 'b':8, 'c':7},
	         'e': {}}
	return graph

def test_weight_builder(generate_dummy_graph):
	initial_weight = weight_builder('a', generate_dummy_graph)
	assert initial_weight == {'a':(0, None), 'b': (float("inf"), None),
							  'c':(float("inf"), None),  'd':(float("inf"), None),
							  'e':(float("inf"), None)}
def test_get_minweighted_key():
	sample_weight = {1:(5.3, 1), 2: (1.6, 3), 3: (4.6, 3), 4:(1.2, 3)}
	unvisited = [1,3,4]
	assert get_minweighted_unvisited_key(sample_weight, unvisited) == 4

def test_dijkstra_tree_from_a(generate_dummy_graph):
	shortest_path_tree = run_dijkstra('a', generate_dummy_graph)
	print('tree: ', shortest_path_tree)


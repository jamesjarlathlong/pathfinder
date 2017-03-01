import copy
import functools

def adjust(adjust_function, kv, k):
    new_kv = copy.deepcopy(kv)
    new_kv[k] = adjust_function(new_kv[k])
    return new_kv

def relax_adjustment(weights, rootnode, current_cumulative_distance):
	tentative_distance = weights[rootnode][0] + current_cumulative_distance
	tentative_predecessor = rootnode
	adjustment_function = functools.partial(min, (tentative_predecessor, tentative_predecessor))

def relax_one(node, neighbor_kv, weights)
	###careful: the haskell version graph structure returns something like
	### graph[node]-> [('a',3),('b',4)] whereas ours returns {'a':3, 'b':4}
	neighbor_weight = neighbor_kv[1]
	neighbor_name = neighbor_kv[0]
	adjuster = functools.partial(relax_adjustment, weights, node, neighbor_weight)
	return adjust(adjuster, weights, neighbor_name)

def weight_builder(source_node, graph):
	"""builds the initial weight data structure based on the graph and
	the source_node key, the sourcenode is initialised with weight 0
	while all others have infinite weight"""
	return {key: (0 if key==source_node else float("inf"), None) for key in graph}

def dijkstraStep(graph, weights, unvisited_keys):
	if not unvisited_keys:
		return weights
	else:
		current_node = get_minweighted_unvisited_key(weights, unvisited_keys)
		neighbors_of_current = graph[current_node]


def get_minweighted_unvisited_key(weights, unvisited_keys):
	"""from the weight dictionary return the key corresponding
	to the minimum weight"""
	candidate_weights = {k:v for k,v in weights.items() if k in unvisited_keys}
	return min(candidate_weights, key=lambda k: candidate_weights[k][0])

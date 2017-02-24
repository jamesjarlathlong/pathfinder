import Data.List
import qualified Data.List.Key as K
import Data.Map ((!), fromList, fromListWith, adjust, keys, Map)
buildGraph :: Ord a => [(a, a, Float)] -> Map a [(a, Float)]
buildGraph g = fromListWith (++) listified where 
	tupletoList (a,b,d) = [(a,[(b,d)])]
	listified = concat $ map tupletoList g

buildWeights :: (Ord a) => a-> Map a [(a, Float)] -> Map a (Float, Maybe a)
buildWeights source graph = let 
	lst = [(node, (if node == source then 0 else 1/0, Nothing))|node<- keys graph]
	in fromList lst

getWeightbyKey :: (Ord a) => Map a (Float, Maybe a) -> a -> Float
getWeightbyKey weights key = fst (weights ! key)

minWeightKey :: (Ord a) => Map a (Float, Maybe a) -> [a] -> a
minWeightKey weights ks = let
	getWeightforKey = (getWeightbyKey weights)
	in K.minimum getWeightforKey ks

relaxAdjustment :: (Ord a) => Map a (Float, Maybe a)-> a -> Float -> (Float, Maybe a)->(Float, Maybe a)
relaxAdjustment weights rootnodeName neighborWeight = let
	tentativeWeight = fst (weights ! rootnodeName) + neighborWeight
	tentativePredecessor = Just rootnodeName
	in min (tentativeWeight, tentativePredecessor)

relax::(Ord a)=> a -> (a, Float) -> Map a (Float, Maybe a) -> Map a (Float, Maybe a)
relax currentnode (neighborName, neighborWeight) weights  = let
	adjusterFn = relaxAdjustment weights currentnode neighborWeight
	in adjust adjusterFn neighborName weights

dijkstraStep :: Ord a => Map a [(a, Float)] -> Map a (Float, Maybe a) -> [a] -> Map a (Float, Maybe a)
dijkstraStep graph weights [] = weights
dijkstraStep graph weights unvisited = dijkstraStep graph (foldr relaxer weights neighbors) (delete currentnode unvisited) where
	currentnode = minWeightKey weights unvisited
	neighbors = graph ! currentnode
	relaxer = relax currentnode

dijkstra :: Ord a => a -> Map a [(a, Float)] -> Map a (Float, Maybe a)
dijkstra source graph = dijkstraStepper initialWeights initialUnvisited where
	initialWeights = buildWeights source graph
	initialUnvisited = keys graph
	dijkstraStepper = dijkstraStep graph

shortestPath :: (Ord a) => a -> a -> Map a [(a, Float)] -> [a]
shortestPath source destination graph = reverse $ tracer destination where
	tracer node = node : maybe [] tracer (snd $ dijkstra source graph ! node)

d = [('a','c',2::Float), ('a','d',6::Float), ('b','a',3::Float),('b','d',8::Float)
	 ,('c','d',7::Float), ('c','e',5::Float) ,('d','e',10::Float), ('c','a',2::Float),
	 ('d','a',6::Float), ('a','b',1::Float),('d','b',8::Float),('d','c',7::Float)]

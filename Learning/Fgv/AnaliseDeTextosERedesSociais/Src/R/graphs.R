require(igraph)

bidirectionalGraph <- graph.formula(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 4-6, 4-7, 5-6, 6-7)

plot(bidirectionalGraph)

orientedGraph <- graph.formula(1-+2, 1-+3, 2++3, 3+-+4)

plot(orientedGraph)

reducedGraph <- bidirectionalGraph - vertices(c(6,7))

plot(reducedGraph)

restoredGraph <- reducedGraph + 
    vertices(c(6,7)) + 
    edges(c(5,6), c(4,6), c(4,7), c(6,7))

plot(restoredGraph)

bidirectionalGraph2  <- graph.formula(5-6, 4-6, 4-7, 6-7)

plot(bidirectionalGraph2)

unionGraph  <- graph.union(bidirectionalGraph, bidirectionalGraph2)

treeGraph <- graph.formula(1-+2, 1-+3, 1-+4, 2-+5, 2-+6, 2-+7, 3-+8, 3-+9, 4-+10)

parent={}
topo=[] 
def DFS(Adj):
    node=[]
    for i in range(0, len(Adj)):
        node.append(i)

    for s in node:
        if s not in parent:
            print "From node %d:" %s
            print s            
            parent[s]=None
            DFS_recursive(Adj, s)
    print "Recursion order (topological sort for directed acyclic graphs):"
    topo.reverse()    
    print topo


def DFS_recursive(Adj, s):
    for v in Adj[s]:
        if v not in parent:                
            print v
            parent[v]=s
            DFS_recursive(Adj, v)
    topo.append(s)
        

def BFS(Adj, s):
    level={s:0}
    parent={s:None}
    i=1
    frontier=[s]
    print s
    while frontier:
        next=[]
        for u in frontier:
            for v in Adj[u]:
                if v not in  level:
                    level[v]=i
                    parent[v]=u
                    next.append(v)
                    print v
        frontier=next
        i+=1
    print level
    
def Dijkstra(Adj, s):
    Q={}
    dist={}
    for i in range(0, len(Adj)):
        Q[i]=float("inf")
        dist[i]=float("inf")
    Q[s]=0
    while Q:
        u = min(Q, key=Q.get)
        dist[u] = Q[u]
        for v in Adj[u]:
            if v in Q:
                if Q[v] > Q[u] + Adj[u][v]:
                    Q[v] = Q[u] + Adj[u][v]
        Q.pop(u)
    print dist

v=[[1,2],[0,2,4],[0,1,3],[2,4,5],[1,3,5],[3,4]]
w=[[1,2],[],[],[0,1,2]]
dag=[[1],[2,3,5],[4],[7],[],[6],[],[]]
weight=[{1:10,2:3},{2:1, 3:2},{1:4, 3:8, 4:2},{4:7},{3:9}]
killer=[{1:16,2:0},{2:-32},{3:8,4:0},{4:-16},{5:4,6:0},{6:-8},{7:2,8:0},{8:-4},{9:1,10:-2},{}]
non_co=[{1:1, 2:1},{2:1, 3:1},{3:1, 5:1},{4:1},{},{},{},{6:1}]
non_dir=[{1:8,3:2},{0:8,2:5,3:3,4:1},{1:5,3:2,4:4},{0:2,1:3,2:2},{1:1,2:4}]
Dijkstra(non_dir,0)



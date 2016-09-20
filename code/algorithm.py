from UnionFind import UnionFind


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
    
topo=[]
def TopologicalSort(Adj):
    node=[]
    for i in range(0, len(Adj)):
        node.append(i)

    for s in node:
        if s not in parent:
            parent[s]=None
            DFS_recursive(Adj, s)
    #topo.reverse()    
    return topo

    

#______________________________________________________________________________

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
    
#______________________________________________________________________________    
    
def Dijkstra(Adj, s):
    Q={}
    dist={}
    tree={}
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
                    tree[v] = u
        Q.pop(u)
        
    return dist, tree

#    print "Distances:"
#    print dist
#    print "Shortest-path tree:"
#    print tree

#______________________________________________________________________________
    
def BellmanFord(Adj, s):
    dist={}
    tree={}
    for i in range(0, len(Adj)):
        dist[i]=float("inf")
        tree[i]=None
    dist[s]=0
    
    for i in range(0, len(Adj)-1):
        for u in range(0, len(Adj)):
            for v in Adj[u]:
                if dist[v] > dist[u] + Adj[u][v]:
                    dist[v] = dist[u] + Adj[u][v]
                    tree[v]=u
    for u in range(0, len(Adj)):
        for v in Adj[u]:
            if dist[v] > dist[u] + Adj[u][v]:
                print "There are negative-weight cycles"
                break
    return dist, tree
#    print "Distances:"
#    print dist
#    print "Shortest-path tree:"
#    print tree
    
#______________________________________________________________________________    
    
def Prim(Adj):
    Q={}
    tree={}
    for i in range(0,len(Adj)):
        Q[i]=float("inf")
    Q[0]=0
    while Q:
        u = min(Q, key=Q.get)
        for v in Adj[u]:
            if v in Q and Adj[u][v] < Q[v]:
                Q[v] = Adj[u][v]
                tree[v] = u
        Q.pop(u)
    return tree
                
#______________________________________________________________________________                
                
def Kruskal(Adj):
    subtree = UnionFind()
    tree = [] 
    for e, u, v in sorted((Adj[u][v],u,v) for u in Adj for v in Adj[u]):
        for u in Adj:
            for v in Adj[u]:
                if subtree[u] != subtree[v]:
                    tree.append((u,v))
                    subtree.union(u,v)
    return tree
 
#______________________________________________________________________________

def FloydWarshall(Adj):
    dist=[[float("inf") for x in range(len(Adj))] for y in range(len(Adj))]
    for i in range(0,len(Adj)):
       dist[i][i] = 0
    for v in range(len(Adj)):
        for u in Adj[v]:
            dist[v][u] = Adj[v][u]
    for x in range(len(Adj)):
        for u in range(len(Adj)):
            for v in range(len(Adj)):
                if dist[u][v] > dist[u][x] + dist[x][v]:
                    dist[u][v] = dist[u][x] + dist[x][v]
    return dist
                    
#______________________________________________________________________________    

def Hamilton_recursive(Adj, s, e, path):
    path = path + [s]
    if s == e:
        return path
    for n in Adj[s]:
        if n not in path:
            nou_path = Hamilton_recursive(Adj, n, e, path)
            if nou_path: 
                return nou_path
    return None
    
def Hamilton(Adj, s, e):
    path=[]
    return Hamilton_recursive(Adj, s, e, path)

    
def Hamilton2(Adj):
    Q=[]
    ban=[]
    Q.append(0)
    

#______________________________________________________________________________


def Euler(Adj):
    graf = Adj
    senar = [v for v in graf.keys() if len(graf[v])%2 != 0]
    senar.append(graf.keys()[0])
    print senar
    
    if len(senar)>3:
        return None
        
    Q = [senar[0]]
    path = []
    while Q:
        v = Q[-1]
        if graf[v]:
            u = graf[v][0]
            Q.append(u)
            del graf[u][graf[u].index(v)]
            del graf[v][0]
        else:
            path.append(Q.pop())
            
    return path
    
#______________________________________________________________________________
    
#Avis: aixo basicament no fa res, no funciona. S'ha de fer que les funcions que
#conte retornin el que pertoca i comprovar que la sortida esta en el format que 
#toca. Tot i aixi, es una bona guia per entendre el que fa.
def Johnson(Adj):
    original = Adj
    new = Adj
    for i in range(len(Adj)):
        new[-1][i] = 0
    optimized, residual = BellmanFord(new, -1) #Bellman ford ha de tornar alguna cosa...
    
    for v in range(len(Adj)):
        for u in original[v]:
            original[v][u] = original[v][u] + optimized[v] - optimized[u]
    return Dijkstra(original, 0)
    
    
    
            


## Falten: Camins Eulerians(done), Camins Hamiltonians(cal repassar l'algorisme), A*, K*, Eppstein

v=[[1,2],[0,2,4],[0,1,3],[2,4,5],[1,3,5],[3,4]]
w=[[1,2],[],[],[0,1,2]]
dag=[[1],[2,3,5],[4],[7],[],[6],[],[]]
weight=[{1:10,2:3},{2:1, 3:2},{1:4, 3:8, 4:2},{4:7},{3:9}]
killer=[{1:16,2:0},{2:-32},{3:8,4:0},{4:-16},{5:4,6:0},{6:-8},{7:2,8:0},{8:-4},{9:1,10:0},{10:-2},{}]
non_co=[{1:1, 2:1},{2:1, 3:1},{3:1, 5:1},{4:1},{},{},{},{6:1}]
non_dir=[{1:8,3:2},{0:8,2:5,3:3,4:1},{1:5,3:2,4:4},{0:2,1:3,2:2},{1:1,2:4}]
lit=[{1:5,3:-2},{2:1},{3:2,5:3,4:7},{1:2},{5:10},{}]
test=[{1:1,2:10},{3:2},{3:-10},{4:3},{}]
prim=[{1:6,2:5,3:14,4:8},{0:6,2:12},{1:12, 0:5,5:7,6:9},{0:14,4:3},{0:8,3:3,5:10},{2:7,4:10,7:15},{2:9},{5:15}]
weight2={0:{1:10,2:3},1:{2:1, 3:2},2:{1:4, 3:8, 4:2},3:{4:7},4:{3:9}}
weight3={1:{2:1, 3:2},0:{1:10,2:3},2:{1:4, 3:8, 4:2},4:{3:9},3:{4:7}}
hamilton={0:[1,3],1:[0,2,4,5],2:[1,4,5],3:[1,2],4:[1,2],5:[1,2]}
treball={0:[3],1:[],2:[1,4,5,9,11],3:[],4:[0,3,7,9],5:[6,7,10],6:[],7:[],8:[2,7],9:[],10:[11],11:[]}
euler={0:[1,3],1:[0,2,4,5],2:[1,3,4,5],3:[0,2],4:[1,2],5:[1,2]}
euler2={0:[1,2,3],1:[0,2,3],2:[0,1,3,4],3:[0,1,2,4],4:[3,2]}
proves_dijkstra={0:{1:3,2:4},1:{},2:{1:-2}}
hamilton2={0:[2,3,5,1],1:[0,2,4,5],2:[0,1,3,4],3:[0,2,4,5],4:[1,2,3,5],5:[0,1,3,4]}

Dijkstra(proves_dijkstra, 0)
DFS(dag)
print Hamilton(hamilton2, 0,5)
print TopologicalSort(dag)
#print Euler(euler2)
#print euler2
#print 6&1
#Dijkstra(weight,0)
#BellmanFord(weight,0)
#Prim(weight)
#BFS(weight,0)
#DFS(weight)
#Kruskal(weight2)
#Hamilton(hamilton, 0, 0)
#BFS(non_dir, 0)
#FloydWarshall(killer)
#for v in range(len(weight3)):
#    print "v: %d" %v
#    for u in weight3[v]:
#        print "u: %d" %u
#        print "weight: %d" %weight3[v][u]



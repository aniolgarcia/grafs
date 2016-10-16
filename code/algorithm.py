# -*- coding: Latin-1 -*-
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


def OrderedDijkstra(Adj, s):
    Q = dict.fromkeys(Adj.keys(), float("inf"))
    dist = dict.fromkeys(Adj.keys(), float("inf"))
    tree = {}
    Q[s] = 0
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

#    
#def Hamilton2(Adj):
#    Q=[]
#    ban=[]
#    Q.append(0)
    

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

def coloring(Adj):
    graph = sorted(Adj, key=lambda k:len(Adj[k]), reverse=True)
    colors = {}
    usat = False
    actual = 0
    
    for i in range(0, len(Adj)):
        colors[i]=None
    colors[graph[0]]=0
    
    while None in colors.values():     
        for v in graph:
            if colors[v] == None:
                for k in Adj[v]:
                    if colors[k] == actual:
                        usat = True
                        break
                    
                if usat == False:
                    colors[v] = actual
                usat = False
        actual = actual + 1
    return colors
                    
   
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
    
#______________________________________________________________________________    

def metro(Adj, inici, final):
    recorregut=[]
    
    print "Punt inicial:", inici.decode("ISO-8859-15")
    
    print "Punt final:", final.decode("ISO-8859-15")
    
    dist, tree = OrderedDijkstra(Adj, inici)
    print type(inici)
    print type(final)
    print "Temps total del recorregut:", dist[final]

    print "Recorregut:",
    
    #inici = inici.encode("latin1")
    #final = final.encode("latin1")

    i = final
    
    #recorregut.append(i)
    while tree[i] != inici:
        recorregut.append(tree[i])
        i = tree[i]
        
    recorregut.reverse()
    print "[",
    for i in range(0,len(recorregut)):
        print recorregut[i].decode("ISO-8859-15")+",",

    print final.decode("ISO-8859-15"),"]"         
    
    
    
#______________________________________________________________________________
    
            


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
bipartite={0:[4,5,6,7],1:[4,5,6,7],2:[4,5,6,7],3:[4,5,6,7],4:[0,1,2,3],5:[0,1,2,3],6:[0,1,2,3],7:[0,1,2,3]}
proves_decimals2={0:{1:10,2:3},1:{2:1,3:2},2:{1:4,3:8,4:2},3:{4:7},4:{3:9}}
proves_decimals3={100:{101:10,102:3},101:{102:1,103:2},102:{101:4,103:8,104:2},103:{104:7},104:{103:9}}
proves_decimals={1.0:{1.1:10,1.2:3},1.1:{1.2:1,1.3:2},1.2:{1.1:4,1.3:8,1.4:2},1.3:{1.4:7},1.4:{1.3:9}}
proves_decimals4={"a":{"a":10,1.2:3},1.1:{1.2:1,1.3:2},1.2:{1.1:4,1.3:8,1.4:2},1.3:{1.4:7},1.4:{1.3:9}}
graf_metro={"1_Hospital de Bellvitge":{"1_Bellvitge":1}, "1_Bellvitge":{"1_Hospital de Bellvitge":1, "1_Av. Carrilet":1},"1_Av. Carrilet":{"1_Bellvitge":1, "1_Rbla. Just Oliveras":1, "8_L'Hospitalet - Av. Carrilet":1}, "1_Rbla. Just Oliveras":{"1_Av. Carrilet":1, "1_Can Serra":1}, "1_Can Serra":{"1_Rbla. Just Oliveras":1, "1_Florida":1}, "1_Florida":{"1_Can Serra":1, "1_Torrassa":1}, "1_Torrassa":{"1_Florida":1, "1_Santa Eulàlia":1, "9S_Torrassa":1}, "1_Santa Eulàlia":{"1_Torrassa":1,"1_Mercat Nou":1}, "1_Mercat Nou":{"1_Santa Eulàlia":1, "1_Plaça de Sants":1}, "1_Plaça de Sants":{"1_Mercat Nou":1, "1_Hostafrancs":1, "5_Plaça de Sants":1}, "1_Hostafrancs":{"1_Plaça de Sants":1, "1_Espanya":1}, "1_Espanya":{"1_Hostafrancs":1, "1_Rocafort":1, "3_Espanya":209, "8_Espanya":1}, "1_Rocafort":{"1_Espanya":1, "1_Urgell":1}, "1_Urgell":{"1_Rocafort":1, "1_Universitat":1}, "1_Universitat":{"1_Urgell":1, "1_Catalunya":50, "2_Universitat":1}, "1_Catalunya":{"1_Universitat":50, "1_Urquinaona":52, "3_Catalunya":229, "6_Catalunya":229, "7_Catalunya":229}, "1_Urquinaona":{"1_Catalunya":52, "1_Arc de Triomf":1, "4_Urquinaona":256}, "1_Arc de Triomf":{"1_Urquinaona":1, "1_Marina":1}, "1_Marina":{"1_Arc de Triomf":1, "1_Glòries":1}, "1_Glòries":{"1_Marina":1, "1_Clot":1}, "1_Clot":{"1_Glòries":1,"1_Navas":1, "2_Clot":180}, "1_Navas":{"1_Clot":1, "1_La Sagrera":1}, "1_La Sagrera":{"1_Navas":1, "1_Fabra i Puig":1, "5_La Sagrera":133, "9N_La Sagrera":133, "10_La Sagrera":133}, "1_Fabra i Puig":{"1_La Sagrera":1, "1_Sant Andreu":1}, "1_Sant Andreu":{"1_Fabra i Puig":1, "1_Torras i Bages":1}, "1_Torras i Bages":{"1_Sant Andreu":1, "1_Trinitat Vella":1}, "1_Trinitat Vella":{"1_Torras i Bages":1, "1_Baró de Viver":1}, "1_Baró de Viver":{"1_Trinitat Vella":1, "1_Santa Coloma":1}, "1_Santa Coloma":{"1_Baró de Viver":1, "1_Fondo":1}, "1_Fondo":{"1_Santa Coloma":1, "9N_Fondo":140}, "2_Paral·lel":{"2_Sant Antoni":1, "3_Paral·lel":83}, "2_Sant Antoni":{"2_Paral·lel":1, "2_Universitat":1}, "2_Universitat":{"2_Sant Antoni":1, "2_Passeig de Gràcia":80, "1_Universitat":144}, "2_Passeig de Gràcia":{"2_Universitat":80, "2_Tetuan":1, "3_Passeig de Gràcia":238, "4_Passeig de Gràcia":238}, "2_Tetuan":{"2_Passeig de Gràcia":1, "2_Monumental":1}, "2_Monumental":{"2_Tetuan":1, "2_Sagrada Família":1}, "2_Sagrada Família":{"2_Monumental":1, "2_Encants":1, "5_Sagrada família":178}, "2_Encants":{"2_Sagrada Família":1, "2_Clot":1}, "2_Clot":{"2_Encants":1, "2_Bac de Roda":1, "1_Clot":180}, "2_Bac de Roda":{"2_Clot":1, "2_Sant Martí":1}, "2_Sant Martí":{"2_Bac de Roda":1, "2_La Pau":1}, "2_La Pau":{"2_Sant Martí":1, "2_Verneda":1, "4_La Pau":165}, "2_Verneda":{"2_La Pau":1, "2_Artigues Sant Adrià":1}, "2_Artigues Sant Adrià":{"2_Verneda":1, "2_Sant Roc":1}, "2_Sant Roc":{"2_Artigues Sant Adrià":1, "2_Gorg":1}, "2_Gorg":{"2_Sant Roc":1, "2_Pep Ventura":1, "10_Gorg":50}, "2_Pep Ventura":{"2_Gorg":1, "2_Badalona Pompeu Fabra":1}, "2_Badalona Pompeu Fabra":{"2_Pep Ventura":1}, "3_Zona Universitària":{"3_Palau Reial":1, "9S_Zona Universitària":1}, "3_Palau Reial":{"3_Zona Universitària":1, "3_Maria Cristina":1}, "3_Maria Cristina":{"3_Palau Reial":1, "3_Les Corts":1}, "3_Les Corts":{"3_Maria Cristina":1, "3_Plaça del Centre":1}, "3_Plaça del Centre":{"3_Les Corts":1, "3_Sants Estació":1},"3_Sants Estació":{"3_Plaça del Centre":1, "3_Tarragona":1, "5_Sants Estació":232},"3_Tarragona":{"3_Sants Estació":1, "3_Espanya":1}, "3_Espanya":{"3_Tarragona":1, "3_Poble Sec":1, "1_Espanya":209, "8_Espanya":209}, "3_Poble Sec":{"3_Espanya":1, "3_Paral·lel":1}, "3_Paral·lel":{"3_Poble Sec":1, "3_Drassanes":1, "2_Paral·lel":83}, "3_Drassanes":{"3_Paral·lel":1, "3_Liceu":1}, "3_Liceu":{"3_Drassanes":1, "3_Catalunya":1}, "3_Catalunya":{"3_Liceu":1, "3_Passeig de Gràcia":98, "1_Catalunya":229, "6_Catalunya":229, "7_Catalunya":229}, "3_Passeig de Gràcia":{"3_Catalunya":98, "3_Diagonal":92, "2_Passig de Gràcia":238, "4_Passeig de Gràcia":238}, "3_Diagonal":{"3_Passeig de Gràcia":92, "3_Fontana":1, "5_Diagonal":217, "6_Provença":1, "7_Provença":1}, "3_Fontana":{"3_Diagonal":1, "3_Lesseps":1}, "3_Lesseps":{"3_Fontana":1, "3_Vallcarca":1}, "3_Vallcarca":{"3_Lesseps":1, "3_Penitents":1}, "3_Penitents":{"3_Vallcarca":1, "3_Vall d'Hebron":1}, "3_Vall d'Hebron":{"3_Penitents":1, "3_Montbau":1, "5_Vall d'Hebron":290}, "3_Montbau":{"3_Vall d'Hebron":1, "3_Mundet":1}, "3_Mundet":{"3_Montbau":1, "3_Valldaura":1}, "3_Valldaura":{"3_Mundet":1, "3_Canyelles":1}, "3_Canyelles":{"3_Valldaura":1, "3_Roquetes":1}, "3_Roquetes":{"3_Canyelles":1, "3_Trinitat Nova":1}, "3_Trinitat Nova":{"3_Roquetes":1, "4_Trinitat Nova":193, "11_Trinitat Nova":193},"7_Catalunya":{"7_Provença":1,"1_Catalunya":1,"3_Catalunya":1,"6_Catalunya":1},"7_Provença":{"7_Catalunya":1, "7_Gràcia":1, "3_Diagonal":1, "5_Diagonal":1, "6_Provença":1},"7_Gràcia":{"7_Provença":1,"7_Plaça Molina":1,"6_Gràcia":1},"7_Plaça Molina":{"7_Gràcia":1,"7_Pàdua":1, "6_Sant Gervasi":1},"7_Pàdua":{"7_Plaça Molina":1,"7_El Putxet":1},"7_El Putxet":{"7_Pàdua":1, "7_Av. Tibidabo":1}, "7_Av. Tibidabo":{"7_El Putxet":1}}
#print OrderedDijkstra(proves_decimals,1.0)
#print Dijkstra(proves_decimals2,0)
a,b = OrderedDijkstra(graf_metro,"1_Torrassa")
print type("1_Catalunya")
metro(graf_metro, "7_Av. Tibidabo", "3_Palau Reial")
#print FloydWarshall(proves_decimals)
#Dijkstra(proves_dijkstra, 0)
#DFS(dag)
#print Hamilton(hamilton2, 0,5)
#print TopologicalSort(dag)
#print coloring(bipartite)
#print sorted(euler, key=len)
#print sorted(proves_dijkstra, key=lambda k: len(proves_dijkstra[k]), reverse=True)
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
#print FloydWarshall(killer)
#for v in range(len(weight3)):
#    print "v: %d" %v
#    for u in weight3[v]:
#        print "u: %d" %u
#        print "weight: %d" %weight3[v][u]



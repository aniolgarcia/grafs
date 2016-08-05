parent={}
def DFS(Adj):
	node=[]
	for i in range(0, len(Adj)):
	   node.append(i)

	for s in node:
		if s not in parent:
			parent[s]=None
			DFS_recursive(Adj, s)


def DFS_recursive(Adj, s):
	for v in Adj[s]:
		if v not in parent:
			parent[v]=s
			DFS_recursive(Adj, v)

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

v=[[1,2],[0,2,4],[0,1,3],[2,4,5],[1,3,5],[3,4]]
DFS(v)

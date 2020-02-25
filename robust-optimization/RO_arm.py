"""
learn from xprog and bertsimas's paper(price of robustness)
http://xprog.weebly.com/
the initial model cann't be solved by gurobi or cplex
the problem has an equivalent linear formulation as follows:
    max  z
    s.t. z<=sum(p[i]x[i])-(sum(Q[i])+Γ[i]m[i])
        Q[i]+m[i]>=σ[i]x[i]
        Q[i]>=0
        m[i]>=0
        sum(x[i])=1
        x[i]>=0
Γis the protection level of the actual portfolio return in the following sense

"""
from gurobipy import *
import pandas as pd
import numpy as np

try:
    m = Model("RO")
#read

    data = pd.read_excel (r'sur.arm150.xlsx')
    #for an earlier version of Excel, you may need to use the file extension of 'xls'
    #print (data.p)
    #print (data.se)
    # Convert the dictionary into DataFrame
    df = pd.DataFrame(data)
#    print(df['se'])
#establishment of constant
    N = 150
    phi = 20#0.5#2
    σ = df['se']#[]
    p = df['p']#[]
    Γ= []
    for n in range(1,N+1):
        #σ.append(0.05/450*(2*n*150*151)**0.5)
        #p.append(1.15+n*0.05/150)
        #σ.append(df.se)
    #    σ.append(df['se'])
        #p.append(df.p)
    #    p.append(df['p'])
        Γ.append(phi)
#Add variables
#    x = m.addVars(N,lb=0.0001,name='x')
    x = m.addVars(N,lb=0,name='x')
#    x = m.addVars(N,lb=0,name='x')
    z = m.addVar(name='z')
    Q = m.addVars(N,name='Q')
    mm = m.addVars(N,name='m')

    px = sum(p[i]*x[i] for i in range(N))
    QC =sum(Q[i] for i in range(N))

# Add Constrs
    m.addConstrs((z<=px-mm[i]*Γ[i]-QC for i in range(N)),name='first')
    m.addConstrs((mm[i]+Q[i]>=σ[i]*x[i] for i in range(N)),name='second')
    m.addConstr(sum(x[i] for i in range(N))==1,name='third')
#    m.addConstr(np.count_nonzero(x[i] for i in range(N))==10,name='forth')
#set obj
    m.setObjective(z,GRB.MAXIMIZE)

#print model
    m.write ("RO.lp")

#solve model
    m.optimize()
#print variables
    for v in m.getVars ():
         print ('%s: %g' % (v.varName, v.x))
    print("non-zero of x: %s " % np.count_nonzero(x[i] for i in range(N)))

#write   https://www.guru99.com/reading-and-writing-files-in-python.html
    f= open("sur.arm20.txt","w+")
    for v in m.getVars ():
        f.write("%s: %g\r\n" % (v.varName, v.x))
    f.close()


except GurobiError as e:
    print('Error code ' + str(e.errno) + ": " + str(e))

except AttributeError:
    print('Encountered an attribute error')

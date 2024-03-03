import numpy as np
import pandas as pan
import matplotlib.pyplot as plt


def LagrangeFunction(x, i, number_of_nodes, nodes_x):
    result = 1
    for j in range(number_of_nodes):
        if j != i:
            numerator = x - nodes_x[j]
            denominator = nodes_x[i] - nodes_x[j]
            result *= (numerator / denominator)
    return result


def LagrangeInterpolation(x, number_of_nodes, nodes_x, nodes_y):
    interpolated_value = 0
    for i in range(number_of_nodes):
        phi = LagrangeFunction(x, i,number_of_nodes, nodes_x)
        interpolated_value += nodes_y[i] * phi
    return interpolated_value


def LagrangePlot(number_of_nodes, all_nodes_x, all_nodes_y):
    indicies = np.linspace(0, len(all_nodes_x) - 1, number_of_nodes, dtype=int)
    nodes_x = [all_nodes_x[i] for i in indicies]
    indicies = np.linspace(0, len(all_nodes_y) - 1, number_of_nodes, dtype=int)
    nodes_y = [all_nodes_y[i] for i in indicies]

    #x = np.linspace(0,nodes_x[-1])
    x = all_nodes_x
    y = LagrangeInterpolation(x, number_of_nodes, nodes_x, nodes_y)

    DoOneGraph(all_nodes_x, all_nodes_y,nodes_x, nodes_y,x,y,"Interpolacja metodą Lagrange'a w " + name + " dla " + str(number_of_nodes) + " węzłów.")

def SplinePlot(number_of_nodes, all_nodes_x, all_nodes_y):
    indicies = np.linspace(0, len(all_nodes_x) - 1, number_of_nodes, dtype=int)
    nodes_x = [all_nodes_x[i] for i in indicies]
    indicies = np.linspace(0, len(all_nodes_y) - 1, number_of_nodes, dtype=int)
    nodes_y = [all_nodes_y[i] for i in indicies]

    result = SplineFunction(number_of_nodes, nodes_x, nodes_y)
    #x = np.linspace(nodes_x[0],nodes_x[-1])
    x = all_nodes_x
    y = []
    for el in x:
        y.append(SplineInterpolation(el, result, nodes_x))

    DoOneGraph(all_nodes_x, all_nodes_y,nodes_x, nodes_y,x,y,"Interpolacja metodą splajanów w " + name + " dla " + str(number_of_nodes) + " węzłów.")

def SplineInterpolation(x, result, nodes_x):
    j = 0
    for i in nodes_x:
        if (x == nodes_x[j+1]) or (x >= i and x < nodes_x[j+1]):
            return result[4*j] + result[4*j+1] * (x-i) + result[4*j+2] * (x-i)**2 + result[4*j+3] * (x-i)**3
        j+=1

def SplineFunction(number_of_nodes, nodes_x, nodes_y):
    matrixA = np.zeros((4*number_of_nodes - 4, 4*number_of_nodes - 4))  # - 4
    vectorB = np.zeros((4 * number_of_nodes - 4, 1))

    #1
    matrixA[0][0] = 1
    vectorB[0] = nodes_y[0]
    start = 1
    j = 1
    #2
    #h = 1
    for i in range(number_of_nodes-2):  #rows
        h = nodes_x[i + 1] - nodes_x[i ]
        matrixA[i + start][0 + 4 * i] = h ** 0
        matrixA[i + start][1 + 4 * i] = h ** 1
        matrixA[i + start][2 + 4 * i] = h ** 2
        matrixA[i + start][3 + 4 * i] = h ** 3
        vectorB[i + start] = nodes_y[i + start]
        j = i + 1
    start += j

    #3
    for i in range(number_of_nodes - 2):
        matrixA[i + start][4*i + 4] = 1
        vectorB[i + start] = nodes_y[i + 1]      #i? i-1???
        j = i + 1
    start += j

    #4
    i = 0
    h = nodes_x[i + 1] - nodes_x[i ]
    matrixA[i + start][4*number_of_nodes - 4 - 4] = h ** 0
    matrixA[i + start][4*number_of_nodes - 4 - 3] = h ** 1
    matrixA[i + start][4*number_of_nodes - 4 - 2] = h ** 2
    matrixA[i + start][4*number_of_nodes - 4 - 1] = h ** 3
    vectorB[i + start] = nodes_y[number_of_nodes-1]
    j = i + 1
    start += j

    # h = nodes_x[i+1] - nodes_x[i]
    #     matrixA[set_of_equations * 8 + 3][4 * number_of_nodes - 8 + i] = h**i
    #     vectorB[set_of_equations * 8 + 3] = nodes_y[i]  #NOT [I], coś stałeg, poza petla

    #5
    for i in range(number_of_nodes - 2):
        h = nodes_x[i + 1] - nodes_x[i]
        matrixA[i + start][0 + 4 * i] = 0
        matrixA[i + start][1 + 4 * i] = 1
        matrixA[i + start][2 + 4 * i] = 2 * h
        matrixA[i + start][3 + 4 * i] = 3 * h ** 2
        matrixA[i + start][5 + 4 * i] = -1
        vectorB[i + start] = 0
        j = i + 1
    start += j

    # h = nodes_x[i+1] - nodes_x[i]
    #     matrixA[set_of_equations *8 + 4][4 * i + 1] = 1
    #     matrixA[set_of_equations *8 + 4][4 * i + 2] = 2*h
    #     matrixA[set_of_equations *8 + 4][4 * i + 3] = 3*h**2
    #     matrixA[set_of_equations *8 + 4][4 * i + 5] = -1
    #     vectorB[set_of_equations * 8 + 4] = 0


    #6
    for i in range(number_of_nodes - 2):
        h = nodes_x[i + 1] - nodes_x[i ]
        matrixA[i + start][2 + 4 * i] = 2
        matrixA[i + start][3 + 4 * i] = 6*h
        matrixA[i + start][6 + 4 * i] = -2
        vectorB[i + start] = 0
        j = i + 1
    start += j

        # matrixA[set_of_equations *8 + 5][4 * i + 2] = 2
        # matrixA[set_of_equations *8 + 5][4 * i + 3] = 6*h
        # matrixA[set_of_equations *8 + 5][4 * i + 6] = -2
        # vectorB[set_of_equations * 8 + 5] = 0

    #7
    matrixA[start][2] = 2
    vectorB[start] = 0
    start += 1
    #8
    matrixA[start][number_of_nodes*4 - 4 - 2] = 2
    matrixA[start][number_of_nodes*4 - 4 - 1] = 12
    vectorB[start] = 0

    result = np.linalg.solve(matrixA, vectorB)
    return result

def DoOneGraph(all_nodes_x, all_nodes_y,nodes_x, nodes_y,x,y, title):
    plt.figure()
    plt.plot(x, y, color='black', linewidth='4.0', label='Dane interpolowane')
    plt.plot(all_nodes_x, all_nodes_y, linestyle='None', markersize = 2.0, color='g',marker = ".", label='Wszystkie punkty wejściowe')
    plt.plot(nodes_x, nodes_y, linestyle='None', markersize = 3.0, color='red',marker = "o", label='Węzły interpolacyjne')
    plt.title(title)
    plt.legend()
    plt.xlabel("Odległość [m]")
    plt.ylabel("Wysokość [m]")

def DoGraphs(s,l):
    all_nodes_x = data.x
    all_nodes_y = data.y
    SplinePlot(s, all_nodes_x, all_nodes_y)
    LagrangePlot(l, all_nodes_x, all_nodes_y)


# Używając wszystkich punktów występuje potezny efekt runego - im więcej węzłów tym mocniejszy
# właściwie powyżej 10 węzłów już się robi niepraktyczne
# W splajanach nie powinno tego być

#na zmianę góra dół, stromo
data = pan.read_csv("trasy\WielkiKanionKolorado.csv", names=["x","y"], header=0)
name = "WielkiKanionKolorado"
#DoGraphs(15,30)

#stromo, potem wolny spadek
data = pan.read_csv("trasy\ostrowa.txt", names=["x", "y"], header=0)
name = "Ostrowa"
DoGraphs(10,10)
DoGraphs(4,4)
DoGraphs(15,15)

#Plaski poczatek stromy spadek i wzniesienie
data = pan.read_csv("trasy\GlebiaChallengera.csv", names=["x", "y"], header=0)
name = "GlebiaChallengera"
#DoGraphs(10,10)

plt.show()

# number_of_all_nodes = 3
# all_nodes_y = [6,-2,4]#data.x
# all_nodes_x = [1,3,5]#data.y
# all_nodes_y = [4,1,6,1]#data.x
# all_nodes_x = [0,2,3,4]#data.y

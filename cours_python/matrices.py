## Fonctions pour calcul matriciel
# Julien Bosse

import numpy as np

def egalite(a,b):

    shape_a = np.shape(a)
    shape_b = np.shape(b)

    if shape_a != shape_b:
        return False
    else:
        for i in range(shape_a[0]):
            for j in range(shape_a[1]):
                if a[i,j] != b[i,j]:
                    return False
        return True

def transposition(a):

    shape_a = np.shape(a)
    aT = np.zeros((shape_a[1],shape_a[0]))

    for i in range(shape_a[0]):
            for j in range(shape_a[1]):
                aT[j,i] = a[i,j]

    return aT

def addition(a,b):

    shape_a = np.shape(a)
    shape_b = np.shape(b)
    c = np.zeros(shape_a)

    if shape_a != shape_b:
        return False
    else:
        for i in range(shape_a[0]):
            for j in range(shape_a[1]):
                c[i,j] = a[i,j] + b[i,j]

    return c

def soustraction(a,b):

    shape_a = np.shape(a)
    shape_b = np.shape(b)
    c = np.zeros(shape_a)

    if shape_a != shape_b:
        return False
    else:
        for i in range(shape_a[0]):
            for j in range(shape_a[1]):
                c[i,j] = a[i,j] - b[i,j]

    return c

def multiplication(a,b):
    shape_a = np.shape(a)
    c = np.zeros(shape_a)
    for i in range(shape_a[0]):
            for j in range(shape_a[1]):
                c[i,j] = b*a[i,j]
    return c

def produit(a,b):
    shape_a = np.shape(a)
    shape_b = np.shape(b)
    c = np.zeros((shape_a[0],shape_b[1]))

    if shape_a[1] != shape_b[0]:
        print("colonnes(a) != lignes(b)")
    else:
        for i in range(shape_a[0]):
            for j in range(shape_b[1]):
                rowa = a[i,:]
                colb = b[:,j]
                c[i,j] = np.sum(rowa*colb)
        return c

def inversion(a):
    shape_a = np.shape(a)
    if shape_a != (2,2):
        print("Pas une matrice 2x2")
        return False
    else:
        det = a[0,0]*a[1,1]-(a[1,0]*a[0,1])
        if det==0:
            print("Dterminant égal à 0")
            return False
        else:
            c = np.zeros(shape_a)
            c[0,0]=a[1,1]
            c[1,0]=-a[1,0]
            c[0,1]=-a[0,1]
            c[1,1]=a[0,0]
            c = multiplication(c, 1/det)
    return c

def puissance(a,n):
    res=a
    for i in range(n-1):
        print(a)
        res = produit(res, a)
    return res



A=np.array([[1,2],[3,4]])

B=np.array([[5,6],[7,8]])

print("\nEGALITE :")
print(egalite(A,B))

print("\nTRANSPOSITION :")
print(transposition(A))

print("\nADDITION :")
print(addition(A,B))

print("\nSOUSTRACTION :")
print(soustraction(A,B))

print("\n MULTIPLICATION PAR UN REEL :")
print(multiplication(A,2))

A=np.array([[5,6],[7,8]])

B=np.array([[5,6,10],[7,8,9]])

print("\nPRODUIT :")
print(produit(A,B))

print("\nINVERSE :")
print(inversion(A))

A=np.array([[5,6],[7,8]])
b=3

print("\nPUISSANCE :")
print(puissance(A,b))
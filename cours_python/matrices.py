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



(A,B) = (np.array([[1,2],[3,4],[3,4]]), np.array([[1,2],[3,4],[3,4]]))

print("\nEGALITE :")
print(egalite(A,B))

print("\nTRANSPOSITION :")
print(transposition(A))

print("\nADDITION :")
print(addition(A,B))

print("\nSOUSTRACTION :")
print(soustraction(A,B))
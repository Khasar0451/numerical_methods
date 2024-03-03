import math
import time
import matplotlib.pyplot as plt


def add2Vectors(a, b):
    return [x + y for x, y in zip(a, b)]


def sub2Vectors(a, b):
    return [x - y for x, y in zip(a, b)]


class SquareMatrix:
    def __init__(self, size):
        self.N = size
        self.mat = []








        for _ in range(self.N):
            self.mat.append([])





        self.row = 0  # raczej niepotrzebne pole
        self.col = 0

    def matAddMat(self, mat2: 'SquareMatrix') -> 'SquareMatrix':  # '  ' -> forward reference, class doesn't exist yet
        newMat = SquareMatrix(self.N)
        for i in range(self.N):
            row = []
            for j in range(self.N):
                row.append(self.mat[i][j] + mat2.mat[i][j])
            newMat.mat[i] = row
            # newMat.mat[row] += ([sum(val) for val in zip(self.mat[row], mat2.mat[row])])
            # self.mat[row] = ([sum(val) for val in zip(self.mat[row], mat2.mat[row])])
        return newMat

    def matMulVec(self, vec):
        newVec = []
        for row in range(self.N):
            num = 0
            for col in range(self.N):
                num += self.mat[row][col] * vec[col]
            newVec.append(num)
        return newVec

    def matMulScalar(self, scalar):
        newMat = SquareMatrix(self.N)
        for row in range(self.N):
            newMat.mat[row] = [val * scalar for val in self.mat[row]]
        return newMat

    def matTrUpper(self):
        newMat = SquareMatrix(self.N)
        for row in range(self.N):
            newMat.mat.append([])
            for col in range(self.N):
                if row >= col:
                    newMat.mat[row].append(0)
                else:
                    newMat.mat[row].append(self.mat[row][col])
        return newMat

    def matTrLower(self):
        newMat = SquareMatrix(self.N)
        for row in range(self.N):
            newMat.mat.append([])
            for col in range(self.N):
                if row <= col:
                    newMat.mat[row].append(0)
                else:
                    newMat.mat[row].append(self.mat[row][col])
        return newMat

    def matDiagonal(self):
        newMat = SquareMatrix(self.N)
        for row in range(self.N):
            newMat.mat.append([])
            for col in range(self.N):
                if row != col:
                    newMat.mat[row].append(0)
                else:
                    newMat.mat[row].append(self.mat[row][col])
        return newMat

    def forwardSub(self, b):
        x = [0] * self.N
        for row in range(self.N):
            aSum = 0
            for col in range(row):  # +1 ?
                aSum += self.mat[row][col] * x[col]
            x[row] = (b[row] - aSum) / self.mat[row][row]
        return x

    def backSub(self, b):
        x = [0] * self.N
        for row in range(self.N - 1, -1, -1):
            aSum = 0
            for col in range(row+1, self.N):  # +1 ?
                aSum += self.mat[row][col] * x[col]
            x[row] = (b[row] - aSum) / self.mat[row][row]
        return x

    def lu(self, b):
        l = SquareMatrix(self.N)
        l.matBandCreate(1, 0, 0)
        u = self
        start = time.time()
        for k in range(self.N-1):
            for j in range(k + 1, self.N):
                l.mat[j][k] = u.mat[j][k] / u.mat[k][k]
                for i in range(k + 1, self.N):
                    u.mat[j][i] -= l.mat[j][k] * u.mat[k][i]
        end = time.time()
        print(self.mat)
        y = l.forwardSub(b)
        x = u.backSub(y)
        res = self.normedRes(x, b)
        print("RES ERROR: ")
        print(res)
        return x, end - start

    def norm(self, vec):
        suma = sum(x ** 2 for x in vec)
        return math.sqrt(suma)

    def normedRes(self, r, b):
        mr = self.matMulVec(r)
        res = sub2Vectors(mr, b)
        return self.norm(res)

    def direct(self, b):
        return self.forwardSub(b)

    def residualErrorTooBig(self, iterations, start, res):
        print("Norma bledu rezydualnego zbiegla do zbyt duzej wartosci - " + str(res))
        end = time.time()
        print(str(iterations) + " iteracji, zajęło " + str(end - start) + " sekund")

    def residualErrorRising(self, iterations, start):
        print("Norma bledu rezydualnego prawdopodobnie nie zbiegnie")
        end = time.time()
        print(str(iterations) + " iteracji, zajęło " + str(end - start) + " sekund")

    def jacobi(self, b):
        r = [1] * self.N
        d = self.matDiagonal()
        l = self.matTrLower()
        u = self.matTrUpper()

        lu = l.matAddMat(u)
        minusD = d.matMulScalar(-1)
        db = d.forwardSub(b)
        res = self.normedRes(r, b)

        errorRes = res ** 30
        maxRes = pow(10, -9)
        iterations = 0
        start = time.time()
        terminationCountdown = 0
        resLast = res
        resarr = []

        while res > maxRes:
            iterations += 1
            lur = lu.matMulVec(r)
            dlur = minusD.forwardSub(lur)

            r = add2Vectors(dlur, db)
            res = self.normedRes(r, b)

            resarr.append(res)
            if res >= errorRes:
                self.residualErrorRising(iterations, start)
                return [0]

            if resLast == res:
                terminationCountdown += 1
                if terminationCountdown == 200:
                    self.residualErrorTooBig(iterations, start, res)
                    return [0]
            else:
                terminationCountdown = 0

            resLast = res
        end = time.time()
        print(str(iterations) + "iteracji, zajęło " + str(end - start) + " sekund")
        return r, end - start

    def gaussSiedel(self, b):
        r = [1] * self.N
        d = self.matDiagonal()
        l = self.matTrLower()
        u = self.matTrUpper()

        dl = d.matAddMat(l)
        dlb = dl.forwardSub(b)
        minusDL = dl.matMulScalar(-1)

        res = self.normedRes(r, b)
        resLast = res
        errorRes = res ** 30
        maxRes = 10 ** -9
        iterations = 0
        terminationCountdown = 0
        start = time.time()
        while res > maxRes:
            iterations += 1
            ur = u.matMulVec(r)
            dlur = minusDL.forwardSub(ur)

            r = add2Vectors(dlur, dlb)
            res = self.normedRes(r, b)

            if resLast == res:
                terminationCountdown += 1
                if terminationCountdown == 200:
                    self.residualErrorTooBig(iterations, start, res)
                    return [0]
            else:
                terminationCountdown = 0
            resLast = res

            if res >= errorRes:
                self.residualErrorRising(iterations, start)
                return [0]

        end = time.time()
        print(str(iterations) + " iteracji, zajęło " + str(end - start) + " sekund")
        return r, end - start

    def matPrint(self):
        for row in range(self.N):
            print(*self.mat[row])  # * -> print whole array in one line
            print()

    def matTestCreate(self):
        self.mat[0] = ([1,1,1,1])
        self.mat[1] = ([0,2,1,1])
        self.mat[2] = ([0,0,3,1])
        self.mat[3] = ([0,0,0,4])
        # for row in range(self.N):
        #     for col in range(self.N):
        #         self.mat[row].append(3)

    def matBandCreate(self, a1, a2, a3):
        start = 2
        current = start
        band = [a3, a2, a1, a2, a3]
        width = len(band)

        for row in range(self.N):
            zeroStart = math.ceil(width / 2) + row
            zeroEnd = -math.ceil(width / 2) + row
            for col in range(self.N):
                if col >= zeroStart or col <= zeroEnd:
                    num = 0
                else:
                    num = band[current]
                    current += 1
                self.mat[row].append(num)

            if start > 0:
                start -= 1
            current = start


N = 90  # 9 * 2 * 5

b = []
for i in range(N):
    b.append(math.sin(i * (8 + 1)))
    #b.append(i+2)

m = SquareMatrix(N)
m.matBandCreate(3, -1, -1)
#m.matBandCreate(12, -1, -1)
#m.matTestCreate()
#print("this one")
#print(m.backSub(b))


r1 = m.lu(b)
print("Wynik faktoryzacji LU: " + str(r1[0]) + "\n")

r2 = m.jacobi(b)
print("Wynik Jacobi: " + str(r2[0]) + "\n")

r3 = m.gaussSiedel(b)
print("Wynik Gauss-Seidel: " + str(r3[0]) + "\n")

N = [100, 500, 1000, 2000]
jacobiArr = []
gaussArr = []
for n in N:
    print("Rozmiar macierzy: " + str(n))

    m = SquareMatrix(n)
    m.matBandCreate(12, -1, -1)
    b = []
    for i in range(n):
        b.append(math.sin(i * (8 + 1)))

    r2 = m.jacobi(b)
    print("Wynik Jacobi: " + str(r2[0]) + "\n")
    jacobiArr.append(r2[1])

    r3 = m.gaussSiedel(b)
    print("Wynik Gauss-Seidel: " + str(r3[0]) + "\n")
    gaussArr.append(r3[1])

fig, (ax1, ax2) = plt.subplots(2)
ax1.plot(N, jacobiArr, marker='o')
ax1.set_title("Czas wykonywania metody Jacobiego")
ax1.set_xlabel("Wielkość macierzy")
ax1.set_ylabel("Czas")

ax2.plot(N, gaussArr, marker='o')
ax2.set_title("Czas wykonywania metody Gaussa-Seidla")
ax2.set_xlabel("Wielkość macierzy")
ax2.set_ylabel("Czas")
plt.tight_layout()
plt.show()

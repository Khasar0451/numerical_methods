import pandas as pan
import matplotlib.pyplot as plt


def alfa(n):
    return 2 / (n + 1)


def ema(n, list):
    a = alfa(n)
    emaList = []
    for i in range(n, len(list)):  # dla każdego elementu listy (od n) wylicz średnią kroczącą (do n danych wstecz)
        x = 0
        y = 0
        print("i ", i)
        for k in range(0, n):  # n elementow
            x += list[i - k] * pow(1 - a, k)
        #       print("x ", x)
        #       print("val ", list[i - k])
        for k in range(0, n):
            y += pow(1 - a, k)
        #      print("y ", y)

        emaList.append(x / y)
    #    print(emaList)
    return emaList


data = pan.read_csv("int.csv")
ema12 = ema(12, data.High)
ema26 = ema(26, data.High)
macd = []
signal = []
start = 32
for j in range(0, len(ema26)):
    macd.append(ema12[j] - ema26[j])  # 26 and 12 days

signal = ema(9, macd)

dates = data.Date[26:]
datesS = data.Date[26 + 9:]
plt.plot(dates, macd, color='r', label='MACD')
plt.plot(datesS, signal, color='g', label='SIGNAL')
# plt.plot(data.High, color='b', label='INPUT')
plt.legend()
plt.show()
print(macd)
# print(signal)

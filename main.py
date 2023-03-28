import pandas as pan
import matplotlib.pyplot as plt
import matplotlib.dates as mdates


def sell


def buy


def decide



def alfa(n):
    return 2 / (n + 1)


def ema(n, list):
    a = alfa(n)
    emaList = []
    for i in range(n, len(list)):  # dla każdego elementu listy (od n) wylicz średnią kroczącą (do n danych wstecz)
        x = 0
        y = 0
        for k in range(0, n):
            x += list[i - k] * pow(1 - a, k)
        for k in range(0, n):
            y += pow(1 - a, k)

        emaList.append(x / y)
    return emaList


data = pan.read_csv("11B.WA.csv")
ema12 = ema(12, data.High)
ema26 = ema(26, data.High)
macd = []
signal = []
start = 32
for j in range(0, len(ema26)):
    macd.append(ema12[j] - ema26[j])  # 26 and 12 days

signal = ema(9, macd)

print(data.Date)

figure, axes = plt.subplots()
axes.plot(data.Date[26:], macd, color='r', label='MACD')
axes.plot(data.Date[26 + 9:], signal, color='g', label='SIGNAL')
axes.plot(data.Date[26:], data.High[26:], color='b', label='INPUT')

locator = mdates.AutoDateLocator()
axes.xaxis.set_major_locator(locator)
axes.tick_params(axis="x", rotation=-15)

plt.legend()
plt.show()

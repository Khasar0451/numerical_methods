import pandas as pan
import matplotlib.pyplot as plt
import matplotlib.dates as mdates


def sell(capital, actions, price):
    capital += actions * price
    actions = 0
    print(f"selling for {price}, results in {round(capital, 2)}")
    return round(capital, 2), actions


def buy(capital, price):
    actions = capital / price
    capital -= actions * price
    print(f"buying for {price} with {actions} actions")
    return round(capital, 2), round(actions, 2)


def decide(shorterMacd):
    macdAbove = False
    capital = 1000
    actions = 0
    for i, m, s in zip(range(len(shorterMacd)), shorterMacd, signal):
        if m > s and macdAbove == False:
            capital, actions = buy(capital, prices[i])
            macdAbove = True
        if m < s and macdAbove == True:
            capital, actions = sell(capital, actions, prices[i])
            macdAbove = False


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


data = pan.read_csv("a.csv")
prices = round(data.Close, 2)
ema12 = ema(12, prices)
ema26 = ema(26, prices)
macd = []
signal = []
start = 32
for j in range(0, len(ema26)):
    macd.append(ema12[j] - ema26[j])  # 26 and 12 days

signal = ema(9, macd)

decide(macd[9:])

figure, axes = plt.subplots()
axes.plot(data.Date, prices, color='b', label='INPUT')
axes.plot(data.Date[26:], macd, color='r', label='MACD')
axes.plot(data.Date[26 + 9:], signal, color='g', label='SIGNAL')

locator = mdates.AutoDateLocator()
axes.xaxis.set_major_locator(locator)
axes.tick_params(axis="x", rotation=-15)

plt.legend()
plt.show()

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
    print(f"buying for {price}: {round(actions, 2)} actions")
    return round(capital, 2), round(actions, 2)


def decide():
    if macd[0] > signal[0]:
        macdAbove = True
    else:
        macdAbove = False
    capital = 1000
    actions = 0
    print(range(len(macd) + 35)[35:])
    for i, m, s in zip(range(len(macd) + 35)[35:], macd, signal):
        if m > s and macdAbove is False:
            print(f"{i} week, day is {data.Date[i]}     ", end='')
            capital, actions = buy(capital, prices[i])
            macdAbove = True
        if m < s and macdAbove is True:
            print(f"{i} week, day is {data.Date[i]}     ", end='')
            capital, actions = sell(capital, actions, prices[i])
            macdAbove = False


def alfa(n):
    return 2 / (n + 1)


def ema(n, list):
    a = alfa(n)
    emaList = []
    for i in range(n, len(list)):
        x = 0
        y = 0
        for k in range(0, n + 1):
            x += list[i - k] * pow(1 - a, k)
        for k in range(0, n + 1):
            y += pow(1 - a, k)

        emaList.append(x / y)
    return emaList


data = pan.read_csv("11B.WA.csv")
prices = round(data.High, 2)
prices = prices.tolist()
ema12 = ema(12, prices)
ema26 = ema(26, prices)
macd = []
signal = []
for j in range(0, len(ema26)):
    macd.append(ema12[j] - ema26[j])

signal = ema(9, macd)

macd = macd[9:]

decide()

figure, axes = plt.subplots()
axes.plot(data.Date[26 + 9:], prices[26 + 9:], color='b', label='INPUT (High)')
axes.plot(data.Date[26 + 9:], macd, color='r', label='MACD')
axes.plot(data.Date[26 + 9:], signal, color='g', label='SIGNAL')

locator = mdates.AutoDateLocator()
axes.xaxis.set_major_locator(locator)
axes.tick_params(axis="x", rotation=-15)
axes.set_xlabel("Data")
axes.set_ylabel("Wartość wyznacznika")
axes.set_title("Wyznacznik MACD")

plt.legend()
plt.show()

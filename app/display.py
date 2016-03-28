#!/usr/bin/env python3
import numpy as np
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt

minutes = []
with open("data/minutes_output.csv", "r") as f:
    line = f.readline()
    while line != '':
        minutes.append(int(line))
        line = f.readline()

minutes = np.array(minutes)

# the histogram of the data
n, bins, patches = plt.hist(minutes, 50, facecolor='green', alpha=0.75)

plt.xlabel('Minutes')
plt.ylabel('Count')
plt.grid(True)

plt.show()

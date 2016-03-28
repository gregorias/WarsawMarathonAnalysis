Overview
========

These are small scripts that I have used to extract and graph marathon finish
times from Warsaw marathon. This graph was used to see whether Central Limit
Theorem applies to that marathon finish times.

Running
=======

The Haskell script is used to parse HTML file from `data/` to a list of minutes.

    stack exec marathon-exe

The Python script may then be used to display a histogram of that data.

    python3 app/display.py

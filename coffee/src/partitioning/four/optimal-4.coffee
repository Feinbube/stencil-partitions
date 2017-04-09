"use strict"


class @Optimal4 extends Optimized4


    name:       "Optimized+"


    getProcessor: (x, y, w, h) =>

        if w is 10 and h is 10
            return 1 if x is w // 2 and y is h // 2
            return 2 if x is w - Math.floor(w * Math.sqrt(0.5)) and y is h - 1
            return 3 if x is Math.floor(w * Math.sqrt(0.5)) and y is h // 2  # is is only correct for 10x10. general solution below

        # Alternative version: works only for 10x10 :/
        #
        # return 1 if x is w // 2 and y is h // 2
        # return 2 if x is w - Math.floor(w * Math.sqrt(0.5)) and y is h - 1

        # cellsForLastProcessor = w*h - 3 * w*h // 4
        # rasterizedCells = (Math.floor(Math.sqrt(0.5) * w) * Math.floor(Math.sqrt(0.5) * h - 1)) // 2
        # delta = cellsForLastProcessor - rasterizedCells
        # return 3 if x is w - Math.floor(w * Math.sqrt(0.5)) + delta and y is h - delta - 1

        super(x, y, w, h)

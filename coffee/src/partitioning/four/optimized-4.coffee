"use strict"


class @Optimized4


    name:       "Optimized"
    processors: 4


    countInfoPosition: (processorId, w, h) =>

        [
            w * 0.125 + 6 * (processorId %  2) * w * 0.125
            h * 0.125 + 6 * (processorId // 2) * h * 0.125
        ]


    conceptLines: (w, h) =>

        w07 = w * Math.sqrt(0.5)
        h07 = h * Math.sqrt(0.5)
        w03 = w07 * 0.5
        h03 = h07 * 0.5

        [
            [ 0,       h07, w07,   0       ]
            [ w - w07, h,   w,     h - h07 ]
            [ w03,     h03, w-w03, h - h03 ]
        ]


    getProcessor: (x, y, w, h) =>

        cellCount = w * h

        return 0 if Utility.diagonalStepsTo(x, y, w, h)         < cellCount * 0.25
        return 3 if Utility.diagonalStepsTo(w-x-1, h-y-1, w, h) < cellCount * 0.25
        return 1 if Utility.diagonalStepsTo(w-x-1, y, w, h)     < cellCount * 0.5
        return 2 if Utility.diagonalStepsTo(x, h-y-1, w, h)     < cellCount * 0.5

        throw "this should never happen!"


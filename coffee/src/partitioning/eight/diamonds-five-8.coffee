"use strict"


class @DiamondsFive8


    name:       "DiamondsFive"
    processors: 8


    countInfoPosition: (processorId, w, h) =>

        return [ w * 0.5,      h * 0.0625 ] if processorId is 0
        return [ w * 0.1,      h * 0.5    ] if processorId is 1
        return [ w * 0.5, 15 * h * 0.0625 ] if processorId is 2
        return [ w * 0.5,      h * 0.5    ] if processorId is 3

        processorId -= 4

        [
            w * 0.25 + 2 * (processorId %  2) * w * 0.25
            h * 0.25 + 2 * (processorId // 2) * h * 0.25
        ]


    conceptLines: (w, h) =>

        [
            [ 0,        h * 0.25,  w * 0.75, h        ]
            [ w * 0.25, 0,         w,        h * 0.75 ]
            [ w,        h * 0.25,  w * 0.25, h        ]
            [ w * 0.75, 0,         0,        h * 0.75 ]
            [ 0,        h * 0.25,  w * 0.25, 0        ]
            [ w * 0.75, h,         w,        h * 0.75 ]
            [ w,        h * 0.25,  w * 0.75, 0        ]
            [ w * 0.25, h,         0,        h * 0.75 ]
        ]


    getProcessor: (x, y, w, h) =>

        cellCount32 = Math.floor(w * h * 0.03125)

        # top edge
        return 0 if Utility.diagonalStepsTo(x, y, w, h)                     < cellCount32
        return 0 if Utility.diagonalStepsTo(w-x-1, y, w, h)                 < cellCount32
        return 0 if Utility.diagonalStepsTo(w * 0.5-x-1, y, w, h)           < cellCount32 and x  < w * 0.5
        return 0 if Utility.diagonalStepsTo(x-w * 0.5, y, w, h)             < cellCount32 and x >= w * 0.5

        # center edge
        return 1 if Utility.diagonalStepsTo(x, h * 0.5-y-1, w, h)           < cellCount32 and y <  h * 0.5
        return 1 if Utility.diagonalStepsTo(x, y - h * 0.5, w, h)           < cellCount32 and y >= h * 0.5
        return 1 if Utility.diagonalStepsTo(w-x-1, h * 0.5-y-1, w, h)       < cellCount32 and y <  h * 0.5
        return 1 if Utility.diagonalStepsTo(w-x-1, y - h * 0.5, w, h)       < cellCount32 and y >= h * 0.5

        # bottom edge
        return 2 if Utility.diagonalStepsTo(x, h-y-1, w, h)                 < cellCount32
        return 2 if Utility.diagonalStepsTo(w-x-1, h-y-1, w, h)             < cellCount32
        return 2 if Utility.diagonalStepsTo(w * 0.5-x-1, h-y-1, w, h)       < cellCount32 and x <  w * 0.5
        return 2 if Utility.diagonalStepsTo(x-w * 0.5, h-y-1, w, h)         < cellCount32 and x >= w * 0.5

        # center diamond
        return 3 if Utility.diagonalStepsTo(x-w * 0.5, h * 0.5-y-1, w, h)   < cellCount32 and x >= w * 0.5 and y <  h * 0.5
        return 3 if Utility.diagonalStepsTo(x-w * 0.5, y - h * 0.5, w, h)   < cellCount32 and x >= w * 0.5 and y >= h * 0.5
        return 3 if Utility.diagonalStepsTo(w * 0.5-x-1, h * 0.5-y-1, w, h) < cellCount32 and x <  w * 0.5 and y <  h * 0.5
        return 3 if Utility.diagonalStepsTo(w * 0.5-x-1, y - h * 0.5, w, h) < cellCount32 and x <  w * 0.5 and y >= h * 0.5

        # rest is pretty easy :)
        return 4 if x <  w * 0.5 and y <  h * 0.5
        return 5 if x >= w * 0.5 and y <  h * 0.5
        return 6 if x <  w * 0.5 and y >= h * 0.5
        return 7 if x >= w * 0.5 and y >= h * 0.5

        throw "this should never happen!"

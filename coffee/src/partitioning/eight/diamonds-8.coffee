"use strict"


class @Diamonds8


    name:       "Diamonds"
    processors: 8
        

    countInfoPosition: (processorId, w, h) =>

        return [     w * 0.5,      h * 0.25 ] if processorId is 0
        return [ 3 * w * 0.25,     h * 0.5  ] if processorId is 1
        return [     w * 0.25,     h * 0.5  ] if processorId is 2
        return [     w * 0.5,  3 * h * 0.25 ] if processorId is 3
        
        processorId -= 4

        [
            w * 0.125 + 6 * (processorId %  2) * w * 0.125
            h * 0.125 + 6 * (processorId // 2) * h * 0.125
        ]


    conceptLines: (w, h) =>

        [
            [ 0,        h * 0.5,  w * 0.5,  0        ]
            [ w * 0.5,  0,        w,        h * 0.5  ]
            [ w,        h * 0.5,  w * 0.5,  h        ]
            [ w * 0.5,  h,        0,        h * 0.5  ]
            [ w * 0.25, h * 0.25, w * 0.75, h * 0.75 ]
            [ w * 0.25, h * 0.75, w * 0.75, h * 0.25 ]
        ]


    getProcessor: (x, y, w, h) =>

        cellCount = w * h

        # edges
        return 4 if Utility.diagonalStepsTo(x, y, w, h)         <  cellCount * 0.125
        return 7 if Utility.diagonalStepsTo(w-x-1, h-y-1, w, h) <  cellCount * 0.125
        return 5 if Utility.diagonalStepsTo(w-x-1, y, w, h)     <  cellCount * 0.125
        return 6 if Utility.diagonalStepsTo(x, h-y-1, w, h)     <  cellCount * 0.125

        # center diamonds
        return 0 if Utility.diagonalStepsTo(x, y+1, w, h)       <= cellCount * 0.5 and Utility.diagonalStepsTo(w-x-1, y, w, h) <= cellCount * 0.5
        return 0 if x + y is w - 1 and x >= w * 0.5
        return 3 if Utility.diagonalStepsTo(w-x-1, h-y, w, h)   <= cellCount * 0.5 and Utility.diagonalStepsTo(x, h-y-1, w, h) <= cellCount * 0.5
        return 3 if x + y is w - 1 and x < w * 0.5
        return 1 if Utility.diagonalStepsTo(w-x-1, y, w, h)     <  cellCount * 0.5 and Utility.diagonalStepsTo(w-x-1, y, w, h) <  cellCount * 0.5
        return 2 if Utility.diagonalStepsTo(x, h-y-1, w, h)     <  cellCount * 0.5 and Utility.diagonalStepsTo(x, h-y-1, w, h) <  cellCount * 0.5
        
        throw "this should never happen!"

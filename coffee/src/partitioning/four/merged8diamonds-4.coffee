"use strict"


class @Merged8Diamonds4


    name:       "Merged8xDiamonds"
    processors: 4


    countInfoPosition: (processorId, w, h) =>

        [
            w * 0.125 + 6 * (processorId %  2) * w * 0.125
            h * 0.125 + 6 * (processorId // 2) * h * 0.125
        ]


    conceptLines: (w, h) =>

        [
            [ w * 0.25, h * 0.25, w * 0.75, h * 0.75 ]
            [ w * 0.75, h * 0.25, w * 0.25, h * 0.75 ]
            [ 0,        h * 0.5,  w * 0.25, h * 0.25 ]
            [ w,        h * 0.5,  w * 0.75, h * 0.75 ]
            [ w * 0.75, h * 0.25, w * 0.5,  0        ]
            [ w * 0.25, h * 0.75, w * 0.5,  h        ]
        ]


    getProcessor: (x, y, w, h) =>

        cellCount = w * h

        return 0 if Utility.diagonalUpStepsTo(x, y, w, h)         <  cellCount * 0.125
        return 3 if Utility.diagonalUpStepsTo(w-x-1, h-y-1, w, h) <  cellCount * 0.125
        return 1 if Utility.diagonalStepsTo(w-x-1, y, w, h)       <  cellCount * 0.125
        return 2 if Utility.diagonalStepsTo(x, h-y-1, w, h)       <  cellCount * 0.125
        
        return 0 if Utility.diagonalStepsTo(x, y+1, w, h)         <= cellCount * 0.5 and Utility.diagonalStepsTo(w-x-1, y, w, h) < cellCount * 0.5
        return 3 if Utility.diagonalStepsTo(w-x-1, h-y, w, h)     <= cellCount * 0.5 and Utility.diagonalStepsTo(x, h-y-1, w, h) < cellCount * 0.5
        return 1 if Utility.diagonalStepsTo(w-x-1, y, w, h)       <  cellCount * 0.5 and Utility.diagonalStepsTo(w-x-1, y, w, h) < cellCount * 0.5
        return 2 if Utility.diagonalStepsTo(x, h-y-1, w, h)       <  cellCount * 0.5 and Utility.diagonalStepsTo(x, h-y-1, w, h) < cellCount * 0.5
        #super(x, y)

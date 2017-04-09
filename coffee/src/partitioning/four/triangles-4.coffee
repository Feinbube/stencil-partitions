"use strict"


class @Triangles4


    name:       "Triangles"
    processors: 4


    countInfoPosition: (processorId, w, h) =>

        return [     w * 0.5,       h * 0.125 ] if processorId is 0
        return [ 7 * w * 0.125,     h * 0.5   ] if processorId is 1
        return [     w * 0.5,   7 * h * 0.125 ] if processorId is 2
        return [     w * 0.125,     h * 0.5   ] if processorId is 3


    conceptLines: (w, h) =>

        [
            [ 0, 0, w, h ]
            [ w, 0, 0, h ]
        ]


    getProcessor: (x, y, w, h) =>

        cellCount = w * h
        
        return 0 if Utility.diagonalStepsTo(x, y+1, w, h)     <= cellCount * 0.5 and Utility.diagonalStepsTo(w-x-1, y, w, h) < cellCount * 0.5
        return 3 if Utility.diagonalStepsTo(w-x-1, h-y, w, h) <= cellCount * 0.5 and Utility.diagonalStepsTo(x, h-y-1, w, h) < cellCount * 0.5
        return 1 if Utility.diagonalStepsTo(w-x-1, y, w, h)   <  cellCount * 0.5 and Utility.diagonalStepsTo(w-x-1, y, w, h) < cellCount * 0.5
        return 2 if Utility.diagonalStepsTo(x, h-y-1, w, h)   <  cellCount * 0.5 and Utility.diagonalStepsTo(x, h-y-1, w, h) < cellCount * 0.5
        
        throw "this should never happen!"

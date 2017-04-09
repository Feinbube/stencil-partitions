"use strict"


class @Squares4


    name:       "Squares"
    processors: 4


    countInfoPosition: (processorId, w, h) =>

        [
            w * 0.125 + 6 * (processorId %  2) * w * 0.125
            h * 0.125 + 6 * (processorId // 2) * h * 0.125
        ]


    conceptLines: (w, h) =>        

        [
            [ w * 0.5, 0,       w * 0.5, h       ]
            [ 0,       h * 0.5, w,       h * 0.5 ]
        ]


    getProcessor: (x, y, w, h) =>

        return 0 if x <  w * 0.5 and y <  h * 0.5
        return 1 if x >= w * 0.5 and y <  h * 0.5
        return 2 if x <  w * 0.5 and y >= h * 0.5
        return 3 if x >= w * 0.5 and y >= h * 0.5
        
        throw "this should never happen!"

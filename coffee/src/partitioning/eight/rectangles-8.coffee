"use strict"


class @Rectangles8


    name:       "Rectangles"
    processors: 8


    countInfoPosition: (processorId, w, h) =>

        [
            w / 8 +     (processorId %  4) * w / 4
            h / 8 + 6 * (processorId // 4) * h / 8
        ]


    conceptLines: (w, h) =>

        [
            [ w * 0.25, 0,       w * 0.25, h       ]
            [ w * 0.5,  0,       w * 0.5,  h       ]
            [ w * 0.75, 0,       w * 0.75, h       ]
            [ 0,        h * 0.5, w,        h * 0.5 ]
        ]


    getProcessor: (x, y, w, h) =>

        (x // (w * 0.25)) + (y // (h * 0.5)) * 4

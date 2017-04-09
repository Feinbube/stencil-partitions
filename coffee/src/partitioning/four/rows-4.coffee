"use strict"


class @Rows4


    name:       "Rows"
    processors: 4


    countInfoPosition: (processorId, w, h) =>

        [
            w * 0.125
            processorId * h * 0.25 + h * 0.125
        ]


    conceptLines: (w, h) =>

        ([0, i * h * 0.25, w, i * h * 0.25] for i in [0...4])


    getProcessor: (x, y, w, h) =>

        4 * (y * w + x) // (w * h)

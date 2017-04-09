"use strict"


class @Rows8


    name:       "Rows"
    processors: 8


    countInfoPosition: (processorId, w, h) =>

        [
            w * 0.125
            processorId * h * 0.125 + h * 0.0625
        ]


    conceptLines: (w, h) =>

        ([0, i * h * 0.125, w, i * h * 0.125] for i in [0...8])


    getProcessor: (x, y, w, h) =>

        8 * (y * w + x) // (w * h)

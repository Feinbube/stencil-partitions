"use strict"


class @ViewConfig


    @getter 'scale', -> @pixelW / @fieldW

    
    constructor: () ->

        @fieldW = 10
        @pixelW = 200

        @infoMode = "cachedOverheadPerProcessor"

        @showCells        = true
        @showAccesses     = true
        @showLines        = true
        @showConceptLines = false


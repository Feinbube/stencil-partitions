"use strict"


class @Partitioning


    constructor: (@game, @partition, @w, @h) ->

        @fillGrid()
        @markAccesses()
        @uncachedOverheadPerProcessor = @computeUncachedOverhead()
        @efficiency = (@cachedOverheadPerProcessor[i] / (@w * @h) * @partition.processors for i in [0...@partition.processors])


    emptyCounters: () =>

        (0 for i in [0...@partition.processors])


    fillGrid: () =>
        
        @cellsPerProcessor = @emptyCounters()
        @setProcessor(@partition.getProcessor(x, y, @w, @h), x, y) for x in [0...@w] for y in [0...@h]
        @


    setProcessor: (p, x, y) =>

        @cellsPerProcessor[p]++
        @


    markAccesses: () =>

        @cachedOverheadPerProcessor = @emptyCounters()
        @markCell(x, y) for x in [0...@w] for y in [0...@h]
        @


    markCell: (x, y) =>

        accessedBy = @emptyCounters()
        p = @partition.getProcessor(x, y, @w, @h)
        @mark(p, x, y, x-1, y,   accessedBy) if x > 0
        @mark(p, x, y, x+1, y,   accessedBy) if x < @w-1
        @mark(p, x, y, x,   y-1, accessedBy) if y > 0
        @mark(p, x, y, x,   y+1, accessedBy) if y < @h-1

        # update counters based on accessedBy
        for pi in [0...@partition.processors]
            if accessedBy[pi] > 0 
                @cachedOverheadPerProcessor[pi]++ 
        @


    mark: (p, x, y, otherX, otherY, accessedBy) =>

        pn = @partition.getProcessor(otherX, otherY, @w, @h)
        return null if p is pn

        accessedBy[pn] = 1
        pn


    computeUncachedOverhead: () =>

        result = @emptyCounters()
        for y in [0...@h]
            for x in [0...@w]
                p = @partition.getProcessor(x, y, @w, @h)
                result[p]++ if x > 0    and @partition.getProcessor(x-1, y, @w, @h) isnt p
                result[p]++ if x < @w-1 and @partition.getProcessor(x+1, y, @w, @h) isnt p
                result[p]++ if y > 0    and @partition.getProcessor(x, y-1, @w, @h) isnt p
                result[p]++ if y < @h-1 and @partition.getProcessor(x, y+1, @w, @h) isnt p
        result


    # computeOverhead: () =>

    #     markedFields = (@emptyfield() for p in [0...@partition.processors])

    #     for y in [0...@h]
    #         for x in [0...@w]
    #             p = @partition.getProcessor(x, y, @w, @h)
    #             markedFields[p][y][x-1] = 1 if x > 0    and @partition.getProcessor(x-1, y, @w, @h) isnt p
    #             markedFields[p][y][x+1] = 1 if x < @w-1 and @partition.getProcessor(x+1, y, @w, @h) isnt p
    #             markedFields[p][y-1][x] = 1 if y > 0    and @partition.getProcessor(x, y-1, @w, @h) isnt p
    #             markedFields[p][y+1][x] = 1 if y < @h-1 and @partition.getProcessor(x, y+1, @w, @h) isnt p

    #     result = @emptyCounters()
    #     for y in [0...@h]
    #         for x in [0...@w]
    #             for p in [0...@partition.processors]
    #                 result[p]++ if markedFields[p][y][x] is 1
    #     result


    # emptyfield: () =>

    #     ((0 for x in [0...@w]) for y in [0...@h])


    # markGrid: (processor) =>

    #     result = @emptyfield()
    #     @bitmapData.context.fillStyle = '#FFFFFF'        

    #     for y in [0...@h]
    #         for x in [0...@w]
    #             p = @partition.getProcessor(x, y, @w, @h)
    #             continue if processor isnt p

    #             @bitmapData.context.fillRect((x-1)*@scale, y*@scale, @scale, @scale) if x > 0    and @partition.getProcessor(x-1, y, @w, @h) isnt p
    #             @bitmapData.context.fillRect((x+1)*@scale, y*@scale, @scale, @scale) if x < @w-1 and @partition.getProcessor(x+1, y, @w, @h) isnt p
    #             @bitmapData.context.fillRect(x*@scale, (y-1)*@scale, @scale, @scale) if y > 0    and @partition.getProcessor(x, y-1, @w, @h) isnt p
    #             @bitmapData.context.fillRect(x*@scale, (y+1)*@scale, @scale, @scale) if y < @h-1 and @partition.getProcessor(x, y+1, @w, @h) isnt p
    #     @
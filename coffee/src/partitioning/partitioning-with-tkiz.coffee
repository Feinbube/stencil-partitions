"use strict"


class @PartitioningWithTkiz extends PartitioningWithGraphics


    constructor: (game, partition, w, h, x, y, viewConfig) ->

        @tkizCode = ""
        @colorCache = {}
        @colorCacheIndex = 1

        super(game, partition, w, h, x, y, viewConfig)

        @graphics.inputEnabled = true
        @graphics.events.onInputDown.add( =>
                @showTikZCode()
            , @)


    showTikZCode: () =>

        HTML.showModal("""
            \\begin{tikzpicture}[scale=0.025]
                \\draw[style=help lines, step=#{@scale}cm] (-3,-3) grid (#{@scale * @w + 3}, #{@scale * @w + 3}); % grid
                \\begin{scope}[style=very nearly opaque, text opacity=100]
            #{@tkizCode}
                \\end{scope}
            \\end{tikzpicture}
            """)


    fromColorCache: (color) =>

        unless "c" + color of @colorCache
            @colorCache["c" + color] = "processorAccessColor" + @colorCacheIndex
            @colorCacheIndex++
        @colorCache["c" + color]


    drawRect: (graphics, x, y, w, h, color) =>

        @tkizCode += """    \\fill[#{@fromColorCache(color)}] (#{x} cm, #{y} cm) rectangle (#{x+w} cm, #{y+h} cm);\n"""
        super(graphics, x, y, w, h, color)


    drawTriangle: (graphics, x1, y1, x2, y2, x3, y3, color) =>

        @tkizCode += """    \\path[fill=#{@fromColorCache(color)}] (#{x1} cm, #{y1} cm) -- (#{x2} cm, #{y2} cm) -- (#{x3} cm, #{y3} cm) -- cycle;\n"""
        super(graphics, x1, y1, x2, y2, x3, y3, color)


    drawLine: (graphics, x1, y1, x2, y2, color) =>

        @tkizCode += """    \\draw[] (#{x1} cm, #{y1} cm) -- (#{x2} cm, #{y2} cm);\n"""
        super(graphics, x1, y1, x2, y2, color)


    drawCircle: (graphics, x, y, r, color) =>

        @tkizCode += """    \\fill[#{@fromColorCache(color)}] (#{x} cm, #{y} cm) circle (#{r} cm);\n"""
        super(graphics, x, y, r, color)

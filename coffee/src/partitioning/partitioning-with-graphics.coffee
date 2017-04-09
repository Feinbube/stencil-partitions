"use strict"


class @PartitioningWithGraphics extends Partitioning


    constructor: (game, partition, w, h, @x, @y, @viewConfig) ->

        @colors = (Colors.RGBtoHEX(rgb) for rgb in Colors.range(partition.processors))

        @scale = @viewConfig.scale
        @fontSize = Math.floor(@scale * h / 12)
        @fontSize = 0 if @viewConfig.infoMode is "none"
        @fontSize *= 0.7 if @viewConfig.infoMode is "efficiency"

        @renderWidth  = w * @scale
        @renderHeight = h * @scale + 2 * @fontSize

        unless @viewConfig.infoMode is "none"
            @nameText = game.add.text(@x, @y, partition.processors + "x " + partition.name, { font: "bold " + @fontSize + "px Courier", fill: "#000"})
            @y += @fontSize

        @graphics = game.add.graphics(@x, @y)
        PhaserUtility.drawRect(@graphics, 0, 0, w * @scale, h * @scale, 0xFFFFFF)

        super(game, partition, w, h)

        @drawConceptLines() if @viewConfig.showConceptLines

        @drawLine(@graphics, 0, 0, @scale * @w, 0, 0x000000)
        @drawLine(@graphics, 0, 0, 0, @scale * @h, 0x000000)
        @drawLine(@graphics, 0, @scale * @h, @scale * @w, @scale * @h, 0x000000)
        @drawLine(@graphics, @scale * @w, 0, @scale * @w, @scale * @h, 0x000000)

        unless @viewConfig.infoMode is "none"
            for processorId in [0...partition.processors]
                position = @partition.countInfoPosition(processorId, @w, @h)
                value = @[@viewConfig.infoMode][processorId]
                value = value.toFixed(3) if @viewConfig.infoMode is "efficiency"
                @drawText(value, @scale * position[0], @scale * position[1], true, true, @fontSize, "Courier", "#000")
            value = (@[@viewConfig.infoMode].reduce (i, j) -> i + j)
            value = (value / @[@viewConfig.infoMode].length).toFixed(3) if @viewConfig.infoMode is "efficiency"
            value = if @viewConfig.infoMode is "efficiency" then "average: #{value}" else "sum: #{value}"
            @countsSumText = game.add.text(@x, @y + h * @scale, value, { font: "bold " + @fontSize + "px Courier", fill: "#000", align: "right", boundsAlignH: "right", boundsAlignV: "top" })
            @countsSumText.setTextBounds(0, 0, w * @scale, @fontSize)


    name: () => undefined # ABSTRACT -> Implement in child classes.


    drawConceptLines: () =>

        for conceptLine in @partition.conceptLines(@w, @h)
            @drawLine(@graphics, @scale * conceptLine[0], @scale * conceptLine[1], @scale * conceptLine[2], @scale * conceptLine[3], 0x000000) 
        @


    setProcessor: (p, x, y) =>

        super(p, x, y)
        @drawRect(@graphics, x*@scale, y*@scale, @scale, @scale, @colors[p]) if @viewConfig.showCells
        @


    mark: (p, x, y, otherX, otherY, accessedBy) =>

        pn = super(p, x, y, otherX, otherY, accessedBy)
        @drawMark(x, y, otherX, otherY, @colors[p], @colors[pn]) if pn?
        @


    drawMark: (x, y, px, py, color1, color2) =>

        color = color2 #if @lines then color2 else Colors.lerpHEX(color1, color2, 0.5)
        if px < x # left
            # @drawTriangle(@graphics, x*@scale,     y*@scale,     x*@scale,     (y+1)*@scale, (x+0.25)*@scale, (y+0.5)*@scale,  color)
            @drawCircle(@graphics, (x+0.25)*@scale, (y+0.5)*@scale,  @scale * 0.15, color) if @viewConfig.showAccesses
            @drawLine(@graphics, x*@scale, y*@scale, x*@scale, (y+1)*@scale, 0x000000) if @viewConfig.showLines
        else if x < px # right
            # @drawTriangle(@graphics, (x+1)*@scale, y*@scale,(x+1)*@scale, (y+1)*@scale, (x+0.75)*@scale, (y+0.5)*@scale,  color)
            @drawCircle(@graphics, (x+0.75)*@scale, (y+0.5)*@scale,  @scale * 0.15, color) if @viewConfig.showAccesses
        else if py < y # top
            # @drawTriangle(@graphics, x*@scale,y*@scale,(x+1)*@scale, y*@scale,(x+0.5)*@scale,  (y+0.25)*@scale, color)
            @drawCircle(@graphics, (x+0.5)*@scale,  (y+0.25)*@scale, @scale * 0.15, color) if @viewConfig.showAccesses
            @drawLine(@graphics, x*@scale, y*@scale, (x+1)*@scale, y*@scale, 0x000000) if @viewConfig.showLines
        else if y < py #bottom
            # @drawTriangle(@graphics, x*@scale,(y+1)*@scale, (x+1)*@scale, (y+1)*@scale, (x+0.5)*@scale,  (y+0.75)*@scale, color)
            @drawCircle(@graphics, (x+0.5)*@scale,  (y+0.75)*@scale, @scale * 0.15, color) if @viewConfig.showAccesses
        @ 


    drawRect: (graphics, x, y, w, h, color) => 
        
        PhaserUtility.drawRect(graphics, x, y, w, h, color)


    drawTriangle: (graphics, x1, y1, x2, y2, x3, y3, color) => 
        
        PhaserUtility.drawTriangle(graphics, x1, y1, x2, y2, x3, y3, color)


    drawLine: (graphics, x1, y1, x2, y2, color) => 
        
        PhaserUtility.drawLine(graphics, x1, y1, x2, y2, color)


    drawCircle: (graphics, x, y, r, color) =>

        PhaserUtility.drawCircle(graphics, x, y, r, color)


    drawText: (text, x, y, bold, centered, size, family, color) =>

        text = @game.add.text(@x + x, @y + y + 0.3 * size, text, { font: "#{if bold then "bold" else ""} #{size}px #{family}", fill: "#{Colors.HEXtoHEXString(color)}" })
        text.anchor.set(0.5) if centered
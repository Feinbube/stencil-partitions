"use strict"


class @PartitioningDiagram


    constructor: (@game, @partitions, @x, @y, @viewConfig) ->

        @w = @game.width - 200
        @h = 200

        @fontSize = 14
        @colors = (Colors.RGBtoHEX(rgb) for rgb in Colors.range(@partitions.length))

        @graphics = @game.add.graphics(@x, @y)
        PhaserUtility.drawRect(@graphics, 0, 0, @w, @h, 0xFFFFFF)

        csv = (partition.name for partition in @partitions).join('; ')
        csv = "field width; field area; " + csv + "; \n"

        maxY = 0
        for i in [1..@viewConfig.fieldW] 
            csv += "#{i}; #{i*i}; "
            for partitionId in [0...@partitions.length]
                newMax = (new Partitioning(@game, @partitions[partitionId], i, i)[@viewConfig.infoMode].reduce (i, j) -> i + j)
                csv += newMax + "; "
                maxY = newMax if newMax > maxY
            csv += "\n"

        @graphics.inputEnabled = true
        @graphics.events.onInputDown.add( => 
                HTML.showModal(csv)
            , @)
       
        for i in [1..@viewConfig.fieldW]
            x = i * @w / @viewConfig.fieldW
            PhaserUtility.drawLine(@graphics, x, 0, x, @h, 0xA0A0A0)
            @game.add.text(@x + i * @w / @viewConfig.fieldW, @y + @h + 10, "#{i}", { font: "bold " + @fontSize + "px Arial", fill: "#000"})

        for partitionId in [0...@partitions.length]
            @lastX = 0
            @lastY = @h

            for i in [1..@viewConfig.fieldW]
                partitioning = new Partitioning(@game, @partitions[partitionId], i, i)
                @plot(i * @w / @viewConfig.fieldW, (partitioning[@viewConfig.infoMode].reduce (i, j) -> i + j) / maxY * @h, @colors[partitionId]) 

            @game.add.text(10 + @x + @lastX, @y + @lastY - @fontSize * 0.5, @partitions[partitionId].processors + "x " + @partitions[partitionId].name, { font: "bold " + @fontSize + "px Arial", fill: Colors.HEXtoHEXString(@colors[partitionId])})


    plot: (x, y, color) =>

        y = @h - y
        PhaserUtility.drawLine(@graphics, @lastX, @lastY, x, y, color)
        @lastX = x
        @lastY = y


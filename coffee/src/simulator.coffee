"use strict"


window.onload = () =>

    Utility.testAll()
    document.simulator = new Simulator()


class @Simulator


    constructor: () ->

        @game = new Phaser.Game('100', '100', Phaser.WEB_GL, 'screen', { preload: @preload, create: @create, update: @update, render: @render })
        @controller = new Controller()


    restart: () =>

        @game.state.restart()
        @


    preload: () => @


    create: () =>

        @game.stage.backgroundColor = "#FFFFFF"

        # handle resize
        @game.scale.scaleMode = Phaser.ScaleManager.RESIZE
        @game.scale.onSizeChange.add => @resize()

        partitionsFour  = (Utility.new(partition) for partition in ["Squares4", "Rows4", "Triangles4", "Optimal4", "Merged8Diamonds4"]) # "Optimized4"
        partitionsEight = (Utility.new(partition) for partition in ["Rectangles8", "Rows8", "Diamonds8", "DiamondsAlso8", "DiamondsFive8"])
        partitions      = if HTML.getSelectedValue("processorSelect") is "p4" then partitionsFour else partitionsEight

        viewConfig = new ViewConfig()
        viewConfig.fieldW           = HTML.getInt("widthInput")
        viewConfig.pixelW           = HTML.getInt("pixelInput")
        viewConfig.infoMode         = HTML.getSelectedValue("countsSelect")
        viewConfig.showLines        = HTML.isChecked("linesAccess")
        viewConfig.showConceptLines = HTML.isChecked("linesConceptual")
        viewConfig.showCells        = HTML.isChecked("showCells")
        viewConfig.showAccesses     = HTML.isChecked("showAccess")
        viewConfig.showDiagram      = HTML.isChecked("showDiagram")

        graphics = []
        nextPos = Utility.layout2DF partitions, @game.width, 
            # (id, partition, x, y) => graphics.push new PartitioningWithTkiz(@game, partition, viewConfig.fieldW, viewConfig.fieldW, x, y, viewConfig)
            (id, partition, x, y) => graphics.push new PartitioningWithPdf(@game, partition, viewConfig.fieldW, viewConfig.fieldW, x, y, viewConfig)
            (id, partition, x, y) => graphics[id].renderWidth  + 10
            (id, partition, x, y) => graphics[id].renderHeight + 10

        if viewConfig.showDiagram
            nextPos = [0, nextPos[1] + graphics[graphics.length - 1].renderHeight + 10] unless nextPos[0] is 0
            graphics.push new PartitioningDiagram(@game, partitions, 0, nextPos[1] + 10, viewConfig)
        @


    update: () => @


    render: () => @


    resize: () =>

        Utility.scheduleOrDelay("restart", 200, () => @restart()) if HTML.isChecked('instantGo')
        @
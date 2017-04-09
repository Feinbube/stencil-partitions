"use strict"


@PhaserUtility or= {}


PhaserUtility.drawRect = (graphics, x, y, w, h, color) ->

    graphics.beginFill(color)
    graphics.lineStyle(0, color, 1)
    graphics.drawRect(x, y, w, h)
    graphics.endFill()
    graphics


PhaserUtility.drawTriangle = (graphics, x1, y1, x2, y2, x3, y3, color) ->

    graphics.beginFill(color)
    graphics.lineStyle(0, color, 1)
    graphics.drawPolygon(x1, y1, x2, y2, x3, y3)
    graphics.endFill()
    graphics


PhaserUtility.drawLine = (graphics, x1, y1, x2, y2, color) ->

    graphics.beginFill(color)
    graphics.lineStyle(1, color, 1)
    graphics.moveTo(x1, y1)
    graphics.lineTo(x2, y2)
    graphics.endFill()
    graphics


PhaserUtility.drawCircle = (graphics, x, y, r, color) ->

    graphics.beginFill(color)
    graphics.lineStyle(0, color, 1)
    graphics.drawCircle(x, y, r * 2)
    graphics.endFill()
    graphics
"use strict"


class @PartitioningWithPdf extends PartitioningWithGraphics


    constructor: (game, partition, w, h, x, y, viewConfig) ->

        @margin = 2
        @doc = new jsPDF({
          orientation: 'landscape',
          unit: 'mm',
          format: [viewConfig.pixelW + 2 * @margin, viewConfig.pixelW + 2 * @margin]
        })

        super(game, partition, w, h, x, y, viewConfig)

        @graphics.inputEnabled = true
        @graphics.events.onInputDown.add( =>
                @saveAsPdf()
            , @)


    saveAsPdf: () =>

        name  = "#{@partition.processors}x#{@partition.name}"
        name += "-#{@w}x#{@h}"
        name += "-#{@viewConfig.infoMode}" unless @viewConfig.infoMode is "none"
        name += "-cells" if @viewConfig.showCells
        name += "-accesses" if @viewConfig.showAccesses
        name += "-lines" if @viewConfig.Lines
        name += "-concept" if @viewConfig.showConceptLines
        @doc.save("#{name}.pdf")


    drawRect: (graphics, x, y, w, h, color) => 

        c = Colors.HEXtoRGB(color)
        @doc.setFillColor(c[0], c[1], c[2])
        @doc.rect(x + @margin, y + @margin, w, h, 'F')

        super(graphics, x, y, w, h, color)


    drawTriangle: (graphics, x1, y1, x2, y2, x3, y3, color) => 
        
        c = Colors.HEXtoRGB(color)
        @doc.setFillColor(c[0], c[1], c[2])
        doc.triangle(x1 + @margin, y1 + @margin, x2 + @margin, y2 + @margin, x3 + @margin, y3 + @margin, 'F')

        super(graphics, x1, y1, x2, y2, x3, y3, color)


    drawLine: (graphics, x1, y1, x2, y2, color) => 
        
        c = Colors.HEXtoRGB(color)
        @doc.setDrawColor(c[0], c[1], c[2])
        @doc.setLineWidth(1)
        @doc.line(x1 + @margin, y1 + @margin, x2 + @margin, y2 + @margin)

        super(graphics, x1, y1, x2, y2, color)


    drawCircle: (graphics, x, y, r, color) =>

        c = Colors.HEXtoRGB(color)
        @doc.setFillColor(c[0], c[1], c[2])
        @doc.circle(x + @margin, y + @margin, r, 'F')

        super(graphics, x, y, r, color)


    drawText: (text, x, y, bold, centered, size, family, color) =>

        c = Colors.HEXtoRGB(color)
        @doc.setTextColor(c[0], c[1], c[2])
        @doc.setFont(family)
        @doc.setFontSize(size * 2)
        @doc.setFontType(if bold then "bold" else "normal")
        if centered
            @doc.text(x + @margin, y + @margin + 0.3 * size, "#{text}", null, null, 'center') 
        else
            @doc.text(x + @margin, y + @margin + 0.3 * size, "#{text}")
        
        super(text, x, y, bold, centered, size, family, color)
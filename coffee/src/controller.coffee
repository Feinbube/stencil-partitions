"use strict"


class @Controller


    constructor: () ->

        @setup()


    setup: () =>

        restartOnChange = () => 
            document.simulator.restart() if HTML.isChecked("instantGo")

        HTML.getElement("buttonGo").onclick = () => document.simulator.restart()

        for textInput  in ["widthInput", "pixelInput"]
            HTML.getElement(textInput).onkeyup = restartOnChange 

        for clickInput in ["linesNone", "linesConceptual", "linesAccess", "showCells", "showAccess", "showDiagram", "instantGo"]
            HTML.getElement(clickInput).onclick = restartOnChange 

        for selectInput in ["processorSelect", "countsSelect"]
            HTML.getElement(selectInput).onchange = restartOnChange

        HTML.getElement("widthSelect").onchange = () =>
            HTML.bind("widthSelect", "widthInput", "value")
            restartOnChange()

        HTML.getElement("pixelSelect").onchange = () =>
            HTML.bind("pixelSelect", "pixelInput", "value")
            restartOnChange()


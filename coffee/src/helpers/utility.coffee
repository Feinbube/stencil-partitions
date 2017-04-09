"use strict"


@Utility or= {}


# Usage:
# @getter 'mode', -> @genome[@modeId]
Function::getter = (prop, get) ->
  Object.defineProperty @prototype, prop, {get, configurable: yes}

# Usage
# setter 'color', (color) -> 
#   @hexColor = Color.RGBtoHEX(color)
Function::setter = (prop, set) ->
  Object.defineProperty @prototype, prop, {set, configurable: yes}


#  █████╗ ██████╗ ██████╗  █████╗ ██╗   ██╗███████╗
# ██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝
# ███████║██████╔╝██████╔╝███████║ ╚████╔╝ ███████╗
# ██╔══██║██╔══██╗██╔══██╗██╔══██║  ╚██╔╝  ╚════██║
# ██║  ██║██║  ██║██║  ██║██║  ██║   ██║   ███████║
# ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝


Array::uniques = ->

  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output


Array::shuffle = ->

    a = @[..]
    i = a.length
    while --i > 0
        j = ~~(Math.random() * (i + 1))
        t = a[j]
        a[j] = a[i]
        a[i] = t
    a

  
Array::minEntry = ->

  @indexAndEntry( @, (a, b) -> a < b )


Array::maxEntry = ->

  @indexAndEntry( @, (a, b) -> a > b )


Array::indexAndEntry = (fn) ->

  value = @[0]
  index = 0
  for i in [0...@length]
    if fn(@[i], value)
      value = @[i]
      index = i
  [index, value]


Array::minAndMax = ->

  min = @[0]
  max = @[0]

  for i in [0..a.length-1]
    min = @[i] if @[i] < min
    max = @[i] if @[i] > max
  [min, max]


Array::histogram = (buckets) ->

  [left, right] = @.minAndMax()
  weight = buckets / (right - left)

  result = []
  for value in @
    index = Math.floor( (value - left) * weight )
    if result[index]? then result[index]++ else result[index] = 1

  { histogram: result, left: left, right: right }


Array::randomElement = ->

  @[Math.randomInteger(@length)]


Utility.allEqual = (list...) ->

  for item in list
    return false unless item is list[0]

  return true


# ███████╗████████╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
# ██╔════╝╚══██╔══╝██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
# ███████╗   ██║   ██████╔╝██║██╔██╗ ██║██║  ███╗███████╗
# ╚════██║   ██║   ██╔══██╗██║██║╚██╗██║██║   ██║╚════██║
# ███████║   ██║   ██║  ██║██║██║ ╚████║╚██████╔╝███████║
# ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝


String::padLeft = (length, padCharacter = '0') ->
  
  paddingLength = length - @.length
  if paddingLength <= 0 then @ else new Array(paddingLength + 1).join(padCharacter) + @


String::capitalizeFirst = () ->

  @[0].toUpperCase() + @[1..-1].toLowerCase()


String::replaceAll = (search, replacement) ->

  @replace(new RegExp(search, 'g'), replacement)


# ███╗   ███╗ █████╗ ████████╗██╗  ██╗
# ████╗ ████║██╔══██╗╚══██╔══╝██║  ██║
# ██╔████╔██║███████║   ██║   ███████║
# ██║╚██╔╝██║██╔══██║   ██║   ██╔══██║
# ██║ ╚═╝ ██║██║  ██║   ██║   ██║  ██║
# ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
                                                  

Math.lerp = (from, to, value) ->
  
  (1-value)*from + value*to 


Math.lerpA = (fromTo, value) ->
  
  (1-value)*fromTo[0] + value*fromTo[1]


Math.clamp = (value, min, max) -> 

    return min if min >= max 

    value -= max while value >= max
    value += max while value < min
    value % max


Math.randomInteger = (min, max) ->

  return if max? then Math.floor(Math.random() * (max-min) + min) else Math.floor(Math.random() * min)


Math.gauss = (n) ->

  n * (n + 1) // 2

  
#  ██████╗ ██████╗ ██╗      ██████╗ ██████╗ ███████╗
# ██╔════╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔════╝
# ██║     ██║   ██║██║     ██║   ██║██████╔╝███████╗
# ██║     ██║   ██║██║     ██║   ██║██╔══██╗╚════██║
# ╚██████╗╚██████╔╝███████╗╚██████╔╝██║  ██║███████║
#  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝


@Colors or= {} # based on https://gist.github.com/lekevicius/5020342


Colors.HUEtoRGB = (p, q, t) ->
  t += 1 if t < 0
  t -= 1 if t > 1
  return p + (q - p) * 6 * t if t < 1/6
  return q if t < 1/2
  return p + (q - p) * (2/3 - t) * 6 if t < 2/3
  return p


Colors.HSLtoRGB = (h, s, l) ->
  if s is 0
    r = g = b = l # achromatic
  else
    if l < 0.5
      q = l * (1 + s)
    else
      q = l + s - l * s
    p = 2 * l - q
    r = Colors.HUEtoRGB p, q, h + 1/3
    g = Colors.HUEtoRGB p, q, h
    b = Colors.HUEtoRGB p, q, h - 1/3

  [ Math.round(r * 255), Math.round(g * 255), Math.round(b * 255) ]
  

Colors.HSVtoRGB = (h, s, v) ->
  i = Math.floor(h * 6)
  f = h * 6 - i
  p = v * (1 - s)
  q = v * (1 - f * s)
  t = v * (1 - (1 - f) * s)

  switch i % 6
    when 0 then [r, g, b] = [v, t, p]
    when 1 then [r, g, b] = [q, v, p]
    when 2 then [r, g, b] = [p, v, t]
    when 3 then [r, g, b] = [p, q, v]
    when 4 then [r, g, b] = [t, p, v]
    when 5 then [r, g, b] = [v, p, q]

  [ Math.round(r * 255), Math.round(g * 255), Math.round(b * 255) ]
  

Colors.HEXtoRGB = (hex) ->

  [ hex >> 16 & 0xff, hex >> 8 & 0xff, hex & 0xff ]


Colors.HEXtoHEXString = (hex) ->

  Colors.RGBtoHEXString(Colors.HEXtoRGB(hex))
  

Colors.RGBtoHEXString = (rgb) ->
  '#' + rgb[0].toString(16) + rgb[1].toString(16) + rgb[2].toString(16)


Colors.RGBtoHEX = (rgb) ->
  ((1 << 24) + (rgb[0] << 16) + (rgb[1] << 8) + rgb[2] | 0)


Colors.range = (count) ->

  (Colors.HSVtoRGB(hue, 0.4 + (0.6 * (1-hue)), 0.7 + 0.3 * hue) for hue in [0...1] by 1 / count)


Colors.lerpRGB = (fromRGB, toRGB, value) ->

  (Math.lerp(fromRGB[i], toRGB[i], value) for i in [0...3])


Colors.lerpHEX = (from, to, value) ->

  Colors.RGBtoHEX(Colors.lerpRGB(Colors.HEXtoRGB(from), Colors.HEXtoRGB(to), value))


# ██╗  ██╗████████╗███╗   ███╗██╗     
# ██║  ██║╚══██╔══╝████╗ ████║██║     
# ███████║   ██║   ██╔████╔██║██║     
# ██╔══██║   ██║   ██║╚██╔╝██║██║     
# ██║  ██║   ██║   ██║ ╚═╝ ██║███████╗
# ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝╚══════╝


@HTML or= {}


HTML.setAttribute = (elementId, attribute, value) ->
  
  HTML.getElement(elementId).setAttribute(attribute, value)


HTML.bind = (inputId, outputId, outputAttribute) ->

  HTML.setAttribute(outputId, outputAttribute, HTML.getSelectedValue(inputId))


HTML.getElement = (elementId) ->

  document.getElementById(elementId)


HTML.get = (elementId) ->

  HTML.getElement(elementId).value


HTML.getInt = (elementId) ->

  parseInt(HTML.get(elementId))


HTML.getSelectedValue = (elementId) ->

  element = HTML.getElement(elementId)
  element.options[element.selectedIndex].value


HTML.isChecked = (elementId) ->

  HTML.getElement(elementId).checked


HTML.showModal = (text) ->

  unless Utility.modal?
    #TODO: add html and style automatically

    Utility.modal = document.getElementById('theModal')
    Utility.modalText = document.getElementById('modal-text')
    window.onclick = (event) -> 
      Utility.modal.style.display = "none" if event.target is Utility.modal

  Utility.modal.style.display = "block"
  Utility.modalText.innerHTML = text.replaceAll("\n", "<br />")
  @


# ███████╗██╗   ██╗███████╗██████╗ ██╗   ██╗████████╗██╗  ██╗██╗███╗   ██╗ ██████╗     ███████╗██╗     ███████╗███████╗
# ██╔════╝██║   ██║██╔════╝██╔══██╗╚██╗ ██╔╝╚══██╔══╝██║  ██║██║████╗  ██║██╔════╝     ██╔════╝██║     ██╔════╝██╔════╝
# █████╗  ██║   ██║█████╗  ██████╔╝ ╚████╔╝    ██║   ███████║██║██╔██╗ ██║██║  ███╗    █████╗  ██║     ███████╗█████╗  
# ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗  ╚██╔╝     ██║   ██╔══██║██║██║╚██╗██║██║   ██║    ██╔══╝  ██║     ╚════██║██╔══╝  
# ███████╗ ╚████╔╝ ███████╗██║  ██║   ██║      ██║   ██║  ██║██║██║ ╚████║╚██████╔╝    ███████╗███████╗███████║███████╗
# ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚══════╝╚══════╝╚══════╝╚══════╝


Utility.lengthOfMap = (map) ->

  Object.keys(map).length


Utility.new = (className, parameters) ->

  new window[className](parameters...)


# returns the number of steps it takes to get from (0, 0) to (x, y)
# by traversing a two dimensional array diagonally
# example:
# 0 > 1   3   6 
#   /   /   /
# 2   4   7   9 
#   /   /   /
# 5   8  10  11 
Utility.diagonalStepsTo = (x, y, w, h) ->
    
  diagonal      = x + y
  rectIndex     = Math.gauss(diagonal) + y
  leftTriangle  = Math.gauss(Math.max(0, diagonal - h))
  rightTriangle = Math.gauss(Math.max(0, diagonal - w + 1))
  rectIndex - leftTriangle - rightTriangle


# returns the number of steps it takes to get from (0, 0) to (x, y)
# by traversing a two dimensional array diagonally
# example:
# 0   2   5   8 
# v /   /   / 
# 1   4   7  10
#   /   /   /
# 3   6   9  11
Utility.diagonalUpStepsTo = (x, y, w, h) ->

  Utility.diagonalStepsTo(y, x, h, w)


Utility.layout2D = (list, maxWidth, deltaX, deltaY, perItem) ->

  x = 0
  y = 0
  for itemId in [0...list.length]
    perItem(list[itemId], x, y)
    x += deltaX
    if x > maxWidth - deltaX
      x = 0
      y += deltaY
  [x, y]


Utility.layout2DF = (list, maxWidth, perItem, deltaXofItem, deltaYofItem) ->

  x = 0
  y = 0
  for itemId in [0...list.length]
    perItem(itemId, list[itemId], x, y)
    deltaX = deltaXofItem(itemId, list[itemId], x, y)
    x += deltaX
    if x > maxWidth - deltaX
      x = 0
      y += deltaYofItem(itemId, list[itemId], x, y)
  [x, y]


Utility.schedule = {}
Utility.scheduleOrDelay = (id, timeoutInMs, func) ->

  clearTimeout(Utility.schedule[id]) if id of Utility.schedule
  Utility.schedule[id] = window.setTimeout(
    () =>
      delete Utility.schedule[id]
      func()
    timeoutInMs
    )
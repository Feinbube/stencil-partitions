# Frank Feinbube frank@feinbube.de


class @NoiseHelper extends @Noise

  fractualBrownianMotionNoise: (x, y) ->

    total = 0
    frequency = 1
    persistance = 0.5
    octaves = 8

    amplitude = persistance

    for i in [0...octaves]
      total += @at(x * frequency, y * frequency) * amplitude

      frequency *= 2
      amplitude *= persistance

    total


  rigidFBMNoise: (x, y) ->

    1.0 - Math.abs(@at(x, y))


  valueNoise: (x, y) ->
    dx = @at(x + 0.5, y) * 10
    dy = @at(x, y + 0.5) * 10

    @at(x + dx, y + dy)
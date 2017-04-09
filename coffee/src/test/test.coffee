"use strict"


@Test or= {}


Test.assert = (value) ->

    throw "Test failed" unless value
    true


Test.areEqual = (v1, v2) ->

    Test.assert(v1 is v2)

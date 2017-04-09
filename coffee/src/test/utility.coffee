"use strict"


Utility.testAll = () ->

    tests = [Utility.testDiagonalStepsTo, Utility.testDiagonalUpStepsTo]

    console.log "Running all Utility tests. (#{tests.length})"
    test() for test in tests
    console.log "All tests passed."
    @


Utility.testDiagonalStepsTo = () ->    

    # 0 > 1   3   6 
    #   /   /   /
    # 2   4   7   9 
    #   /   /   /
    # 5   8  10  11 
    Test.areEqual( 0, Utility.diagonalStepsTo(0, 0, 4, 3))
    Test.areEqual( 1, Utility.diagonalStepsTo(1, 0, 4, 3))
    Test.areEqual( 2, Utility.diagonalStepsTo(0, 1, 4, 3))
    Test.areEqual( 8, Utility.diagonalStepsTo(1, 2, 4, 3))
    Test.areEqual( 6, Utility.diagonalStepsTo(3, 0, 4, 3))
    Test.areEqual( 9, Utility.diagonalStepsTo(3, 1, 4, 3))
    Test.areEqual(11, Utility.diagonalStepsTo(3, 2, 4, 3))
    @


Utility.testDiagonalUpStepsTo = () ->    

    # 0   2   5   8 
    # v /   /   / 
    # 1   4   7  10
    #   /   /   /
    # 3   6   9  11
    Test.areEqual( 0, Utility.diagonalUpStepsTo(0, 0, 4, 3))
    Test.areEqual( 1, Utility.diagonalUpStepsTo(0, 1, 4, 3))
    Test.areEqual( 2, Utility.diagonalUpStepsTo(1, 0, 4, 3))
    Test.areEqual( 6, Utility.diagonalUpStepsTo(1, 2, 4, 3))
    Test.areEqual( 8, Utility.diagonalUpStepsTo(3, 0, 4, 3))
    Test.areEqual(10, Utility.diagonalUpStepsTo(3, 1, 4, 3))
    Test.areEqual(11, Utility.diagonalUpStepsTo(3, 2, 4, 3))
    @


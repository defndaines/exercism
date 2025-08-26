def equilateral(sides):
    uniq = list(set(sides))
    return len(uniq) == 1 and uniq[0] != 0


def isosceles(sides):
    sides.sort()
    return sides[1] == sides[2]


def scalene(sides):
    sides.sort()
    uniq = list(set(sides))
    return len(uniq) == 3 and sides[0] + sides[1] > sides[2]

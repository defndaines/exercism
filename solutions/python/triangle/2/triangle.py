def equilateral(sides):
    a, b, c = sorted(sides)
    return a == b == c and a != 0


def isosceles(sides):
    _, b, c = sorted(sides)
    return b == c


def scalene(sides):
    a, b, c = sorted(sides)
    return a != b != c and a + b > c

RESISTORS = [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white",
]

SCALE = ["", "kilo", "mega", "giga"]


def label(colors):
    x, y, z, *_ = colors
    value = (10 * RESISTORS.index(x) + RESISTORS.index(y)) * 10 ** RESISTORS.index(z)
    for unit in SCALE:
        if value % 1000 == value:
            return f"{value} {unit}ohms"
        value //= 1000

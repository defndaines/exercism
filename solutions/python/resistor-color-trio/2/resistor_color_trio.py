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
    ohms = (10 * RESISTORS.index(x) + RESISTORS.index(y)) * 10 ** RESISTORS.index(z)

    for unit in SCALE:
        if ohms % 1000 == ohms:
            return f"{ohms} {unit}ohms"
        ohms //= 1000

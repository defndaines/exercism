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
TOLERANCE = {
    "grey": "0.05",
    "violet": "0.1",
    "blue": "0.25",
    "green": "0.5",
    "brown": 1,
    "red": 2,
    "gold": 5,
    "silver": 10,
}


def resistor_label(colors):
    if ["black"] == colors:
        return "0 ohms"

    *bands, m, t = colors

    ohms = 0
    for band in bands:
        ohms = ohms * 10 + RESISTORS.index(band)

    ohms *= 10 ** RESISTORS.index(m)

    for unit in SCALE:
        if ohms % 1000 == ohms:
            return f"{str(ohms).removesuffix('.0')} {unit}ohms ±{TOLERANCE[t]}%"
        ohms /= 1000

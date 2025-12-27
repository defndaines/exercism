BANDS = [
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


def value(colors):
    band_1, band_2, *_ = colors
    return BANDS.index(band_1) * 10 + BANDS.index(band_2)

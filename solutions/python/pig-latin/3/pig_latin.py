import re


def pig(word):
    match re.split(r"(yt|xr|[aeiouy])", word, maxsplit=1):
        case "", "y", rest:
            return rest + "y"
        case "", _, _:
            return word
        case c, v, rest:
            if v == "u" and c.endswith("q"):
                return rest + c + v
            return v + rest + c


def translate(text):
    return " ".join(pig(word) + "ay" for word in text.split())

import re


def to_pig(word):
    match re.split(r"([aeiouy])", word, 1):
        case "", "y", rest:
            if rest.startswith("t"):
                return word + "ay"
            return rest + "yay"
        case "", _, _:
            return word + "ay"
        case "xr", _, _:
            return word + "ay"
        case c, v, rest:
            if v == "u" and c.endswith("q"):
                return rest + c + v + "ay"
            return v + rest + c + "ay"


def translate(text):
    return " ".join(to_pig(word) for word in text.split())

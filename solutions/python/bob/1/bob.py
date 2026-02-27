import re

def response(hey_bob):
    if re.match(r"^\s*$", hey_bob):
        return "Fine. Be that way!"

    match [hey_bob.strip()[-1] == "?", hey_bob == hey_bob.upper() and bool(re.match(r"[A-Za-z]", hey_bob))]:
        case [True, True]:
            return "Calm down, I know what I'm doing!"
        case [True, _]:
            return "Sure."
        case [_, True]:
            return "Whoa, chill out!"
        case [_, _]:
            return "Whatever."

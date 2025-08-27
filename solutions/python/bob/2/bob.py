def response(hey_bob):
    hey_bob = hey_bob.strip()

    if not hey_bob:
        return "Fine. Be that way!"

    match [
        hey_bob.endswith("?"),
        hey_bob.isupper() and any(ch.isalpha() for ch in hey_bob),
    ]:
        case [True, True]:
            return "Calm down, I know what I'm doing!"
        case [True, _]:
            return "Sure."
        case [_, True]:
            return "Whoa, chill out!"
        case [_, _]:
            return "Whatever."

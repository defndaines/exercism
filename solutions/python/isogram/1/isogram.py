from string import ascii_lowercase


def is_isogram(string):
    seen = set()
    for ch in string.lower():
        if ch in seen:
            return False
        if ch in ascii_lowercase:
            seen.add(ch)

    return True

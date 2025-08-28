def is_isogram(string):
    seen = set()

    for ch in string.lower():
        if ch in seen:
            return False
        if ch.isalpha():
            seen.add(ch)

    return True

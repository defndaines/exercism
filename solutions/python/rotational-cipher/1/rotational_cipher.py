CAP_A = ord("A")
LOW_A = ord("a")


def rotate(text, key):
    cipher = ""

    for ch in text:
        if (is_lower := "a" <= ch <= "z") or "A" <= ch <= "Z":
            offset = LOW_A if is_lower else CAP_A
            cipher += chr(offset + ((ord(ch) - offset + key) % 26))
        else:
            cipher += ch

    return cipher

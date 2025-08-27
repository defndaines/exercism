def convert(number):
    return "".join(
        sound
        for modulus, sound in [(3, "Pling"), (5, "Plang"), (7, "Plong")]
        if not number % modulus
    ) or str(number)

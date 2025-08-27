def convert(number):
    result = ""

    for modulus, rain in [(3, 'Pling'), (5, 'Plang'), (7, 'Plong')]:
        if number % modulus == 0:
            result += rain

    return result or str(number)

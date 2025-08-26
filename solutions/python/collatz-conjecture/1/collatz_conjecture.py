def steps(number, i=0):
    if number < 1:
        raise ValueError("Only positive integers are allowed")

    if number == 1:
        return i

    if number % 2 == 1:
        return steps(number * 3 + 1, i + 1)

    return steps(number / 2, i + 1)

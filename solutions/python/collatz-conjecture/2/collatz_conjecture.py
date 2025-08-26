def steps(number, i=0):
    if number == 1:
        return i

    if number < 1:
        raise ValueError("Only positive integers are allowed")

    next = number * 3 + 1 if number % 2 else number // 2
    return steps(next, i + 1)

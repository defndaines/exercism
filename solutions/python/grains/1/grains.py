def square(number):
    if 0 < number < 65:
        return 1 << (number - 1)

    raise ValueError("square must be between 1 and 64")


def total():
    return sum(square(n) for n in range(1, 65))

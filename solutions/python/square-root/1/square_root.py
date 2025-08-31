def square_root(number):
    if number < 2:
        return number

    smaller = square_root(number >> 2) << 1
    larger = smaller + 1
    return smaller if larger * larger > number else larger

def is_valid(isbn):
    f = 10
    total = 0

    for d in isbn:
        if d.isdigit():
            total += int(d) * f
            f -= 1
        elif f == 1 and d == "X":
            total += 10
            f -= 1
        elif d == "-":
            next
        else:
            return False

    return not f and not total % 11

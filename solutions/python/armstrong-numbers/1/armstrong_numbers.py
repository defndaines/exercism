def is_armstrong_number(number):
    n = str(number)
    i = len(n)
    return sum(int(d) ** i for d in n) == number

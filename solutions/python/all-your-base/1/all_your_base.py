def to_base(n, base, acc=[]):
    if n == 0:
        return acc if acc else [0]

    return to_base(n // base, base, [n % base] + acc)


def rebase(input_base, digits, output_base):
    if input_base < 2:
        raise ValueError("input base must be >= 2")

    if output_base < 2:
        raise ValueError("output base must be >= 2")

    number = 0
    for d in digits:
        if d >= input_base or d < 0:
            raise ValueError("all digits must satisfy 0 <= d < input base")

        number = number * input_base + d

    return to_base(number, output_base)

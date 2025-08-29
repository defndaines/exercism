def rebase(input_base, digits, output_base):
    if input_base < 2:
        raise ValueError("input base must be >= 2")

    if output_base < 2:
        raise ValueError("output base must be >= 2")

    number = 0
    for d in digits:
        if not 0 <= d < input_base:
            raise ValueError("all digits must satisfy 0 <= d < input base")

        number = number * input_base + d

    based = []
    while number:
        based.insert(0, number % output_base)
        number //= output_base

    return based or [0]

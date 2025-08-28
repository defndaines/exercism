def classify(number):
    """A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """
    if number < 1:
        raise ValueError("Classification is only possible for positive integers.")

    factors = sum(n for n in range(1, number // 2 + 1) if not number % n)

    if factors == number:
        return "perfect"
    if factors > number:
        return "abundant"
    return "deficient"

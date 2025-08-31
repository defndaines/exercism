PAIRS = {"}": "{", "]": "[", ")": "("}


def is_paired(input_string):
    stack = []
    for ch in input_string:
        if ch in "[{(":
            stack.append(ch)
        elif bracket := PAIRS.get(ch):
            if not stack or not stack.pop() == bracket:
                return False

    return not stack

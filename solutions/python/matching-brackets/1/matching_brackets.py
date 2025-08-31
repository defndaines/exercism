PAIRS = {"}": "{", "]": "[", ")": "("}


def is_paired(input_string):
    stack = []
    for ch in input_string:
        if ch in "[{(":
            stack.append(ch)
        elif bracket := PAIRS.get(ch):
            if stack and stack.pop() == bracket:
                continue
            else:
                return False

    return not stack

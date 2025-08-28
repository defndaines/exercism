def is_pangram(sentence):
    return all(ch in sentence.lower() for ch in "abcdefghijklmnopqrstuvwxyz")

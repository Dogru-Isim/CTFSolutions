#!/bin/env python3

def read_file():
    with open('enc', 'r') as h:
        enc = h.read()
        enc = [*enc]

    return enc

def fix_enc_char(enc_char: str) -> str:
    if len(bin(ord(enc_char))) != 18:   # 16 bits + '0b' at the beginning
        enc_char_bin = "0" * (18-len(bin(ord(enc_char)))) + bin(ord(enc_char))[2:]   # strip '0b'
        # print(f"HEYOOOO, new enc is: {enc_char_bin}")
    else:
        enc_char_bin = bin(ord(enc_char))[2:]
        print(f"{enc_char_bin}")

    return enc_char_bin

def find_letters(enc: list, option: str) -> str:
    if option == "even":
        even_letters = ""

        for i in range(len(enc)):
            # letter = ord(enc[i])
            #letter = bin(letter)[2:]
            letter = fix_enc_char(enc[i])
            letter_even = letter[:8]
            even_letters += chr(int(letter_even, 2))

        return even_letters
    elif option == "odd":
        odd_letters = ""

        for i in range(len(enc)):
            # letter = ord(enc[i])
            # letter = bin(letter)[2:]
            letter = fix_enc_char(enc[i])
            letter_odd = letter[8:]
            odd_letters += chr(int(letter_odd, 2))

        return odd_letters
    else:
        raise("Wrong option provided")

def concat_letters(even_letters: str, odd_letters: str) -> str:
    flag = ""
    for i in range(len(even_letters)):  # Only one is enough
        flag += even_letters[i] + odd_letters[i]

    return flag

def explanation(enc: list):
    letter = ord(enc[0])

    print("Actual: 0b0" + bin(letter)[2:] + f" ASCII: {chr(letter)}")
    print("Notice the first 8 bits and the last 8 bits are exactly the letters added from the flag. They are still there, looking at us in binary form.")
    letter = bin(letter)[2:]    # Strip "0b
    letter_even = letter[:8]    # even number range
    letter_odd = letter[8:]     # odd number range

    print(f"Even: 0b{letter_even} : p")
    print(f"Odd: 0b0{letter_odd} : i")

def main():
    enc = read_file()

    explanation(enc)
    even_letters = find_letters(enc, "even")
    odd_letters = find_letters(enc, "odd")

    flag = concat_letters(even_letters, odd_letters)
    print(f"\n Here is your flag btw: {flag}")

main()

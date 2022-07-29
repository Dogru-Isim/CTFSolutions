"""
This one was the best out of all other PW Crack X challenges.
Instead of reading dictionary.txt and piping the output to level5.py, I decided to crack the hash using Python which is incredibly faster.
"""

import hashlib
import sys

correct_pw_hash = open('level5.hash.bin', 'rb').read()

def hash_pw(pw_str):
    pw_bytes = bytearray()
    pw_bytes.extend(pw_str.encode())
    m = hashlib.md5()
    m.update(pw_bytes)
    return m.digest()


def level_5_pw_check():
    with open('dictionary.txt', 'r') as f:
        passwords = f.readlines()
        for pwd in passwords:
            pwd=pwd.strip()
            pwd_hash = hash_pw(pwd)
            if ( pwd_hash == correct_pw_hash ):
                print(f"Found the password: {pwd}")
                sys.exit()

level_5_pw_check()

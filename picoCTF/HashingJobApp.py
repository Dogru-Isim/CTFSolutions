import telnetlib
import re 
import hashlib
import sys

tn = telnetlib.Telnet("18.217.86.78", 63116, timeout = 2)
print("Connection established! \n")

def encrypt():
        try:
                output = tn.read_until(b'Answer: ')
                  # b"Please md5 hash the text between quotes, excluding the quotes: 'log cabins'\r\nAnswer: "

                if b'pico' in output:
                        output = re.sub("^.*pico", "pico",  str(output))
                        print("\n", re.sub("}.*$", "}",  str(output)))
                        sys.exit()

                plain = re.sub("^.*: '", "", str(output))
                  # log cabins'\r\nAnswer: "

                plain = re.sub("'.*", "", plain)
                print(f"Hashing: {plain}")
                  # log cabins

                answer = hashlib.md5(plain.encode()).hexdigest()
                print(f"Trying to send: {answer} \n")

                tn.write(answer.encode())
                tn.write(b'\n')
                print(f"Sent: {answer} \n")

                  # b"\r\n3a6ad3cffd52913dfafce6761c0424a7\r\nCorrect.\r\nPlease md5 hash the text between quotes, excluding the quotes: 'space'\r\nAnswer: "

        except EOFError:
                sys.exit()

while True:
        encrypt()

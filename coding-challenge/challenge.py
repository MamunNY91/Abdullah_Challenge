import re

# Match the credit card number pattern
pattern = r'^[456]([\d]{15}|[\d]{3}(-[\d]{4}){3})$'

# Match repeated consecutive digits
repeat_pattern = r'(\d)\1{3,}'

n = int(input())

for _ in range(n):
    cc_number = input()

    # Check if the credit card number matches the pattern
    if re.match(pattern, cc_number) and not re.search(repeat_pattern, cc_number.replace('-', '')):
        print("Valid")
    else:
        print("Invalid")
import re

file = open('test.py')

def findPrint():
  print_count = 0
  for line in file.readlines():
    print_count += len(re.findall(r'\bprint\b(?=(?:[^"]*"[^"]*")*[^"]*$)', line))
  return print_count

try:
  printNumber = findPrint()
  print(printNumber)

finally:
    file.close()
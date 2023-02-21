import re
import ast

inputFile = 'test.py'
def parseBracketsAndStrings(header, charIndices):
  leftBracket = charIndices["("]
  rightBracket = charIndices[")"]
  # Remove any extra parentheses if there are no string brackets
  # TODO - This won't work if there are any strings! Maybe just ignore any bracket strings?
  if len(charIndices["\""]) == 0 or len(charIndices["="]) == 0:
    if len(leftBracket) > 1:
      headToFix = header[leftBracket[1]:]
      headToFix.replace("(", "")
      header = header[:leftBracket[1]] + headToFix
    if len(rightBracket) > 1:
      headToFix = header[rightBracket[1]:]
      headToFix.replace("(", "")
      header = header[rightBracket[1]:] + headToFix
  return header

def findHeaders(inputPath, outputPath):
  input = open(inputPath, "r")
  output = open(outputPath, "w")

  for line in input.readlines():
    # Parse and fix function headers
    if line.startswith("def "):
      header = "def " + checkAndFixHeader(line.replace("def ", ""))
      output.write(header)
    else:
      output.write(line)
  input.close()
  output.close()

def checkAndFixHeader(header):
  specialChars = {"(":[], ")":[], "=":[], ",":[], "\"":[], ":":[], " ":[]}
  # Parse header
  for i in range(len(header) - 1, 0, -1):
    char = header[i]
    # Remove any characters after end of header
    if char == ":":
      header = header[0:i + 1] + "\n"
      specialChars[":"].append(i)
    # Store indexes of special characters
    elif char in specialChars:
      specialChars[char].append(i)
  
  header = parseBracketsAndStrings(header, specialChars)
  # TODO - Add condition for brackets in strings, maybe returned from above func
  # Add open parenthesis if none exist
  if len(specialChars["("]) == 0:
    header = header[:specialChars[" "][-1]] + "(" + header[specialChars[" "][-1] + 1:]
  # add close parenthesis if none exist
  if len(specialChars[")"]) == 0:
    # add colon if none exist
    if len(specialChars[":"]) == 0:
      header = header.replace("\n","") + "):\n"
    else: 
      header = header.replace("\n","")[:-2] + "):\n"
  return header  

def findPrint(path):
  file = open(path)
  print_count = 0
  for line in file.readlines():
    print_count += len(re.findall(r'\bprint\b(?=(?:[^"]*"[^"]*")*[^"]*$)', line))
  return print_count

try:
  findHeaders(inputFile, "output.txt")
  printNumber = findPrint(inputFile)
  print(printNumber)

finally:
  print("complete")
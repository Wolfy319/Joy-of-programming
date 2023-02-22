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


"""
This class is a child inheritence of a built in ast node visiting class
It goes through the abstract syntax tree, and checks the number of keyword prints
It ignores the other possible print values, "print(", print in a function name.
The tree has different names for items such as strings so this bypasses those because
in the syntax tree they are not represeneted by their string value
"""
class PrintCounter(ast.NodeVisitor):
    def __init__(self):
        self.count = 0

    def visit_Call(self, node):
        if isinstance(node.func, ast.Name) and node.func.id == 'print':
            self.count += 1
        self.generic_visit(node)


def printCount(filename):
    with open(filename, 'r') as file:
        code = file.read()

    tree = ast.parse(code)
    print_counter = PrintCounter()
    print_counter.visit(tree)

    print("Number of print statements: " + str(print_counter.count))


try:
  printCount('Project2/print_test.py')
  findHeaders(inputFile, "output.txt")

finally:
  print("complete")
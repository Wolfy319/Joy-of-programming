import re
import ast
import os

# inputFile = 'Project2/testExamples.py'
inputFile = 'testExamples.py'
indentOutput = 'output.py'


def check_indentation(inputFile):
    with open(inputFile, 'r', encoding="utf8") as f:
        lines = f.readlines()

    # Check and fix indentation errors
    indentation_level = 0
    updated = []
    for line in lines:
        stripped_line = line.strip()
        if stripped_line.startswith("if") or stripped_line.startswith("for"):
            updated.append(
                "    " * indentation_level + stripped_line + "\n")
            indentation_level += 1
        elif stripped_line.startswith("def"):
            indentation_level = 0
            updated.append(stripped_line + "\n")
            indentation_level += 1
        elif stripped_line.startswith("#"):
            updated.append("")
        elif stripped_line.startswith(""):
            updated.append(
                "    " * indentation_level + stripped_line + "\n")
        else:
            updated.append(
                "    " * indentation_level + stripped_line + "\n")

    # Write the updated program to a new file
    with open(indentOutput, 'w', encoding="utf8") as f:
        f.writelines(updated)


def findHeaders(indentOutput, outputPath):
    input = open(indentOutput, encoding="utf8")
    output = open(outputPath, "w", encoding="utf8")

    for line in input.readlines():
        # Parse and fix function headers
        if line.startswith("def"):
            header = "def " + checkAndFixHeader(line.replace("def", ""))
            output.write(header)
        else:
            output.write(line)
    input.close()
    output.close()


def checkAndFixHeader(header):
    specialChars = {"(": [], ")": [], ":": [], " ": []}
    # Parse header
    for i in range(len(header) - 1, 0, -1):
        char = header[i]
        # Store indexes of special characters
        if char in specialChars:
            specialChars[char].append(i)

    # add open parenthesis if none exist
    if len(specialChars["("]) == 0:
        # place after first character if no spaces
        if len(specialChars[" "]) == 0:
            header = header[0] + "(" + header[1:]
        # else, place where first space occurs
        else:
            header = header[:specialChars[" "][0]] + \
                "(" + header[specialChars[" "][0] + 1:]
    # add close parenthesis if none exist
    if len(specialChars[")"]) == 0:
        header = header[:specialChars[":"][0]] + "):\n"
    # add colon if none exist
    if len(specialChars[":"]) == 0:
        header = header[:specialChars[")"][0]] + "):\n"
    return header.replace(" ", "")


class PrintCounter(ast.NodeVisitor):
    # inheritance of node vistor class in ast library
    def __init__(self):
        self.count = 0
    # defines the inherited call function

    def visit_Call(self, node):
        # checks if there is a keyword print being used as it iterates through the tree
        if isinstance(node.func, ast.Name) and node.func.id == 'print':
            self.count += 1
        self.generic_visit(node)


def printCount(filename):
    with open(filename, 'r', encoding="utf8") as file:
        code = file.read()
    # uses the printcounter class to parse through the ast
    tree = ast.parse(code)
    print_counter = PrintCounter()
    print_counter.visit(tree)

    return "Number of print statements: " + str(print_counter.count)


def printOutput(bad_file):
    # opens old file and saves it for later
    with open(bad_file, 'r', encoding='utf-8') as file:
        old = file.read()

    # for presentation purposes
    title = "Joy of Programming, Project 2"
    old_title = "Old File"
    fix_title = "Fixed File"

    # fixes indents on original file
    check_indentation(bad_file)
    # fixes headers on fixed indent file
    findHeaders(indentOutput, "output.txt")

    # gets the fixed file and saves it for later
    with open("output.txt", "r", encoding='utf-8') as fix_file:
        fix = fix_file.read()

    # writes the final.txt file for #4 with the old file, fixed file and print count
    with open("final.txt", 'w', encoding='utf-8') as final:
        final.write(title + "\n\n" + old_title + "\n\n" + old + "\n\n" +
                    fix_title + "\n\n" + fix + "\n\n" + printCount("output.txt"))

  # writes the final.txt file for #4 with the old file, fixed file and print count
  with open("final.txt", 'w', encoding='utf-8') as final:
    final.write(title + "\n\n" + old_title + "\n" + old + "\n\n\n" + fix_title + "\n" + fix + "\n\n" + printCount("output.txt"))

try:
    # check_indentation(inputFile)
    # findHeaders(indentOutput, "output.txt")
    # printCount("output.txt")
    printOutput(inputFile)

finally:
    print("Complete")

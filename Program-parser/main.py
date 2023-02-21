import ast

class PrintCounter(ast.NodeVisitor):
    def __init__(self):
        self.count = 0

    def visit_Call(self, node):
        if isinstance(node.func, ast.Name) and node.func.id == 'print':
            self.count += 1
        self.generic_visit(node)

filename = 'Program-parser/test.py'
with open(filename, 'r') as file:
    code = file.read()

tree = ast.parse(code)
print_counter = PrintCounter()
print_counter.visit(tree)

print(print_counter.count)
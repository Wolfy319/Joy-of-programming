

#1. Check to make sure all the indentation in the input program is used correctly. If not, fix it. 

def welcome_student(name):
print(f"Hi, {name}! Welcome to CS3210.") #Indentation error here

def print_pattern(num_rows):
    for i in range(num_rows):
        for num_cols in range(num_rows-i):
        print("*", end="")  #Indentation error here

def print_funny():
    grade = 90
if grade >= 90:  #Indentation error here
    print("This is fun bc I got an A") #Indentation error here

#2. Check to make sure all the function headers are syntactically correct. If not, fix it. 

def welcome_student(name)
    print(f"Hi, {name}! Welcome to CS3210.") 

defprint_pattern(num_rows):
    for i in range(num_rows):
        for num_cols in range(num_rows-i):
            print("*", end="")  

def print_funny(grade:
    if grade >= 90:  
        print("This is fun bc I got an A") 

#3. Count how many time the keyword “print” is used as keywords in the input program. 

def welcome_print_easy(name):
    print(f"Hello: {name}! Welcome to CS3210.")
    print(f"CS3210 is fun.")
    print(f"Hello: CS3210 is very easy.")
    #the keyword “print” is used as keyword for 3 times

def welcome_print_hard(name):
    print(f"Print: {name}! Welcome to CS3210. finished Print") 
    #the keyword “print” is used as keyword for only 1 time.
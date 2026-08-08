# Assignment 3 Submitted by Devashish Sathawane

## Project Name

Star Pattern Generator and Tomcat Number Utility using Bash Shell Script

## Description

This assignment focuses on creating two shell script utilities using Bash.

The assignment is divided into two parts.

### Part A - Star Pattern Generator

The first part contains a shell script named `drawStar.sh`.

The script takes two command-line arguments:

- Size of the pattern
- Type of the star pattern

The script generates different star patterns depending on the type provided by the user.

The supported pattern types are:

- t1 - Right Triangle
- t2 - Left Aligned Triangle
- t3 - Pyramid
- t4 - Inverted Left Triangle
- t5 - Inverted Right Triangle
- t6 - Inverted Pyramid
- t7 - Diamond

Example:

./drawStar.sh 5 t1

Here, `5` represents the size and `t1` represents the pattern type.

### Part B - Tomcat Number Utility

The second part contains a shell script named `printTomcat.sh`.

The script takes one number as a command-line argument and checks whether the number is divisible by 3, 5, or 15.

The output is:

- `tom` - If the number is divisible by 3
- `cat` - If the number is divisible by 5
- `tomcat` - If the number is divisible by 15

Example:

./printTomcat.sh 6

Output:

tom

---

# Requirements

The following are required to execute this assignment:

- Ubuntu/Linux
- Bash Shell
- Basic Linux commands
- nano or vim
- chmod

---

# Files

Assignment3/
│── drawStar.sh
│── printTomcat.sh
│── README.md

---

# Part A - Star Pattern Generator

## 1. Create drawStar.sh

First, create the `drawStar.sh` file using the nano editor.

### Command

nano drawStar.sh

The Bash script is written inside the file.

The script accepts two arguments:

- First argument - Size
- Second argument - Pattern type

Example:

./drawStar.sh 5 t1

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the creation of `drawStar.sh` using nano and the Bash script.

---

## 2. Give Executable Permission

Before executing the script, executable permission is given using the `chmod` command.

### Command

chmod +x drawStar.sh

Check the permissions:

ls -l drawStar.sh

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing `chmod +x drawStar.sh` and the executable permission.

---

# Star Pattern Types

The `drawStar.sh` script supports seven different star patterns.

---

## 3. Type t1 - Right Triangle

The `t1` pattern generates a right triangle where the number of stars increases on every line.

### Command

./drawStar.sh 5 t1

### Output

*
**
***
****
*****

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

./drawStar.sh 5 t1

---

## 4. Type t2 - Left Aligned Triangle

The `t2` pattern generates a left-aligned triangle.

### Command

./drawStar.sh 5 t2

### Output

*
**
***
****
*****

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

./drawStar.sh 5 t2

---

## 5. Type t3 - Pyramid

The `t3` pattern generates a centered pyramid.

### Command

./drawStar.sh 5 t3

### Output

    *
   ***
  *****
 *******
*********

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

./drawStar.sh 5 t3

---

## 6. Type t4 - Inverted Left Triangle

The `t4` pattern generates an inverted triangle where the number of stars decreases on every line.

### Command

./drawStar.sh 5 t4

### Output

*****
****
***
**
*

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

./drawStar.sh 5 t4

---

## 7. Type t5 - Inverted Right Triangle

The `t5` pattern generates an inverted right-aligned triangle.

### Command

./drawStar.sh 5 t5

### Output

*****
 ****
  ***
   **
    *

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

./drawStar.sh 5 t5

---

## 8. Type t6 - Inverted Pyramid

The `t6` pattern generates an inverted pyramid.

### Command

./drawStar.sh 5 t6

### Output

*********
 *******
  *****
   ***
    *

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

./drawStar.sh 5 t6

---

## 9. Type t7 - Diamond

The `t7` pattern generates a diamond by combining an upper pyramid and a lower inverted pyramid.

### Command

./drawStar.sh 5 t7

### Output

    *
   ***
  *****
 *******
*********
 *******
  *****
   ***
    *

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the output of:

./drawStar.sh 5 t7

---

# Pattern Summary

| Type | Pattern |
|------|---------|
| t1 | Right Triangle |
| t2 | Left Aligned Triangle |
| t3 | Pyramid |
| t4 | Inverted Left Triangle |
| t5 | Inverted Right Triangle |
| t6 | Inverted Pyramid |
| t7 | Diamond |

The PDF demonstrates execution of all seven patterns using size `5`. :contentReference[oaicite:1]{index=1}

---

# Part B - Tomcat Number Utility

## 10. Create printTomcat.sh

The second part of the assignment requires creating a shell script named `printTomcat.sh`.

### Command

nano printTomcat.sh

The script accepts one number as an argument.

Example:

./printTomcat.sh 7

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the creation of `printTomcat.sh` using nano.

---

## 11. Give Executable Permission

Give executable permission to the script.

### Command

chmod +x printTomcat.sh

Check the permission:

ls -l printTomcat.sh

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing executable permission for `printTomcat.sh`.

---

# Divisibility Conditions

The script checks the number using the following conditions.

## Divisible by 15

If the number is divisible by 15, the script prints:

tomcat

Example:

./printTomcat.sh 30

Output:

tomcat

---

## Divisible by 3

If the number is divisible by 3, the script prints:

tom

Example:

./printTomcat.sh 6

Output:

tom

---

## Divisible by 5

If the number is divisible by 5, the script prints:

cat

Example:

./printTomcat.sh 10

Output:

cat

---

## Not Divisible by 3 or 5

If the number is not divisible by 3, 5, or 15, the script does not print `tom`, `cat`, or `tomcat`.

Example:

./printTomcat.sh 7

No special output is produced.

---

# Test Cases

## Test Case 1

### Command

./printTomcat.sh 7

### Output

No output because 7 is not divisible by 3 or 5.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing the execution of `./printTomcat.sh 7`.

---

## Test Case 2

### Command

./printTomcat.sh 6

### Output

tom

6 is divisible by 3.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing:

./printTomcat.sh 6

and the output `tom`.

---

## Test Case 3

### Command

./printTomcat.sh 10

### Output

cat

10 is divisible by 5.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing:

./printTomcat.sh 10

and the output `cat`.

---

## Test Case 4

### Command

./printTomcat.sh 30

### Output

tomcat

30 is divisible by both 3 and 5, therefore it is divisible by 15.

### Screenshot

[ADD SCREENSHOT HERE]

Screenshot showing:

./printTomcat.sh 30

and the output `tomcat`.

The PDF demonstrates these test cases and their corresponding outputs. :contentReference[oaicite:2]{index=2}

---

# Important Bash Concepts Used

## Command-Line Arguments

The scripts use command-line arguments to receive input from the user.

For example:

./drawStar.sh 5 t1

Here:

$1 = 5

$2 = t1

Similarly:

./printTomcat.sh 30

Here:

$1 = 30

---

## Case Statement

The `case` statement is used in `drawStar.sh` to select the required star pattern based on the type.

For example:

case $type in

t1)
    ...
    ;;

t2)
    ...
    ;;

esac

This allows one script to handle multiple pattern types.

---

## For Loop

The `for` loop is used to repeatedly print spaces and stars.

Example:

for ((i=1; i<=size; i++))
do
    ...
done

Loops make it possible to generate patterns dynamically according to the size given by the user.

---

## Arithmetic Operations

Arithmetic calculations are used to determine the number of stars and spaces.

For example:

2*i-1

is used to calculate the number of stars required for a pyramid.

---

## Modulus Operator

The `%` operator is used in `printTomcat.sh` to check divisibility.

Example:

num % 3

If the result is `0`, the number is divisible by 3.

Similarly:

num % 5

checks divisibility by 5.

And:

num % 15

checks divisibility by 15.

---

# Script Usage

## drawStar.sh

General syntax:

./drawStar.sh <size> <type>

Example:

./drawStar.sh 5 t1

---

## printTomcat.sh

General syntax:

./printTomcat.sh <number>

Example:

./printTomcat.sh 30

---

# Screenshots

## 1. drawStar.sh Creation

[ADD SCREENSHOT HERE]

Screenshot showing `drawStar.sh` being created using nano.

---

## 2. drawStar.sh Executable Permission

[ADD SCREENSHOT HERE]

Screenshot showing:

chmod +x drawStar.sh

and the executable permission.

---

## 3. t1 Pattern

[ADD SCREENSHOT HERE]

Screenshot showing:

./drawStar.sh 5 t1

---

## 4. t2 Pattern

[ADD SCREENSHOT HERE]

Screenshot showing:

./drawStar.sh 5 t2

---

## 5. t3 Pattern

[ADD SCREENSHOT HERE]

Screenshot showing:

./drawStar.sh 5 t3

---

## 6. t4 Pattern

[ADD SCREENSHOT HERE]

Screenshot showing:

./drawStar.sh 5 t4

---

## 7. t5 Pattern

[ADD SCREENSHOT HERE]

Screenshot showing:

./drawStar.sh 5 t5

---

## 8. t6 Pattern

[ADD SCREENSHOT HERE]

Screenshot showing:

./drawStar.sh 5 t6

---

## 9. t7 Pattern

[ADD SCREENSHOT HERE]

Screenshot showing:

./drawStar.sh 5 t7

---

## 10. printTomcat.sh Creation

[ADD SCREENSHOT HERE]

Screenshot showing `printTomcat.sh` being created using nano.

---

## 11. printTomcat.sh Permission

[ADD SCREENSHOT HERE]

Screenshot showing:

chmod +x printTomcat.sh

---

## 12. Tomcat Test Cases

[ADD SCREENSHOT HERE]

Screenshot showing the execution of:

./printTomcat.sh 7

./printTomcat.sh 6

./printTomcat.sh 10

./printTomcat.sh 30

and their corresponding outputs.

---

# Result

The star pattern generator and Tomcat number utility were successfully created using Bash Shell Script.

The `drawStar.sh` script can generate seven different star patterns based on the size and type provided by the user.

The `printTomcat.sh` script checks the divisibility of a number and prints the appropriate output based on the given conditions.

The assignment demonstrates practical use of Bash command-line arguments, case statements, for loops, arithmetic operations, and the modulus operator.

---

# Conclusion

This assignment provided practical knowledge of Bash scripting and control structures.

The first part helped in understanding nested loops, command-line arguments, spacing, and pattern generation.

The second part helped in understanding conditional statements and arithmetic operations using the modulus operator.

Overall, the assignment improved understanding of how Bash scripts can accept user input through command-line arguments and perform different operations based on the input.

---

# Author

Devashish Sathawane

Assignment 3 - Star Pattern Generator and Tomcat Number Utility
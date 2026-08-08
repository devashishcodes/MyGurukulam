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

# Files

Assignment3/
│── drawStar.sh
│── printTomcat.sh
│── README.md

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
<img width="1002" height="63" alt="Screenshot 2026-08-08 231658" src="https://github.com/user-attachments/assets/b122c2a5-ab63-4549-a909-8dd96663a952" />

Screenshot showing the creation of `drawStar.sh` using nano and the Bash script.

## 2. Give Executable Permission

Before executing the script, executable permission is given using the `chmod` command.

### Command

chmod +x drawStar.sh

### Screenshot
<img width="1090" height="52" alt="Screenshot 2026-08-08 231730" src="https://github.com/user-attachments/assets/53e2b641-160a-4dee-8ae5-ec848f6825d6" />

Screenshot showing `chmod +x drawStar.sh` and the executable permission.

# Star Pattern Types

The `drawStar.sh` script supports seven different star patterns.

## 3. Type t1 - Right Triangle

The `t1` pattern generates a right triangle where the number of stars increases on every line.

### Command

./drawStar.sh 5 t1

### Screenshot
<img width="1092" height="250" alt="Screenshot 2026-08-08 231828" src="https://github.com/user-attachments/assets/d3097027-4f24-46fe-9393-b3ae1084c1ec" />

Screenshot showing the output of:
./drawStar.sh 5 t1

## 4. Type t2 - Left Aligned Triangle

The `t2` pattern generates a left-aligned triangle.

### Command
./drawStar.sh 5 t2

### Screenshot
<img width="1097" height="273" alt="Screenshot 2026-08-08 231913" src="https://github.com/user-attachments/assets/2f603128-60b8-4770-a6fa-b11bfccd4a17" />

Screenshot showing the output of:
./drawStar.sh 5 t2

## 5. Type t3 - Pyramid

The `t3` pattern generates a centered pyramid.

### Command
./drawStar.sh 5 t3

### Screenshot
<img width="1088" height="248" alt="Screenshot 2026-08-08 231941" src="https://github.com/user-attachments/assets/7835e255-40f3-47c9-b544-5209424ca985" />

Screenshot showing the output of:
./drawStar.sh 5 t3

## 6. Type t4 - Inverted Left Triangle

The `t4` pattern generates an inverted triangle where the number of stars decreases on every line.

### Command

./drawStar.sh 5 t4

### Screenshot
<img width="1092" height="250" alt="Screenshot 2026-08-08 232018" src="https://github.com/user-attachments/assets/0d96a61d-ad1c-4e89-aba7-61a2e00a6fee" />

Screenshot showing the output of:
./drawStar.sh 5 t4

## 7. Type t5 - Inverted Right Triangle

The `t5` pattern generates an inverted right-aligned triangle.

### Command

./drawStar.sh 5 t5

### Screenshot
<img width="1092" height="246" alt="Screenshot 2026-08-08 232048" src="https://github.com/user-attachments/assets/f2787eb8-f08e-4501-b486-2fc617553aa6" />

Screenshot showing the output of:
./drawStar.sh 5 t5

## 8. Type t6 - Inverted Pyramid

The `t6` pattern generates an inverted pyramid.

### Command

./drawStar.sh 5 t6

### Screenshot
<img width="1097" height="255" alt="Screenshot 2026-08-08 232113" src="https://github.com/user-attachments/assets/cbe4a176-9971-46d7-bff9-d410fe8c0828" />


Screenshot showing the output of:
./drawStar.sh 5 t6

## 9. Type t7 - Diamond

The `t7` pattern generates a diamond by combining an upper pyramid and a lower inverted pyramid.

### Command

./drawStar.sh 5 t7

### Screenshot
<img width="1092" height="435" alt="Screenshot 2026-08-08 232137" src="https://github.com/user-attachments/assets/a79636f3-2eb2-4564-8ba7-1af35877b879" />

Screenshot showing the output of:
./drawStar.sh 5 t7

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

# Part B - Tomcat Number Utility

## 10. Create printTomcat.sh

The second part of the assignment requires creating a shell script named `printTomcat.sh`.

### Command

nano printTomcat.sh
The script accepts one number as an argument.

Example:
./printTomcat.sh 7

### Screenshot
<img width="1065" height="65" alt="Screenshot 2026-08-08 232243" src="https://github.com/user-attachments/assets/a972ed01-5351-4ea6-90f5-03af65680629" />


Screenshot showing the creation of `printTomcat.sh` using nano.

## 11. Give Executable Permission

Give executable permission to the script.

### Command

chmod +x printTomcat.sh

### Screenshot
<img width="1181" height="48" alt="Screenshot 2026-08-08 232329" src="https://github.com/user-attachments/assets/06688942-1c3c-4fe3-82c5-177bc48eb532" />

Screenshot showing executable permission for `printTomcat.sh`.

# Divisibility Conditions

The script checks the number using the following conditions.

## Divisible by 15

If the number is divisible by 15, the script prints:
tomcat

Example:
./printTomcat.sh 30

Output:
tomcat

## Divisible by 3

If the number is divisible by 3, the script prints:
tom

Example:
./printTomcat.sh 6

Output:
tom

## Divisible by 5

If the number is divisible by 5, the script prints:
cat

Example:
./printTomcat.sh 10

Output:
cat

## Not Divisible by 3 or 5

If the number is not divisible by 3, 5, or 15, the script does not print `tom`, `cat`, or `tomcat`.

Example:

./printTomcat.sh 7
No special output is produced.


# Test Cases
The `printTomcat.sh` script was tested with different numbers to verify all the required conditions.

## Test Case 1 - Number 7

### Command
./printTomcat.sh 7

### Output
No output because 7 is not divisible by 3, 5, or 15.


## Test Case 2 - Number 6

### Command
./printTomcat.sh 6

### Output
tom

6 is divisible by 3.

## Test Case 3 - Number 10

### Command
./printTomcat.sh 10

### Output
cat

10 is divisible by 5.

## Test Case 4 - Number 30

### Command
./printTomcat.sh 30

### Output
tomcat

30 is divisible by 15.

## Screenshot - All Test Cases
<img width="1180" height="366" alt="Screenshot 2026-08-08 232529" src="https://github.com/user-attachments/assets/d56f8915-22e0-4eed-a657-b1932dc1ab70" />

The screenshot shows all four test cases executed together:

- `7` → No output
- `6` → `tom`
- `10` → `cat`
- `30` → `tomcat`

This confirms that the `printTomcat.sh` script correctly handles the required divisibility conditions.

# Conclusion

This assignment provided practical knowledge of Bash scripting and control structures.

The first part helped in understanding nested loops, command-line arguments, spacing, and pattern generation.

The second part helped in understanding conditional statements and arithmetic operations using the modulus operator.

Overall, the assignment improved understanding of how Bash scripts can accept user input through command-line arguments and perform different operations based on the input.

# Author
Devashish Sathawane

Assignment 3 - Star Pattern Generator and Tomcat Number Utility

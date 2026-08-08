# Assignment 3 – drawStar.sh & printTomcat.sh

**Submitted by:** Devashish Sathawane

Two standalone Bash scripts: one that draws different star/triangle/diamond patterns based on a size and type argument, and one that plays a FizzBuzz-style "TomCat" game based on divisibility rules.

## Part A: drawStar.sh

Generates a star pattern. Takes two arguments — `size` and `type` (`t1`–`t7`) — and prints the corresponding shape using nested loops and `printf`.

### Setup
```bash
nano drawStar.sh
chmod +x drawStar.sh
```

### Usage
```bash
./drawStar.sh <size> <type>
```

### Types

| Type | Shape |
|---|---|
| `t1` | Right-aligned right triangle |
| `t2` | Left-aligned triangle |
| `t3` | Pyramid |
| `t4` | Inverted left triangle |
| `t5` | Inverted right triangle |
| `t6` | Inverted pyramid |
| `t7` | Diamond |

### Examples
```bash
./drawStar.sh 5 t1
    *
   **
  ***
 ****
*****

./drawStar.sh 5 t2
*
**
***
****
*****

./drawStar.sh 5 t3
    *
   ***
  *****
 *******
*********

./drawStar.sh 5 t4
*****
****
***
**
*

./drawStar.sh 5 t5
*****
 ****
  ***
   **
    *

./drawStar.sh 5 t6
*********
 *******
  *****
   ***
    *

./drawStar.sh 5 t7
    *
   ***
  *****
 *******
*********
 *******
  *****
   ***
    *
```

### Logic

- Each shape is built with an outer loop for rows and one or two inner loops: one to `printf` leading spaces, one to `printf` the `*` characters.
- `t7` (diamond) is simply an upper pyramid (`t3` logic) followed by a lower pyramid (mirrored, shrinking from `size-1`).
- Invalid `type` values fall through to a `case` default that prints `"Invalid Type"`.
- The script validates argument count first (`$# -ne 2`) and exits with a usage message if size/type aren't both supplied.

## Part B: printTomcat.sh

A FizzBuzz-style script: given a number, it prints `tom`, `cat`, `tomcat`, or nothing, based on divisibility.

### Setup
```bash
nano printTomcat.sh
chmod +x printTomcat.sh
```

### Usage
```bash
./printTomcat.sh <number>
```

### Rules

| Condition | Output |
|---|---|
| Divisible by 15 | `tomcat` |
| Divisible by 3 (not 15) | `tom` |
| Divisible by 5 (not 15) | `cat` |
| Otherwise | *(no output)* |

The divisible-by-15 check is placed first in the `if`/`elif` chain so multiples of 15 (which are also multiples of 3 and 5) print `tomcat` rather than `tom` or `cat`.

### Examples
```bash
./printTomcat.sh 7

./printTomcat.sh 6
tom

./printTomcat.sh 10
cat

./printTomcat.sh 30
tomcat
```

## Screenshots

<!-- Add your terminal/output screenshots below -->

### drawStar.sh script and t1 output
<img width="547" height="37" alt="image" src="https://github.com/user-attachments/assets/54968de3-eea8-4da9-b314-c1cddfe974dd" />
<img width="610" height="172" alt="image" src="https://github.com/user-attachments/assets/38a2d0f8-8b43-4b6b-ad1f-62e7324456ab" />

### drawStar.sh outputs for t2–t7
<img width="532" height="820" alt="image" src="https://github.com/user-attachments/assets/c1c88ba5-2fd1-446b-ad53-d9b7bdebc3c7" />

### printTomcat.sh script and outputs
<img width="503" height="25" alt="image" src="https://github.com/user-attachments/assets/c9fdd4cc-a84a-43c6-8743-045e24d2f248" />
<img width="572" height="205" alt="image" src="https://github.com/user-attachments/assets/885c17f7-262d-4e39-95be-bd29f53ff91b" />

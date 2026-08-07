Assignment 5 Submitted by Devashish Sathawane

# Assignment 5

## Project Name

Template Engine and Text Editor Utility using Shell Script

---

## Description

This assignment contains two shell scripts.

### Part A - Template Engine

The Template Engine reads a template file and replaces the variables with the values provided by the user through command-line arguments.

### Part B - Text Editor Utility

The Text Editor performs different text editing operations such as adding, deleting, updating, and inserting text into a file using shell scripting.

---

## Requirements

- Ubuntu/Linux
- Bash Shell
- sed
- nano (optional)

---

## Files

```
Assignment5/
│── templateEngine.sh
│── trainer.template
│── otTextEditor
│── sample.txt
│── README.md

# Part A

## Template File

trainer.template

{{fname}} is trainer of {{topic}}

## Command

```bash
./templateEngine.sh trainer.template fname=Sandeep topic=Linux

## Output

Sandeep is trainer of Linux


# Part B

## Commands

### Add Line at Top

```bash
./otTextEditor addLineTop sample.txt "Welcome"
```

### Add Line at Bottom

```bash
./otTextEditor addLineBottom sample.txt "Thank You"
```

### Add Line at Specific Position

```bash
./otTextEditor addLineAt sample.txt 3 "Linux Class"
```

### Update First Word

```bash
./otTextEditor updateFirstWord sample.txt Linux Unix
```

### Update All Words

```bash
./otTextEditor updateAllWords sample.txt Linux Ubuntu
```

### Insert Word

```bash
./otTextEditor insertWord sample.txt from jaipur very
```

### Delete Line

```bash
./otTextEditor deleteLine sample.txt 4
```

### Delete Line Containing Word

```bash
./otTextEditor deleteLineWord sample.txt from
```

### Count Lines (Extra Feature)

```bash
./otTextEditor countLines sample.txt
```

### Convert File to Uppercase (Extra Feature)

```bash
./otTextEditor upperCase sample.txt
```

---

# Extra Features

- Count total number of lines.
- Convert complete file into uppercase.

---

# Output

The utility successfully performs all the required text editing operations.

---

# Author

Devashish Sathawane

---

# Screenshots

## Template Engine

![Template Output](screenshots/1-template-output.png)

## Add Line at Top

![Add Top](screenshots/2-add-top.png)

## Add Line at Bottom

![Add Bottom](screenshots/3-add-bottom.png)

## Add Line at Specific Position

![Add Line](screenshots/4-add-line.png)

## Update First Word

![Update First](screenshots/5-update-first.png)

## Insert Word

![Insert Word](screenshots/6-insert-word.png)

## Delete Line

![Delete Line](screenshots/7-delete-line.png)

## Delete Line Containing Word

![Delete Word](screenshots/8-delete-word.png)

## Count Lines

![Count Lines](screenshots/9-count-lines.png)

## Uppercase

!
# Assignment 5 Submitted by Devashish Sathawane

## Project Name
Template Engine and Text Editor Utility using Shell Script

## Description
This assignment contains two shell scripts.

### Part A - Template Engine
The Template Engine reads a template file and replaces the variables with the values provided by the user through command-line arguments.

### Part B - Text Editor Utility
The Text Editor performs different text editing operations such as adding, deleting, updating, and inserting text into a file using shell scripting.

## Requirements
- Ubuntu/Linux
- Bash Shell
- sed
- nano (optional)

## Files
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
./templateEngine.sh trainer.template fname=Sandeep topic=Linux

## Output
Sandeep is trainer of Linux

# Part B
## Commands

### Add Line at Top
./otTextEditor addLineTop sample.txt "Welcome"

### Add Line at Bottom
./otTextEditor addLineBottom sample.txt "Thank You"

### Add Line at Specific Position
./otTextEditor addLineAt sample.txt 3 "Linux Class"

### Update First Word
./otTextEditor updateFirstWord sample.txt Linux Unix

### Update All Words
./otTextEditor updateAllWords sample.txt Linux Ubuntu

### Insert Word
./otTextEditor insertWord sample.txt from jaipur very

### Delete Line
./otTextEditor deleteLine sample.txt 4

### Delete Line Containing Word
./otTextEditor deleteLineWord sample.txt from

### Count Lines (Extra Feature)
./otTextEditor countLines sample.txt

### Convert File to Uppercase (Extra Feature)
./otTextEditor upperCase sample.txt

# Extra Features
- Count total number of lines.
- Convert complete file into uppercase.

# Output
The utility successfully performs all the required text editing operations.

# Author
Devashish Sathawane

# Screenshots

## Template Engine

<img width="1091" height="115" alt="Screenshot 2026-08-07 233448" src="https://github.com/user-attachments/assets/77c37035-0439-4185-9508-93b88dadf26e" />

## Add Line at Top

<img width="902" height="45" alt="Screenshot 2026-08-07 233347" src="https://github.com/user-attachments/assets/42671945-aecb-4f38-bc96-e627e78b0dd2" />
<img width="897" height="26" alt="Screenshot 2026-08-07 233421" src="https://github.com/user-attachments/assets/581aaf0a-189e-4890-b094-8a4fa5c9ba0f" />
<img width="898" height="187" alt="Screenshot 2026-08-07 233255" src="https://github.com/user-attachments/assets/7d5d1e26-7321-4349-917c-023e4ce6a631" />

## Add Line at Bottom

<img width="952" height="212" alt="Screenshot 2026-08-07 233237" src="https://github.com/user-attachments/assets/9cbddc08-7e69-47d1-b4b4-08d1996be0fe" />

## Add Line at Specific Position

<img width="958" height="232" alt="Screenshot 2026-08-07 233214" src="https://github.com/user-attachments/assets/94e5a548-0500-487f-95b0-048ac082f5c0" />

## Update First Word

<img width="975" height="235" alt="Screenshot 2026-08-07 233150" src="https://github.com/user-attachments/assets/6f27e3b4-8507-4c94-9381-7c4d521ae4e4" />

## Insert Word

<img width="985" height="235" alt="Screenshot 2026-08-07 233048" src="https://github.com/user-attachments/assets/d77cb2c3-83c9-46da-8c53-6ece04323852" />

## Delete Line

<img width="807" height="212" alt="Screenshot 2026-08-07 233003" src="https://github.com/user-attachments/assets/fd1f98fe-8b50-4c9a-a1eb-741e9ee40664" />

## Delete Line Containing Word

<img width="888" height="117" alt="Screenshot 2026-08-07 232847" src="https://github.com/user-attachments/assets/994468ec-8592-4e43-b94d-d6a7e7fcd5c9" />

## Count Lines

<img width="770" height="50" alt="Screenshot 2026-08-07 232807" src="https://github.com/user-attachments/assets/5b054804-3c4a-451d-bc63-02a830c948e3" />

## Uppercase

<img width="760" height="116" alt="Screenshot 2026-08-07 232344" src="https://github.com/user-attachments/assets/223c42e2-e027-4a25-860f-3a69c50c3059" />

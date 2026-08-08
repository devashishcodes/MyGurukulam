# Assignment 5 – templateEngine.sh & otTextEditor

**Submitted by:** Devashish Sathawane

Two standalone Bash utilities: a template engine that substitutes `{{placeholder}}` variables in a file, and a lightweight command-line text editor for common line/word editing operations without opening an actual editor.

## Part A: templateEngine.sh

Takes a template file containing `{{variable}}` placeholders and a list of `key=value` pairs, and prints the template with each placeholder replaced by its corresponding value.

### Setup
```bash
nano templateEngine.sh
chmod +x templateEngine.sh
```

### Usage
```bash
./templateEngine.sh <template file> key1=value1 key2=value2 ...
```

### Example

**trainer.template**
```
{{fname}} is trainer of {{topic}}
```

```bash
./templateEngine.sh trainer.template fname=sandeep topic=linux
sandeep is trainer of linux
```

### Logic

- Each `key=value` argument is split on `=` to get the variable name and its replacement value.
- For every pair, the corresponding `{{key}}` token in the template is substituted with `value` (e.g. via `awk`/`bash` string substitution, without using `sed`).
- The template file itself is left untouched — output is printed (or optionally redirected) rather than edited in place.
- Placeholders with no matching argument are left as-is (or could be flagged, depending on the implementation).

## Part B: otTextEditor

A CLI utility for making targeted edits to a text file: inserting or deleting lines, replacing or inserting words, and deleting lines by number or by content.

### Setup
```bash
nano otTextEditor
chmod +x otTextEditor
```

### Commands

| Command | Description |
|---|---|
| `otTextEditor addLineTop <file> <line>` | Insert `<line>` at the top of the file |
| `otTextEditor addLineBottom <file> <line>` | Append `<line>` at the end of the file |
| `otTextEditor addLineAt <file> <linenumber> <line>` | Insert `<line>` at a specific line number |
| `otTextEditor updateFirstWord <file> <word> <word2>` | Replace the first occurrence of `<word>` with `<word2>` |
| `otTextEditor updateAllWords <file> <word> <word2>` | Replace every occurrence of `<word>` with `<word2>` |
| `otTextEditor insertWord <file> <word1> <word2> <word to be inserted>` | Insert a word between `<word1>` and `<word2>` |
| `otTextEditor deleteLine <file> <line no>` | Delete the line at `<line no>` |
| `otTextEditor deleteLine <file> <line no> <word>` | Delete the line at `<line no>` only if it contains `<word>` |

### Examples
```bash
./otTextEditor addLineTop notes.txt "Meeting notes"
./otTextEditor addLineBottom notes.txt "End of file"
./otTextEditor addLineAt notes.txt 3 "Inserted line"
./otTextEditor updateFirstWord notes.txt old new
./otTextEditor updateAllWords notes.txt old new
./otTextEditor insertWord notes.txt quick brown fox
./otTextEditor deleteLine notes.txt 5
./otTextEditor deleteLine notes.txt 5 draft
```

### Additional custom features

<!-- List any extra features you added, e.g.: -->
- `otTextEditor countLines <file>` — print the total number of lines
- `otTextEditor countWord <file> <word>` — count occurrences of a word
- `otTextEditor showLine <file> <line no>` — print a single line's content
- `otTextEditor backup <file>` — create a timestamped backup before editing

### Logic Notes

- All operations avoid `sed`, using combinations of `head`, `tail`, `awk`, `cat`, temp files, and `mv` for safe in-place edits (write to a temp file, then replace the original).
- Line insertion/deletion is done by splitting the file at the target line number using `head -n` and `tail -n +`, then reassembling with the new/removed content in between.
- Word replacement uses `awk` (or shell string manipulation) rather than `sed`, since the assignment excludes `sed` use across scripts.

## Screenshots

<!-- Add your terminal/output screenshots below -->

### Template Engine

<img width="1091" height="115" alt="Screenshot 2026-08-07 233448" src="https://github.com/user-attachments/assets/77c37035-0439-4185-9508-93b88dadf26e" />

### Add Line at Top

<img width="902" height="45" alt="Screenshot 2026-08-07 233347" src="https://github.com/user-attachments/assets/42671945-aecb-4f38-bc96-e627e78b0dd2" />
<img width="897" height="26" alt="Screenshot 2026-08-07 233421" src="https://github.com/user-attachments/assets/581aaf0a-189e-4890-b094-8a4fa5c9ba0f" />
<img width="898" height="187" alt="Screenshot 2026-08-07 233255" src="https://github.com/user-attachments/assets/7d5d1e26-7321-4349-917c-023e4ce6a631" />

### Add Line at Bottom

<img width="952" height="212" alt="Screenshot 2026-08-07 233237" src="https://github.com/user-attachments/assets/9cbddc08-7e69-47d1-b4b4-08d1996be0fe" />

### Add Line at Specific Position

<img width="958" height="232" alt="Screenshot 2026-08-07 233214" src="https://github.com/user-attachments/assets/94e5a548-0500-487f-95b0-048ac082f5c0" />

### Update First Word

<img width="975" height="235" alt="Screenshot 2026-08-07 233150" src="https://github.com/user-attachments/assets/6f27e3b4-8507-4c94-9381-7c4d521ae4e4" />

### Insert Word

<img width="985" height="235" alt="Screenshot 2026-08-07 233048" src="https://github.com/user-attachments/assets/d77cb2c3-83c9-46da-8c53-6ece04323852" />

### Delete Line

<img width="807" height="212" alt="Screenshot 2026-08-07 233003" src="https://github.com/user-attachments/assets/fd1f98fe-8b50-4c9a-a1eb-741e9ee40664" />

### Delete Line Containing Word

<img width="888" height="117" alt="Screenshot 2026-08-07 232847" src="https://github.com/user-attachments/assets/994468ec-8592-4e43-b94d-d6a7e7fcd5c9" />

### Count Lines

<img width="770" height="50" alt="Screenshot 2026-08-07 232807" src="https://github.com/user-attachments/assets/5b054804-3c4a-451d-bc63-02a830c948e3" />

### Uppercase

<img width="760" height="116" alt="Screenshot 2026-08-07 232344" src="https://github.com/user-attachments/assets/223c42e2-e027-4a25-860f-3a69c50c3059" />

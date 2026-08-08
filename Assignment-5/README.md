# Assignment 5 – templateEngine.sh & otTextEditor

**Submitted by:** Devashish Sathawane

Two Bash utilities: a simple template engine that substitutes `{{placeholder}}` variables in a file, and a text editor utility for line/word-level edits from the command line — this time built using `sed`.

## Part A: templateEngine.sh

Takes a template file containing `{{key}}` placeholders and a list of `key=value` pairs, and prints the template with every placeholder replaced by its corresponding value.

### Setup
```bash
touch templateEngine.sh
chmod +x templateEngine.sh
```

### Usage
```bash
./templateEngine.sh <template_file> key1=value1 key2=value2 ...
```

### Example

`trainer.template`
```
{{fname}} is trainer of {{topic}}
```

```bash
./templateEngine.sh trainer.template fname=sandeep topic=linux
```

**Output**
```
sandeep is trainer of linux
```

### Logic

- Each `key=value` argument is split on `=` to get the variable name and its replacement value.
- For every pair, `{{key}}` is substituted with `value` across the template's content using `sed` (e.g. `sed "s/{{$key}}/$value/g"`), chaining substitutions across all provided pairs.
- Placeholders left in the template with no matching argument stay as-is (not substituted).

## Part B: otTextEditor

A command-line text editor utility for adding, replacing, inserting, and deleting lines/words in a file — implemented **using `sed`** for in-place edits.

### Setup
```bash
touch otTextEditor
chmod +x otTextEditor
```

### Setup
```bash
touch otTextEditor
chmod +x otTextEditor
```

### Commands

| Command | Description |
|---|---|
| `otTextEditor addLineTop <file> <line>` | Add a line at the top of the file |
| `otTextEditor addLineBottom <file> <line>` | Add a line at the bottom of the file |
| `otTextEditor addLineAt <file> <linenumber> <line>` | Insert a line at a specific line number |
| `otTextEditor updateFirstWord <file> <word> <word2>` | Replace the **first** occurrence of `word` with `word2` |
| `otTextEditor updateAllWords <file> <word> <word2>` | Replace **all** occurrences of `word` with `word2` |
| `otTextEditor insertWord <file> <word1> <word2> <insert>` | Insert `<insert>` between `<word1>` and `<word2>` (all occurrences) |
| `otTextEditor deleteLine <file> <line_no>` | Delete the line at a given line number |
| `otTextEditor deleteLineWord <file> <word>` | Delete every line that contains `<word>` |
| `otTextEditor countLines <file>` | Print the total number of lines in the file |
| `otTextEditor upperCase <file>` | Convert the entire file content to uppercase |

### How each command works

| Command | Approach |
|---|---|
| `addLineTop` | `sed -i "1i $line" "$file"` — inserts before line 1 |
| `addLineBottom` | `echo "$line" >> "$file"` — plain append, no `sed` needed |
| `addLineAt` | `sed -i "${lineno}i $line" "$file"` — inserts before the given line number |
| `updateFirstWord` | `sed -i "0,/$old/s//$new/" "$file"` — the `0,/pattern/` range restricts the substitution to only the first match in the whole file |
| `updateAllWords` | `sed -i "s/$old/$new/g" "$file"` — global substitution on every line |
| `insertWord` | `sed -i "s/$word1 $word2/$word1 $insert $word2/g" "$file"` — matches the exact `word1 word2` sequence and slots `insert` between them |
| `deleteLine` | `sed -i "${lineno}d" "$file"` — deletes by line number |
| `deleteLineWord` | `sed -i "/$word/d" "$file"` — deletes every line matching the pattern, not just one |

### Additional Features (custom)

Beyond the required commands, two extra utilities were added:
- **`countLines <file>`** — prints the total number of lines in the file (`wc -l`)
- **`upperCase <file>`** — converts the entire file's content to uppercase in place (`sed -i 's/.*/\U&/'`)

Any unrecognized command falls through to the `*)` case and prints `"Invalid Command"`.

## Note on `sed`

Unlike the earlier assignments (which deliberately avoided `sed`), **Part B of this assignment uses `sed`** for all in-place line and word edits, since it's the standard, efficient tool for this kind of scripted text editing.

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

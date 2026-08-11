# Assignment 5 – templateEngine.sh & otTextEditor

Submitted by Devashish Sathawane

## Part A: templateEngine.sh

Template engine that replaces `{{variable}}` in a file with values passed as arguments.

```bash
nano templateEngine.sh
chmod +x templateEngine.sh
nano trainer.template
./templateEngine.sh trainer.template fname=Sandeep topic=Linux
```
Output:
```
Sandeep is trainer of Linux
```
<img width="1472" height="165" alt="image" src="https://github.com/user-attachments/assets/d39f0b17-8ec0-426f-b69b-a1bad0f5aff3" />

## Part B: otTextEditor

Text editor utility built using `sed`.

```bash
nano otTextEditor
nano sample.txt
chmod +x otTextEditor
```
<img width="1437" height="142" alt="image" src="https://github.com/user-attachments/assets/205bc7e9-53b3-4280-bd55-d419d6cd81eb" />

### Add Line at Top

```bash
./otTextEditor addLineTop sample.txt "Welcome"
cat sample.txt
```
<img width="1458" height="308" alt="image" src="https://github.com/user-attachments/assets/c21795a7-d630-4be6-a87e-e10691f33785" />

### Add Line at Bottom

```bash
./otTextEditor addLineBottom sample.txt "Thank You"
cat sample.txt
```
<img width="1483" height="335" alt="image" src="https://github.com/user-attachments/assets/eaf02a56-e35a-4d4c-a19f-19c111221766" />

### Add Line at Specific Position

```bash
./otTextEditor addLineAt sample.txt 3 "Linux Class"
cat sample.txt
```
<img width="1473" height="372" alt="image" src="https://github.com/user-attachments/assets/8592c828-b175-4e35-be7f-1f9c8b21bc88" />

### Update First Word

```bash
./otTextEditor updateFirstWord sample.txt Linux Unix
cat sample.txt
```
<img width="1485" height="373" alt="image" src="https://github.com/user-attachments/assets/27321046-ff20-4ccd-b82f-f0a28ef813b5" />

### Insert Word

```bash
./otTextEditor insertWord sample.txt from jaipur very
cat sample.txt
```
<img width="1481" height="358" alt="image" src="https://github.com/user-attachments/assets/499fec09-e8b5-463a-8fa7-14190e16d4e2" />

### Delete Line

```bash
./otTextEditor deleteLine sample.txt 4
cat sample.txt
```
<img width="1452" height="387" alt="image" src="https://github.com/user-attachments/assets/60d89268-d5aa-49b2-9b15-09a4523163e6" />

### Delete Line Containing Word

```bash
./otTextEditor deleteLineWord sample.txt from
cat sample.txt
```
<img width="1482" height="200" alt="image" src="https://github.com/user-attachments/assets/c583f4fb-e185-4d86-8048-ec7892b019b1" />

### Count Lines

```bash
./otTextEditor countLines sample.txt
```
<img width="1437" height="117" alt="image" src="https://github.com/user-attachments/assets/6f5992c2-fdc6-4b7b-a025-01a7a2696087" />

### Uppercase (extra feature)

```bash
./otTextEditor upperCase sample.txt
cat sample.txt
```
<img width="1435" height="226" alt="image" src="https://github.com/user-attachments/assets/6f253334-ccc3-4362-ac13-93a54dd53b13" />

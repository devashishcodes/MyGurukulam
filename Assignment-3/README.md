# Assignment 3 – drawStar.sh & printTomcat.sh

Submitted by Devashish Sathawane

## Part A: Make drawStar.sh

Script takes 2 arguments — size and type — and prints a star pattern.

```bash
nano drawStar.sh
```
<img width="486" height="31" alt="image" src="https://github.com/user-attachments/assets/4a174ae3-c58b-4222-b8bb-d7b001c951b0" />

```bash
chmod +x drawStar.sh
./drawStar.sh 5 t1
```
```
    *
   **
  ***
 ****
*****
```
<img width="530" height="156" alt="image" src="https://github.com/user-attachments/assets/c03223fe-2c56-4ba2-a334-fcfc58280d82" />

```bash
./drawStar.sh 5 t2
```
```
*
**
***
****
*****
```
<img width="527" height="132" alt="image" src="https://github.com/user-attachments/assets/6826a222-a590-4166-aa2a-3eb0711202bf" />

```bash
./drawStar.sh 5 t3
```
```
    *
   ***
  *****
 *******
*********
```
<img width="522" height="125" alt="image" src="https://github.com/user-attachments/assets/16f0900a-a2ed-41e5-a976-0b0e8714f8f3" />

```bash
./drawStar.sh 5 t4
```
```
*****
****
***
**
*
```
<img width="530" height="122" alt="image" src="https://github.com/user-attachments/assets/01f44bda-2831-4ff0-8274-c676edc31a1f" />

```bash
./drawStar.sh 5 t5
```
```
*****
 ****
  ***
   **
    *
```
<img width="538" height="122" alt="image" src="https://github.com/user-attachments/assets/aab1890e-a40f-47aa-8b7c-678ad1e583a2" />

```bash
./drawStar.sh 5 t6
```
```
*********
 *******
  *****
   ***
    *
```
<img width="530" height="123" alt="image" src="https://github.com/user-attachments/assets/ebb73a91-dc6e-49b0-a2ca-38ae0b36b1d6" />

```bash
./drawStar.sh 5 t7
```
```
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
<img width="527" height="205" alt="image" src="https://github.com/user-attachments/assets/61d1796b-23d5-48f5-9bbe-f52a1497f3b2" />

## Part B: Make printTomcat.sh

Script takes a number and prints:
- `tom` if divisible by 3
- `cat` if divisible by 5
- `tomcat` if divisible by 15

```bash
nano printTomcat.sh
```
<img width="515" height="32" alt="image" src="https://github.com/user-attachments/assets/7bc9bebc-31ee-486a-b745-71a88e3aac05" />

```bash
chmod +x printTomcat.sh
./printTomcat.sh 7
./printTomcat.sh 6
./printTomcat.sh 10
./printTomcat.sh 30
```
```
(no output)
tom
cat
tomcat
```
<img width="572" height="203" alt="image" src="https://github.com/user-attachments/assets/bc37dafb-558d-444e-856d-c75a1e5bf60b" />

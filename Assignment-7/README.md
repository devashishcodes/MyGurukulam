# Assignment 7 – buildMaven.sh

Submitted by Devashish Sathawane

A utility to manage build operations of a maven based java project (generate artifact, install to local repo, static code analysis, unit tests, deploy to tomcat).

Repo used: https://github.com/opstree/spring3hibernate.git

## Flags

| Flag | Meaning |
|---|---|
| `-a` | Generate artifact |
| `-i` | Install artifact to local repo |
| `-s <tool>` | Static code analysis (checkstyle / findbugs / pmd) |
| `-t <plugin>` | Unit testing + code coverage |
| `-c` | Generate project documentation |
| `-d` | Deploy artifact to tomcat |

## Clone the repo

```bash
git clone https://github.com/opstree/spring3hibernate.git
```
<img width="975" height="22" alt="image" src="https://github.com/user-attachments/assets/01dfdff3-9949-4637-8050-090e54182fca" />

## Write and give permission to buildMaven.sh

```bash
nano buildMaven.sh
chmod +x buildMaven.sh
```
<img width="975" height="69" alt="image" src="https://github.com/user-attachments/assets/9593f182-bbe3-4d32-8f81-12bbda0ac3e4" />

## Generate artifact (-a)

```bash
./buildMaven.sh -a
```
Runs `mvn clean package`.
<img width="975" height="351" alt="image" src="https://github.com/user-attachments/assets/aa8fb3d5-8a34-46ff-bec4-03c1a034a04d" />
<img width="975" height="413" alt="image" src="https://github.com/user-attachments/assets/503e5ad1-7a51-4a5e-850a-2f93a1eb37d9" />

## Install artifact to local repo (-i)

```bash
./buildMaven.sh -i
```
Runs `mvn clean install`.
<img width="975" height="425" alt="image" src="https://github.com/user-attachments/assets/4ed65194-f3af-43fc-9ee5-f08a669f430c" />
<img width="975" height="336" alt="image" src="https://github.com/user-attachments/assets/a70a2122-0a69-4c0c-ad1e-3856fb39a01a" />

## Static code analysis – checkstyle (-s checkstyle)

```bash
./buildMaven.sh -s checkstyle
```
<img width="975" height="353" alt="image" src="https://github.com/user-attachments/assets/360baa59-7a62-4c34-bd60-b62a653ce156" />
<img width="975" height="393" alt="image" src="https://github.com/user-attachments/assets/5d752e9c-db09-44ee-b28e-6506ce32d276" />

## Static code analysis – findbugs (-s findbugs)

```bash
./buildMaven.sh -s findbugs
```
Uses SpotBugs plugin.
<img width="975" height="332" alt="image" src="https://github.com/user-attachments/assets/1ab06889-f5ed-488e-a484-b82db165c5a2" />
<img width="975" height="124" alt="image" src="https://github.com/user-attachments/assets/bc0fdfc8-865b-402d-be58-47d3dae0c951" />

## Static code analysis – pmd (-s pmd)

```bash
./buildMaven.sh -s pmd
```
<img width="975" height="356" alt="image" src="https://github.com/user-attachments/assets/295bad10-4f6f-4faf-9097-c64c6ba54c2d" />

## Unit test + code coverage (-t jacoco)

```bash
./buildMaven.sh -t jacoco
```
<img width="975" height="272" alt="image" src="https://github.com/user-attachments/assets/faa4fb80-f625-46ad-b7d5-ecba2a9f195e" />
<img width="975" height="274" alt="image" src="https://github.com/user-attachments/assets/a1a5fedf-2c45-41e6-bbdb-97d58f097a12" />

## Generate documentation (-c)

```bash
./buildMaven.sh -c
```
Runs `mvn site`.
<img width="975" height="153" alt="image" src="https://github.com/user-attachments/assets/319111d8-2403-447a-ba88-2f0307fc28da" />
<img width="975" height="258" alt="image" src="https://github.com/user-attachments/assets/e42725e3-8110-4a98-b5b7-2177cf913172" />

## Deploy artifact to Tomcat (-d)

```bash
./buildMaven.sh -d
```
<img width="975" height="219" alt="image" src="https://github.com/user-attachments/assets/e6f4a7d8-8482-4745-a143-4a0420a9208b" />
<img width="975" height="277" alt="image" src="https://github.com/user-attachments/assets/23b414e9-fac3-4929-b542-be9407c1d9ca" />

### Verify on browser
```
http://localhost:8080
```
<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/b8e9ea6e-179a-4767-86c8-d3a3dae7e972" />

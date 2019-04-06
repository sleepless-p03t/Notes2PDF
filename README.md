# Notes2PDF

Notes2PDF is a simple parser which converts a pseudo
markdown language into LaTeX which is then compiled into a
PDF file.

## Prerequisites

### Windows Users Only
1. Open PowerShell (as admin)
2. Run:
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
and restart your computer when prompted\
3. Search Ubuntu in the Windows Store\
4. Install Ubuntu\
5. After Ubuntu is installed, open the application\
6. Follow the prompts for Username and Password setup\
7. Run the following after Ubuntu finishes installing:
```bash
sudo apt-get update
sudo apt-get upgrade
```

Adding easy access to Windows directories:

1. If you don't know your Windows username, do the following in cmd:
```cmd
echo %USERNAME%
```
2. In the Ubuntu terminal do this:
```bash
echo 'export WHOME="/mnt/c/Users/<your username>/"' >> ~/.bashrc
source ~/.bashrc
```
Copying a file to your Windows Desktop (example)
```bash
cp myfile $WHOME/Desktop/
```

### Installing texlive packages

In a terminal, do one of the following:

```bash
sudo apt-get install texlive-full
```
or
```bash
sudo apt-get install texlive-latex-extra texlive-latex-recommended
```

## Installing Notes2PDF

Open a terminal and run:
```bash
git clone https://github.com/sleepless-p03t/Notes2PDF.git
cd Notes2PDF
sudo cp notes2pdf /usr/local/bin/
sudo chmod +x /usr/local/bin/notes2pdf
```

If you want to add syntax rules for notes files to vim:
```bash
mkdir -p ~/.vim/ftdetect/
mkdir -p ~/.vim/syntax/
cp vim/ftdetect/notes.vim ~/.vim/ftdetect/
cp vim/syntax/notes.vim ~/.vim/syntax/
```
## Running Notes2PDF

Assuming LaTeX is installed properly, Notes2PDF should work immediately

In a terminal, run:
```bash
notes2pdf <file>.notes
```
Assuming no errors exist in the notes file, Notes2PDF will run successfully

## Help and Tips

Notes2PDF is relatively expandable\
It currently supports:
- Titles
- Bullets
- inline equations
- equation blocks
- Fractions
- a choose b notation
- rudimentary table formatting
- syntax highlighting for programming languages

## The Notes Syntax

#### Bullet lists

Titles are defined as\
	- # Title

Bullet list start\
	- LSTS\
Bullet list end\
	- LSTE\
Lines starting with \* denote bullets\
	- \*\
Any text that immediately follows \* is treated as the bullet icon\
	- \*text

Bullet levels are defined by indentation (tabs)

#### Equation blocks

Equation block start\
	- EQUS\
Equation block end\
	- EQUE

#### Source code blocks
Source code block start; language specified with :*language*\
	- SRCS:*language*\
Source code block end\
	- SRCE

#### Tables
Table start; number of columns is the first argument, table title is the second argument\
	- TBLS:*cols*:*title*\
Table end\
	- TBLE

Columns are separated by tabs

*note: the first row of the table is treated as the column titles*

An example can be viewed [here](template.notes)\
And the generated PDF can be viewed [here](template.pdf)

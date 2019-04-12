# Notes2PDF

Notes2PDF is a simple parser which converts a pseudo
markdown language into LaTeX which is then compiled into a formatted
PDF file. The markdown language is designed to be easy to type quickly

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
echo 'export WHOME="/mnt/c/Users/<your Windows username>/"' >> ~/.bashrc
source ~/.bashrc
```
Copying a file to your Windows Desktop from Ubuntu terminal (example)
```bash
cp myfile $WHOME/Desktop/
```
Changing to Windows User directory (example)
```bash
cd $WHOME
```

### Installing texlive packages (Linux and Windows)

In a terminal, do one of the following:

```bash
sudo apt-get install texlive-full
```
or
```bash
sudo apt-get install texlive-latex-extra texlive-latex-recommended
```

### Installing Git and texlive (Mac\*)

#### Git
In a terminal, run
```bash
git --version
```
If Git isn't installed, you should be prompted to install it

#### texlive

The texlive package can be downloaded from [here](https://tug.org/mactex/mactex-download.html)\
If you have issues, check out the [FAQ](http://www.tug.org/mactex/faq/index.html)

\* *I do not own a Mac, so I have not tested this myself*

## Installing Notes2PDF

Open a terminal and run:
```bash
git clone https://github.com/sleepless-p03t/Notes2PDF.git
cd Notes2PDF
sudo cp notes2pdf /usr/local/bin/
sudo chmod +x /usr/local/bin/notes2pdf
```
## Adding Syntax Highlighting to Vim and Notepad++

If you want to add syntax rules and keyword completion for notes files to vim:\
*Note: ~/.vim and ~/.vimrc are Linux/OSX only*
Windows users: Check [here](https://superuser.com/questions/86246/where-should-the-vimrc-file-be-located-on-windows-7) for vim/vimrc locations

```bash
mkdir -p ~/.vim/ftdetect/
mkdir -p ~/.vim/syntax/
mkdir -p ~/.vim/words/

cp vim/ftdetect/notes.vim ~/.vim/ftdetect/
cp vim/syntax/notes.vim ~/.vim/syntax/
cp vim/words/notes.txt ~/.vim/words/
```
Next add the following to the end of your ~/.vimrc file:
```vim
"--- Autoswap colorschemes based on current buffer/window ---
" Dark colorschemes (excluding evening) are swapped to elflord for notes files
" Light colorschemes are swapped to evening with background=light for notes files
" Leaving a notes file swaps colors back to the default/user specified colorscheme

" store the user specified colorscheme name
let g:udefault = g:colors_name

" This function sets the notes colorscheme based on the current colorscheme
if !exists("*SetNotesScheme")
	function SetNotesScheme()
		if &background ==# "dark" && g:colors_name !=# "elflord"
			colorscheme elflord
			syntax on
		elseif exists("g:colors_name")
			if g:colors_name ==# "evening"
				set background="light"
				syntax on
			endif
		else
			colorscheme evening
			set background="light"
			syntax on
		endif
	endfunction
endif

" This function restores the default colorscheme
if !exists("*SetDefaultScheme")
	function SetDefaultScheme()
		execute ':colorscheme ' . g:udefault
		syntax on
	endfunction
endif

" Automatically call SetDefaultScheme() for all file types
autocmd BufEnter,WinEnter * call SetDefaultScheme()

" Automatically call SetNotesScheme() when entering a notes file
autocmd BufEnter,WinEnter *.notes call SetNotesScheme()
" Automatically call SetDefaultScheme() when leaving a notes file
autocmd BufLeave,WinLeave *.notes call SetDefaultScheme()
```

If you want to add syntax highlighting to Notepad++ (Windows/Linux)\
From the terminal do:
```bash
# Windows
cp notepad++/notes.xml $WHOME/notes.xml
# Linux
cp notepad++/notes.xml ~/notes.xml
```
2. Open Notepad++ (Notepad++ can be installed/run via Wine in Linux)
3. Under the Language menu, select Define Your Language...
4. Click Import...
5. Select the notes.xml file from your user/home directory
6. Restart Notepad++
7. Now you should see the Notes language at the bottom of the Language list

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
- Inline equations
- equation blocks
- Fractions
- a choose b notation
- Rudimentary table formatting
- Syntax highlighting for programming languages

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

#### Math Formatting

Inline math formatting: everything between the parantheses is treated as math
- equ()
- EX: equ(g(x) = x^2 + (x-2) + 5)\
Fraction formatting: between the parentheses is *numerator*/*denominator* which can also be fractions
- frc(*numerator*/*denominator*)
- EX: frc(12/frc(7/4))\
Combinations formatting: between the parentheses is *n*,*r*
- cmb(*n*,*r*)
- EX: cmb(4,2)

These can all be used together:
- EX: equ(frc(cmb(4,2) + cmb(3,1)/cmb(7,3)))

An example can be viewed [here](template.notes)\
And the generated PDF can be viewed [here](template.pdf)

If you have any questions or issues, you can email me at sleepless.genesis6@gmail.com

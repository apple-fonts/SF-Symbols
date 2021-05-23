# .dmg files directory
This directory stores the URL files (`.url`) and split .dmg files (`.dmg{00,01,...}`). They are used to generate the .dmg files.

Currently available .dmg files:
* `SF-Symbols-2.1.dmg`
* `SF-Symbols.dmg`

## Available commands
To generate all .dmg files:
```shell
make -B -j
```
* `-B` means to always remake a target. This could be used to retrieve updated .dmg files from the Apple server.
* `-j` means to run the jobs in parallel.

To make a single .dmg:
* `make -B SF-Symbols.dmg`
* `make -B SF-Symbols-2.1.dmg`

To clean up:
```shell
make clean
```
This removes the two .dmg files listed above.

## Procedure to generate the .dmg files
This part describes what happens when you type
```shell
make -B -j
```
as provided in the previous section.

1. The `make` program looks for the split .dmg files (`*.dmg{00,01,...}`). If the split .dmg files are found, then it invokes `cat` to concatenate the split .dmg files together. Otherwise, head directly to step 2.
2. The program invokes `wget` to check the .dmg files on the Apple server, and see if the server side has updated the corresponding files. If yes, then the new versions will be downloaded. Otherwise, nothing will be downloaded.
3. The program then splits the .dmg file into smaller volumes (`*.dmg{00,01,...}`). If the .dmg file was updated, then the original split files will also be overwritten.
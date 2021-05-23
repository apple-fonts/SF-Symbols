# .dmg and .img files directory
This directory stores the URL files (`.url`) and split .dmg files (`.dmg{00,01,…}`). They are used to generate the .dmg and .img files.

Currently available .dmg files:
* `SF-Symbols-2.1.dmg`
* `SF-Symbols.dmg`

The corresponding .img files are:
* `SF-Symbols-2.1.img`
* `SF-Symbols.img`

## Prerequisites
To generate the .img files, you must have the following programs installed:
* [`dmg2img`](http://vu1tur.eu.org/tools/)


## Making .dmg and .img files

### Generating .dmg and .img files
To generate all .dmg and .img files:
```shell
make -B -j
```
* `-B` means to always remake a target. This could be used to retrieve updated .dmg files from the Apple server.
* `-j` means to run the jobs in parallel.

This command does the following jobs:
1. The `make` program looks for the split .dmg files (`*.dmg{00,01,…}`). If the split .dmg files are found, then it invokes `cat` to concatenate the split .dmg files together. Otherwise, head directly to step 2.
2. The program invokes `wget` to check the .dmg files on the Apple server, and see if the server side has updated the corresponding files. If yes, then the new versions will be downloaded. Otherwise, nothing will be downloaded.
3. The program then splits the .dmg file into smaller volumes (`*.dmg{00,01,…}`). If the .dmg file was updated, then the original split files will also be overwritten.
4. The program then converts the .dmg files to .img files by invoking the `dmg2img` program.

#### Making single .dmg files
* `make -B SF-Symbols.dmg`
* `make -B SF-Symbols-2.1.dmg`

#### Making corresponding .img files
* `make SF-Symbols.dmg`
* `make SF-Symbols-2.1.dmg`

### Clean up
```shell
make clean
```
This removes the two .dmg files listed above.

### Removing the split .dmg files
```shell
make rmsplit
```
This removes all of the `*.dmg{00,01,…}` files.
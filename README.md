# SF-Symbols
This repository extract the fonts contained in Apple SF Symbols (https://developer.apple.com/sf-symbols/).

## Extract
```shell
make -j
```
* `-j` means to run the jobs in parallel.
* Extracted font files are saved into the `fonts/` directory.

## Clean up
```shell
make clean
```
* This command cleans up the `fonts/` directory.
SFS := SF-Symbols
SFS21 := SF-Symbols-2.1

all = $(dmg_files) $(img_files)
dmg_files := $(SFS).dmg $(SFS21).dmg
img_files := $(dmg_files:.dmg=.img)

make_dmg_exec := make_dmg.sh

.PHONY: all
all: $(all)

%.img: %.dmg
	dmg2img "$<" "$@"

%.dmg:
	bash "$(make_dmg_exec)" "$@"

.PHONY: clean
clean:
	-rm -rfv $(all)

.PHONY: rmsplit
rmsplit:
	-rm -rfv $(foreach dmg_file,$(dmg_files),$(dmg_file)??)
SFS := SF-Symbols
SFS21 := SF-Symbols-2.1

all = $(dmg) $(img)
dmg = $(SFS).dmg $(SFS21).dmg
img = $(dmg:.dmg=.img)

.PHONY: all
all: $(all)

%.img: %.dmg
	dmg2img "$<" "$@"

%.dmg:
	bash make-dmg.sh $@

.PHONY: clean
clean:
	-rm -rfv $(all)

.PHONY: rmsplit
rmsplit:
	-rm -rfv $(foreach dmg_file,$(dmg),$(dmg_file)??)
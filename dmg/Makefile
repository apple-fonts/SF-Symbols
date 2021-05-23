SFS := SF-Symbols
SFS21 := SF-Symbols-2.1

all = $(SFS).dmg $(SFS21).dmg

.PHONY: all
all: $(all)

%.dmg:
	bash make-dmg.sh $@

.PHONY: clean
clean:
	-rm -rfv $(all)
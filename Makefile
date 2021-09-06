dmg_img_dir := dmg_img

url_files := $(shell ls $(dmg_img_dir)/*.url)
img_files := $(url_files:.url=.img)

fonts_dir := fonts
fonts_dirs := $(patsubst $(dmg_img_dir)/%.url,$(fonts_dir)/%,$(url_files))

extract_exec := $(dmg_img_dir)/img_extract.sh

.PHONY: all
all: $(fonts_dirs)

$(fonts_dir)/%: $(dmg_img_dir)/%.img
	$(MAKE) "$(notdir $<)" -C "$(dir $<)"
	bash "$(extract_exec)" "$<" "$@"

.PHONY: clean
clean:
	-rm -rfv $(fonts_dir)/
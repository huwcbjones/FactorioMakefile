##
## Factorio Mod Makefile
##
## Instructions:
## 1 - Create your mod in /src
## 2 - Place this Makefile in /
## 3 - Call make. Mod zip will be placed into /dist
##
## Extras:
## make install :-
## 		*should* install the mod into the mods directory for your platform.
##		Only tested on OS X
##

SHELL = /bin/sh

ifeq ($(OS),Windows_NT)
	install_dir := "%appdata%\Roaming\Factorio\mods\"
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		install_dir := ~/Library/Application\ Support/factorio/mods/
	else
		install_dir := ~/.factorio/mods/
	endif
endif

# Get the mod name from info.json
MOD := $(shell grep "name" src/info.json | sed -n 's/.*"name":.*"\(.*\)",.*/\1/p')
VERSION := $(shell grep "version" src/info.json | ggrep -Po '([0-9]+\.){2}[0-9]+')
DIRECTORY := $(MOD)_$(VERSION)
MOD_ZIP := $(DIRECTORY).zip

package: dist/$(MOD_ZIP)

dist/$(MOD_ZIP): $(shell tree -if --noreport src)
	mkdir -p dist
	if [ -d ".git" ]; then grep -q -F '**/dist/*' .gitignore || echo '**/dist/*' >> .gitignore; fi
	cp -R src $(DIRECTORY)
	cp LICENSE *.md $(DIRECTORY) 2>/dev/null
	zip -r $(MOD_ZIP) $(DIRECTORY)
	mv $(MOD_ZIP) dist/
	rm -r $(DIRECTORY)

clean:
		rm -rf $(DIRECTORY)
		rm -f $(MOD_ZIP)
		rm -f dist/$(MOD_ZIP)

remove:
	rm -f $(install_dir)$(MOD)*.zip

install: remove
	cp dist/$(MOD_ZIP) $(install_dir)

.PHONY: clean install remove package

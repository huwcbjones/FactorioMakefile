# Factorio Makefile #
## A Makefile for [Factorio](http://www.factorio.com) mods ##

## Usage ##

1. Create your mod inside `/src`.
2. Drop the Makefile into `/`.
3. Call `make`.

Your mod should now be packaged in `/dist`

### Extras ###

- `make package`: Default make call
- `make clean`: Cleans output and temporary files
- `make install`: Attempts to install the mod into your Factorio mods directory.
- `make remove`: Removes all traces of your mod in your Factorio mods directory. (Useful if you have changed versions and want to test a different version).

## Notes ##
This Makefile uses `info.json` to get your mod name/version, so now extra files are needed!

It also copies in `LICENSE` (if exists) and any markdown (`*.md`) files too.

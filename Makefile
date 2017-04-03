# MC_data
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: selection.out 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md notes.txt
Sources += standard.local
include stuff.mk
# include $(ms)/perl.def

##################################################################

## Content

Sources += $(wildcard *.R)

## Convert is the Dropbox where we keep basic, converted data sets
## DHS_convert are the JD rules for converting them
convert/%: convert DHS_convert
	cd DHS_convert && $(MAKE) convert/$*

convert: DHS_convert_drop
	$(forcelink)

Sources += select.csv
df/%.Rout: select.csv wselect.R 
	$(MAKE) df
	$(run-R)

df: mc_data_files_drop
	$(forcelink)

######################################################################

## Sets and short names
## These rules are made by browsing ~/git/DHS_overview/standard.files.mk
df/ke4.Rout: convert/Kenya_IV.DHS.IV.men.Rout
df/ke7.Rout: convert/Kenya_VII.DHS.VI.men.Rout
df/ls4.Rout: convert/Lesotho_IV.DHS.IV.men.Rout
df/ls7.Rout: convert/Lesotho_VII.DHS.VI.men.Rout
df/mw4.Rout: convert/Malawi_IVa.DHS.IV.men.Rout
df/mw6.Rout: convert/Malawi_VI.DHS.V.men.Rout
df/mw7.Rout: convert/Malawi_VII.DHS.VII.men.Rout
df/mz4.Rout: convert/Mozambique_IV.DHS.IV.men.Rout
df/mz6.Rout: convert/Mozambique_VI.DHS.VI.men.Rout
df/nm5.Rout: convert/Namibia_V.DHS.V.men.Rout
df/nm6.Rout: convert/Namibia_VI.DHS.VI.men.Rout
df/rw5.Rout: convert/Rwanda_V.DHS.IV.men.Rout
df/rw6.Rout: convert/Rwanda_VI.DHS.VI.men.Rout
df/rw7.Rout: convert/Rwanda_VII.DHS.VI.men.Rout
df/tz4.Rout: convert/Tanzania_IVa.DHS.IV.men.Rout
df/tz6.Rout: convert/Tanzania_VI.DHS.V.men.Rout
df/tz7.Rout: convert/Tanzania_VII.DHS.VII.men.Rout
df/zm5.Rout: convert/Zambia_V.DHS.V.men.Rout
df/zm6.Rout: convert/Zambia_VI.DHS.VI.men.Rout
df/zw5.Rout: convert/Zimbabwe_V.DHS.V.men.Rout
df/zw6.Rout: convert/Zimbabwe_VI.DHS.VI.men.Rout
df/zw7.Rout: convert/Zimbabwe_VII.DHS.VII.men.Rout
df/ug5.Rout: convert/Uganda_V.DHS.V.men.Rout
df/ug6.Rout: convert/Uganda_VI.DHS.VI.men.Rout

# Older Malawi; not used
# convert/Malawi_IVb.DHS.IV.men.Rout: convert/mwmr41fl.sav

sets = ke4 ke7 ls4 ls7 mw4 mw6 mz4 mz6 nm5 nm6 rw5 rw6 rw7 tz4 tz6 ug5 ug6 zm5 zm6 zw5 zw6 zw7 mw7

### Download and convert all of the MC sets
download: $(sets:%=df/%.Rout)

selection.out: $(sets:%=df/%.Rout)
	$(cat)

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/linkdirs.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk

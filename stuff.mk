Drop = ./Dropbox
-include local.mk
export ms = ./makestuff
-include $(ms)/os.mk

makestuff:
	git submodule add git@github.com:dushoff/$@.git $@

%.local.link: %.local
	$(LN) $< local.mk

# Neatroff top-level Makefile

# Neatroff base directory
BASE = $(PWD)

BIN = /home/e55/bin/troff
MAN = /usr/local/man/man1
# There is no need to install it, but if you wish it, this is the location.
#BASE = /usr/local/

INSTALL = install
MKDIR = mkdir -p -m 755
PWD = $${PWD}

NEATREPOS = neatroff neatpost neatmkfn neateqn neatrefer
NEATREPOS_GIT = $(REPOS:%=%.git)
REPOS = $(NEATREPOS) troff

all: help

help:
	@echo "Neatroff top-level makefile"
	@echo
	@echo "   init        Initialise git repositories and fonts"
	@echo "   init_fa     Initialise for Farsi"
	@echo "   neat        Compile the programs and generate the fonts"
	@echo "   pull        Update git repositories (git pull)"
	@echo "   clean       Remove the generated files"
	@echo "   install     Install Neatroff in $(DESTDIR)$(BASE)"
	@echo

$(REPOS):
	@got checkout $@.git $@

$(NEATREPOS_GIT):
	@got clone https://github.com/aligrudi/$<

troff.git:
	@got clone https://github.com/troff9p.git troff

init: | $(NEATREPOS_GIT) troff.git
	@echo "Cloned Git repositories"
	@echo "Downloading fonts"
	@cd fonts && sh ./fonts.sh

init_fa: init
	@cd fonts && sh ./fonts_fa.sh

pull: | $(REPOS)
	for i in $(REPOS); do echo $$i; cd $$i; got fetch; got merge refs/remotes/origin/master; cd ..; done
	got fetch
	got merge refs/remotes/origin/master

comp: | $(REPOS)
	@echo "Compiling programs"
	@base="$(BASE)" && cd neatroff && $(MAKE) FDIR="$$base" MDIR="$$base/tmac"
	@base="$(BASE)" && cd neatpost && $(MAKE) FDIR="$$base" MDIR="$$base/tmac"
	@cd neateqn && $(MAKE)
	@cd neatmkfn && $(MAKE)
	@cd neatrefer && $(MAKE)
	@cd troff/pic && $(MAKE)
	@cd troff/tbl && $(MAKE)
	@cd soin && $(MAKE)
	@cd shape && $(MAKE)

neat: comp
	@echo "Generating font descriptions"
	@pwd="$(PWD)" && cd neatmkfn && ./gen.sh "$$pwd/fonts" "$$pwd/devutf" >/dev/null

install:
	@echo "Copying binaries to $(DESTDIR)$(BASE)"
	@$(MKDIR) "$(DESTDIR)$(BASE)/neatroff"
	@$(MKDIR) "$(DESTDIR)$(BASE)/neatpost"
	@$(MKDIR) "$(DESTDIR)$(BASE)/neateqn"
	@$(MKDIR) "$(DESTDIR)$(BASE)/neatmkfn"
	@$(MKDIR) "$(DESTDIR)$(BASE)/neatrefer"
	@$(MKDIR) "$(DESTDIR)$(BASE)/troff/pic"
	@$(MKDIR) "$(DESTDIR)$(BASE)/troff/tbl"
	@$(MKDIR) "$(DESTDIR)$(BASE)/soin"
	@$(MKDIR) "$(DESTDIR)$(BASE)/shape"
	@$(MKDIR) "$(DESTDIR)$(BASE)/share/man/man1"
	@$(INSTALL) neatroff/roff "$(DESTDIR)$(BASE)/neatroff/"
	@$(INSTALL) neatpost/post "$(DESTDIR)$(BASE)/neatpost/"
	@$(INSTALL) neatpost/pdf "$(DESTDIR)$(BASE)/neatpost/"
	@$(INSTALL) neateqn/eqn "$(DESTDIR)$(BASE)/neateqn/"
	@$(INSTALL) neatmkfn/mkfn "$(DESTDIR)$(BASE)/neatmkfn/"
	@$(INSTALL) neatrefer/refer "$(DESTDIR)$(BASE)/neatrefer/"
	@$(INSTALL) soin/soin "$(DESTDIR)$(BASE)/soin/"
	@$(INSTALL) shape/shape "$(DESTDIR)$(BASE)/shape/"
	@$(INSTALL) troff/pic/pic "$(DESTDIR)$(BASE)/troff/pic/"
	@$(INSTALL) troff/tbl/tbl "$(DESTDIR)$(BASE)/troff/tbl/"
	@$(INSTALL) man/neateqn.1 "$(DESTDIR)$(BASE)/share/man/man1"
	@$(INSTALL) man/neatmkfn.1 "$(DESTDIR)$(BASE)/share/man/man1"
	@$(INSTALL) man/neatpost.1 "$(DESTDIR)$(BASE)/share/man/man1"
	@$(INSTALL) man/neatrefer.1 "$(DESTDIR)$(BASE)/share/man/man1"
	@$(INSTALL) man/neatroff.1 "$(DESTDIR)$(BASE)/share/man/man1"
	@echo "Copying font descriptions to $(DESTDIR)$(BASE)/tmac"
	@$(MKDIR) "$(DESTDIR)$(BASE)/tmac"
	@cp -r tmac/* "$(DESTDIR)$(BASE)/tmac/"
	@find "$(DESTDIR)$(BASE)/tmac" -type d -exec chmod 755 {} \;
	@find "$(DESTDIR)$(BASE)/tmac" -type f -exec chmod 644 {} \;
	@echo "Copying devutf device to $(DESTDIR)$(BASE)/devutf"
	@$(MKDIR) "$(DESTDIR)$(BASE)/devutf"
	@cp devutf/* "$(DESTDIR)$(BASE)/devutf/"
	@chmod 644 "$(DESTDIR)$(BASE)/devutf"/*
	@echo "Copying fonts to $(DESTDIR)$(BASE)/fonts"
	@$(MKDIR) "$(DESTDIR)$(BASE)/fonts"
	@cp fonts/* "$(DESTDIR)$(BASE)/fonts/"
	@chmod 644 "$(DESTDIR)$(BASE)/fonts"/*
	@echo "Updating fontpath in font descriptions"
	@for f in "$(DESTDIR)$(BASE)/devutf"/*; do sed "/^fontpath /s=$(PWD)/fonts=$(BASE)/fonts=" <$$f >.fd.tmp; mv .fd.tmp $$f; done

repoclean:
	rm -rf $(REPOS)

dist: comp
	$(INSTALL) neatroff/roff neatpost/post neatpost/pdf neateqn/eqn neatmkfn/mkfn neatrefer/refer soin/soin shape/shape troff/pic/pic troff/tbl/tbl "$(BIN)"
	$(INSTALL) man/neateqn.1 man/neatmkfn.1 man/neatpost.1 man/neatrefer.1 man/neatroff.1 "$(MAN)"

undist:
	@for i in roff post pdf eqn mkfn refer soin shape pic tbl; do rm -rf "$(BIN)/$$i"; done
	@for i in neateqn neatmkfn neatpost neatrefer neatroff; do rm -rf "$(MAN)/$$i.1"; done

clean:
	@cd neatroff && $(MAKE) clean
	@cd neatpost && $(MAKE) clean
	@cd neateqn && $(MAKE) clean
	@cd neatmkfn && $(MAKE) clean
	@cd neatrefer && $(MAKE) clean
	@cd troff/tbl && $(MAKE) clean
	@cd troff/pic && $(MAKE) clean
	@cd soin && $(MAKE) clean
	@test ! -d shape || (cd shape && $(MAKE) clean)
	@rm -fr $(PWD)/devutf

.PHONY: all help init init_fa comp neat install clean dist repoclean

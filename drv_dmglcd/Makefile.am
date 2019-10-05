SRC = \
top.v \
img.v

NODIST_SRC =

HDR =

NODIST_HDR =

EXTRA_DIST = $(SRC) $(HDR) drv_dmglcd.pcf

CLEANFILES = \
$(NODIST_SRC) \
drv_dmglcd.asc \
drv_dmglcd.bin \
drv_dmglcd.json \
viewer.html

DISTCLEANFILES = \
$(NODIST_HDR)

all: drv_dmglcd.bin

prog: drv_dmglcd.bin
	$(ICEPROG) $<

run: drv_dmglcd.bin
	$(ICEPROG) -S $<

view: drv_dmglcd.asc
	$(top_srcdir)/ice40_viewer/iceview_html.py -s firefox $< viewer.html

.PHONY: all prog run json view

drv_dmglcd.json: Makefile $(addprefix $(srcdir)/,$(SRC) $(HDR)) $(NODIST_SRC) $(NODIST_HDR)
	$(YOSYS) $(YOSYSFLAGS) -q -p "synth_ice40 -abc2 -json $@" $(addprefix $(srcdir)/,$(SRC)) $(NODIST_SRC)

drv_dmglcd.asc: drv_dmglcd.json drv_dmglcd.pcf Makefile
	$(NEXTPNR) $(NEXTPNRFLAGS) --hx8k --package ct256 --pcf drv_dmglcd.pcf --json $< --asc $@

drv_dmglcd.bin: drv_dmglcd.asc Makefile
	$(ICEPACK) $(ICEPACKFLAGS) $< $@

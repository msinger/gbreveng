SRC = \
dump.sv

NODIST_SRC =

HDR =

NODIST_HDR =

EXTRA_DIST = $(SRC) $(HDR) dump.pcf

CLEANFILES = \
$(NODIST_SRC) \
dump.asc \
dump.bin \
dump.json \
viewer.html

DISTCLEANFILES = \
$(NODIST_HDR)

all: dump.bin

prog: dump.bin
	$(ICEPROG) $<

run: dump.bin
	$(ICEPROG) -S $<

view: dump.asc
	$(top_srcdir)/ice40_viewer/iceview_html.py -s firefox $< viewer.html

.PHONY: all prog run json view

dump.json: Makefile $(addprefix $(srcdir)/,$(SRC) $(HDR)) $(NODIST_SRC) $(NODIST_HDR)
	$(YOSYS) $(YOSYSFLAGS) -q -p "synth_ice40 -abc2 -json $@" $(addprefix $(srcdir)/,$(SRC)) $(NODIST_SRC)

dump.asc: dump.json $(srcdir)/dump.pcf Makefile
	$(NEXTPNR) $(NEXTPNRFLAGS) --hx8k --package ct256 --pcf $(srcdir)/dump.pcf --json $< --asc $@

dump.bin: dump.asc Makefile
	$(ICEPACK) $(ICEPACKFLAGS) $< $@

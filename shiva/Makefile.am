SRC = \
top.v \
cdc.v \
lr35902_cpu.v \
lr35902_dbg_ifc.v \
ft245_ifc.v \
counter.v \
counter_block.v \
dp_reg.v

NODIST_SRC = \
pll.v

HDR =

NODIST_HDR =

EXTRA_DIST = $(SRC) $(HDR) shiva.pcf shiva-constraints.py

CLEANFILES = \
$(NODIST_SRC) \
shiva.asc \
shiva.bin \
shiva.json \
viewer.html

DISTCLEANFILES = \
$(NODIST_HDR)

all: shiva.bin

prog: shiva.bin
	$(ICEPROG) $<

run: shiva.bin
	$(ICEPROG) -S $<

view: shiva.asc
	$(top_srcdir)/ice40_viewer/iceview_html.py -s firefox $< viewer.html

.PHONY: all prog run view

shiva.json: Makefile $(addprefix $(srcdir)/,$(SRC) $(HDR)) $(NODIST_SRC) $(NODIST_HDR)
	$(YOSYS) $(YOSYSFLAGS) -q -p "synth_ice40 -abc2 -json $@" $(addprefix $(srcdir)/,$(SRC)) $(NODIST_SRC)

shiva.asc: shiva.json shiva.pcf shiva-constraints.py Makefile
	$(NEXTPNR) $(NEXTPNRFLAGS) --hx8k --package ct256 --pcf shiva.pcf --pre-pack shiva-constraints.py --json $< --asc $@

shiva.bin: shiva.asc Makefile
	$(ICEPACK) $(ICEPACKFLAGS) $< $@

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

%.gb: %.o
	$(LD) $(LDFLAGS) -o $@ $^
	$(FIX) -fhg $(FIXFLAGS) $@

%.coff: %.o
	$(LD) $(LDFLAGS) --oformat coff-lr35902 -o $@ $^

pll.v: Makefile
	$(ICEPLL) -q -i 12 -o 60 -mf $@

SRC = \
test_hw.sv

NODIST_SRC =

HDR =

NODIST_HDR =

EXTRA_DIST = $(SRC) $(HDR) test_hw.pcf test_hw-constraints.py

CLEANFILES = \
$(NODIST_SRC) \
test_hw.asc \
test_hw.bin \
test_hw.json \
viewer.html

DISTCLEANFILES = \
$(NODIST_HDR)

all: test_hw.bin

prog: test_hw.bin
	$(ICEPROG) $<

run: test_hw.bin
	$(ICEPROG) -S $<

view: test_hw.asc
	$(top_srcdir)/ice40_viewer/iceview_html.py -s firefox $< viewer.html

.PHONY: all prog run view

test_hw.json: Makefile $(addprefix $(srcdir)/,$(SRC) $(HDR)) $(NODIST_SRC) $(NODIST_HDR)
	$(YOSYS) $(YOSYSFLAGS) -q -p "synth_ice40 -abc2 -json $@" $(addprefix $(srcdir)/,$(SRC)) $(NODIST_SRC)

test_hw.asc: test_hw.json $(srcdir)/test_hw.pcf $(srcdir)/test_hw-constraints.py Makefile
	$(NEXTPNR) $(NEXTPNRFLAGS) --hx8k --package ct256 --pcf $(srcdir)/test_hw.pcf --pre-pack $(srcdir)/test_hw-constraints.py --json $< --asc $@

test_hw.bin: test_hw.asc Makefile
	$(ICEPACK) $(ICEPACKFLAGS) $< $@

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

%.gb: %.o
	$(LD) $(LDFLAGS) -o $@ $^
	$(FIX) -fhg $(FIXFLAGS) $@

%.coff: %.o
	$(LD) $(LDFLAGS) --oformat coff-lr35902 -o $@ $^

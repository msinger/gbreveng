SRC = \
top.sv

NODIST_SRC = \
pll.v

HDR =

NODIST_HDR =

EXTRA_DIST = $(SRC) $(HDR) mrd_test.pcf rom.s

CLEANFILES = \
$(NODIST_SRC) \
rom.o \
rom.coff \
rom.gb \
rom.bin \
rom.hex \
mrd_test.asc \
mrd_test.bin \
mrd_test.json \
viewer.html

DISTCLEANFILES = \
$(NODIST_HDR)

all: mrd_test.bin

prog: mrd_test.bin
	$(ICEPROG) $<

run: mrd_test.bin
	$(ICEPROG) -S $<

view: mrd_test.asc
	$(top_srcdir)/ice40_viewer/iceview_html.py -s firefox $< viewer.html

.PHONY: all prog run json view

mrd_test.json: Makefile $(addprefix $(srcdir)/,$(SRC) $(HDR)) $(NODIST_SRC) $(NODIST_HDR) rom.hex
	$(YOSYS) $(YOSYSFLAGS) -q -p "synth_ice40 -abc2 -json $@" $(addprefix $(srcdir)/,$(SRC)) $(NODIST_SRC)

mrd_test.asc: mrd_test.json $(srcdir)/mrd_test.pcf Makefile
	$(NEXTPNR) $(NEXTPNRFLAGS) --hx8k --package ct256 --pcf $(srcdir)/mrd_test.pcf --json $< --asc $@

mrd_test.bin: mrd_test.asc Makefile
	$(ICEPACK) $(ICEPACKFLAGS) $< $@

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

%.gb: %.o
	$(LD) $(LDFLAGS) -o $@ $^
	$(FIX) -fhg $(FIXFLAGS) $@

%.coff: %.o
	$(LD) $(LDFLAGS) --oformat coff-sm83 -o $@ $^

rom.bin: rom.gb Makefile
	dd if=$< of=$@ bs=128 count=1 skip=2

rom.hex: rom.bin Makefile
	@test "$$(wc -c <$<)" -eq 128 || (echo ERROR: size of ROM must be 128 bytes; exit 1)
	od -An -v -tx1 -w16 $< >$@

pll.v: Makefile
	$(ICEPLL) -q -i 12 -o 60 -mf $@

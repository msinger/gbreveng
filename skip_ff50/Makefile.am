SRC = \
top.v

NODIST_SRC = \
pll.v

HDR =

NODIST_HDR =

EXTRA_DIST = $(SRC) $(HDR) skip_ff50.pcf rom.s

CLEANFILES = \
$(NODIST_SRC) \
rom.o \
rom.coff \
rom.gb \
rom.bin \
rom.hex \
skip_ff50.asc \
skip_ff50.bin \
skip_ff50.json \
viewer.html

DISTCLEANFILES = \
$(NODIST_HDR)

all: skip_ff50.bin

prog: skip_ff50.bin
	$(ICEPROG) $<

run: skip_ff50.bin
	$(ICEPROG) -S $<

view: skip_ff50.asc
	$(top_srcdir)/ice40_viewer/iceview_html.py -s firefox $< viewer.html

.PHONY: all prog run json view

skip_ff50.json: Makefile $(addprefix $(srcdir)/,$(SRC) $(HDR)) $(NODIST_SRC) $(NODIST_HDR) rom.hex
	$(YOSYS) $(YOSYSFLAGS) -q -p "synth_ice40 -abc2 -json $@" $(addprefix $(srcdir)/,$(SRC)) $(NODIST_SRC)

skip_ff50.asc: skip_ff50.json $(srcdir)/skip_ff50.pcf Makefile
	$(NEXTPNR) $(NEXTPNRFLAGS) --hx8k --package ct256 --pcf $(srcdir)/skip_ff50.pcf --json $< --asc $@

skip_ff50.bin: skip_ff50.asc Makefile
	$(ICEPACK) $(ICEPACKFLAGS) $< $@

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

%.gb: %.o
	$(LD) $(LDFLAGS) -o $@ $^
	$(FIX) -fhg $(FIXFLAGS) $@

%.coff: %.o
	$(LD) $(LDFLAGS) --oformat coff-sm83 -o $@ $^

rom.bin: rom.gb Makefile
	dd if=$< of=$@ bs=256 count=1 skip=1 seek=1
	dd if=$< of=$@ bs=256 count=1 skip=2 seek=0 conv=nocreat,notrunc

rom.hex: rom.bin Makefile
	@test "$$(wc -c <$<)" -eq 512 || (echo ERROR: size of ROM must be 512 bytes; exit 1)
	od -An -v -tx1 -w16 $< >$@

pll.v: Makefile
	$(ICEPLL) -q -i 12 -o 66 -mf $@

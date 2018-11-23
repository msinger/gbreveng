SRC = \
top.v

NODIST_SRC = \
pll.v

HDR =

NODIST_HDR =

EXTRA_DIST = $(SRC) $(HDR) genclk.pcf rom.s

CLEANFILES = \
$(NODIST_SRC) \
rom.o \
rom.coff \
rom.gb \
rom.bin \
rom.hex \
genclk.asc \
genclk.bin \
genclk.blif \
genclk.post.blif \
genclk.post.blif.json \
viewer.html

DISTCLEANFILES = \
$(NODIST_HDR)

all: genclk.bin

prog: genclk.bin
	$(ICEPROG) $<

run: genclk.bin
	$(ICEPROG) -S $<

json: genclk.post.json

view: genclk.asc
	$(top_srcdir)/ice40_viewer/iceview_html.py -s firefox $< viewer.html

.PHONY: all prog run json view

genclk.blif: Makefile $(addprefix $(srcdir)/,$(SRC) $(HDR)) $(NODIST_SRC) $(NODIST_HDR) rom.hex
	$(YOSYS) $(YOSYSFLAGS) -q -p "synth_ice40 -abc2 -blif $@" $(addprefix $(srcdir)/,$(SRC)) $(NODIST_SRC)

genclk.asc genclk.post.blif: genclk.blif genclk.pcf Makefile
	$(ARACHNE) $(ARACHNEFLAGS) -m 800 -d 8k -p genclk.pcf $< -o genclk.asc --post-place-blif genclk.post.blif

genclk.bin: genclk.asc Makefile
	$(ICEPACK) $(ICEPACKFLAGS) $< $@

genclk.post.json: genclk.post.blif Makefile
	$(YOSYS) $(YOSYSFLAGS) -o $@ $<

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

%.gb: %.o
	$(LD) $(LDFLAGS) -o $@ $^
	$(FIX) -fhg $(FIXFLAGS) $@

%.coff: %.o
	$(LD) $(LDFLAGS) --oformat coff-lr35902 -o $@ $^

rom.bin: rom.gb Makefile
	dd if=$< of=$@ bs=128 count=1 skip=2

rom.hex: rom.bin Makefile
	@test "$$(wc -c <$<)" -eq 128 || (echo ERROR: size of ROM must be 128 bytes; exit 1)
	od -An -v -tx1 -w16 $< >$@

pll.v: Makefile
	$(ICEPLL) -q -i 12 -o 48 -mf $@

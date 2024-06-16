ROMS = \
	hram-rw.s \
	wram-rw.s \
	xram-rw.s \
	vram-rw.s \
	oam-rw.s \
	rom-rw.s \
	w-rom-ie.s \
	w-rom-vram.s \
	w-hram.s \
	w-vram.s \
	w-wram.s \
	dma-wram.s \
	dma-vram.s \
	move-logo.s \
	disp-test.s \
	stop.s \
	halt.s \
	sck-in.s \
	eidi.s \
	rout.s

EXTRA_DIST = common.s $(ROMS)

CLEANFILES = \
common.o \
common.coff \
common.gb \
$(ROMS:%.s=%.o) \
$(ROMS:%.s=%.coff) \
$(ROMS:%.s=%.gb)

all: $(ROMS:%.s=%.gb)

.PHONY: all

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

%.gb: common.o %.o
	$(LD) $(LDFLAGS) -o $@ $^
	$(FIX) -fhg $(FIXFLAGS) $@

%.coff: common.o %.o
	$(LD) $(LDFLAGS) --oformat coff-sm83 -o $@ $^

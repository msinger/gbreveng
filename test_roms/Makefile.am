ROMS = \
	hram-rw \
	wram-rw \
	xram-rw \
	vram-rw \
	oam-rw \
	rom-rw \
	w-rom-ie \
	w-rom-vram \
	w-hram \
	w-vram \
	w-wram \
	dma-wram \
	dma-vram \
	move-logo \
	disp-test

CLEANFILES = \
common.o \
common.coff \
common.gb \
$(ROMS:%=%.o) \
$(ROMS:%=%.coff) \
$(ROMS:%=%.gb)

all: $(ROMS:%=%.gb)

.PHONY: all

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

%.gb: common.o %.o
	$(LD) $(LDFLAGS) -o $@ $^
	$(FIX) -fhg $(FIXFLAGS) $@

%.coff: common.o %.o
	$(LD) $(LDFLAGS) --oformat coff-lr35902 -o $@ $^

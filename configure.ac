AC_PREREQ([2.63])
AC_INIT([gbreveng], [0.1])
AC_CONFIG_SRCDIR([mrd_test/top.sv])
AC_CONFIG_MACRO_DIR([m4])

AM_INIT_AUTOMAKE([foreign dist-bzip2 filename-length-max=99 no-dependencies tar-ustar])
AM_MAINTAINER_MODE

MY_CHECK_WS

MY_PROG_YOSYS
MY_PROG_NEXTPNR
MY_PROG_ICEPACK
MY_PROG_ICEPLL
MY_PROG_ICEPROG

MY_PROG_SM83_AS
MY_PROG_SM83_LD
MY_PROG_FIX

AC_CONFIG_FILES([
test_roms/Makefile
mrd_test/Makefile
genclk/Makefile
skip_ff50/Makefile
drv_dmglcd/Makefile
shiva/Makefile
test_hw/Makefile
wb64agb_prom_dump/Makefile
wb64agb_flash_dump/Makefile
Makefile
])

AC_OUTPUT

echo
echo
echo "=== CONFIGURATION SUMMARY ==="
echo
echo "--- Tools ---"
echo "Yosys:                              $YOSYS"
echo "nextpnr:                            $NEXTPNR"
echo "IcePack:                            $ICEPACK"
echo "IcePLL:                             $ICEPLL"
echo "IceProg:                            $ICEPROG"
echo "Assembler:                          $AS"
echo "Linker:                             $LD"
echo "rgbfix:                             $FIX"

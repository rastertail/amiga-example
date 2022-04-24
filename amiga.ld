SECTIONS {
    TEXT : {
        *(.text.startup .text.startup.*)
        *(.text .text.*)
    }

    DATA : {
        *(.data .data.*)
        *(.rodata .rodata.*)
    }

    CHIP : {
        *(.chip .chip.*)
    }

    BSS : {
        *(.bss .bss.*)
        *(COMMON)
    }

    /DISCARD/ : {
        *(*)
    }
}

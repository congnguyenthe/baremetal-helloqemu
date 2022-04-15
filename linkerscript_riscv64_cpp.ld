OUTPUT_ARCH(riscv)

ENTRY(_start)

MEMORY {
    DRAM (wxa) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS {
    .text :{
        PROVIDE(_text_start = .);
        *(.text.init) *(.text .text.*)
        PROVIDE(_text_end = .);
    } > DRAM :text

    PROVIDE(_global_pointer = .);

    .rodata :{
        PROVIDE(_rodata_start = .);
        *(.rodata .rodata.*)
        PROVIDE(_rodata_end = .);
    } > DRAM :text

    .data :{
        . = ALIGN(4096);
        PROVIDE(_data_start = .);
        *(.sdata .sdata.*) *(.data .data.*)
        PROVIDE(_data_end = .);
    } > DRAM :data

    .bss :{
        PROVIDE(_bss_start = .);
        *(.sbss .sbss.*) *(.bss .bss.*)
        PROVIDE(_bss_end = .);
    } > DRAM :bss

    PROVIDE(_memory_start = ORIGIN(DRAM));
    PROVIDE(_stack_start = _bss_end);
    PROVIDE(_stack_end = _stack_start + 0x80000);
    PROVIDE(_memory_end = ORIGIN(DRAM) + LENGTH(DRAM));
    PROVIDE(_heap_start = _stack_end);
    PROVIDE(_heap_size = _memory_end - _heap_start);
}
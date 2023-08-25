ENTRY(_start);

SECTIONS
{
    _start = 0x80200000;
    . = 0x80200000;
    .data : {
        *(.data)
    }
}

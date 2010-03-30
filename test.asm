ayctrl: EQU     65533
aydata: EQU     49149

org 10000
start:  ld      d,7             ; select the mixer register
        ld      e,62            ; enable channel A only
        call    outer           ; send it to PSG
        ld      d,1             ; channel A course pitch
        ld      e,50            ; pitch value
        call    outer           ; send it to PSG
        ld      d,8             ; channel A volume
        ld      e,15            ; maximum
        call    outer           ; send it to PSG
        ret

outer:  ld      bc,ayctrl       ; select control port
        out     (c),d           ; send specified value
        ld      bc,aydata       ; select data port
        out     (c),e           ; send specified value
        ret


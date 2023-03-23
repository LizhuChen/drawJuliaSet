
.data

format:    .asciz "ppp%d\n"
color:    .word 0
maxIter:  .word 255
zx:       .word 0
zy:       .word 0
tmp:      .word 0
i:        .word 0
x:        .word 0
y:        .word 0
a:        .word 1500
b:        .word 1000
c:        .word 4000000
cx:       .word -700


.text
.globl drawJuliaSet

drawJuliaSet:
        stmfd   sp!,{r4-r9, lr}

        mov     r4, r0
        ldr     r5, =cx  @ 把cx存在sp-4
        ldr     r5, [r5]
        mov     r6, r1   @ 把cy存在sp-4
        mov     r7, r2   @ 把width存在sp-4
        mov     r8, r3   @ 把height存在sp-4

        ldr     r2, =x
        mov     r1, #0
        str     r1,[r2]

.Loop1: @7
        ldr     r1, =x
		ldr     r1, [r1]
        mov     r3, r7 @ width
        cmp     r1, r3 @ x-width
        bge     finish
        ldr     r2, =y
        mov     r1, #0
        str     r1,[r2]

.Loop2: @6
        ldr     r1, =y
		ldr     r1, [r1]
        mov     r3, r8 @height
        cmp     r1, r3
        bge     .L3

        mov     r3, r7  @width
        asr     r3, r3, #1     @width右移1

        ldr     r2, =x
		ldr     r2, [r2]
        sub     r3, r2, r3

        ldr     r2, =a         @r2=1500
		ldr     r2, [r2]
        mul     r2, r3, r2     @r2=(x-width>>1)*1500
        mov     r3, r7         @r3=width
        asr     r3, r3, #1     @r3=width>>1
        mov     r1, r3
        mov     r0, r2
        bl      __aeabi_idiv   @r0=r0/r1
        mov     r3, r0         @r3=r0
		ldr     r1,=zx
		str     r3, [r1]       @zx=r3

		mov     r3, r8  @height
        asr     r3, r3, #1     @height右移1

        ldr     r2, =y
		ldr     r2, [r2]
        sub     r3, r2, r3     @r3=r2-r3
		ldr     r2, =b         @r2=b=1000
		ldr     r2, [r2]
        mul     r2, r3, r2     @r2=(y-height>>1)*1000
		mov     r3, r8  @r3=height
        asr     r3, r3, #1     @r3=height>>1
        mov     r1, r3
        mov     r0, r2
        bl      __aeabi_idiv   @r0=r0/r1(r2/r3)
        mov     r3, r0         @r3=r0
		ldr     r1,=zy
		str     r3, [r1]       @zy=r3

        ldr     r3,=maxIter
		ldr     r3,[r3]
		ldr     r2,=i
        str     r3, [r2]

.Loop3: @5

        ldr     r3, =zx
		ldr     r3, [r3]
		mov     r2, r3
		mul     r2, r2, r3     @zx*zx

		ldr     r3, =zy
		ldr     r3, [r3]
		mov     r1, r3
		mul     r3, r1, r3     @zy*zy

        cmp     r2, #0
        addpl   r2, r2, r3     @r2 = zx*zx + zy*zy
        ldr     r3, =c
		ldr     r3,[r3]
        cmp     r2, r3
        addge   r3, r3, #0
        bge     .L4

        ldr     r3, =i
		ldr     r3,[r3]
        cmp     r3, #0       @osidjfsoidjfsodi
        addle   r3, #0       @sdfkjsdofjsodifj
        ble     .L4

        ldr     r3, =zx
		ldr     r3, [r3]
		mov     r2, r3
		mul     r2, r2, r3     @r2=zx*zx

		ldr     r3, =zy
		ldr     r3, [r3]
		mov     r1, r3
		mul     r3, r1, r3     @r3=zy*zy

        sub     r3, r2, r3     @r3 = zx*zx - zy*zy

        ldr     r1, =b
		ldr     r1,[r1]        @r1=b=1000

        mov     r0, r3
        bl      __aeabi_idiv   @r0=r0/r1

        mov     r3, r0         @r3=r0
        mov     r2, r3         @r2=r3

        mov     r3, r5         @cX
        add     r3, r2, r3

		ldr     r2, =tmp       @r2=tmp
        str     r3, [r2]       @r3存進tmp

        ldr     r3, =zx
		ldr     r3,[r3]
        lsl     r3, r3, #1     @zx*2

        ldr     r2, =zy
		ldr     r2,[r2]
        mul     r3, r2, r3     @r3=zy*zx*2

        ldr     r1, =b
		ldr     r1, [r1]       @r1=1000
        mov     r0, r3         @r0=r3
        bl      __aeabi_idiv   @r0=r0/r1 (r3/1000)

        mov     r3, r0         @r3=r0
        mov     r2, r3         @r2=r3=r0

        mov     r3, r6         @r3=cY
        add     r3, r2, r3     @r3=cY+r2
		ldr     r2, =zy
        str     r3, [r2]       @zy=r3

        ldr     r3, =tmp
		ldr     r3,[r3]

		ldr     r2, =zx
        str     r3, [r2]       @tmp存進zx

        ldr     r3, =i
		ldr     r3,[r3]        @i
        sub     r3, r3, #1     @i=i-1
		ldr     r2, =i
        str     r3, [r2]
        b       .Loop3

.L4:
        ldr     r3, =i        @r3=i
		ldr     r3,[r3]
		ldr     r2, =0xff      @r2=ff
		and     r2, r2, r3    @r2&r3
		mov     r3, r2        @r3=(r2&r3)
        lsl     r2, r2, #8    @r2=(r2&r3)<<8
		orr     r2, r2, r3    @r2=(r2|r3)

		mvn     r2, r2
		ldr     r1, =0xffff
		and     r2, r1, r2
		ldr     r9, = color
		strh    r2, [r9]

        ldr     r2, =y
        ldr     r2, [r2]       @r2=y
        mov     r1, r2         @r1=r2
        mov     r2, r2, lsl#2  @r2=y*4
        add     r2, r1, r2     @r2=y*5
        lsl     r2, r2, #8     @r2=(y*5)*256 (1280)
        add     r2, r4, r2     @r2=frame+y*1280
        ldr     r3, =x
        ldr     r3, [r3]       @r3=x
        mov     r0, #1
        mov     r3, r3, lsl r0  @r3=x*2
        add     r2, r2, r3     @r2=frame+y*1280 + x*2
        ldr     r9, = color
        ldrh    r9, [r9]       @r9=color
        strh    r9, [r2]


        ldr     r3, =y
		ldr     r3,[r3]
        add     r3, r3, #1
		ldr     r1, =y
        str     r3, [r1]
        b       .Loop2

.L3:
        ldr     r3, =x
		ldr     r3,[r3]
        add     r3, r3, #1
		ldr     r1, =x
        str     r3, [r1]
        b       .Loop1

finish:
        mov     r0,#0
        mov     r1,#0
        mov     r2,#0
        mov     r3, r11
        sbcs    r11, r0, r1
        mov     r11, r3
        mov     r3,#0
        ldmfd   sp!,{r4-r9, lr}
        mov     pc, lr


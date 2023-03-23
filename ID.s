      .data
fmtInt: .asciz "%d"
outputfmtInt: .asciz "%d\n"
input:.asciz "%s"
enter:.asciz "\n"
id1:  .word 0
id2:  .word 0
id3:  .word 0
total:.word 0
command: .word 0
IsP:  .word 'p'
str1: .asciz "*****Input ID*****\n"
str2: .asciz "** Please Enter Member 1 ID:**\n"
str3: .asciz "** Please Enter Member 2 ID:**\n"
str4: .asciz "** Please Enter Member 3 ID:**\n"
str5: .asciz "** Please Enter Command **\n"
str6: .asciz "***** Print Team Member ID and ID Summation*****\n"
str7: .asciz "ID Summation = %d\n"
str8: .asciz "*****End Print*****\n"
error:.asciz "Command is not p.\n"

      .text
      .globl fmtInt
      .globl id1
      .globl id2
      .globl id3
      .globl total
      .globl str7
      .globl ID
      .type ID, %function
ID:
   stmfd sp!,{r4-r6,lr} @ push r4-r6 and lr onto stack
   ldr   r0,=str1       @ load str1 to r0
   bl    printf         @ call print

   ldr   r0,=str2       @ load str2 to r0 "Please Enter Member 1 ID:"
   bl    printf         @ call print

   ldr   r0,=fmtInt
   ldr   r1,=id1        @ load id1 to r0
   bl    scanf          @ call scanf


   ldr   r0,=str3       @"Please Enter Member 2 ID:"
   bl    printf

   ldr   r0,=fmtInt
   ldr   r1,=id2
   bl    scanf


   ldr   r0,=str4       @"Please Enter Member 3 ID:"
   bl    printf

   ldr   r0,=fmtInt
   ldr   r1,=id3
   bl    scanf

   ldr   r0,=str5       @"Please Enter Command"
   bl    printf

   ldr   r0,=input
   ldr   r1,=command
   bl    scanf

   ldr   r0,=IsP
   ldr   r0,[r0]
   ldr   r1,=command
   ldr   r1,[r1]
   cmp   r0,r1

   ldrne r0,=error
   blne  printf


   ldr   r0,=str6       @"Print Team Member ID and ID Summation"
   bl    printf
   ldr   r0,=outputfmtInt
   ldr   r1,=id1
   ldr   r1,[r1]

   bl    printf

   ldr   r0,=outputfmtInt
   ldr   r1,=id2
   ldr   r1,[r1]
   bl    printf

   ldr   r0,=outputfmtInt
   ldr   r1,=id3
   ldr   r1,[r1]
   bl    printf

   ldr   r0,=enter
   bl    printf

   ldr   r0,=str7       @"ID Summation = "
   ldr   r4,=id1
   ldr   r4,[r4]
   ldr   r5,=id2
   ldr   r5,[r5]
   ldr   r6,=id3
   ldr   r6,[r6]
   cmp   r6, #0
   addpl   r3,r4,r5
   addpl   r3,r3,r6

   ldr   r1,=total
   str   r3,[r1]
   mov   r1,r3

   bl    printf

   ldr   r0,=str8       @"End Print"
   bl    printf

   moval   r1,#0
   moval   r3,#0

   moval   r0,#0
   ldmfd sp!,{r4-r6,lr}
   mov   pc,lr
   .end



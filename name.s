      .data
str1: .asciz "*****Print Name*****\n"
str2: .asciz "*****End Print*****\n"
team: .asciz "Team 13\n"
name1: .asciz "Li Zhu Chen\n"
name2: .asciz "Chieh Lee Hung\n"
name3: .asciz "Li Wei Chiang\n"

    .text
    .globl
    .globl name1
    .globl name2
    .globl name3
    .globl team
    .globl NAME
    .type NAME, %function

NAME:stmfd sp!,{lr}
     mov  r1,#0
     mov  r2,#0
     adcs r0,r1,r2

     ldr r0, =str1
     bl  printf

     ldr r0, =team
     bl  printf

     ldr r0, =name1
     bl  printf

     ldr r0, =name2
     bl  printf

     ldr r0, =name3
     bl  printf

     ldr r0, =str2
     bl  printf

     ldmfd sp!,{lr}
     mov   pc, lr

     .end






#define __SFR_OFFSET 0x00
#include <avr/io.h>

.global Funcion_calculo
.global function_busca_resultado

Funcion_calculo:
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Empilha valor 0x5
ldi r16, 0x0
push r16
ldi r16, 0x5
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x4
ldi r16, 0x0
push r16
ldi r16, 0x4
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
pop R17 ; Desempilha o LSB do resultado
pop R16 ; Desempilha o MSB do resultado
; Armazena o valor em R16(MSB) e R17(LSB) na memoria
STS 0x100, R16
STS 0x101, R17

; Empilha valor 0xa
ldi r16, 0x0
push r16
ldi r16, 0xa
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Mover o dividendo de r18:r19 para r17:r16
mov r16, r19 ; Move o byte menos significativo do dividendo primeiro
mov r17, r18 ; Move o byte mais significativo do dividendo

; Mover o divisor de r20:r21 para r19:r18
mov r18, r21 ; Move o byte menos significativo do divisor
mov r19, r20 ; Move o byte mais significativo do divisor

div16u_a87ba98bd2f14253a458050aae5bc68b: clr r14 ; clear remainder Low byte
sub r15, r15 ; clear remainder High byte and carry
ldi r20, 17 ; init loop counter
d16u_1_a87ba98bd2f14253a458050aae5bc68b: rol r16 ; shift left dividend
rol r17
dec r20 ; decrement counter
brne d16u_2_a87ba98bd2f14253a458050aae5bc68b ; if not done continue
rjmp end_a87ba98bd2f14253a458050aae5bc68b ; end of division
d16u_2_a87ba98bd2f14253a458050aae5bc68b: rol r14 ; shift dividend into remainder
rol r15
sub r14, r18 ; subtract divisor from remainder
sbc r15, r19
brcc d16u_3_a87ba98bd2f14253a458050aae5bc68b ; if result is negative
add r14, r18 ; restore remainder
adc r15, r19
clc ; clear carry to be shifted into result
rjmp d16u_1_a87ba98bd2f14253a458050aae5bc68b ; continue loop
d16u_3_a87ba98bd2f14253a458050aae5bc68b: sec ; set carry to be shifted into result
rjmp d16u_1_a87ba98bd2f14253a458050aae5bc68b
end_a87ba98bd2f14253a458050aae5bc68b: push r17 ; push MSB of the result
push r16 ; push LSB of the result
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Empilha valor 0x4
ldi r16, 0x0
push r16
ldi r16, 0x4
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
; Empilha valor 0xa
ldi r16, 0x0
push r16
ldi r16, 0xa
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Mover o dividendo de r18:r19 para r17:r16
mov r16, r19 ; Move o byte menos significativo do dividendo primeiro
mov r17, r18 ; Move o byte mais significativo do dividendo

; Mover o divisor de r20:r21 para r19:r18
mov r18, r21 ; Move o byte menos significativo do divisor
mov r19, r20 ; Move o byte mais significativo do divisor

div16u_7ef3e185a700428dbed06dc2bcf6b3c8: clr r14 ; clear remainder Low byte
sub r15, r15 ; clear remainder High byte and carry
ldi r20, 17 ; init loop counter
d16u_1_7ef3e185a700428dbed06dc2bcf6b3c8: rol r16 ; shift left dividend
rol r17
dec r20 ; decrement counter
brne d16u_2_7ef3e185a700428dbed06dc2bcf6b3c8 ; if not done continue
rjmp end_7ef3e185a700428dbed06dc2bcf6b3c8 ; end of division
d16u_2_7ef3e185a700428dbed06dc2bcf6b3c8: rol r14 ; shift dividend into remainder
rol r15
sub r14, r18 ; subtract divisor from remainder
sbc r15, r19
brcc d16u_3_7ef3e185a700428dbed06dc2bcf6b3c8 ; if result is negative
add r14, r18 ; restore remainder
adc r15, r19
clc ; clear carry to be shifted into result
rjmp d16u_1_7ef3e185a700428dbed06dc2bcf6b3c8 ; continue loop
d16u_3_7ef3e185a700428dbed06dc2bcf6b3c8: sec ; set carry to be shifted into result
rjmp d16u_1_7ef3e185a700428dbed06dc2bcf6b3c8
end_7ef3e185a700428dbed06dc2bcf6b3c8: push r17 ; push MSB of the result
push r16 ; push LSB of the result
; Empilha valor 0x5
ldi r16, 0x0
push r16
ldi r16, 0x5
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Subtracao de dois valores
sub r19, r21 ; Subtrai os LSBs
sbc r18, r20 ; Subtrai os MSBs com borrow
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
pop R17 ; Desempilha o LSB do resultado
pop R16 ; Desempilha o MSB do resultado
; Armazena o valor em R16(MSB) e R17(LSB) na memoria
STS 0x102, R16
STS 0x103, R17

; Empilha valor 0x6
ldi r16, 0x0
push r16
ldi r16, 0x6
push r16
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Subtracao de dois valores
sub r19, r21 ; Subtrai os LSBs
sbc r18, r20 ; Subtrai os MSBs com borrow
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x4
ldi r16, 0x0
push r16
ldi r16, 0x4
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Mover o dividendo de r18:r19 para r17:r16
mov r16, r19 ; Move o byte menos significativo do dividendo primeiro
mov r17, r18 ; Move o byte mais significativo do dividendo

; Mover o divisor de r20:r21 para r19:r18
mov r18, r21 ; Move o byte menos significativo do divisor
mov r19, r20 ; Move o byte mais significativo do divisor

div16u_7720a835eb074a8eaab2eac39fc061e5: clr r14 ; clear remainder Low byte
sub r15, r15 ; clear remainder High byte and carry
ldi r20, 17 ; init loop counter
d16u_1_7720a835eb074a8eaab2eac39fc061e5: rol r16 ; shift left dividend
rol r17
dec r20 ; decrement counter
brne d16u_2_7720a835eb074a8eaab2eac39fc061e5 ; if not done continue
rjmp end_7720a835eb074a8eaab2eac39fc061e5 ; end of division
d16u_2_7720a835eb074a8eaab2eac39fc061e5: rol r14 ; shift dividend into remainder
rol r15
sub r14, r18 ; subtract divisor from remainder
sbc r15, r19
brcc d16u_3_7720a835eb074a8eaab2eac39fc061e5 ; if result is negative
add r14, r18 ; restore remainder
adc r15, r19
clc ; clear carry to be shifted into result
rjmp d16u_1_7720a835eb074a8eaab2eac39fc061e5 ; continue loop
d16u_3_7720a835eb074a8eaab2eac39fc061e5: sec ; set carry to be shifted into result
rjmp d16u_1_7720a835eb074a8eaab2eac39fc061e5
end_7720a835eb074a8eaab2eac39fc061e5: push r17 ; push MSB of the result
push r16 ; push LSB of the result
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x1
ldi r16, 0x0
push r16
ldi r16, 0x1
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
; Empilha valor 0x6
ldi r16, 0x0
push r16
ldi r16, 0x6
push r16
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Subtracao de dois valores
sub r19, r21 ; Subtrai os LSBs
sbc r18, r20 ; Subtrai os MSBs com borrow
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x4
ldi r16, 0x0
push r16
ldi r16, 0x4
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Mover o dividendo de r18:r19 para r17:r16
mov r16, r19 ; Move o byte menos significativo do dividendo primeiro
mov r17, r18 ; Move o byte mais significativo do dividendo

; Mover o divisor de r20:r21 para r19:r18
mov r18, r21 ; Move o byte menos significativo do divisor
mov r19, r20 ; Move o byte mais significativo do divisor

div16u_c6a984d3eaef44c2a1c65b5b4c591793: clr r14 ; clear remainder Low byte
sub r15, r15 ; clear remainder High byte and carry
ldi r20, 17 ; init loop counter
d16u_1_c6a984d3eaef44c2a1c65b5b4c591793: rol r16 ; shift left dividend
rol r17
dec r20 ; decrement counter
brne d16u_2_c6a984d3eaef44c2a1c65b5b4c591793 ; if not done continue
rjmp end_c6a984d3eaef44c2a1c65b5b4c591793 ; end of division
d16u_2_c6a984d3eaef44c2a1c65b5b4c591793: rol r14 ; shift dividend into remainder
rol r15
sub r14, r18 ; subtract divisor from remainder
sbc r15, r19
brcc d16u_3_c6a984d3eaef44c2a1c65b5b4c591793 ; if result is negative
add r14, r18 ; restore remainder
adc r15, r19
clc ; clear carry to be shifted into result
rjmp d16u_1_c6a984d3eaef44c2a1c65b5b4c591793 ; continue loop
d16u_3_c6a984d3eaef44c2a1c65b5b4c591793: sec ; set carry to be shifted into result
rjmp d16u_1_c6a984d3eaef44c2a1c65b5b4c591793
end_c6a984d3eaef44c2a1c65b5b4c591793: push r17 ; push MSB of the result
push r16 ; push LSB of the result
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Empilha valor 0x5
ldi r16, 0x0
push r16
ldi r16, 0x5
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
pop R17 ; Desempilha o LSB do resultado
pop R16 ; Desempilha o MSB do resultado
; Armazena o valor em R16(MSB) e R17(LSB) na memoria
STS 0x104, R16
STS 0x105, R17

; Empilha valor 0x7
ldi r16, 0x0
push r16
ldi r16, 0x7
push r16
; Empilha valor 0x5
ldi r16, 0x0
push r16
ldi r16, 0x5
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x8
ldi r16, 0x0
push r16
ldi r16, 0x8
push r16
; Empilha valor 0x4
ldi r16, 0x0
push r16
ldi r16, 0x4
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Mover o dividendo de r18:r19 para r17:r16
mov r16, r19 ; Move o byte menos significativo do dividendo primeiro
mov r17, r18 ; Move o byte mais significativo do dividendo

; Mover o divisor de r20:r21 para r19:r18
mov r18, r21 ; Move o byte menos significativo do divisor
mov r19, r20 ; Move o byte mais significativo do divisor

div16u_f93c40d5fd32492dadc53e8669d1e23b: clr r14 ; clear remainder Low byte
sub r15, r15 ; clear remainder High byte and carry
ldi r20, 17 ; init loop counter
d16u_1_f93c40d5fd32492dadc53e8669d1e23b: rol r16 ; shift left dividend
rol r17
dec r20 ; decrement counter
brne d16u_2_f93c40d5fd32492dadc53e8669d1e23b ; if not done continue
rjmp end_f93c40d5fd32492dadc53e8669d1e23b ; end of division
d16u_2_f93c40d5fd32492dadc53e8669d1e23b: rol r14 ; shift dividend into remainder
rol r15
sub r14, r18 ; subtract divisor from remainder
sbc r15, r19
brcc d16u_3_f93c40d5fd32492dadc53e8669d1e23b ; if result is negative
add r14, r18 ; restore remainder
adc r15, r19
clc ; clear carry to be shifted into result
rjmp d16u_1_f93c40d5fd32492dadc53e8669d1e23b ; continue loop
d16u_3_f93c40d5fd32492dadc53e8669d1e23b: sec ; set carry to be shifted into result
rjmp d16u_1_f93c40d5fd32492dadc53e8669d1e23b
end_f93c40d5fd32492dadc53e8669d1e23b: push r17 ; push MSB of the result
push r16 ; push LSB of the result
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Subtracao de dois valores
sub r19, r21 ; Subtrai os LSBs
sbc r18, r20 ; Subtrai os MSBs com borrow
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x7
ldi r16, 0x0
push r16
ldi r16, 0x7
push r16
; Empilha valor 0x5
ldi r16, 0x0
push r16
ldi r16, 0x5
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Mover o dividendo de r18:r19 para r17:r16
mov r16, r19 ; Move o byte menos significativo do dividendo primeiro
mov r17, r18 ; Move o byte mais significativo do dividendo

; Mover o divisor de r20:r21 para r19:r18
mov r18, r21 ; Move o byte menos significativo do divisor
mov r19, r20 ; Move o byte mais significativo do divisor

div16u_2cb54c7f46c842b1b119884d18046215: clr r14 ; clear remainder Low byte
sub r15, r15 ; clear remainder High byte and carry
ldi r20, 17 ; init loop counter
d16u_1_2cb54c7f46c842b1b119884d18046215: rol r16 ; shift left dividend
rol r17
dec r20 ; decrement counter
brne d16u_2_2cb54c7f46c842b1b119884d18046215 ; if not done continue
rjmp end_2cb54c7f46c842b1b119884d18046215 ; end of division
d16u_2_2cb54c7f46c842b1b119884d18046215: rol r14 ; shift dividend into remainder
rol r15
sub r14, r18 ; subtract divisor from remainder
sbc r15, r19
brcc d16u_3_2cb54c7f46c842b1b119884d18046215 ; if result is negative
add r14, r18 ; restore remainder
adc r15, r19
clc ; clear carry to be shifted into result
rjmp d16u_1_2cb54c7f46c842b1b119884d18046215 ; continue loop
d16u_3_2cb54c7f46c842b1b119884d18046215: sec ; set carry to be shifted into result
rjmp d16u_1_2cb54c7f46c842b1b119884d18046215
end_2cb54c7f46c842b1b119884d18046215: push r17 ; push MSB of the result
push r16 ; push LSB of the result
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
pop R17 ; Desempilha o LSB do resultado
pop R16 ; Desempilha o MSB do resultado
; Armazena o valor em R16(MSB) e R17(LSB) na memoria
STS 0x106, R16
STS 0x107, R17

; Empilha valor 0x4
ldi r16, 0x0
push r16
ldi r16, 0x4
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
; Empilha valor 0x6
ldi r16, 0x0
push r16
ldi r16, 0x6
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Subtracao de dois valores
sub r19, r21 ; Subtrai os LSBs
sbc r18, r20 ; Subtrai os MSBs com borrow
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
; Empilha valor 0x9
ldi r16, 0x0
push r16
ldi r16, 0x9
push r16
; Empilha valor 0x3
ldi r16, 0x0
push r16
ldi r16, 0x3
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Mover o dividendo de r18:r19 para r17:r16
mov r16, r19 ; Move o byte menos significativo do dividendo primeiro
mov r17, r18 ; Move o byte mais significativo do dividendo

; Mover o divisor de r20:r21 para r19:r18
mov r18, r21 ; Move o byte menos significativo do divisor
mov r19, r20 ; Move o byte mais significativo do divisor

div16u_272fbf7708ab4562811734f895092707: clr r14 ; clear remainder Low byte
sub r15, r15 ; clear remainder High byte and carry
ldi r20, 17 ; init loop counter
d16u_1_272fbf7708ab4562811734f895092707: rol r16 ; shift left dividend
rol r17
dec r20 ; decrement counter
brne d16u_2_272fbf7708ab4562811734f895092707 ; if not done continue
rjmp end_272fbf7708ab4562811734f895092707 ; end of division
d16u_2_272fbf7708ab4562811734f895092707: rol r14 ; shift dividend into remainder
rol r15
sub r14, r18 ; subtract divisor from remainder
sbc r15, r19
brcc d16u_3_272fbf7708ab4562811734f895092707 ; if result is negative
add r14, r18 ; restore remainder
adc r15, r19
clc ; clear carry to be shifted into result
rjmp d16u_1_272fbf7708ab4562811734f895092707 ; continue loop
d16u_3_272fbf7708ab4562811734f895092707: sec ; set carry to be shifted into result
rjmp d16u_1_272fbf7708ab4562811734f895092707
end_272fbf7708ab4562811734f895092707: push r17 ; push MSB of the result
push r16 ; push LSB of the result
; Empilha valor 0x4
ldi r16, 0x0
push r16
ldi r16, 0x4
push r16
; Empilha valor 0x2
ldi r16, 0x0
push r16
ldi r16, 0x2
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Inicializa os registradores para o resultado intermediário
clr r22  ; Limpa o registrador r22 (parte baixa do resultado)
clr r23  ;Limpa o registrador r23 (parte alta do resultado)
clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)
clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)
; Multiplica os LSBs (r19 por r21)
mul r19, r21
mov r22, r0 ; Move o resultado para r22
mov r23, r1
clr r1 ; Limpa r1 após a multiplicacao
; Multiplica r18 por r21 e adiciona ao resultado
mul r18, r21
add r23, r0 ; Adiciona ao resultado
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1      ; Limpa r1 após a multiplicacao
; Multiplica r19 por r20 e adiciona ao resultado
mul r19, r20
add r23, r0 ; Adiciona ao proximo byte
adc r24, r1 ; Adiciona ao proximo byte, considerando carry
clr r1     ; Limpa r1 apos a multiplicacao
; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto
; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo
mul r18, r20
add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)
adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)
clr r1     ; Limpa r1 após a multiplicacao
; O resultado final de 16 bits mais significativo esta em r22:r23
; Para um resultado de 32 bits, considere tambem r24:r25
mov r17, r22
mov r16, r23
push r16
push r17
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Empilha valor 0x1
ldi r16, 0x0
push r16
ldi r16, 0x1
push r16
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
; Desempilha os 2 ultimos valores da pilha para os registradores
pop r21 ; LSB do segundo valor
pop r20 ; MSB do segundo valor
pop r19 ; LSB do primeiro valor
pop r18 ; MSB do primeiro valor
; Adicao de dois valores
add r19, r21 ; Adiciona os LSBs
adc r18, r20 ; Adiciona os MSBs com carry
push r18 ; Empilha o MSB do resultado
push r19 ; Empilha o LSB do resultado
pop R17 ; Desempilha o LSB do resultado
pop R16 ; Desempilha o MSB do resultado
; Armazena o valor em R16(MSB) e R17(LSB) na memoria
STS 0x108, R16
STS 0x109, R17



function_busca_resultado:

    PUSH R0
    MOV R26, R24
    MOV R27, R25

    LD R25, X
    INC R26
    LD R24, X

    CLR R1
    POP R0
    RET

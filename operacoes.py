import uuid

def adicao_assembly():
    return [
        "; Adicao de dois valores",
        "add r19, r21 ; Adiciona os LSBs",
        "adc r18, r20 ; Adiciona os MSBs com carry",
        "push r18 ; Empilha o MSB do resultado",
        "push r19 ; Empilha o LSB do resultado",
    ]


def subtracao_assembly():
    return [
        "; Subtracao de dois valores",
        "sub r19, r21 ; Subtrai os LSBs",
        "sbc r18, r20 ; Subtrai os MSBs com borrow",
        "push r18 ; Empilha o MSB do resultado",
        "push r19 ; Empilha o LSB do resultado",
    ]


def multiplicacao_assembly():
    return [
        "; Inicializa os registradores para o resultado intermediário",
        "clr r22  ; Limpa o registrador r22 (parte baixa do resultado)",
        "clr r23  ;Limpa o registrador r23 (parte alta do resultado)",
        "clr r24 ; Limpa o registrador r24 (extensão baixa do resultado para 32 bits, opcional)",
        "clr r25 ; Limpa o registrador r25 (extensão alta do resultado para 32 bits, opcional)",
        "; Multiplica os LSBs (r19 por r21)",
        "mul r19, r21",
        "mov r22, r0 ; Move o resultado para r22",
        "mov r23, r1",
        "clr r1 ; Limpa r1 após a multiplicacao",
        "; Multiplica r18 por r21 e adiciona ao resultado",
        "mul r18, r21",
        "add r23, r0 ; Adiciona ao resultado",
        "adc r24, r1 ; Adiciona ao proximo byte, considerando carry",
        "clr r1      ; Limpa r1 após a multiplicacao",
        "; Multiplica r19 por r20 e adiciona ao resultado",
        "mul r19, r20",
        "add r23, r0 ; Adiciona ao proximo byte",
        "adc r24, r1 ; Adiciona ao proximo byte, considerando carry",
        "clr r1     ; Limpa r1 apos a multiplicacao",
        "; Multiplica os MSBs (r18 por r20) e adiciona ao resultado mais alto",
        "; Este passo pode ser omitido se estivermos interessados apenas no resultado de 16 bits mais significativo",
        "mul r18, r20",
        "add r24, r0 ; Adiciona ao byte mais baixo da extensao (opcional)",
        "adc r25, r1 ; Adiciona ao byte mais alto da extensao (opcional)",
        "clr r1     ; Limpa r1 após a multiplicacao",
        "; O resultado final de 16 bits mais significativo esta em r22:r23",
        "; Para um resultado de 32 bits, considere tambem r24:r25",
        "mov r17, r22",
        "mov r16, r23",
        "push r16",
        "push r17",
    ]


def divisao_assembly():
    identificador_operacao = uuid.uuid4().hex
    return [
        "; Mover o dividendo de r18:r19 para r17:r16",
        "mov r16, r19 ; Move o byte menos significativo do dividendo primeiro",
        "mov r17, r18 ; Move o byte mais significativo do dividendo",
        "",
        "; Mover o divisor de r20:r21 para r19:r18",
        "mov r18, r21 ; Move o byte menos significativo do divisor",
        "mov r19, r20 ; Move o byte mais significativo do divisor",
        "",
        f"div16u_{identificador_operacao}: clr r14 ; clear remainder Low byte",
        "sub r15, r15 ; clear remainder High byte and carry",
        "ldi r20, 17 ; init loop counter",
        f"d16u_1_{identificador_operacao}: rol r16 ; shift left dividend",
        "rol r17",
        "dec r20 ; decrement counter",
        f"brne d16u_2_{identificador_operacao} ; if not done continue",
        f"rjmp end_{identificador_operacao} ; end of division",
        f"d16u_2_{identificador_operacao}: rol r14 ; shift dividend into remainder",
        "rol r15",
        "sub r14, r18 ; subtract divisor from remainder",
        "sbc r15, r19",
        f"brcc d16u_3_{identificador_operacao} ; if result is negative",
        "add r14, r18 ; restore remainder",
        "adc r15, r19",
        "clc ; clear carry to be shifted into result",
        f"rjmp d16u_1_{identificador_operacao} ; continue loop",
        f"d16u_3_{identificador_operacao}: sec ; set carry to be shifted into result",
        f"rjmp d16u_1_{identificador_operacao}",
        f"end_{identificador_operacao}: push r17 ; push MSB of the result",
        "push r16 ; push LSB of the result",
    ]


def resto_assembly():
    identificador_operacao = uuid.uuid4().hex
    return [
        "; Mover o dividendo de r18:r19 para r17:r16",
        "mov r16, r19 ; Move o byte menos significativo do dividendo primeiro",
        "mov r17, r18 ; Move o byte mais significativo do dividendo",
        "",
        "; Mover o divisor de r20:r21 para r19:r18",
        "mov r18, r21 ; Move o byte menos significativo do divisor",
        "mov r19, r20 ; Move o byte mais significativo do divisor",
        "",
        f"div16u_{identificador_operacao}: clr r14 ; clear remainder Low byte",
        "sub r15, r15 ; clear remainder High byte and carry",
        "ldi r20, 17 ; init loop counter",
        f"d16u_1_{identificador_operacao}: rol r16 ; shift left dividend",
        "rol r17",
        "dec r20 ; decrement counter",
        f"brne d16u_2_{identificador_operacao} ; if not done continue",
        f"rjmp end_{identificador_operacao} ; end of division",
        f"d16u_2_{identificador_operacao}: rol r14 ; shift dividend into remainder",
        "rol r15",
        "sub r14, r18 ; subtract divisor from remainder",
        "sbc r15, r19",
        f"brcc d16u_3_{identificador_operacao} ; if result is negative",
        "add r14, r18 ; restore remainder",
        "adc r15, r19",
        "clc ; clear carry to be shifted into result",
        f"rjmp d16u_1_{identificador_operacao} ; continue loop",
        f"d16u_3_{identificador_operacao}: sec ; set carry to be shifted into result",
        f"rjmp d16u_1_{identificador_operacao}",
        f"end_{identificador_operacao}: push r15 ; push MSB of the result",
        "push r14 ; push LSB of the result",
    ]


def potencia_assembly():
    identificador_operacao = uuid.uuid4().hex
    return [
        "LDI R24, 0x00 ",
        "LDI R25, 0x01",
        f"loop_{identificador_operacao}:",
        "; Multiply R24:R25 by r18:r19 here, store back in R24:R25",
        "; Inicializa os registradores para o resultado intermediario",
        "clr r22  ; Limpa o registrador r22 (parte baixa do resultado)",
        "clr r23  ;Limpa o registrador r23 (parte alta do resultado)",
        "; Multiplica os LSBs",
        "mul R25, R19",
        "mov r22, r0 ; Move o resultado para r22",
        "mov r23, r1",
        "clr r1 ; Limpa r1 ap s a multiplicacao",
        "; Multiplica r18 por r21 e adiciona ao resultado",
        "mul R24, r19",
        "add r23, r0 ; Adiciona ao resultado",
        "clr r1      ; Limpa r1 ap s a multiplicacao",
        "; Multiplica r19 por r20 e adiciona ao resultado",
        "mul r25, r18",
        "add r23, r0 ; Adiciona ao proximo byte",
        "clr r1     ; Limpa r1 apos a multiplicacao",
        "; O resultado final de 16 bits mais significativo esta em r23:r22",
        "MOV R24, R23",
        "MOV R25, R22",
        "; Decrement exponent",
        "DEC R21                 ; Decrement the low byte",
        f"BRNE loop_{identificador_operacao} ",
        f"end_{identificador_operacao}:",
        "push R24",
        "push R25",
    ]


operacoes = {
    "+": adicao_assembly,
    "-": subtracao_assembly,
    "*": multiplicacao_assembly,
    "|": divisao_assembly,
    "/": divisao_assembly,
    "%": resto_assembly,
    "^": potencia_assembly,
}

endereco_memoria_atual = 0x100

def resetar_out(out_text):
    with open(out_text, 'w') as arquivo:
        arquivo.write('')


def empilhar_valor(valor):
    valor_msb = valor >> 8
    valor_lsb = valor & 0xFF
    return [
        f"; Empilha valor {hex(valor)}",
        f"ldi r16, {hex(valor_msb)}",  # Carrega parte mais significativa do valor
        "push r16",  # Empilha parte mais significativa
        f"ldi r16, {hex(valor_lsb)}",  # Carrega parte menos significativa do valor
        "push r16",  # Empilha parte menos significativa
    ]


def desempilha_valores():  # Desempilha os valores da pilha para os registradores
    # r20, r21, r18 e r19
    return [
        "; Desempilha os 2 ultimos valores da pilha para os registradores",
        "pop r21 ; LSB do segundo valor",
        "pop r20 ; MSB do segundo valor",
        "pop r19 ; LSB do primeiro valor",
        "pop r18 ; MSB do primeiro valor",
    ]


def desempilha_resultado_da_pilha():
    return [
        "pop R17 ; Desempilha o LSB do resultado",
        "pop R16 ; Desempilha o MSB do resultado",
    ]


def armazenar_memoria_assembly():
    global endereco_memoria_atual
    codigo_assembly = [
        f"; Armazena o valor em R16(MSB) e R17(LSB) na memoria",
        f"STS {hex(endereco_memoria_atual)}, R16",
        f"STS {hex(endereco_memoria_atual + 1)}, R17",
    ]
    endereco_memoria_atual += 2  # Atualiza o endereço de memoria para o próximo uso
    return codigo_assembly


def armazenar_MEM_assembly():
    global endereco_memoria_atual
    codigo_assembly = [
        f"; Armazena valor de MEM na memoria",
        f"pop r31 ; Carrega parte menos significativa do valor",
        f"pop r30 ; Carrega parte mais significativa do valor",
        "; Insere o resultado como 0",
        f"ldi r16, 0x0",
        f"STS {hex(endereco_memoria_atual)}, R16",
        f"STS {hex(endereco_memoria_atual + 1)}, R16",
    ]
    endereco_memoria_atual += 2  # Atualiza o endereço de memoria para o próximo uso
    return codigo_assembly


def empilhar_MEM():
    return [
        "; Empilha valor de MEM na pilha",
        "push r30 ; Empilha parte mais significativa de MEM",
        "push r31 ; Empilha parte menos significativa de MEM",
    ]


def resgatar_RES(n):
    return [
        "pop R17 ; Desempilha o LSB de n",
        "pop R16 ; Desempilha o MSB de n",
        "ldi R28, 0x00 ; Low byte of address",
        "ldi R29, 0x01 ; High byte of address",
        f"; Adjust Y to point to {hex(0x100 + n)}",
        f"adiw Y, {n}  ; Add immediate to word, Y = Y + {n}",
        "ld R16, Y",
        f"; Increment Y to point to the next address (0x100 + {n} + 1)",
        "adiw Y, 1  ; Y = Y + 1",
        "ld R17, Y",
        "push R16 ; Empilha MSB do resultado",
        "push R17 ; Empilha LSB do resultado",
    ]

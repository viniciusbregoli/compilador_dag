from ll1 import *
from dag import *
from solver import *
import sys

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Erro: Por favor, forneça o nome do arquivo de entrada e o nome do arquivo de saída como argumentos.")
    else:
        nome_arquivo_entrada = sys.argv[1]
        arquivo_output = sys.argv[2]


cabecalho = """#define __SFR_OFFSET 0x00
#include <avr/io.h>

.global Funcion_calculo
.global function_busca_resultado

Funcion_calculo:
"""

with open(arquivo_output, "w") as f:
    f.write(cabecalho)

i = 1

with open(nome_arquivo_entrada, "r") as f:
    for line in f:
        print("================================================================")
        print()
        if parse(line):
            gerarDag(line, i) # Gera a DAG
            resultado = avaliar_expressao(line.strip(), i) # Avalia e resolve a expressão e converte para assembly
            if arquivo_output:
                with open(arquivo_output, "a") as f:
                    for linha in resultado:
                        f.write(linha + "\n")
            i += 1
        print()

trecho_final = """

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
"""

with open(arquivo_output, "a") as f:
    f.write(trecho_final)


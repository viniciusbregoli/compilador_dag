from operacoes import *
from funcoes_assembly import *


def avaliar_npr(expressao, linha):
    expressao = expressao.replace("(", "").replace(")", "")
    tokens = expressao.split()
    codigo_completo = []
    pilha = []
    flag_MEM = False
    for i in range(len(tokens)):
        token = tokens[i]
        codigo_assembly = []
        if token in operacoes:
            codigo_assembly.extend(desempilha_valores())
            codigo_assembly.extend(operacoes[token]())
        elif token == "MEM":
            try:
                prox_valor = tokens[i + 1]
                if prox_valor.isdigit() or (
                    prox_valor in operacoes
                ):  # empilhar valor de MEM na pilha
                    codigo_assembly.extend(empilhar_MEM())
            except IndexError:
                flag_MEM = True
                codigo_assembly.extend(armazenar_MEM_assembly())
        elif token == "RES":
            n = (linha - pilha.pop()) * 2 - 2
            codigo_assembly.extend(resgatar_RES(n))
        else:
            pilha.append(int(token))
            codigo_assembly.extend(empilhar_valor(int(token)))
        codigo_completo.extend(codigo_assembly)
    if not flag_MEM:
        codigo_completo.extend(desempilha_resultado_da_pilha())
        codigo_completo.extend(armazenar_memoria_assembly())
    codigo_completo.append("")
    return codigo_completo

import sys
from operacoes import *
from funcoes_assembly import *
from parenteses import *


def avaliar_expressao(expressao, linha):
    if expressao.count("(") > 1:
        resultado = avaliar_npr(expressao, linha)
        return resultado
    else:
        expressao = expressao.replace("(", "").replace(")", "")
    partes = expressao.split()
    pilha = []
    codigo_assembly = []
    flag_MEM = False
    for i in range(len(partes)):
        parte = partes[i]
        if parte.isdigit():
            codigo_assembly.extend(empilhar_valor(int(parte)))
            pilha.append(int(parte))
        elif parte == "MEM":
            try:
                prox_valor = partes[i + 1]
                if prox_valor.isdigit() or (
                    prox_valor in operacoes
                ):  # empilhar valor de MEM na pilha
                    codigo_assembly.extend(empilhar_MEM())
            except IndexError:
                if len(pilha) == 0: # quer dizer que é ela sozinha
                    codigo_assembly.extend(empilhar_MEM())
                else:
                    flag_MEM = True
                    codigo_assembly.extend(armazenar_MEM_assembly())
        elif parte == "RES":
            n = (linha - pilha.pop()) * 2 - 2
            codigo_assembly.extend(resgatar_RES(n))
        elif parte in operacoes:
            codigo_assembly.extend(desempilha_valores())
            codigo_assembly.extend(operacoes[parte]())
    if not flag_MEM:
        codigo_assembly.extend(desempilha_resultado_da_pilha())
        codigo_assembly.extend(armazenar_memoria_assembly())
    codigo_assembly.append("")
    return codigo_assembly


def ler_e_avaliar_arquivo(nome_arquivo, arquivo_output=None):
    resetar_out(arquivo_output)
    try:
        with open(nome_arquivo, "r") as arquivo:
            i = 1
            for linha in arquivo:
                expressao = linha.strip()
                resultado = avaliar_expressao(expressao, i)
                if arquivo_output:
                    with open(arquivo_output, "a") as f:
                        for linha in resultado:
                            f.write(linha + "\n")
                i += 1
    except FileNotFoundError:
        print(f"Erro: o arquivo {nome_arquivo} não foi encontrado.")


# ler_e_avaliar_arquivo("teste2.txt", "out.txt")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Erro: Por favor, forneça o nome do arquivo de entrada e o nome do arquivo de saída como argumentos.")
    else:
        nome_arquivo_entrada = sys.argv[1]
        nome_arquivo_saida = sys.argv[2]
        ler_e_avaliar_arquivo(nome_arquivo_entrada, nome_arquivo_saida)

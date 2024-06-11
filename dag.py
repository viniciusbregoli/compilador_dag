import networkx as nx
import matplotlib.pyplot as plt
from networkx.drawing.nx_agraph import to_agraph


def gerarDag(expressao, n):
    expressaoOriginal = expressao
    expressao = expressao.replace("(", "").replace(")", "")
    pilha = []  # Pilha para armazenar operandos e resultados intermediários
    grafo = nx.DiGraph()  # Cria um grafo
    subExpressoes = {}  # Dicionário para armazenar nós de sub-expressões
    nodeCount = 1  # Contador para rotular os nós de operação de forma única

    tokens = expressao.split()  # Divide a expressão em tokens separados por espaço

    for token in tokens:
        if token.isdigit():  # Verifica se o token é um dígito (operando)
            pilha.append(token)  # Adiciona o operando à pilha
            if (
                token not in grafo.nodes
            ):  # Adiciona o operando como nó no grafo, se ainda não estiver
                grafo.add_node(token, label=token, shape="circle")
        else:  # Caso contrário, o token é um operador
            operando2 = pilha.pop()  # Retira o segundo operando da pilha
            operando1 = pilha.pop()  # Retira o primeiro operando da pilha
            subExpressao = f"{operando1} {token} {operando2}"  # Cria a sub-expressão

            if (
                subExpressao in subExpressoes
            ):  # Verifica se a sub-expressão já foi processada
                nodeOperacao = subExpressoes[subExpressao]  # Reutiliza o nó existente
            else:
                nodeOperacao = f"{token}_{nodeCount}"  # Cria um novo nó de operação
                nodeCount += 1  # Incrementa o contador de nós
                grafo.add_node(
                    nodeOperacao, label=token, shape="circle"
                )  # Adiciona o nó de operação ao grafo
                grafo.add_edge(
                    operando1, nodeOperacao
                )  # Adiciona uma aresta do primeiro operando para o nó de operação
                grafo.add_edge(
                    operando2, nodeOperacao
                )  # Adiciona uma aresta do segundo operando para o nó de operação
                subExpressoes[subExpressao] = (
                    nodeOperacao  # Armazena a sub-expressão no dicionário
                )

            pilha.append(nodeOperacao)  # Adiciona o nó de operação de volta à pilha
    G = grafo
    A = nx.nx_agraph.to_agraph(G)
    # Define o título do grafo como a expressão original
    A.graph_attr['label'] = expressaoOriginal
    A.graph_attr['labelloc'] = 't'  # Define a posição do título no topo
    A.graph_attr['fontsize'] = '20'  # Define o tamanho da fonte do título
    A.layout(
        "dot", args="-Grankdir=BT"
    )  # Algoritmo 'dot' com direção de rank 'BT' (Bottom to Top)

    A.draw(f"./images/expressao{n}.png")
    n += 1


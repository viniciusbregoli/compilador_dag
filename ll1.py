import sys

non_terminals = ["Expr", "ExprList", "Num", "Digits", "Sign", "Op"]
terminals = ["DIGIT", "+", "-", "*", "/", "(", ")", ".", "E"]
terminals = terminals + ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

# Tabela LL(1) para análise sintática
ll1_table = {
    ("Expr", "("): ["(", "ExprList", ")"],
    ("Expr", "DIGIT"): ["Num"],
    ("ExprList", "("): ["Expr", "Expr", "Op"],
    ("ExprList", "DIGIT"): ["Expr", "Expr", "Op"],
    ("Num", "DIGIT"): ["Sign", "Digits"],
    ("Num", "+"): ["Sign", "Digits"],
    ("Num", "-"): ["Sign", "Digits"],
    ("Num", "."): ["Sign", "Digits", ".", "Digits"],
    ("Num", "E"): ["Sign", "Digits", ".", "Digits", "E", "Sign", "Digits"],
    ("Digits", "DIGIT"): ["Digits", "Digits"],
    ("Digits", "0"): ["0"],
    ("Digits", "1"): ["1"],
    ("Digits", "2"): ["2"],
    ("Digits", "3"): ["3"],
    ("Digits", "4"): ["4"],
    ("Digits", "5"): ["5"],
    ("Digits", "6"): ["6"],
    ("Digits", "7"): ["7"],
    ("Digits", "8"): ["8"],
    ("Digits", "9"): ["9"],
    ("Digits", "."): ["Digits", ".", "Digits"],
    ("Digits", "E"): ["Digits", "E", "Sign", "Digits"],
    ("Sign", "DIGIT"): [""],
    ("Sign", "+"): ["+"],
    ("Sign", "-"): ["-"],
    ("Op", "+"): ["+"],
    ("Op", "-"): ["-"],
    ("Op", "*"): ["*"],
    ("Op", "/"): ["/"],
}


def parse(expression):
    stack = ["Expr"] # Pilha para armazenar os símbolos
    localizado = "" # String para armazenar o que foi localizado
    i = 0
    while i < len(expression) and len(stack) > 0:
        if expression[i] == " ": # Ignora espaços
            localizado += " "
            i += 1
        elif stack[0] == "": # Ignora vazio
            stack.pop(0)
        elif stack[0] in terminals: # Verifica se o topo da pilha é terminal
            if isDigit: # Verifica se é dígito
                localizado += expression[i] # Adiciona o dígito à string localizado
                stack.pop(0)
                i += 1
            else:
                localizado += stack.pop(0) # Adiciona o terminal à string localizado
                i += 1
        elif stack[0] in non_terminals: # Verifica se o topo da pilha é não terminal
            if stack[0] == "Digits" and expression[i + 1].isdigit(): # Verifica se o numero tem mais de um digito
                pop = stack.pop(0) 
                stack = ll1_table[pop, "DIGIT"] + stack # Adiciona mais um digits à pilha
            if stack[0] == "Digits" and expression[i + 1] == ".": # Verifica se o numero tem ponto
                pop = stack.pop(0)
                stack = ll1_table[pop, "."] + stack # Adiciona o ponto à pilha
            if stack[0] == "Digits" and expression[i + 1] == "E": # Verifica se é E
                pop = stack.pop(0)
                stack = ll1_table[pop, "E"] + stack # Adiciona o E à pilha
            isDigit = expression[i].isdigit() # Verifica se é dígito
            if stack[0] == "Digits" and isDigit: # Substitui digits pelo digito em si
                pop = stack.pop(0)
                stack = ll1_table[(pop, expression[i])] + stack
            elif isDigit and (stack[0], "DIGIT") in ll1_table: # Verifica se é dígito e se está na tabela
                pop = stack.pop(0)
                stack = ll1_table[(pop, "DIGIT")] + stack 
            elif (stack[0], expression[i]) in ll1_table:  # Verifica se está na tabela
                pop = stack.pop(0)
                stack = ll1_table[(pop, expression[i])] + stack
            else: # Se não estiver na tabela, a expressão é inválida
                print(expression)
                print(
                    "Expressão inválida, erro encontrado na posição",
                    i,
                    "do caractere",
                    expression[i],
                )
                print("Esperado:", stack[0], "mas recebeu:", expression[i])
                print("Stack:", stack)
                return False
    print(expression)
    print("Expressão válida")
    return True

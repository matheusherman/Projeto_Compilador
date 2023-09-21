"""
    COMPILADORES - FASE 1
        ANALISADOR LEXICO
    
    NOME: Erick Lemmy dos Santos Oliveira
    NOME: Gabrielle Batista Garcia
    NOME: Matheus Herman
    NOME: Leandro Ricardo Guimarães
    
    PROF: Frank Alcantara
"""
import re
import sys
# Código-fonte de exemplo
source_code = """
    bool_var: bool = true;
    var: bool = false;
    // Este é um comentário
    numero: int = 10; // Comentário após a linha de código
    pi: float16 = 3.14159;
    def somar(a: int, b: int) -> int: {
        return a + b;
    }
"""

# Defina padrões para identificadores, números inteiros e números de ponto flutuante
identifier_pattern = r'[a-zA-Z_][a-zA-Z0-9_]*'
integer_pattern = r'\d+'
float_pattern = r'\d+\.\d+'

# Lista de palavras-chave da linguagem
keywords = ['int', 'float16', 'bool', 'def', 'if', 'else', 'while', 'return', 'true', 'false', 'void']

# Símbolos de pontuação da linguagem
punctuation_symbols = [';', '{', '}', '(', ')', ',', '->', ':', '=', '==', '!=', '!', '+', '-', '*', '/', '<', '>']

# Função para analisar o código-fonte
def analyze_code(source_code):
    tokens = []
    lines = source_code.split('\n')
    line_number = 1

    for line in lines:
        line = line.strip()

        # Verifica se a linha contém um comentário "//" e remove-o
        if '//' in line:
            line = line.split('//')[0].strip()

        while line:
            match = None

            # Verifica se a próxima parte da linha é uma palavra-chave
            for keyword in keywords:
                if line.startswith(keyword):
                    tokens.append(('KEYWORD', keyword, line_number))
                    line = line[len(keyword):].lstrip()
                    match = True
                    break

            if not match:
                # Verifica se a próxima parte da linha é um identificador
                match = re.match(identifier_pattern, line)
                if match:
                    identifier = match.group(0)
                    tokens.append(('IDENTIFIER', identifier, line_number))
                    line = line[len(identifier):].lstrip()
                    continue

            if not match:
                # Verifica se a próxima parte da linha é um número de ponto flutuante
                match = re.match(float_pattern, line)
                if match:
                    float_number = match.group(0)
                    tokens.append(('FLOAT', float_number, line_number))
                    line = line[len(float_number):].lstrip()
                    continue

            if not match:
                # Verifica se a próxima parte da linha é um número inteiro
                match = re.match(integer_pattern, line)
                if match:
                    integer = match.group(0)
                    tokens.append(('INTEGER', integer, line_number))
                    line = line[len(integer):].lstrip()
                    continue

            if not match:
                # Verifica se a próxima parte da linha é um símbolo de pontuação
                for symbol in punctuation_symbols:
                    if line.startswith(symbol):
                        tokens.append(('PUNCTUATION', symbol, line_number))
                        line = line[len(symbol):].lstrip()
                        match = True
                        break

            # Se nenhum casamento for encontrado, há um erro léxico
            if not match:
                print(f"Erro léxico na linha {line_number}: '{line[0]}' não é reconhecido como parte da linguagem.")
                break

        line_number += 1

    return tokens

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"USO: python3 {sys.argv[0]} arquivo_de_codigo.cpy")
        code = source_code
    else:
        cod = sys.argv[1]
        # Leitura do código a partir de um arquivo
        with open(cod, "r") as file:
            code = file.read()
            
    # Chama a função de análise de código
    tokens = analyze_code(code)

    # Exibe os tokens encontrados
    for token in tokens:
        print(token)
# Fase 1 - Definição da Linguagem e Análise Léxica

## Descrição da Fase

A Fase 1 deste projeto tem como objetivo principal a criação de uma linguagem de programação que permita a criação de programas destinados a sistemas embarcados, como Arduino Mega, Raspberry PI, ou Tiva, baseados na tecnologia ARM. A linguagem será desenvolvida a partir de um esboço inicial, com ênfase na interação com hardware, tipos de dados estáticos, manipulação de números inteiros e de ponto flutuante, além da implementação de operações matemáticas em conformidade com o padrão IEEE-754 de 16 bits, também conhecido como meia precisão.

### Requisitos da Linguagem

A seguir, estão listados os principais requisitos que a linguagem deve atender:

- [x] Estrutura do Programa: Um programa na linguagem consiste em um bloco de declarações definidas.

- [x] Tipos Básicos: A linguagem deve definir tipos básicos para representar dados, incluindo inteiros e números de ponto flutuante de acordo com o padrão IEEE-754 de 16 bits.

- [x] Expressões e Operadores: Deve ser implementada a precedência de operadores e associatividade corretas em expressões matemáticas. Use não-terminais para definir níveis de precedência e um não-terminal "factor" para tratar expressões entre parênteses, identificadores, referências de arranjos e constantes.

- [x] Tipos Estáticos: A linguagem deve ser de tipos estáticos, ou seja, os tipos de variáveis, valores e expressões precisam ser explicitamente definidos no código.

- [x] Interção com Hardware: É necessário definir regras de produção para interação com o hardware, permitindo ler e escrever em pinos do microcomputador, portas seriais, e em componentes opcionais, como conversores digital-analógico e analógico-digital.

### Fase 1

**Raspberry Pi 3 Model B**

- Processador Broadcom BCM2837 64bit ARMv8 Cortex-A53 Quad-Core
- Clock 1.2 GHz
- Memória RAM: 1GB
- Adaptador Wifi 802.11n integrado (trabalha na frequência de 2.4 Ghz)
- Bluetooth 4.1 BLE integrado
- Conector de vídeo HDMI
- 4 portas USB 2.0
- Conector Ethernet
- Interface para câmera (CSI)
- Interface para display (DSI)
- Slot para cartão microSD
- Conector de áudio e vídeo
- GPIO de 40 pinos
- Número de homologação Anatel: 04908-17-10629
- Dimensões: 85 x 56 x 17mm
- Cartão SD de 16GB
- Sistema Operacional: Raspbian


## Apresentação da Linguagem

Estética: A linguagem é baseada na sintaxe de Python, com algumas características de C, como a declaração de tipos de dados e necessidade de uso do ";".

TODO: **Apresentação da Linguagem**: Durante a apresentação, destaque as principais características da linguagem, com ênfase nas regras de produção criadas para interação com o hardware.

### Bloco de Declarações

```python              
program -> block
block -> { decls stmts }
decls -> decls decl | null
decl -> type id;
params -> param, params | params | null
param -> type id
args -> arglist | null
      | expr | null
arglist -> arglist, bool | bool 
        | arglist, num | num 
        | arglist, id | id
type -> int | float16 | bool
stmts -> stmts stmt | null
```

As mudanças básicas em relação ao bloco fornecido estão relacionadas à expansão da sintaxe para acomodar a criação de funções, a introdução de parâmetros de função, declaração de pinos e instruções específicas para interação com hardware. Aqui estão as principais mudanças em relação ao bloco fornecido:

1. **Adição de Funções e Parâmetros**:
   - A produção `func_decl` foi introduzida para permitir a declaração de funções com parâmetros e tipo de retorno.
   - A produção `params` foi adicionada para definir a lista de parâmetros em uma função.
   - A produção `param` permite a definição de parâmetros de função com seu tipo e nome.

2. **Tipo Básico**:
   - A produção `type` continua a permitir tipos básicos, como `int`, `float16` e `bool`.

3. **Identificadores**:
   - A produção `id` permanece semelhante, permitindo identificadores compostos por letras maiúsculas e minúsculas, bem como dígitos numéricos.

4. **Outras Instruções**:
   - A produção `stmt` foi expandida para acomodar instruções específicas relacionadas ao hardware e funções.

5. **Blocos de Função**:
   - A produçao `block` é usadas para definir o escopo de uma função, incluindo a lista de parâmetros e o corpo da função.


### Lexema Basico

```python
stmt -> var = bool
      | assign
      | func_decl
      | return_stmt
      | if ( bool ): { stmt }
      | if ( bool ): { stmt } else: { stmt }
      | if ( bool ): { stmt } else: stmt
      | if ( bool ): { stmt } elif (bool): { stmt }
      | for (var -> num; bool; var -> var + num): { stmt }
      | while ( bool ): { stmt }
      | do { stmt } while ( bool );
      | break;
      | id (args) { stmt }
      | return bool;
      | block
      | pin(id, num, id)
      | write(id, bool)
      | read(id)
var -> var | id
     | var [ bool ] | id
func_call -> id ( args );
func_decl -> def id ( params ) -> type: block
return_stmt -> return expr;
assign -> id: type = expr | var;
```

As mudanças básicas em relação ao bloco fornecido estão relacionadas à expansão da sintaxe para acomodar a criação de funções, a introdução de parâmetros de função, declaração de pinos e instruções específicas para interação com hardware. Aqui estão as principais mudanças em relação ao bloco fornecido:

1. **Adição de Funções e Retorno**:
   - A produção `func_decl` foi introduzida para permitir a declaração de funções com parâmetros e tipo de retorno.
   - A produção `return_stmt` foi introduzida para representar a possibilidade de retorno dentro de um bloco de estado.
   - A produção `func_call` foi introduzida para representar a possibilidade da chamada de uma funçao dentro de um bloco de stmt.

2. **Tipo Básico**:
   - A produção `type` continua a permitir tipos básicos, como `int`, `float16` e `bool`.

3. **Identificadores**:
   - A produção `id` permanece semelhante, permitindo identificadores compostos por letras maiúsculas e minúsculas, bem como dígitos numéricos.

4. **Outras Instruções**:
   - A produção `stmt` foi expandida para acomodar instruções específicas relacionadas ao hardware e funções.
   - A produção `assign` foi introduzida para representar a atribuicao de valor a uma `decl` dado pelo nome `id` seguido do `type` após `:` e a `expr` ou valor a ser atribuido.

5. **Blocos de Função**:
   - As produções `func_decl` e `block` são usadas para definir o escopo de uma função, incluindo a lista de parâmetros e o corpo da função.




### Regra de Produção para Expressões
```python
bool -> join || join
join -> equality && equality
equality -> rel ( == | != ) rel
rel -> expr (< | <= | >= | >) expr
expr -> term ( + | - ) term
term -> unary ( * | / ) unary
unary -> ( ! | - ) unary | factor
factor -> ( bool ) | var | num | real | true | false
bin_op -> expr + expr     
       | expr - expr  
       | expr * expr  
       | expr / expr  
       | expr == expr 
       | expr != expr 
       | expr < expr  
       | expr <= expr 
       | expr > expr  
       | expr >= expr 
```

### Tratamento dos numeros e letras

```python
id -> [a-zA-Z_][a-zA-Z_0-9]* 
var -> [a-zA-Z-Z0-9]+ 
num -> [0-9]+
real -> [0-9].[0-9]
int -> num
float16 ->  real
bool -> true | false
```

| Produção    | Regra de Produção                        |
|-------------|------------------------------------------|
| None        | None -> null                             |
| FEXP        | FEXP -> down DIFITSF                     |
|             | FEXP -> up DIFITSF                       |
| letters [A-Z] | letters [A-Z] ->                       |
| DIFITSF     | DIFITSF -> DIGITSF DIGITS                |
|             | DIFITSF -> None                          |
|             | DIFITSF -> FEXP                          |
| DIGITS      | DIGITS -> -+[0-9]                        |
|             | DIGITS -> num [0-9]                      |
| int         | int -> inteiro                           |
| float16     | float16 -> real                          |
| bool        | bool -> [0-1] ->                         |
| down        | down -> -     #45 in ascii               |
| up          | up -> +       #43 in ascii               |


### Comunicação com Hardware

Para comunicaçao com o hardware foram criadas e adicionadas as seguintes regras ao lexema basico:

```python
pin(nome, pino, direcao)
write(nome, valor)
read(nome)

stmt -> id (args) { stmt }
      | pin(id, num, id)
      | read(id)
      | write(id, bool)
```

## Exemplos de Código

Apresentação dos exemplos de código que demonstrem as funcionalidades da linguagem criada. Esses exemplos abranger diferentes aspectos da linguagem, como declaração de variáveis, expressões matemáticas, e interação com hardware.


### Exemplo *.Cpy:
```python
// Declara uma variável inteira
numero: int = 10;
led_on: int = 1;
led_off: int = 0;

// Declara uma variável real
pi: float16 = 3.14159;

// Declara uma variável booleana
ligado: bool = true;

// Declara uma função para somar dois números
def somar(a: int, b: int) -> int: {
    return a + b;
}

// Declara uma função para calcular a área de um círculo
def area_circulo(raio: float16) -> float16: {
    return PI * raio * raio;
}
```

#### Interação com Hardware
```python
// Declara um pino como saída
pin(led, GPIO_2, GPIO_OUT);

// Escreve um valor no pino
write(led, 1);

// Lê um valor do pino
read(led);

// Declara uma função para ligar o LED
def ligar_led() -> void: {
    write(led, 1);
}

def desligar_led() -> void: {
    write(led, 0);
}

def led(estado: int) -> void: {
    if (estado == 1): {
        // liga o LED
        ligar_led();
    }
    else: desligar_led();
}

def main() -> int: {
    if (read(led) == 0): {
        led(1);
    }
    else: led(0);

    return 0;
}
```

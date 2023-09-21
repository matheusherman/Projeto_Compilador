# Fase 1 - Definição da Linguagem e Análise Léxica

# Alunos
**`ERICK LEMMY DOS SANTOS OLIVEIRA`**<br>
**`GABRIELLE BATISTA GARCIA`**<br>
**`LEANDRO RICARDO GUIMARÃES`**<br>
**`MATHEUS HERMAN BERNARDIM ANDRADE`**<br>

## Descrição da Fase

A Fase 1 deste projeto tem como objetivo principal a criação de uma linguagem de programação que permita a criação de programas destinados a sistemas embarcados, como Arduino Mega, Raspberry PI, ou Tiva, baseados na tecnologia ARM e a criação do analisador lexico. A linguagem será desenvolvida a partir de um esboço inicial, com ênfase na interação com hardware, tipos de dados estáticos, manipulação de números inteiros e de ponto flutuante, além da implementação de operações matemáticas em conformidade com o padrão IEEE-754 de 16 bits, também conhecido como meia precisão.

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

A linguagem criada é baseada na sintaxe de Python, com algumas características de C, como a declaração de tipos de dados para atribuição de valor e retorno, como também a necessidade de uso do ";" e “{}”.
Abaixo são apresentadas as principais características da linguagem, com ênfase nas regras de produção expandidas e criadas para interação com o hardware.

### Bloco de Declarações

```python              
program -> block
block -> { decls stmts }
decls -> decls decl | null
decl -> type id;
params -> param, params | params | null
param -> type id
func_decl -> def id ( params ) -> type: block | def id ( params ): block
args -> arglist | expr | null
arglist -> arglist, bool | bool 
        | arglist, num | num 
        | arglist, id | id
func_call -> id ( args );
type -> int | float16 | bool | void | null
stmts -> stmts stmt | null
```

As mudanças básicas em relação ao bloco de declaração fornecido estão relacionadas à expansão da sintaxe para acomodar a criação de funções, a introdução de parâmetros de função e alterações na forma de uso, a seguir são apresentadas as principais alterações. 

1. **Adição de Funções e Parâmetros**:
   - A produção `func_decl` foi introduzida para permitir a declaração de funções com parâmetros e tipo de retorno.
   - A produção `params` foi adicionada para definir a lista de parâmetros em uma função.
   - A produção `param` permite a definição de parâmetros de função com seu tipo e nome.
   - A produção `func_call` foi introduzida para representar a possibilidade da chamada de uma funçao dentro de um bloco de stmt.

2. **Tipo Básico**:
   - A produção `type` continua a permitir tipos básicos, como `int`, `float16`, `bool` e pode ser `void` (nulo) sem retorno.

3. **Identificadores**:
   - A produção `id` permanece semelhante, permitindo identificadores compostos por letras maiúsculas e minúsculas, bem como dígitos numéricos, porem serve para representar entidades no código, como funções.

4. **Outras Instruções**:
   - A produção `stmt` foi expandida para acomodar instruções específicas relacionadas ao hardware e funções.

5. **Blocos de Função**:
   - As produções `func_decl` e `block` são usadas para definir o escopo de uma função, incluindo a lista de parâmetros e o corpo da função.

### Lexema Basico

```python
stmt -> assign
      | func_decl
      | return_stmt
      | func_call
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
      | delay(num)
var -> var | id
     | var [ bool ] | id
return_stmt -> return expr;
assign -> var: type = expr | var [ bool ] = expr;
```

As mudanças básicas em relação ao lexema básico fornecido estão relacionadas à expansão da sintaxe e adição de instruções específicas para interação com hardware. A seguir são apresentadas as principais adições:

1. **Adição de Retorno**:
   - A produção `return_stmt` foi introduzida para representar a possibilidade de retorno dentro de um bloco de estado.

2. **Comunicacao com hardware**:
   - A instrução `pin(id, num, id)` foi adicionada e permite definir o valor de um pino digital.
   - A instrução `write(id, bool)` foi adicionada e permite escrever um valor booleano em um pino digital.
   - A instrução `delay(num)` foi introduzida e permite definir um tempo de interrupção no hardare ou seja um tempo de delay na execução.
   
3. **Identificadores**:
   - A produção `var` foi criada para representar uma variável, que é um tipo específico de entidade que pode armazenar e conter valores. Variáveis têm um nome (representado por um `id`) e um tipo de dados (representado por `type` na gramática). `var` é usado para definir e trabalhar com variáveis dentro das regras gramaticais.

4. **Outras Instruções**:
   - A produção `stmt` foi expandida para acomodar instruções específicas relacionadas ao hardware e funções.
   - A produção `assign` foi introduzida para representar a atribuicao de valor a uma `decl` dado pelo nome `var` seguido do `type` após `:` e a `expr` ou valor a ser atribuido.


### Regra de Produção para Expressões
```python
bool -> bool || join | join
join -> join && equality && equality
equality -> rel ( == | != ) rel
rel -> expr (< | <= | >= | >) expr
expr -> term ( + | - ) term
term -> unary ( * | / | %) unary
unary -> ( ! | - ) unary | ++var | --var | var++ | var-- | factor 
factor -> ( bool ) | var | num | real | true | false
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
O tratamento das letras e numeros, é efetuada a partir de regras quem definem como um elemento pode ser substituído por outro, permitindo a construção e interpretação de estruturas dentro desse sistema. Essas regras são fundamentais para a compreensão e manipulação de dados e instruções no contexto em que são aplicadas

1. **NONE**
 - Indica que o elemento "None" deve ser transformado em "null". Isso pode ser usado para representar a ausência de valor.  
2. **FEXP**
 -  pode ser transformado em duas formas diferentes, "down DIFITSF" ou "up DIFITSF". Essa produção parece estar relacionada com alguma representação de valores numéricos ou direções.
3. **letters [aA-zZ]**
 -  São representado por letras maiúsculas ou minúsculas de "a" a "z" (ou "A" a "Z"). 
4. **DIFITSF**
  -  transformada em diferentes formas, dependendo do contexto. Pode ser transformada em "DIGITSF DIGITS", em "None" ou em "FEXP
5. **DIGITS**   
  - Pode pode ser introduzido com um sinal de mais ou menos ("-+" é usado como um possível sinal) ou apenas por um número.
6. **int**
  -  se refere à representação de números inteiros em algum contexto.
7. **float16**
   -  Se refere à representação de números de ponto flutuante com 16 bits de precisão no padrao IEEE-754 em algum contexto.
8. **bool**
   - Se refere a reprensentação de boleanos 0 "false" 1 "true"
9. **minus**
    - Referente à representação de números negativos.
10. **plus**
    - Referente à representação de números positivos
    
A seguir pode ser analizada a tabela, bem como a representação em ascii dos caracteres

| Produção    | Regra de Produção                        |
|-------------|------------------------------------------|
| None        | None -> null                             |
| FEXP        | FEXP -> down DIFITSF                     |
|             | FEXP -> up DIFITSF                       | # 65 to 90 'A-Z' and 97 to 122 'a-z' in ascii
| letters [aA-zZ] | letters [aA-zZ]                      | 
| DIFITSF     | DIFITSF -> DIGITSF DIGITS                |
|             | DIFITSF -> None                          |
|             | DIFITSF -> FEXP                          |
| DIGITS      | DIGITS -> -+[0-9]                        | # 43,45, 48 to 57 in ascii
|             | DIGITS -> num [0-9]                      | # 48 to 57 in ascii
| int         | int -> inteiro                           |
| float16     | float16 -> real                          |
| bool        | bool -> [0-1]                            | # 0 and 1 in ascii
| minus       | minum -> -                               | # 45 in ascii  
| plus        | plus-> +                                 | # 43 in ascii  


### Comunicação com Hardware

Para comunicaçao com o hardware foram criadas e adicionadas as seguintes regras ao lexema basico as quais já foram comentadas anteriormente:

```python
pin(nome, pino, direcao)
write(nome, valor)
read(nome)
delay(ms)

stmt -> id (args) { stmt }
      | pin(id, num, id)
      | read(id)
      | write(id, bool)
      | delay(num)
```

## Exemplos de Código

Aqui estão alguns exemplos de código que demonstram as funcionalidades da linguagem criada, abrangendo diferentes aspectos, como declaração de variáveis, expressões matemáticas e interação com hardware

#### 1. Exemplo Basico*.Cpy:
```python
// Este e um comentario

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

def main() -> int: {
    soma: int = somar(numero, numero);
    return 0;
}

```

#### 2. Interação com Hardware
##### 2.1 - Exemplo 1: Piscar led com intervalo de 1s
```python
// Declara um pino como saída
pin(led, GPIO_2, GPIO_OUT);

def main() -> int: {
    while (true): {
        // Lê o estado atual do LED
        estado_led: int = read(led);
        
        // Inverte o estado do LED
        if (estado_led == 0):
            write(led, 1);
        else:
            write(led, 0);
        
        // Aguarda 1 segundo
        delay(1000);
    }
    return 0;
}
```

##### 2.2 - Exemplo 2: Controle de LED com botão
```python
// Declara um pino como saída para o LED
pin(led, GPIO_2, GPIO_OUT);

// Declara um pino como entrada para o botão
pin(botao, GPIO_3, GPIO_IN);

def main() -> int: {
    while (true): {
        // Lê o estado atual do botão
        estado_botao: int = read(botao);
        
        // Se o botão estiver pressionado, alterna o estado do LED
        if (estado_botao == 1): {
            estado_led = read(led);
            if (estado_led == 0):
                write(led, 1);
            else:
                write(led, 0);
        }
        
        // Aguarda um curto período de tempo para evitar leituras múltiplas do botão
        delay(100);
    }
    return 0;
}
```

#### 2.3 - Exemplo 3: Controle de Intesidade do LED com Potenciometro 
```python
// Declara um pino como saída para o LED
pin(led, GPIO_2, GPIO_OUT);

// Declara um pino como entrada analógica para o potenciômetro (ADC)
pin(potenciometro, ADC_0, GPIO_IN);

def ler_valor_potenciometro() -> int: {
    // Lê o valor analógico do potenciômetro (0-1023)
    valor: int = read(potenciometro);
    return valor;
}

def ajustar_brilho_led(valor_potenciometro: int) -> void: {
    // Converte o valor do potenciômetro para um valor de brilho (0-1)
    brilho: float16 = valor_potenciometro / 1023.0;
    
    // Define o brilho do LED com base no valor do potenciômetro
    write(led, brilho);
}

def main() -> int: {
    while (true): {
        // Lê o valor atual do potenciômetro
        valor_potenciometro: int = ler_valor_potenciometro();
        
        // Ajusta o brilho do LED com base no valor do potenciômetro
        ajustar_brilho_led(valor_potenciometro);
        
        // Aguarda um curto período de tempo antes da próxima leitura
        delay(100);
    }
    return 0;
}
```


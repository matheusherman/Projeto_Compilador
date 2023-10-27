// Este eh um comentario

// Declarando variáveis
numero1: int = 10;
numero2: int = 5;
resultado: int;
pi: float16 = 3.14159;
ligado: bool = true;
desligado: bool = !(ligado);

// Realizando operações aritméticas
resultado = numero1 + numero2;
diferenca: int = numero1 - numero2;
produto: int = numero1 * numero2;
quociente: int = numero1 / numero2;

// Realizando comparações
igual: bool = (numero1 == numero2);
diferente: bool = (numero1 != numero2);
menor: bool = (numero1 < numero2);
maior: bool = (numero1 > numero2);
menor_igual: bool = (numero1 <= numero2);
maior_igual: bool = (numero1 >= numero2);

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
    return 1;
}
// Declara uma variável booleana
ligado: bool = true;

// Declara uma variável real
num: int = 69;
PI: float16 = 3.14159;

def soma(a: float16, b: float16) -> float16: {
    return a + b;
}

// Declara uma função para calcular a área de um círculo
def area_circulo(raio: float16) -> float16: {
    return PI * raio * raio;
}

def main() -> int: {
    for (int i = 0; i <= total; i = i + 1): {
        if (i == 5) : {
            circle_area: float16 = area_circulo(3);
        } else: {
            res = soma(num, num);
        }        
    }
    return 0;
}

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
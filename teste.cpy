// Este e um comentario

// Declara uma variável inteira
numero: int = 10;
led_on: int = 1;
led_off: int = 0;

// Declara uma variável real
pi: float16 = 3.14159;

// Declara uma variável booleana
ligado: bool = true;

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
    while (ligado): {
        if (read(led) == 0): {
            led(1);
        }
        else: led(0);
        delay(1000);        
    }

    return 0;
}

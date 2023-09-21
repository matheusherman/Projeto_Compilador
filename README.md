# Projeto Compilador

Este é o repositório do projeto disciplinar de compilador para a disciplina de Compiladores, realizado no segundo semestre de 2023. O projeto envolve a criação de um compilador para uma linguagem de programação destinada a sistemas embarcados baseados na tecnologia ARM, como Arduino Mega, Raspberry Pi e Tiva.

O projeto será desenvolvido em 3 etapas, desde a definição da linguagem até a geração de código Assembly para a plataforma escolhida.

## Equipe

- [Erick Lemmy dos Santos Oliveira](https://github.com/eriklemy/Compilador)
- Gabrielle Batista Garcia
- Leandro Ricardo Guimarães 
- [Matheus Herman](https://github.com/matheusherman/Projeto_Compilador#readme)

# Objetivo

O objetivo deste projeto é desenvolver um compilador para uma linguagem de programação voltada para sistemas embarcados. Os alunos terão a oportunidade de aprimorar suas habilidades de programação, compreender os conceitos de análise léxica, sintática e semântica, e gerar código Assembly para a plataforma de destino.
Descrição do Trabalho

O projeto está dividido em três fases, cada uma com entregas específicas:

# [Fase 1 - Definição da Linguagem e Análise Léxica](https://github.com/matheusherman/Projeto_Compilador/tree/Fase-1) 

Nesta fase, o objetivo é criar uma linguagem de programação que permita a interação com hardware, como leitura e escrita em pinos do microcomputador, portas seriais e componentes opcionais, como conversores digital-analógico e analógico-digital. A linguagem deve ser definida a partir de um esboço inicial e seguir as normas da ABNT para documentação. Além disso, será necessário criar um analisador léxico capaz de validar os lexemas da linguagem.

# Fase 2 - Verificação de Código - Análise Sintática e Semântica

Na segunda fase, os alunos devem implementar um analisador sintático, utilizando técnicas como LL1 ou LR1, e uma estrutura baseada em cálculo de sequentes para a verificação dos tipos de identificadores, valores e expressões da linguagem. Também é possível utilizar o Antlr para gerar o analisador sintático, mas a análise semântica deve ser implementada manualmente.

# Fase 3 - Geração de Código

Na terceira e última fase, os alunos devem criar um sistema capaz de gerar código Assembly a partir da árvore sintática gerada na fase anterior. O código Assembly será utilizado para a execução do programa na plataforma de sistemas embarcados escolhida. Os alunos podem desenvolver suas próprias ferramentas para a conversão do Assembly em binário e execução no hardware ou utilizar um ambiente de desenvolvimento específico.

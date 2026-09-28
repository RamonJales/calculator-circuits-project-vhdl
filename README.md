# Calculadora de Soma e Subtração em VHDL

Projeto VHDL estrutural (totalmente combinacional) de uma calculadora simples para operações de adição e subtração com operandos de um dígito decimal (0-9).

## Estrutura dos Arquivos

* `kbd_encoder.vhd`: Codificador de teclado. Recebe as teclas `0-9` para o operando A, `0-9` para o operando B, além das teclas `ADD` e `SUB`. Gera sinais binários de 4 bits (`A[3:0]`, `B[3:0]`) e o sinal de operação `OP` (1 = ADD, 0 = SUB).
* `full_adder.vhd`: Somador completo de 1 bit (componente auxiliar da ALU).
* `soma_sub.vhd`: Somador/subtrator implementado estruturalmente com *full-adders* em cascata (*ripple-carry*). Expande os operandos para 6 bits e utiliza a lógica de Complemento de 2 para realizar subtrações.
* `bcd7seg.vhd`: Decodificador binário-para-decimal destinado a dois displays de 7 segmentos. Identifica resultados negativos (acionando o traço central `-` no dígito mais significativo) e converte o valor absoluto do resultado para os pinos do display de unidades e dezenas.
* `top_calculator.vhd`: Entidade *Top-Level* que instancia e interliga todos os três módulos acima.
* `tb_calculator.vhd`: *Testbench* automatizado com os cenários de validação.

## Arquitetura e Limites

* **Entradas:** Operandos decimais de 0 a 9 (codificados em 4 bits).
* **Processamento (ALU):** Opera internamente com vetores de 6 bits em complemento de 2, garantindo suporte seguro para a faixa máxima e mínima de resultados sem *overflow*.
* **Faixa Suportada:** Os resultados podem variar de `-9` (ex: 0 - 9) até `+18` (ex: 9 + 9).

## Como Executar e Simular (How to Run)

O projeto é inteiramente descritivo em VHDL e pode ser simulado em suítes padrão da indústria (Quartus, Vivado) ou simuladores open-source (GHDL + GTKWave).

# 1. Analisa (compila) todos os arquivos .vhd do diretório atual
ghdl -a *.vhd

# 2. Elabora a entidade do testbench (cria o executável da simulação)
ghdl -e tb_calculator

# 3. Executa a simulação e gera o arquivo de captura de ondas (.vcd)
ghdl -r tb_calculator --vcd=resultado.vcd

# 4. Abre a interface gráfica para visualizar os LEDs dos displays
gtkwave resultado.vcd

## Casos de Teste (Testbench)

O *testbench* automatizado (`tb_calculator.vhd`) aplica os estímulos diretamente nas entradas do teclado, simulando o apertar (`'1'`) e soltar (`'0'`) dos botões para os seguintes cenários:
1. `7 + 3 = 10`
2. `9 - 2 =  7`
3. `5 + 5 = 10`
4. `8 - 8 =  0`

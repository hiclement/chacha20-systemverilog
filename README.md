# ChaCha20 en SystemVerilog

Modélisation matérielle du chiffrement par flux **ChaCha20** (RFC 7539) en **SystemVerilog**, simulée et validée sous **ModelSim** à l'aide de testbenchs dédiés à chaque module.

📄 Rapport complet : [`docs/ChaCha20_rapport.pdf`](docs/ChaCha20_rapport.pdf)

## Principe

ChaCha20 est un algorithme de chiffrement symétrique conçu par Daniel J. Bernstein. Il opère sur un état de 512 bits (matrice 4×4 de mots de 32 bits) et n'utilise que des **additions modulo 2³², rotations et XOR** (structure ARX), sans S-box, ce qui le rend naturellement résistant aux attaques par canaux cachés liées aux tables de substitution.

Le keystream est obtenu après 20 rondes (10 en colonne, 10 en diagonale) puis addition avec l'état initial ; le chiffrement est le XOR du keystream avec le texte clair.

## Architecture

Chaque brique est développée puis validée indépendamment avant intégration :

| Module | Rôle |
|---|---|
| `arx` | Addition, rotation, XOR : brique élémentaire |
| `quarter_round` | Quart de ronde opérant sur 4 mots |
| `round_colonne` + rotation de lignes | Rondes en colonne et en diagonale (`COL2DIAG` / `DIAG2COL`) |
| `chacha_bloc` | 20 rondes + addition finale : génération du keystream |
| FSM | Séquencement des états du calcul |
| `compteur_init` | Compteur de rondes / initialisation |
| `reg512` | Registre du keystream |
| `xor_module` | XOR keystream / texte clair |
| `chacha20_top` | Intégration complète |

## Résultats

La simulation du top-level produit les impulsions attendues de `cipher_valid_o`, et la sortie `cipher_o` correspond aux vecteurs de test de référence.

| Quarter round | Simulation complète |
|---|---|
| ![Quarter round](report/figures/quarterroundtb.png) | ![Top-level](report/figures/testbenchtop.png) |

## Structure du dépôt

```
SRC/RTL/     modules SystemVerilog (arx, quarter_round, round_colonne, rotation,
             chacha_bloc, FSM, compteur_init, reg512, xor_module, chacha20_top...)
SRC/BENCH/   testbenchs de chaque module
docs/        rapport (PDF + source LaTeX + figures)
compile_src.sh   compilation et simulation sous ModelSim
init_modelsim.sh chargement de l'environnement ModelSim
```

## Simulation

```bash
source init_modelsim.sh   # charge ModelSim 2020.4
./compile_src.sh          # compile RTL + testbench, lance vsim sur chacha20_top_tb
```

## Compiler le rapport

```bash
cd docs && pdflatex chacha20.tex && pdflatex chacha20.tex
```

## Auteur

Clément Greven

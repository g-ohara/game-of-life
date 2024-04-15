# game-of-life
Simulator of [Conway's Game of Life](https://conwaylife.com/wiki/). It runs on the terminal.

![image gif](https://github.com/g-ohara/game-of-life/assets/80589608/d7fbb69c-a549-4d77-8b2a-ac935cc36f76)

## Getting Started
### Setup
You need [Git](https://git-scm.com/) and [Docker](https://www.docker.com/) installed on your computer.
1. Clone this repo:
   ```sh
   git clone https://github.com/g-ohara/game-of-life.git && cd game-of-life
   ```
1. Run container:
   ```sh
   docker compose up -d
   ```
1. Compile the app:
   ```sh
   docker compose exec haskell ghc simulator.hs
   ```
1. Then you will get the executable ```simulator``` file.
### Simulation
1. Run the app:
   ```sh
   ./simulator
   ```
1. Input the grid size (rows and cols) and the number of generations:
   ```sh
   Enter the size of the board (e.g., 10 10):
   30 50
   Enter the number of generations:
   100
   ```
1. Then, the status of cells of each generation will be displayed on the terminal.

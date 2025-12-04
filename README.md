# 🐉 Bash Adventure Game – Dice, Orcs & Survival

This repository contains a **terminal-based adventure game written entirely in Bash**.  
The player progresses by rolling dice, encounters random monsters, and must survive until reaching the end of the journey.

Your mission: **reach the finish line alive**.

---

## 🎮 How the Game Works

### ✔️ Core Mechanics
- The player **rolls 2 dice** each turn to move forward.
- Each turn has a chance of spawning a monster.
- If a monster appears:
  - The enemy attacks using the `orcoataque` function (3 dice rolls).
  - The player must defend or take damage.
- The game continues in a `while` loop until:
  - The player **wins** by reaching the end 🎉
  - The player **dies in combat** ☠️

---

## 🧩 Script Structure

### 🎲 `tirar_dados`
Rolls two dice (values from 1 to 6) to determine the player's movement.

### ⚔️ `orcoataque`
The monster rolls three dice to calculate total attack damage.

### 🎯 Randomized Events
The script uses Bash's `RANDOM` to:
- Decide if a monster appears
- Generate dice values
- Make each playthrough different

---

## ▶️ How to Run the Game

1. Make sure you are using **Linux**, **macOS**, or **Windows with WSL**.
2. Give execution permissions:

```bash
chmod +x game.sh

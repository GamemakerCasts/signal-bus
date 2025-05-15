# 📡 Signal Bus – GameMaker Implementation

This repository demonstrates how a **Signal Bus** works conceptually and how to implement it in **GameMaker** using GML.

A **Signal Bus** (also known as an Event Bus) is a powerful programming pattern that allows decoupled communication between different parts of your code. Instead of one object directly calling a method on another, it **emits a signal**, and any number of listeners can respond without the emitter needing to know who they are.

---

## 🎥 Visual Explanation

Watch the [Signal Bus Visual Explanation](./lower.mp4) to understand how it works through animation.

---

## 🧠 How It Works in GameMaker

This GameMaker script defines a `SignalBus()` object that:
- Allows listeners to **subscribe** to events (`on`)
- Supports **one-time** listeners (`once`)
- Removes listeners (`off`)
- Emits events (`emit`)
- Automatically removes listeners whose `owner_instance` is destroyed

### ✅ Features

- Event name matching (supports wildcards like `"*"`)
- Listener prioritization (higher numbers are called first)
- Safe handling of destroyed instances
- `once` support for auto-removing after firing

---

## 🧩 Example Usage in GML

```gml
global.signal_bus = new SignalBus();

// Listener
global.signal_bus.on("player_damaged", function(data) {
    show_debug_message("Player took damage: " + string(data.amount));
}, id);

// Emitter
global.signal_bus.emit("player_damaged", { amount: 10 });

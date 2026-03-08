# Android Monster

> Real-time multi-threaded particle system with 1 million Coulomb-force particles rendering chaotic emergent behavior.

---

## Screenshots

![Monster Animation](https://github.com/s4lt3d/android_monster/blob/master/monster.gif?raw=true)

![Preview](https://github.com/s4lt3d/android_monster/blob/master/preview.png?raw=true)

[Watch on YouTube](https://www.youtube.com/watch?v=ejlrw_3oFjw)

---

## Overview

An evolution of the original 2008 Processing sketch, optimized to simulate **1 million particles** in real-time using multi-threaded computation. Particles interact via Coulomb forces based on their charge type (positive, negative, neutral), creating chaotic, ever-shifting visual patterns.

The original sketch used 25,000 particles. Modern optimization with ExecutorService threading and JavaFX rendering allows scaling up 40x without losing responsiveness.

---

## Features

- **1 Million Particles** — Real-time simulation and rendering
- **Multi-Threaded Physics** — ExecutorService with 32 logical threads for parallel force calculations
- **Particle Interactions** — Coulomb-like forces between all particle pairs
- **Charge Types** — Positive, negative, and neutral particles create complex repulsion/attraction patterns
- **JavaFX Rendering** — Hardware-accelerated FX2D mode for smooth performance
- **Emergent Behavior** — No predefined patterns; complexity emerges from simple rules
- **Boundary Wrapping** — Particles recycle across screen edges

---

## Requirements

- **Processing 3.0+** (updated to use JavaFX)
- **High-performance computer** — Recommended: Multi-core processor (i9 or equivalent) for smooth 1M particle simulation
- **JavaFX library** — Included with Processing 3

---

## Usage

1. Open `android_monster.pde` in Processing 3.0 or later
2. Click Run
3. Watch the particle system emerge and evolve

Adjust `count` variable in the sketch to scale particle count based on your hardware (default: 1,000,000). Lower counts run smoothly on less powerful machines.

---

## Technical Details

- **Particle Count:** 1,000,000 (configurable)
- **Thread Pool:** 32 threads (tuned for i9 processors)
- **Rendering:** JavaFX FX2D mode
- **Display:** 1280x720

---

## Evolution

- **2008** — Original Processing sketch with 25,000 particles
- **2016** — Ported to Processing 3, JavaFX rendering added
- **2023** — Optimized to 1M particles with multi-threaded force calculation

---

## License

Copyright 2008, 2016, 2023 Walter Gordy

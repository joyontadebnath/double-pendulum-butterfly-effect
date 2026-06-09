# 🦋 Understanding the Butterfly Effect with Double Pendulum

<div align="center">

![MATLAB](https://img.shields.io/badge/MATLAB-App_Designer-orange?logo=mathworks&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

**A MATLAB App Designer simulation for visualizing chaos theory and the Butterfly Effect through double pendulum dynamics.**
</div>

---

## 📖 About

This project simulates the motion of a **double pendulum** — a classic example of a **chaotic dynamical system** to provide an intuitive, visual understanding of the **Butterfly Effect**.

The Butterfly Effect, first described by Edward Lorenz, captures the idea that a tiny difference in initial conditions can lead to vastly different outcomes over time. The double pendulum is an ideal vehicle for this demonstration because:

- It is governed by **nonlinear coupled ODEs** derived from the **Lagrangian of the system**
- Its motion is **extremely sensitive to initial conditions**
- Two nearly-identical starting configurations will diverge completely after only a short time

The project is built as a **MATLAB App Designer** application and additionally compares three numerical ODE-solving methods, showing how even small *numerical errors* can themselves act as perturbations that trigger the butterfly effect.


## ✨ Features

The app is organized into **6 interactive tabs**:

### Tab 1 — Introduction
A cover page displaying the project title and developer names.

### Tab 2 — Theoretical Background
An in-app reference covering:
- The Butterfly Effect and Chaos Theory (with real-world examples: weather, traffic, ecology, stock markets)
- Double pendulum mechanics
- Overview of the Lagrangian derivation

### Tab 3 — Single Pendulum Simulation
- Live animation of a simple pendulum
- User-configurable: mass, length, gravity, initial angle, angular velocity, simulation time, frame rate
- Color picker for the pendulum bob
- **Skip** button to jump directly to the completed trajectory

### Tab 4 — Double Pendulum Simulation
- Full real-time animation of double pendulum motion
- Simultaneous trajectory traces for both masses (M₁ and M₂)
- Fully configurable parameters including independent ball and trajectory colors
- **Skip** button

### Tab 5 — Two Double Pendulums & Butterfly Effect ⭐
- Runs **two pendulums simultaneously** with independently configurable initial conditions
- Visually demonstrates how a tiny difference (e.g. 1° change in one angle) leads to completely different trajectories
- Color-coded side-by-side trajectory comparison
- Ideal for demonstrating the butterfly effect in a classroom or presentation setting

### Tab 6 — Comparison of Iterative Methods ⭐
- Solves the same ODE system using all three methods simultaneously:
  - `ode45` — MATLAB built-in unge-Kutta 4/5 adaptive solver
  - Euler Method
  - Improved Euler Method (Heun's Method)
- Visualizes how the truncation errors of Euler-family methods act as perturbations that produce a **numerically-induced butterfly effect** in the chaotic system

## ⚙️ Physics

### Equations of Motion

The double pendulum equations of motion are derived using the **Lagrangian formulation**. The system has two degrees of freedom: θ₁ (angle of upper rod from vertical) and θ₂ (angle of lower rod from vertical). The resulting second-order ODEs are reduced to a system of four first-order ODEs.

Let the state vector be `y = [θ₁, θ̇₁, θ₂, θ̇₂]`. Then:

```
ẏ₁ = y₂

ẏ₂ = ──────────────────────────────────────────────────────────────────────
      (mA + mB)·lA − mB·lA·cos²(y₁ − y₃)

      × [ −mB·lA·y₂²·sin(y₁−y₃)·cos(y₁−y₃)
          + mB·g·sin(y₃)·cos(y₁−y₃)
          − mB·lB·y₄²·sin(y₁−y₃)
          − (mA+mB)·g·sin(y₁) ]

ẏ₃ = y₄

ẏ₄ = ──────────────────────────────────────────────────────────────────────
      lB − (mB·lB/(mA+mB))·cos²(y₁ − y₃)

      × [ lA·y₂²·sin(y₁−y₃)
          − g·sin(y₃)
          + (mB·lB/(mA+mB))·y₄²·sin(y₁−y₃)·cos(y₁−y₃)
          + g·sin(y₁)·cos(y₁−y₃) ]
```

> **Design Note:** Damping is **intentionally excluded**. With damping, all trajectories converge to zero displacement regardless of initial conditions — which would mask the butterfly effect over long time horizons.

## 📊 Numerical Methods Compared

| Method | Type | Local Error Order | Notes |
|---|---|---|---|
| `ode45` | Runge-Kutta 4/5 (adaptive step) | O(h⁵) | Most accurate; MATLAB built-in |
| Euler Method | Explicit 1st-order | O(h) | Simplest; accumulates error fastest |
| Improved Euler | Heun's Method (2nd-order) | O(h²) | Better than Euler; still diverges from ODE45 |

In a chaotic system, even the small truncation errors of Euler-family methods act as effective perturbations. Tab 6 makes this visible: three trajectories starting from *identical* initial conditions diverge purely due to solver differences — a **numerically-induced butterfly effect**.


## 🚀 Getting Started

### Requirements

- **MATLAB** (R2020b or later recommended)
  - App Designer is required to run `Project_App.mlapp`
  - No additional toolboxes required

### Running the Main App

1. Clone or download this repository
2. Open MATLAB and navigate to the `src/` folder
3. Open `Project_App.mlapp` in MATLAB App Designer
4. Click **Run ▶** in the App Designer toolbar

### Running the Standalone Scripts

```matlab
% ODE45-based simulation
run('src/Project.m')

% Euler method simulation
run('src/projects_euler_method.m')
```

---

## 🎛️ Default Parameters

| Parameter | Symbol | Default | Description |
|---|---|---|---|
| Mass A | mA | 5 kg | Mass of upper pendulum bob |
| Mass B | mB | 5 kg | Mass of lower pendulum bob |
| Length A | lA | 0.15 m | Length of upper rod |
| Length B | lB | 0.10 m | Length of lower rod |
| Initial Angle A | θ₁ | 115° | Initial angle of upper rod from vertical |
| Initial Angle B | θ₂ | 150° | Initial angle of lower rod from vertical |
| Angular Velocity A | ω₁ | 0 rad/s | Initial angular velocity of upper rod |
| Angular Velocity B | ω₂ | 0 rad/s | Initial angular velocity of lower rod |
| Gravity | g | 9.8 m/s² | Gravitational acceleration |
| Simulation Time | t | 3 s | Duration of simulation |
| Frame Rate | fps | 150 | Animation frame rate |

---

## 👥 Authors

| Name | Student ID | Contribution |
|---|---|---|
| **Joyonta Debnath** | Primary developer |
| **Md. Maksudur Rahman Turzo** | Co-developer |

## 📄 License
You are welcome to use it for educational and non-commercial purposes with attribution.


<div align="center">

Made with MATLAB | *"Does the flap of a butterfly's wings in Brazil set off a tornado in Texas?"* — Edward Lorenz

</div>


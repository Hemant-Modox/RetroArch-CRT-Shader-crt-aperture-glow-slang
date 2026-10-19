# CRT Aperture Glow Shader for RetroArch (Slang)

A highly accurate, customizable, and modern CRT post-processing shader suite for RetroArch. This shader transforms clean pixel-art emulation into an authentic retro-gaming experience by replicating the aesthetic traits of high-end vintage aperture grille monitors.

Built using the modern **Slang** format, it runs exceptionally well on performance-focused video drivers such as **Vulkan, GLCore, Direct3D 11, and Direct3D 12**.

---

## ✨ Key Features

Unlike traditional presets, this shader features dedicated **Enable/Disable toggle switches (`T_` parameters)** for every individual effect, allowing you to fine-tune your look directly from the RetroArch parameters menu without touching the code.

- 📺 **Screen Curvature & Zoom:** Replicates the physical bulb shape of classic tube TVs with custom edge smoothing.
- 🌟 **Bloom & Blur Engine:** Implements adjustable linear-light bloom and thresholds to mimic phosphor glow.
- 🧮 **Phosphor Mask Grid:** Simulates physical RGB aperture line structures.
- 🪟 **Glass Reflection:** Simulates an ambient glare map across the screen surface.
- 🎛️ **Analog Artifacts:** Emulates hardware quirks like subtle signal noise and screen flicker.
- 🎨 **Color Adjustments:** Hardware brightness boost and color saturation mapping.

---

## 📦 Included Presets

1. **`crt-aperture-glow.slangp`** - The full experience. Features prominent curved geometry, visible scanlines, vignette, and ambient screen reflections.
2. **`crt-aperture-glow-flat.slangp`** - A specialized variant tailored for flat-screen setups. Disables geometry curvature, shifts focus toward phosphor grid masks, and relaxes scanline intensities for a cleaner look.

---

## 🚀 How to Install & Use

Follow these steps to install the shader manually on your system:

### 1. Download the Files
Download the contents of this repository to your computer or device. You will need these three core files:
* `crt-aperture-glow-enhanced.slang` (The shader script)
* `crt-aperture-glow.slangp` (Standard preset)
* `crt-aperture-glow-flat.slangp` (Flat-screen variant preset)
* `GenZShader.slangp`

### 2. Place Files in RetroArch Directory
Move all three files together into your RetroArch shaders folder. The standard path depends on your Operating System:
* **Windows:** `RetroArch/shaders/shaders_slang/crt/`
* **Linux:** `~/.config/retroarch/shaders/shaders_slang/crt/`
* **Steam Version:** `Steam/steamapps/common/RetroArch/shaders/shaders_slang/crt/`
* **Android/Mobile:** If the root directory is locked due to system security permissions, go to RetroArch's **Settings > Directory > Video Shaders** and point it to a user-accessible folder (like your local `Downloads` folder), then drop the files there.

### 3. Activate the Shader in-Game
1. Launch RetroArch and ensure your video driver is set to a Slang-compatible backend (Go to **Settings > Driver > Video** and choose **Vulkan**, **GLCore**, or **D3D11/12**).
2. Boot up any game.
3. Open the **RetroArch Quick Menu** (Press `F1` on a keyboard, or press your controller hotkey combination).
4. Scroll down, select **Shaders**, and turn **Video Shaders** to **ON**.
5. Select **Load Preset**, choose `shaders_slang`, navigate to the `crt` folder (or your custom directory), and click on **`crt-aperture-glow.slangp`** or **`crt-aperture-glow-flat.slangp`**.

### 4. Save Your Custom Setup
If you like the look and want it to load automatically, go to the **Save** menu inside the Shaders window:
* **Save Global Preset:** Applies to every game you run across all emulators.
* **Save Core Preset:** Applies only to the current console emulator core (e.g., all SNES games).
* **Save Game Preset:** Applies strictly to the individual game you are playing.

💡 *Tip: For the absolute best visual fidelity and sharpest scanline tracking, enable **Integer Scaling** in your RetroArch Video settings.*

---

## 🎛️ Shader Parameters Reference Guide

This shader includes two types of parameters accessible via the RetroArch **Quick Menu > Shaders > Shader Parameters**:
1. **Value Sliders:** Control the intensity, size, or threshold of an effect.
2. **Toggle Switches (`T_` parameters):** Instantly turn a specific effect completely ON (`1.0`) or OFF (`0.0`) without losing your custom slider adjustments.

### 📺 Geometry & Screen Framing
Adjust the physical shape, sizing, and edge treatment of the virtual CRT monitor.

*   **`CURVE` (Screen Curvature):** Controls how much the screen bends to simulate a classic curved glass tube monitor. *(Default: 0.18)*
*   **`ZOOM` (Screen Zoom):** Adjusts the display scale to frame the image perfectly after applying curvature modifications. *(Default: 1.0)*
*   **`BORDER` (Black Border Size):** Sets the width of the dark frame surrounding the active gameplay viewport. *(Default: 0.035)*
*   **`CORNER` (Corner Roundness):** Curves the four inner corners of the screen to match vintage bezel cutouts. *(Default: 0.10)*
*   **`EDGE_SOFT` (Edge Smoothness):** Smooths out the transition lines along the borders to eliminate harsh pixel stairs. *(Default: 0.018)*

### ⚡ Scanlines & Phosphors
Replicate the physical beam and chemical phosphor behaviors of authentic hardware tubes.

*   **`SCAN` (Scanline Intensity):** Adjusts how dark the empty beam spaces between active horizontal lines appear. *(Default: 0.14)*
*   **`SCAN_BRIGHT` (Scanline Fade On Bright):** Dictates how much scanlines fade out in high-luminance regions, mimicking true electron beam blooming. *(Default: 0.65)*
*   **`MASK` (Phosphor Mask Strength):** Dictates the visibility of the vertical RGB aperture grille mask lines stretching across the image. *(Default: 0.12)*

### 🌟 Lighting, Blur & Glow
Control the internal light bleeding and soft diffusion of bright elements across the display.

*   **`BLUR` (Blur Amount):** Applies a localized box blur across the source texture to blend harsh pixel boundaries smoothly. *(Default: 0.35)*
*   **`BLOOM` (Bloom Strength):** Adjusts the general intensity of the light bleeding outward from bright pixels. *(Default: 0.20)*
*   **`BLOOM_RAD` (Bloom Radius):** Dictates how far the glowing light halo expands across neighboring areas. *(Default: 2.0)*
*   **`BLOOM_THR` (Bloom Threshold):** Sets the brightness cutoff point—pixels must be brighter than this value to trigger the glow engine. *(Default: 0.55)*

### 📻 Ambient Glare & Analog Artifacts
Add hardware instability and environmental variables to heighten retro immersion.

*   **`GLASS` (Glass Reflection):** Simulates a fixed, subtle room glare hitting the upper-left face of the glass screen. *(Default: 0.025)*
*   **`VIGNETTE` (Vignette):** Darkens the peripheral corners of the screen to simulate natural CRT tube light falloff. *(Default: 0.16)*
*   **`NOISE` (Noise Amount):** Superimposes an active layer of high-frequency analog signal grain across the picture. *(Default: 0.008)*
*   **`FLICKER` (Flicker):** Replicates subtle voltage/refresh fluctuations to mimic shifting 50/60Hz tube refresh cycles. *(Default: 0.003)*

### 🎨 Color & Signal Balance
Calibrate display color spaces to keep the final output vibrant and bright.

*   **`BRIGHT` (Brightness):** Boosts the overall output gamma to compensate for light lost to heavy masks and scanline passes. *(Default: 1.03)*
*   **`SAT` (Saturation):** Controls color vibrance levels, allowing for rich, deep tones or a more muted retro presentation. *(Default: 1.05)*


##
<img width="1919" height="1079" alt="crt-aperture-glow" src="https://github.com/user-attachments/assets/659020c0-fba9-4591-a88e-5fb83e751509" />
<img width="1919" height="1076" alt="crt-aperture-glow-enhanced" src="https://github.com/user-attachments/assets/9f42b32b-1cc1-42d5-a0db-88b411373ee7" />
<img width="1919" height="1079" alt="crt-aperture-glow-flat" src="https://github.com/user-attachments/assets/784b068e-4256-4a3b-a2fd-e7056d86307f" />
<img width="1919" height="1079" alt="GenZShader" src="https://github.com/user-attachments/assets/63a54eaf-1947-4385-a589-dfb712ec4879" />

**Full Changelog**: https://github.com/Hemant-Modox/RetroArch-CRT-Shader-crt-aperture-glow-slang/commits/CRT-Shader-RetroArch

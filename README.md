# PS-5--Real-Time-Object-Detection-Using-Hardware-Accelerated-CNN-on-Xilinx-Zynq-FPGA-with-Arm-
# FPGA-Accelerated Image Classification (Hybrid CPU–FPGA)

## Overview
This project implements a hybrid ARM + FPGA image classification system using a custom CNN-inspired accelerator on a Xilinx Zynq platform (PYNQ-Z2 / ZedBoard).

The FPGA accelerates feature scoring, while the ARM CPU performs preprocessing and KNN-based classification.

---

## System Architecture
- ARM CPU: Image preprocessing, dataset handling, KNN classification
- FPGA (PL): Feature scoring via custom AXI CNN IP
- Interface: AXI4-Lite
- Framework: PYNQ

---

## Dataset
- CIFAR-style dataset
- Classes used:
  - bird, cat, deer, dog, frog, horse
- Image size: 32×32
- Full dataset stored on SD card (not uploaded to GitHub)

---

## Hardware Design
- Custom CNN AXI IP
- Registers:
  - 0x04 → Input Feature
  - 0x08 → Weight
  - 0x0C → Bias
  - 0x10 → Output Score

---

## Software Flow
1. Load FPGA overlay
2. Read image from SD card
3. Extract lightweight features
4. Send features to FPGA
5. Read FPGA score
6. Classify using KNN
7. Compute accuracy

---

## Results
- Accuracy achieved: **~44%**
- Demonstrates effective HW/SW co-design under resource constraints

---

## How to Run
```bash
1. Boot PYNQ board
2. Open Jupyter Notebook
# FPGA-Accelerated Image Classification (Hybrid CPU–FPGA)

## Overview
This project implements a hybrid ARM + FPGA image classification system using a custom CNN-inspired accelerator on a Xilinx Zynq platform (PYNQ-Z2 / ZedBoard).

The FPGA accelerates feature scoring, while the ARM CPU performs preprocessing and KNN-based classification.

---

## System Architecture
- ARM CPU: Image preprocessing, dataset handling, KNN classification
- FPGA (PL): Feature scoring via custom AXI CNN IP
- Interface: AXI4-Lite
- Framework: PYNQ

---

## Dataset
- CIFAR-style dataset
- Classes used:
  - bird, cat, deer, dog, frog, horse
- Image size: 32×32
- Full dataset stored on SD card (not uploaded to GitHub)

---

## Hardware Design
- Custom CNN AXI IP
- Registers:
  - 0x04 → Input Feature
  - 0x08 → Weight
  - 0x0C → Bias
  - 0x10 → Output Score

---

## Software Flow
1. Load FPGA overlay
2. Read image from SD card
3. Extract lightweight features
4. Send features to FPGA
5. Read FPGA score
6. Classify using KNN
7. Compute accuracy

---

## Results
- Accuracy achieved: **44.333%**
- Demonstrates effective HW/SW co-design under resource constraints

---

## How to Run
```bash
1. Boot PYNQ board
2. Open Jupyter Notebook
3. Load cnn_fpga_classification.ipynb
4. Run all cells


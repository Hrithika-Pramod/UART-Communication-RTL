# UART Communication System — RTL Design & Verification

A Verilog-based UART communication system developed as a phased RTL design and verification project using Vivado/XSim.

## Project Overview

This project aims to develop a complete UART communication system progressively, starting with a UART transmitter and extending toward full-duplex communication, automated verification, buffering, error detection, and packet-level communication.

The project is being developed and verified through RTL simulation.

## Project Roadmap

| Phase | Module / Feature | Status |
|------|-------------------|--------|
| Phase 1 | UART Transmitter (TX) | ✅ Completed |
| Phase 2 | UART Receiver (RX) | 🔄 Planned |
| Phase 3 | Full-Duplex UART / Loopback | 🔄 Planned |
| Phase 4 | Self-Checking Verification | 🔄 Planned |
| Phase 5 | FIFO + Error Detection | 🔄 Planned |
| Phase 6 | Packet Protocol + CRC | 🔄 Planned |

---

# Phase 1 — UART Transmitter

### Status: ✅ Completed

The first phase implements and verifies a UART transmitter using Verilog RTL.

### Specifications

- **System clock:** 50 MHz
- **Baud rate:** 9600 bps
- **Data bits:** 8
- **Parity:** None
- **Stop bits:** 1
- **UART format:** 8N1
- **Data transmission:** LSB first
- **Design approach:** FSM-based RTL
- **Simulation:** Vivado XSim

### UART Frame

Each transmitted byte follows the standard 8N1 UART frame:

```text
Idle    Start       Data Bits (LSB → MSB)        Stop
  1       0       D0 D1 D2 D3 D4 D5 D6 D7         1

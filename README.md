# Compsys305-FlappyBird

A hardware implementation of the classic Flappy Bird game using VHDL and Verilog, designed as an educational project for digital systems design.

## Overview

This project recreates the Flappy Bird game in hardware description language (HDL), targeting FPGA execution via Intel Quartus. It demonstrates core digital design principles including state machines, input handling, collision detection, and real-time graphics rendering.

## Project Structure
├── miniproject files/ # Main project source files (VHDL/Verilog modules)
├── Quartus Files/ # Intel Quartus project configuration and settings 
├── testing number generate/ # Test benches and test number generators 
├── sends/ # Supporting files or data transmission modules 
├── Team std_logic Interim Progress Report.pdf # Detailed project documentation 
├── README.md # This file 
└── .gitignore


## Technical Details

### Language Composition
- **VHDL**: 87.9% - Primary hardware description language
- **Verilog**: 6.9% - Alternative HDL modules
- **HTML**: 4.7% - Documentation or web interface components
- **Other**: 0.5%

### Tools & Technologies
- **Intel Quartus Prime**: FPGA design environment and synthesis tool
- **VHDL/Verilog**: Hardware description languages for digital design
- **FPGA**: Target platform for hardware implementation

## Getting Started

### Prerequisites
- Intel Quartus Prime (or compatible FPGA design tool)
- VHDL/Verilog compiler and simulator
- Target FPGA board (e.g., DE2-115, Terasic board, etc.)

### Building the Project
1. Open the Quartus project file from the `Quartus Files` directory
2. Configure the project settings for your target FPGA board
3. Compile and synthesize the VHDL/Verilog source files
4. Generate a programming file (`.sof` or `.pof` format)
5. Program the FPGA board with the generated bitstream

### Running Tests
The `testing number generate` directory contains test benches and simulation modules. Use these to verify functionality before hardware deployment.

## Game Features

The implementation includes:
- **Player control**: Input handling for bird movement (typically via button or switch)
- **Game physics**: Gravity and velocity simulation for bird movement
- **Obstacle generation**: Pipe/obstacle rendering and collision logic
- **Collision detection**: Real-time collision checking with obstacles and boundaries
- **Score tracking**: Game score calculation and display
- **Graphics rendering**: Output to video display or LED matrix (FPGA-specific)

## Development Notes

This project was developed as an academic mini-project for COMP SYS 305. The "Team std_logic" interim progress report provides additional implementation details and design decisions.

### Key Modules (Typical Structure)
- **Game Controller**: Main state machine managing game flow
- **Bird Module**: Bird physics and position calculation
- **Obstacle Generator**: Pipe/obstacle generation and movement
- **Collision Detector**: Collision detection logic
- **Display Driver**: Graphics rendering to output display
- **Input Handler**: Button/switch input processing

## Hardware Requirements

- FPGA development board with adequate I/O (buttons, display output)
- Video display output capability (VGA, HDMI, or LED matrix depending on implementation)
- Typical resources: ~3,000-5,000 logic elements (varies by implementation)

## Verification

Use the included test benches in the `testing number generate` folder to simulate and verify:
- Number generation logic
- Collision detection correctness
- State machine transitions
- Display rendering accuracy

## Future Improvements

Potential enhancements could include:
- Difficulty levels and progressive speed increase
- Sound effects (audio module implementation)
- High score tracking with persistent storage
- Multiple game modes
- Enhanced graphics with more detailed sprites
- Wireless controller support

## Documentation

See `Team std_logic Interim Progress Report.pdf` for:
- Detailed design specifications
- Architecture documentation
- Implementation challenges and solutions
- Testing and validation results

## Course Information

- **Course**: COMP SYS 305 - Computer Systems Design
- **Project Type**: Mini-project / Coursework
- **Completion Date**: June 2022

## License

This project was created for educational purposes as part of COMP SYS 305 coursework.

## Contributors

Team std_logic

---

*For questions or clarifications about the project, refer to the interim progress report or contact the project team.*

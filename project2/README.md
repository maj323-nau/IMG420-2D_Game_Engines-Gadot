# Godot Assignment 2: GDExtension with CustomSprite

## Project Structure
- **src/**: Contains C++ source files for the GDExtension:
  - `gdexample.h`, `gdexample.cpp`: Define `CustomSprite` node.
  - `register_types.h`, `register_types.cpp`: Register the custom node with Godot.
- **demo/**: Godot game project, including:
  - `test_scene.tscn`: Scene demonstrating `CustomSprite` with `Label` and `Button`.
  - `bin/gdexample.gdextension`: GDExtension configuration.
  - Assets (e.g., textures, scripts).

## CustomSprite Node
- **Feature 1**: Auto-rotation with `rotation_speed` parameter (adjustable 0–10 in editor).
- **Feature 2**: Pulsing scale with `pulse_amplitude` parameter (adjustable 0–2).
- **Signal**: `pulsed` emitted at scale peak, updates Label to "Sprite pulsed!".
- **Method**: `stop_pulsing` triggered by Button, stops pulsing and resets scale.

## Demo
A YouTube Short demonstrates the `CustomSprite` functionality in `test_scene.tscn`: [Watch here](https://youtube.com/shorts/OhvF50og4mk).

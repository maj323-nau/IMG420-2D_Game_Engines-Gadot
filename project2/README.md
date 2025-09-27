# Godot Assignment 2: GDExtension with CustomSprite

## CustomSprite Node
- **Feature 1**: Auto-rotation with `rotation_speed` parameter (adjustable 0–10 in editor).
- **Feature 2**: Pulsing scale with `pulse_amplitude` parameter (adjustable 0–2).
- **Signal**: `pulsed` emitted at scale peak, updates Label to "Sprite pulsed!".
- **Method**: `stop_pulsing` triggered by Button, stops pulsing and resets scale.

#ifndef GDEXAMPLE_H
#define GDEXAMPLE_H
#include <godot_cpp/classes/sprite2d.hpp>
namespace godot {
class CustomSprite : public Sprite2D {
    GDCLASS(CustomSprite, Sprite2D)
private:
    double time_passed;
    double rotation_speed;  // Feature 1 parameter
    double pulse_amplitude; // Feature 2 parameter
    bool is_pulsing;
    double pulse_time;
protected:
    static void _bind_methods();
public:
    CustomSprite();
    ~CustomSprite();
    void _process(double delta) override;
    void set_rotation_speed(const double p_rotation_speed);
    double get_rotation_speed() const;
    void set_pulse_amplitude(const double p_pulse_amplitude);
    double get_pulse_amplitude() const;
    void stop_pulsing();
};
}
#endif
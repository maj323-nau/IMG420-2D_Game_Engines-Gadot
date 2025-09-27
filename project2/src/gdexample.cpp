#include "gdexample.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
using namespace godot;
void CustomSprite::_bind_methods() {
    ClassDB::bind_method(D_METHOD("get_rotation_speed"), &CustomSprite::get_rotation_speed);
    ClassDB::bind_method(D_METHOD("set_rotation_speed", "p_rotation_speed"), &CustomSprite::set_rotation_speed);
    ClassDB::add_property("CustomSprite", PropertyInfo(Variant::FLOAT, "rotation_speed", PROPERTY_HINT_RANGE, "0,10,0.1"), "set_rotation_speed", "get_rotation_speed");
    ClassDB::bind_method(D_METHOD("get_pulse_amplitude"), &CustomSprite::get_pulse_amplitude);
    ClassDB::bind_method(D_METHOD("set_pulse_amplitude", "p_pulse_amplitude"), &CustomSprite::set_pulse_amplitude);
    ClassDB::add_property("CustomSprite", PropertyInfo(Variant::FLOAT, "pulse_amplitude", PROPERTY_HINT_RANGE, "0,2,0.1"), "set_pulse_amplitude", "get_pulse_amplitude");
    ClassDB::bind_method(D_METHOD("stop_pulsing"), &CustomSprite::stop_pulsing);
    ClassDB::add_signal("CustomSprite", MethodInfo("pulsed"));
}
CustomSprite::CustomSprite() {
    time_passed = 0.0;
    rotation_speed = 1.0;
    pulse_amplitude = 0.5;
    is_pulsing = true;
    pulse_time = 0.0;
}
CustomSprite::~CustomSprite() {}
void CustomSprite::_process(double delta) {
    time_passed += delta;
    // Feature 1: Auto rotation
    set_rotation(get_rotation() + rotation_speed * delta);
    // Feature 2: Pulsing scale
    if (is_pulsing) {
        pulse_time += delta;
        float scale_factor = 1.0 + pulse_amplitude * sin(pulse_time * 2.0);
        set_scale(Vector2(scale_factor, scale_factor));
        if (sin(pulse_time * 2.0) > 0.99) {  // Signal at peak
            emit_signal("pulsed");
        }
    }
}
void CustomSprite::set_rotation_speed(const double p_rotation_speed) { rotation_speed = p_rotation_speed; }
double CustomSprite::get_rotation_speed() const { return rotation_speed; }
void CustomSprite::set_pulse_amplitude(const double p_pulse_amplitude) { pulse_amplitude = p_pulse_amplitude; }
double CustomSprite::get_pulse_amplitude() const { return pulse_amplitude; }
void CustomSprite::stop_pulsing() {
    is_pulsing = false;
    set_scale(Vector2(1.0, 1.0));
}
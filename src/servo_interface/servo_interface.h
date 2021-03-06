#ifndef SERVO_INTERFACE_H
#define SERVO_INTERFACE_H
#include <Servo.h>

#define AIRBRAKES_SERVO_PIN 2
#define DROGUE_SERVO_PIN 3
#define MAIN_SERVO_PIN 4

// Deploy and reset angles refer to servo positions, defined here as reset angles are required in flight_computer.ino
#define DROGUE_DEPLOY_ANGLE 30
#define DROGUE_RESET_ANGLE 145
#define MAIN_DEPLOY_ANGLE 180
#define MAIN_RESET_ANGLE 2

enum servoEnum {
    AIRBRAKES_SERVO, DROGUE_SERVO, MAIN_SERVO, NUM_SERVOS
};

void init_servo(int servo, int pin, int min_pulse, int max_pulse);

Servo* get_servo(int servo);
#endif

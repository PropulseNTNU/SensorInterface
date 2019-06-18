#ifndef AIRBRAKES_CONTROLL_H
#define AIRBRAKES_CONTROLL_H

//structs
typedef struct Parameters_t {
  float kpp;
  float kpi;
  float kpd;
}ControlParameters;


float controller(float* error, ControlParameters* parameters, float* riemann_sum, float dt);
float integrate(float prev_sum, float value, float step);
float test_calculate_area(float u);

#endif

#include "controll.h"
#include <math.h>
float integrate(float prev_sum, float value, float step){
  return prev_sum + (value * step);
}

float pros_to_deg(float prosent){
  return asin(prosent/100.0) * 180.0/M_PI;
}

float controller(float* error, ControlParameters* parameters, float* riemann_sum, float dt){ //PI-controller
  // add a lower and upper bound to prevernt overflow
  if(integrate(*riemann_sum, *error, dt) <= 40 && integrate(*riemann_sum, *error, dt) > -40){
    *riemann_sum = integrate(*riemann_sum, *error, dt); //integrates error
  }

  float prosent = (parameters->kpp*(*error)) + (parameters->kpi*(*riemann_sum));
  if (prosent > 86.6){
    return 60;
  }
  else if(prosent<0.0){
    return 0;
  }
  else {
    return pros_to_deg(prosent);
  }
}

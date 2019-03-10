#ifndef SENSOR_INTERFACE_H
#define SENSOR_INTERFACE_H

#include "Adafruit_BNO055/Adafruit_BNO055.h"
#include "BME280/SparkFunBME280.h"
#include "GPS/gps.h"
#include "sensor_data.h"

const uint8_t IMU_ADDRESS = 0x28;

/*
    Note that the IMU has declared x axis as the yaw axis, the y axis as the
    pitch axis and the z axis as the roll axis. This is corrected as:
      roll  = x axis
      pitch = y axis
      yaw   = z axis
*/
void readSensors(double *data);

//Calibrate BME pressure sensor to read 0m altitude at current location.
void calibrateAGL();

BME280* get_BME();
GPS* get_GPS();
Adafruit_BNO055* get_IMU();

#endif
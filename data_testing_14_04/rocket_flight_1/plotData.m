clear all; close all;
filename = 'DATAFILE.TXT';
delimiterIn = ',';
headerlinesIn = 0;
data = importdata(filename,delimiterIn,headerlinesIn);

%%TODO: IMU_temp = IMU_YAW

timestamp = data(:,1)-data(1,1);
time_est=timestamp(7413:7549)/1000; 
BME_temp = data(:,2);
IMU_temp = data(:,3);
BME_pressure = data(:,4);
BME_altitude = data(:,5);
IMU_acc_x = data(:,6);
IMU_acc_y = data(:,7);
IMU_acc_z = data(:,8);
IMU_roll = data(:,9);
IMU_pitch = data(:,10);
IMU_yaw = data(:,11);
IMU_mag_x = data(:,12);
IMU_mag_y = data(:,13);
IMU_mag_z = data(:,14);
IMU_roll_rate = data(:,15);
IMU_pitch_rate = data(:,16);
IMU_yaw_rate = data(:,17);
IMU_g_accel_x = data(:,18);
IMU_g_accel_y = data(:,19);
IMU_g_accel_z = data(:,20);
IMU_lin_accel_x = data(:,21);
IMU_lin_accel_y = data(:,22);
IMU_lin_accel_z = data(:,23);
IMU_quaternion_x = data(:,24);
IMU_quaternion_y = data(:,25);
IMU_quaternion_z = data(:,26);
IMU_quaternion_w = data(:,27);
states = data(:,28);

h_init=111.83;
a_init=-1.34;
v_init=51.85;
lengde= (7549-7413);
%Kalman_kopi;
dt=[];
est_v2=[];
height=BME_altitude(7413:7549);
time=0;
a=0;
for i =1:lengde
    %dt=append(dt,(time(i+1)-time(i)));
    time=(time_est(i+1)-time_est(i));
    %dif_h=height(i+1)-height(i);
    if i < lengde-2
        est_v2=[est_v2, (height(i+3)-height(i))/(time_est(i+3)-time_est(i))];
        a=a+1;
    elseif i < size(lengde)-1
        est_v2=[est_v2, (height(i+2)-height(i))/(time_est(i+2)-time_est(i))];
    else
        est_v2=[est_v2, (height(i)-height(i+1))/(time_est(i+1)-time_est(i))];
    end
            
    dt=[dt,time];
    %est_v2=[est_v2, height];
    
end
[est_h, est_v]= Kalman_kopi(height,IMU_lin_accel_y(7413:7549), time_est, lengde , h_init, v_init, dt);


filename2 = 'Eggtimer.txt';
delimiterIn2 = ',';
headerlinesIn2 = 0;
data2 = importdata(filename2,delimiterIn2,headerlinesIn2);
time_egg= data2(:,1);
h_egg= data2(:, 2);
v_egg= data2(:, 3);




figure(1);
% %plot Acceleration
% %subplot(5,1,1);
% plot(timestamp/1000, IMU_lin_accel_x,'r');
% hold on;
plot(timestamp/1000, IMU_lin_accel_y,'g');
% plot(timestamp/1000, IMU_lin_accel_z,'b');
xlabel('seconds [s]');
ylabel('acceleration [m/s^2]');
% legend('Lin\_Accel_x','Lin\_Accel_y','Lin\_Accel_z');
xlim([430,450]);
title('Accelerations');
% 
% %plot ROLL/PITCH/YAW
% %subplot(5,1,2);
figure(5);
plot(timestamp/1000, IMU_roll,'r');
hold on;
plot(timestamp/1000, IMU_pitch,'g');
plot(timestamp/1000, IMU_yaw,'b');
xlabel('seconds [s]');
ylabel('degrees [°]');
xlim([430,443]);
legend('Roll_z','Pitch_y','Yaw_x');

% title('Euler angles in body frame');
% 
% %plot altitude
% %subplot(5,1,3);
figure(2);
plot(timestamp/1000, BME_altitude);
xlabel('seconds [s]');
ylabel('height [m]');
xlim([430,500]);
legend('Altitude');
title('Altitude');


figure(3);
plot(time_est(1:136), est_h, 'LineWidth', 2); 
hold on; 
plot(time_est(1:136), BME_altitude(7413:7548), '--', 'LineWidth', 2);
% 
figure(4);
plot(time_est(1:136), est_v, 'LineWidth', 2);
hold on;
plot(time_est(1:136), est_v2, 'LineWidth', 1.5);
ylim([-10,100]); 

% figure(6);
% plot(time_egg, h_egg);
% 
% figure(7);
% plot(time_egg, v_egg);
% ylim([-10,363]);
% xlim([0,12]);
%plot states
% subplot(5,1,4);
% plot(timestamp/1000, states);
% xlabel('seconds [s]');
% ylabel('state');
% xlim([430,550]);
% legend('states');
% title('Altitude');


%plot temperature
% subplot(5,1,5);
% plot(timestamp/1000, BME_temp);
% hold on;
% plot(timestamp/1000, IMU_temp);
% xlabel('seconds [s]');
% ylabel('deg celsius [°/C]');
% legend('BME Temperature','IMU Temperature');
% xlim([430,550]);
% title('Temperature');

%Plot states

%%Program to plot the orbit of Halley's comet in MATLAB for true anomaly
%%values of 0 <= true_anomaly <= 360 degrees, along with the orbit of earth
%%on the same plot with the sun as the center. 

%INITIALIZATION
e_halley = 0.9671429; %%eccentricity of Halley's orbit.
a = 17.834144; %%semi major axis for halley's comet in AU.
e_earth = 0.0167; %%eccentricity for the orbit of Earth.
semimaj_earth = 1; %%semimajor axis for earth in AU.
true_anomaly = [0:0.005:2*pi]; %%vector containing values for the true anomaly from 0 to 360 degrees.

%CALCULATIONS
r_halley = (a * (1 - (e_halley ^2)) ./ (1 - e_halley .* cos(true_anomaly))); %%uses the conic equation as a function of the true anomaly to calculate the r value for Halley.
r_earth = (semimaj_earth * (1 - (e_earth ^2)) ./ (1 - e_earth .* cos(true_anomaly))); %%uses the conic equation as a function of the true anomaly to calculate the r value for Earth.
sun_coord = [0,0]; %%sets the position of the sun at origin.

%FIGURES
polarplot (true_anomaly, r_halley, 'r-') %%using polarplot to plot the value of r against the value of the true anomaly to find Halley's orbit.
title ("The orbit of Halley's comet and Earth with the Sun as origin") %%setting the title of the chart
grid on
hold on
polarplot (true_anomaly, r_earth, 'b-') %%using polarplot to plot the value of r against the value of the true anomaly to find Earth's orbit.
polarplot (0,0,'k*') %%plotting the position of the sun.
hold off
legend ("Halley's Orbit", 'Earth Orbit', 'Location', 'Northeast') %%making a legend to differentiate easily between orbits.

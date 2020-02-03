%% INITIALIZATION
nacatype = input("\nEnter NACA Airfoil Identifier (4-digit series code) in single inverted commas : "); %%asking for a string input containing the NACA airfoil type.
maxcamber = str2double(nacatype(1))/100; %%the parameter describing maximum camber as a percentage of the chord.
lead_dist = str2double(nacatype(2))/10; %%parameter describing the distance of the maximum camber from the airfoil leading edge. 
max_thick = str2double(nacatype(3:4))/100; %%the parameter describing the maximum thickness of the airfoil as a percentage of the chord.
datapoints = 300; %%number of data points to be plotted. An arbitrarily large number was selected.
x = linspace(0, 1, datapoints)'; %%initializing a vector containing the values for the x-axis/chord of the airfoil.
ycamber = zeros (datapoints,1); %%initializing the vector containing the values for the distance between the edge of the airfoil and the camber.
dyc = zeros (datapoints,1); %%the gradient of the camber.
theta = zeros (datapoints,1); %%initializing the value for theta. 

%% CALCULATIONS
for m = 1:1:datapoints %%starting the for loop using a counter variable.
    if (x(m) >= 0 && x(m) < lead_dist) %%plotting the part that is more than 0 but less than the leading edge distance.
        ycamber(m) = (maxcamber/(lead_dist^2)) * ((2 * lead_dist * x(m)) - x(m)^2); %%formula for y value of camber.
        dyc(m) = ((2 * maxcamber)/(lead_dist^2)) * (lead_dist - x(m)); %%formula for the gradient of the camber.
    elseif (x(m) >= lead_dist && x(m) <= 1) %%plotting the part that is more than the leading edge distance from max camber but less than 1.
        ycamber(m) = (maxcamber/((1 - lead_dist)^2)) * (1-(2*lead_dist) + (2*lead_dist*x(m)) - x(m)^2); %%formula for the y value of camber
        dyc(m) = ((2*maxcamber)/((1-lead_dist)^2)) * (lead_dist - x(m)); %%formula for the gradient of the camber
    end
    theta(m) = atan(dyc(m)); %%formula for theta
end

xupper = zeros (datapoints,1); %%initializing the vector containing the values for the positive x values of the airfoil.
yupper = zeros (datapoints,1); %%initializing the vector containing the values for the positive y values of the airfoil.
xlower = zeros (datapoints,1); %%initializing the vector containing the values for the negative x values of the airfoil.
ylower = zeros (datapoints,1); %%initializing the vector containing the values for the negative y values of the airfoil.
ythick = zeros (datapoints,1); %%vector for the thickness of the airfoil.
for m = 1:1:datapoints
    ythick(m) = 5*max_thick*((0.2969 * sqrt(x(m))) + (-0.126 * x(m)) + (-0.3516 * (x(m)^2)) + (0.2843 * (x(m)^3)) + (-0.1036 * (x(m)^4))); %%calculation for airfoil thickness along the airfoil chord.
    xupper(m) = x(m) - ythick(m) * sin(theta(m)); %%calculation for the positive x values of the airfoil.
    yupper(m) = ycamber(m) + ythick(m) * cos(theta(m)); %%calculation for the positive y values of the airfoil.
    xlower(m) = x(m) + ythick(m) * sin(theta(m)); %%calculation for the negative x values of the airfoil.
    ylower(m) = ycamber(m) - ythick(m) * cos(theta(m)); %%calculation for the negative y values of the airfoil.
end

%% PLOTS
figure(1)
plot (xupper, yupper, 'r-') %%plotting the upper half of the airfoil
title (sprintf("NACA %s AIRFOIL", nacatype)) %%Labelling the NACA code
hold on
grid on
axis equal
plot (xlower, ylower, 'b-') %%plotting the lower half of the airfoil.
plot (x, ycamber, 'k-') %%plotting the camber and chords of the airfoil. 






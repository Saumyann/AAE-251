%%asking for user inputs for design parameters.
range = input("Enter range of aircraft in nautical miles: "); %%range input
payload_weight = input("Enter payload weight in lb: "); %%payload weight input
engine_type = input("Enter engine type: "); %%engine type input
crew = input("Enter crew weight in lb: "); %%crew weight input
l_d = input("Enter L/D value for the aircraft: "); %%l/d input.
c_value = input("Enter C value for aircraft for empty weight fraction: ");

%%selection structures to check which engine type the plane is and to
%%assign sfc and l/d values accordingly.
if strcmpi(engine_type, "Pure turbojet") == 1 
    sfc_cruise = 0.9 * (1/3600); %%assigning the value for sfc cruise for every plane.
    sfc_loiter = 0.8 * (1/3600); %%assigning the value for sfc loiter for every plane.
    ld_cruise = 0.866 * l_d; %%assigning the value for ld cruise for every plane.
    ld_loiter = l_d; %%assigning the value for ld loiter for every plane.
elseif strcmpi(engine_type, "Low-bypass turbofan") == 1
    sfc_cruise = 0.8 * (1/3600);
    sfc_loiter = 0.7 * (1/3600);
    ld_cruise = 0.866 * l_d;
    ld_loiter = l_d;
elseif strcmpi(engine_type, "High-bypass turbofan") == 1
    sfc_cruise = 0.5 * (1/3600);
    sfc_loiter = 0.4 * (1/3600);
    ld_cruise = 0.866 * l_d;
    ld_loiter = l_d;
elseif strcmpi(engine_type, "Piston-prop (fixed pitch)") == 1
    sfc_cruise = 0.4 * (1/3600);
    sfc_loiter = 0.5 * (1/3600);
    ld_loiter = 0.866 * l_d;
    ld_cruise = l_d;
elseif strcmpi(engine_type, "Piston-prop (variable pitch)") == 1
    sfc_cruise = 0.4 * (1/3600);
    sfc_loiter = 0.5 * (1/3600);   
    ld_loiter = 0.866 * l_d;
    ld_cruise = l_d;
elseif strcmpi(engine_type, "Piston-prop (fixed pitch)") == 1
    sfc_cruise = 0.5;
    sfc_loiter = 0.6;
    ld_loiter = 0.866 * l_d;
    ld_cruise = l_d;
else 
    fprintf ("Check engine type input. Make sure it is in string format."); %%outputting error message if unidentified engine type is entered.
end

%%Conversions and calculations
range = range * (9114000 / 1500); %%converting from nautical miles into feet. 
vel = input("Enter velocity in Mach: "); %%asking for velocity input and converting into ft/s
velocity = vel * 994.8;
endu_one = input("Enter the first endurance/loiter time in hours: "); %%asking for endurance input for first loiter and converting into seconds.
endurance_one = endu_one;
endu_two = input("Enter the second endurance/loiter time in hours: "); %%asking for endurance input for second loiter and converting into seconds.
endurance_two = endu_two;
cruise_fraction = exp((- range * sfc_cruise) / (velocity * ld_cruise)); %%calculating the value of the first cruise fraction.
loiter_fraction = exp((-endurance_one * sfc_loiter) / ld_loiter); %%calculating the value of the first loiter fraction.
cruise_two = cruise_fraction; %%value for the second cruise fraction.
loiter_two = exp((-endurance_two * sfc_loiter) / ld_loiter); %%value for the second loiter fraction.
a = 0.93; %%setting the value for a for the statistical empty weight fraction.
warm_take = 0.970; %%setting the value for the weight fraction for warmup and takeoff.
climb = 0.985; %%setting the value for the weight fraction for climb phase.
landing = 0.995; %%setting the value for the weight fraction for landing phase.
msf = warm_take * climb * cruise_fraction * loiter_fraction * cruise_two * loiter_two * landing; %%calculating the total mission segment weight fraction.
fuel_fraction = 1.06 * (1 - msf); %%calculating the fuel fraction.

w_guess = 50000; %%guessing the value for the takeoff weight.
sef = a * (w_guess ^ c_value); %%calculating the value for the empty weight fraction based off the guessed value.
w_gross = (payload_weight + crew) / (1 - fuel_fraction - sef); %%calculating the gross takeoff weight using the estimated value.
while w_gross ~= w_guess 
    w_guess = w_gross; %%setting the estimated value equal to the calculated value and running it through a loop until the iterations of both variables return the same value.
    sef = a * (w_guess ^ c_value);
    w_gross = (payload_weight + crew) / (1 - fuel_fraction - sef);
end

    
    
    



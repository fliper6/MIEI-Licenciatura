function[dy] = eqdif(~,y)
dy = 2*y*((92-y)/92);
end

%[x,y] = ode45('eqdif', [0 1 2 3], 10);
%[x,y]

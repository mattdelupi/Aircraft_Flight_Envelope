function [V, n] = gust(VA, VC, VD, G, h, CLa, S, W, cr, tap)
    %% USEFUL CONSTANTS %%
    rho0 = 1.225;
    knot_mps = .514444;
    p0 = 101325;
    T0 = 288.15;
    g = 9.805;
    L = .0065;
    R = 287.05;
    FL_m = 30.48;
    deg_rad = .0174532925;
    sqfoot_sqmeter = .092903;
    lb_kg = .453592;
    feet_m = .3048;
    MAC = 2/3 * cr * (tap^2+tap+1) / (tap+1);
    
    %% CONVERSION %%
    VD = VD * knot_mps;
    VC = VC * knot_mps;
    VA = VA * knot_mps;
    h = h * FL_m;
    CLa = CLa / deg_rad;
    S = S * sqfoot_sqmeter;
    W = W * lb_kg * g;
    MAC = MAC * feet_m;
    
    %% GUST FACTORS %%
    rho = p0 / (R * T0) * (1 - L* h / T0)^(g/(R*L) - 1);
    mu = 2 * W / (S * rho * g * MAC * CLa);
    Kg = .88 * mu / (5.3 + mu);
    
    %% PLOT %%
    n = 1;
    V = [VA VC VD];
    
    for i = 1:3
        n = [n 1+CLa*.5*rho0*V(i)*G(i)*S*Kg/W];
    end
    
    V = [V flip(V)];
    G = flip(G);
    for i = 1:3
        n = [n 1-CLa*.5*rho0*V(i+3)*G(i)*S*Kg/W];
    end
    
    n = [n 1 n(3) n(6) n(1) n(4) n(5) n(1)];
    V = [0 V 0];
    V = [V V(3) V(6) V(1) V(4) V(5) V(1)];
    
    text(.35*V(2), 1.4*(1+.5*(n(2)-1)), 'Lines relative to gusts of:', 'Color', 'r')
    for i = 1:3
        text(.6*V(i+1), 1.11*(1+.6*(n(i+1)-1)), [num2str(G(4-i)) ' m/s'], 'Color', 'r')
    end
    
    plot(V, n, 'r-.');
end
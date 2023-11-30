function [V, n] = maneuvering(VA, VC, VD, nmax_p, nmax_n, S, W)
    %% USEFUL CONSTANTS %%
    rho0 = 1.225;
    knot_mps = .514444;
    sqfoot_sqmeter = .092903;
    lb_kg = .453592;
    
    %% CONVERSION %%
    VD = VD * knot_mps;
    VC = VC * knot_mps;
    VA = VA * knot_mps;
    S = S * sqfoot_sqmeter;
    W = W * lb_kg;
    
    %% AERODYNAMIC LIMIT %%
    CLmax_p = 2 * nmax_p * W / (rho0 * S * VA^2);
    VS_p = sqrt(2 * W / (rho0 * S * CLmax_p));
    VS_n = 1.15 * VS_p;
    CLmax_n = -2 * W / (rho0 * S * VS_n^2);
    VA_n = sqrt(2 * nmax_n * W / (rho0 * S * CLmax_n));
    
    N = 200;
    Vp = linspace(VS_p, VA, N);
    Vn = linspace(VS_n, VA_n, N);
    na_p = CLmax_p * .5 * rho0 * Vp.^2 .* S ./ W;
    na_n = CLmax_n * .5 * rho0 * Vn.^2 .* S ./ W;

    %% PLOT %%
    V = [Vp VD VD VC flip(Vn) VS_n VS_p VS_p];
    n = [na_p nmax_p 0 nmax_n flip(na_n) 0 0 1];
    plot(V, n, 'k-', 'LineWidth', 1.5);
end
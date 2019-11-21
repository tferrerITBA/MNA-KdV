% Returns the solution for the non-linear part of the KdV equation (RK4)
function U = non_linear(U, k, h)
    f = - 3i * k * h;
    a = f .* fast_ft(real(inv_fft(U)).^2);
    b = f .* fast_ft(real(inv_fft(U + a/2)).^2);
    c = f .* fast_ft(real(inv_fft(U + b/2)).^2);
    d = f .* fast_ft(real(inv_fft(U + c)).^2);
    U = U + (a + 2*(b + c) + d) / 6; % phi_0
end

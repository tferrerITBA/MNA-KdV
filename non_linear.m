%linear Returns the solution for the non-linear part of the KdV equation
function U = non_linear(U, k, h)
    %sz = size(U);
    %U = U - (3i * k * h) .* fast_ft((real(inv_fft(U, sz(2)))).^2, sz(2)); % phi_0
    U = U - (3i * k * h) .* fft((real(ifft(U))).^2); % phi_0
end

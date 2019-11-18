%linear Returns the solution for the non-linear part of the KdV equation
function U = non_linear(U, k, h)
  U = U - (3i * k * h) .* fast_ft((real(inv_fft(U))).^2); % phi_0
end

%linear Returns the solution for the non-linear part of the KdV equation
function U = non_linear(U, k, h)
  U = U - (3i * k * h) .* fft((real(ifft(U))).^2); % phi_0
end

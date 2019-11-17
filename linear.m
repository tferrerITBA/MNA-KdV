function U = linear(U, k, h)
  U = U .* exp(1i * k.^3 * h); % phi_1
end

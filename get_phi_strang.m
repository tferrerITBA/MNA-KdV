function Y = get_phi_strang(U, k, delta_t, m, is_plus, counter)
  if is_plus
    Y = U - (3i * k * ((delta_t/2)/m)) .* fft((real(ifft(U))).^2); % phi_0 -- no lineal
    Y = Y .* exp(1i * k.^3 * (delta_t/m)); % phi_1 -- lineal
    Y = Y - (3i * k * ((delta_t/2)/m)) .* fft((real(ifft(Y))).^2); % phi_0 de nuevo -- no lineal
  else
    Y = U .* exp(1i * k.^3 * ((delta_t/2)/m)); % phi_1 -- lineal
    Y = Y - (3i *k * (delta_t/m)) .* fft((real(ifft(Y))).^2); % phi_0 -- no lineal
    Y = Y .* exp(1i * k.^3 * ((delta_t/2)/m)); % phi_1 de nuevo -- lineal
  end

  if counter ~= 1
    Y = get_phi_strang(Y, k, delta_t, m, is_plus, counter-1); 
  end

end

function Y = get_phi(U, k, delta_t, m, is_plus, counter)
  if is_plus
    Y = U.*exp(1i*k.^3*(delta_t/m)); % phi_1 -- lineal
    Y = Y  - (3i*k*(delta_t/m)).*fft((real(ifft(Y))).^2); % phi_0 -- no lineal
  else
    Y = U  - (3i*k*(delta_t/m)).*fft((real(ifft(U))).^2); % phi_0 -- no lineal
    Y = Y.*exp(1i*k.^3*(delta_t/m)); % phi_1 -- lineal
  endif
  
  if counter != 1
    Y = get_phi(Y, k, delta_t, m, is_plus, counter-1); 
  endif
  
endfunction

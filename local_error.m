% Variar orden al insertar parametros
delta_t = 1e-05;
U1 = kdv(delta_t);
U2 = kdv(delta_t);
%sz = size(U);
u1 = real(ifft(U1));%u1 = real(inv_fft(U1, sz(2)));
u2 = real(ifft(U2));%u2 = real(inv_fft(U2, sz(2)));
err_vec = u1 - u2;
error = norm(err_vec, inf)
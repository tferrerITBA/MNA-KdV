% Variar orden al insertar parametros
delta_t = 1e-05;
U1 = kdv(delta_t);
U2 = kdv(delta_t);
u1 = real(inv_fft(U1));
u2 = real(inv_fft(U2));
err_vec = u1 - u2;
error = norm(err_vec, inf)
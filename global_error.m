% Insertar los mismos parametros
delta_t1 = 1e-05;
delta_t2 = 2 * delta_t1;
U1 = kdv(delta_t1);
U2 = kdv(delta_t2);
u1 = real(ifft(U1));
u2 = real(ifft(U2));
err_vec = u1 - u2;
error = norm(err_vec, inf)
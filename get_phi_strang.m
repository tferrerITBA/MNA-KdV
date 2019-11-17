%get_phi_strang Strang integrator implementation
function Y = get_phi_strang(U, k, delta_t, m, is_plus, counter)
  h = delta_t / m;
  if is_plus
    Y = non_linear(linear(non_linear(U, k, h/2), k, h), k, h/2);
  else
    Y = linear(non_linear(linear(U, k, h/2), k, h), k, h/2);
  end

  if counter ~= 1
    Y = get_phi_strang(Y, k, delta_t, m, is_plus, counter-1); 
  end

end

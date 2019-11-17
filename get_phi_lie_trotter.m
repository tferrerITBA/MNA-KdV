function Y = get_phi_lie_trotter(U, k, delta_t, m, is_plus, counter)
  h = delta_t / m;
  if is_plus
    Y = non_linear(linear(U, k, h), k, h);
  else
    Y = linear(non_linear(U, k, h), k, h);
  end
  
  if counter ~= 1
    Y = get_phi_lie_trotter(Y, k, delta_t, m, is_plus, counter-1);
  end

end

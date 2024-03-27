function v = fClarke(V, Delta, f, fs, phi, N)
   A = (sqrt(6)/6) * (V(1)*exp(1i*Delta(1)) + V(2)*exp(1i*Delta(2)) + V(3)*exp(1i*Delta(3)));
   B  = (sqrt(6)/6) * (V(1)*exp(1i*Delta(1)) + V(2)*exp(-1i*(Delta(2)+(2*pi/3))) + V(3)*exp(-1i*(Delta(3)-(2*pi/3))));
   v = A*exp(1i*(2*pi*(f/fs)*(1:N)+phi)) + B*exp(-1i*(2*pi*(f/fs)*(1:N)+phi));
end
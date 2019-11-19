%Kdv Dos_solitones

clear all
clc

q = 0;
while q <= 0 || mod(q,2) > 0
    prompt = 'Please enter the order (even number > 0): ';
    q = input(prompt);
end
s = q/2;

integrators = {@get_phi_lie_trotter, @get_phi_strang};
integrator_num = 0;
while integrator_num <= 0 || integrator_num > 2
    prompt = 'Please select an integrator (1: Lie-Trotter; 2: Strang): ';
    integrator_num = input(prompt);
end
integrator = integrators{integrator_num};

set(gca,'FontSize',8)
set(gca,'LineWidth',2)

N = 256;
x = linspace(-10,10,N);
delta_x = x(2) - x(1);% paso espacial
delta_k = 2*pi/(N*delta_x);

k = [0:delta_k:(N/2-1)*delta_k,0,-(N/2-1)*delta_k:delta_k:-delta_k];% armonicos
c_1 = 13; % velocidad 1
c_2 = 3; % velocidad 2

u = 1/2*c_1*(sech(sqrt(c_1)*(x+8)/2)).^2 + 1/2*c_2*(sech(sqrt(c_2)*(x+1)/2)).^2; % solucion inicial

delta_t = 0.4/N^2; % paso temporal
t = 0;
plot(x,u,'LineWidth',2)
axis([-10 10 0 10])
xlabel('x')
ylabel('u')
text(6,9,['t = ',num2str(t,'%1.2f')],'FontSize',14)
drawnow

gammas = {[0.5]; [-1/16, 9/16]; [1/144, -8/63, 625/1008]; [-1/2304, 32/675, -729/3200, 117649/172800]};

tmax = 1.5;
nplt = floor((tmax/100)/delta_t);
nmax = round(tmax/delta_t);
udata = u.';
tdata = 0;
U = fft(u);

parpool('local', q);

for n = 1:nmax-40000
    t = n*delta_t;
    
    U_aux = zeros(1, N);
    gammas_aux = gammas{s};

    answ = [];

    spmd(q)
        m = ceil(labindex / 2);
        is_linear = (mod(labindex,2) == 0);
        answ = integrator(U, k, delta_t, m, is_linear, m);
    end

    for m = 1:s
        % integrador simetrico
        index = 2 * m;
        Phi_plus = answ{index-1};
        Phi_minus = answ{index};
        U_aux = U_aux + gammas_aux(m) * (Phi_plus + Phi_minus);
    end
    U = U_aux;
    if n == 1 || n == nplt
        U
    end
    
    if mod(n,nplt) == 0
        u = real(ifft(U));
        udata = [udata u.']; tdata = [tdata t];
        if mod(n,4*nplt) == 0
            plot(x,u,'LineWidth',2)
            axis([-10 10 0 10])
            xlabel('x')
            ylabel('u')
            text(6,9,['t = ',num2str(t,'%1.2f')],'FontSize',10)
            drawnow
        end
    end
end

figure

waterfall(x,tdata(1:4:end),udata(:,1:4:end)')
xlabel x, ylabel t, axis([-10 10 0 tmax 0 10]), grid off
zlabel u

delete(gcp);

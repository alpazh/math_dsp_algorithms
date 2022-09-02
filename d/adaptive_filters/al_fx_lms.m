function [d_hat,e,ef,w,dc,uf] = al_fx_lms(s,d,alpha,w,F,h_prim_path)

M = length(w);% number of taps
N = length(d);% length of the signal
epsi = 1e-6;% epsilon

u = zeros(M,1);% update vector (regressor)
ufv = zeros(M,1);% filtered regressor
e = zeros(N,1);% error signal
ef = zeros(N,1);% error signal
d_hat = zeros(N,1);% LMS filter output signal
dc = zeros(N,1);% mean-square deviation curve

NF = length(F);
efdl = zeros(NF-1,1);
ufdl = zeros(NF-1,1);

dc(1) = norm(w-h_prim_path).^2;

for k=1:N
    u(2:M,1) = u(1:M-1,1);
    u(1,1) = s(k);
    
    d_hat(k) = u'*w;
    
    e(k) = d(k) - d_hat(k);
    
    [ef_k,efdl] = filter(F,1,e(k),efdl);% filtered error
    ef(k) = ef_k;
    [uf_k,ufdl] = filter(F,1,s(k),ufdl);% filtered regressor
    uf(k) = uf_k;

    ufv(2:M,1) = ufv(1:M-1,1);
    ufv(1,1) = uf_k;

    f = epsi + norm(u).^2;% factor
    w = w + (alpha/f)*ufv*ef(k);
    dc(k) = norm(w-h_prim_path).^2;
end

end
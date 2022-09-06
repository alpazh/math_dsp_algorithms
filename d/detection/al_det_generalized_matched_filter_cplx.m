function [Tx,thresh] = al_det_generalized_matched_filter_cplx(s,x,Pfa,C)
% [Tx,thresh] = al_det_generalized_matched_filter_cplx(s,x,var_wgn,Pfa)
% Complex Generalized Matched Filter Detector for deterministic signals
%
% Input paramaters:
% s - known deterministic signal to be detected,
% x - input signal x,
% var_wgn - known WGN variance
% Pfa - required Probability of the False Alarm
% C - Noise Covariance Matrix
%
% Output paramaters:
% Tx - Test Statistic,
% thresh - THreshold gamma for the given Pfa.
%
% Reference:
% Kay, Fundamentals of Statistical Signal Processing,
% Volume III Practical Algorithm Development,
% Algorithm 12.16 – Generalized Matched Filter Detector (also Algorithm 10.3)

Ci = inv(C);
% Detector Statistic
Tx = real(x'*(Ci)*s);
% gamma threshold
thresh = real(sqrt((s'*(Ci)*s)/2)*al_q_inv_func(Pfa));

return

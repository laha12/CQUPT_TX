function [bd, ad] = anti_alisasing_filter(D)
%   D:抽取因子
[bd, ad] = low_pass_filter(pi/D-0.05*pi, pi/D+0.05*pi, 1, 30, 100);
end


function feat_mat = WDecBi(mat,label,level)
% mat : name of final matrix (should available at workspace)
% label : name of label matrix (should available at workspace)
% level : enter the level of wavelet decomposition

%%% This programme is written by DIVYASH KUMBHANI
%%% contact number : +91 7490901545
tic

load('HPFB_TF_PSE_Main-Ex5.mat') % filter matrix

for i = 1:size(mat,1)
    
    [Lo_D,Hi_D,Lo_R,Hi_R] = biorfilt(h0',f0'); %%%%% filter bank
    [C,L] = wavedec(mat(i,:),level,Lo_D,Hi_D);
    A = wrcoef('a',C,L,Lo_R,Hi_R,level);
        
    feat_mat(i,1) = signal_shanonEntropy(A); %%%%% feature
    %feat_mat(i,1) = norm(A,1); %%%%% norm1
    
    for p = 1:level
        D = wrcoef('d',C,L,Lo_R,Hi_R,p);
        
        feat_mat(i,p+1) = signal_shanonEntropy(D); %%%%% feature
        %feat_mat(i,1) = norm(D,1); %%%%% norm1
        
    end
    clc
    disp(i)
    toc
end
feat_mat = table(feat_mat,label);
%sname = strcat('_',sname,'_');
%save(sname,'feat_mat')
end
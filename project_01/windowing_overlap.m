function [ Y ] = windowing_overlap( X,window_size,overlap_size )
%windowing of data with certain overlapping 
for k = 1:floor((length(X)-1-window_size)/(window_size-overlap_size))
    Y(1:window_size,k) = X(1+(k-1)*(window_size-overlap_size):...
        window_size + (k-1)*(window_size-overlap_size));
end

% k=1;
% kk=1;
% while kk+window_size<length(X)-window_size
%     kk=1+(k-1)*(window_size-overlap_size);
%     Y(1:window_size,k) = X(kk:window_size + kk-1);
%     k=k+1;
% end
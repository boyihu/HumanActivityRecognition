windowslist=[128, 200, 128, 145];
overlaplist=[64, 0, 10, 100];



outdir = 'Datasets/';
for i=1:size(windowslist,2)
    window = windowslist(i);
    overlap = overlaplist(i);
    X = windowing_overlap(a_x, window, overlap);
    Y = windowing_overlap(y_true, window, overlap);
    
    mkdir(strcat(outdir, int2str(i)));
    save(strcat(outdir, int2str(i), '/','acc_X.mat'), 'X', 'Y');

    X = windowing_overlap(a_y, window, overlap);
    save(strcat(outdir, int2str(i), '/','acc_Y.mat'), 'X', 'Y');

    X = windowing_overlap(a_z, window, overlap);
    save(strcat(outdir, int2str(i), '/','acc_Z.mat'), 'X', 'Y');

    X = windowing_overlap(g_x, window, overlap);
    save(strcat(outdir, int2str(i), '/','gyro_X.mat'), 'X', 'Y');

    X = windowing_overlap(g_y, window, overlap);
    save(strcat(outdir, int2str(i), '/','gyro_Y.mat'), 'X', 'Y');
    
    X = windowing_overlap(g_z, window, overlap);
    save(strcat(outdir, int2str(i), '/','gyro_Z.mat'), 'X', 'Y');

    fid = fopen(strcat(outdir, int2str(i), '/','info.txt'), 'wt');
    fprintf(fid, 'Window\n%d\nOverlap\n%d', window, overlap);
    fclose(fid);
end

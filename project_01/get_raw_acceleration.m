function [a_x , a_y, a_z, g_x, g_y, g_z, y_true] = get_raw_acceleration(folder_path)
%% Import data from text file.

%% Initialize variables.

for k = 1:61
    
    if k<10
        exp_id = ['0' num2str(k)];
    else
        exp_id = [ num2str(k)];
    end
    filename = [folder_path 'acc_exp'...
        exp_id '.txt'];
    filename2 = [folder_path 'gyro_exp'...
        exp_id '.txt'];    delimiter = ' ';
    
    %% Format string for each line of text:
    %   column1: double (%f)
    %	column2: double (%f)
    %   column3: double (%f)
    % For more information, see the TEXTSCAN documentation.
    formatSpec = '%f%f%f%[^\n\r]';
    
    %% Open the text file.
    fileID = fopen(filename,'r');
    fileID2 = fopen(filename2,'r');
    %% Read columns of data according to format string.
    % This call is based on the structure of the file used to generate this
    % code. If an error occurs for a different file, try regenerating the code
    % from the Import Tool.
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);
    dataArray2 = textscan(fileID2, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);
    
    %% Close the text file.
    fclose(fileID);
    
    %% Post processing for unimportable data.
    % No unimportable data rules were applied during the import, so no post
    % processing code is included. To generate code which works for
    % unimportable data, select unimportable cells in a file and regenerate the
    % script.
    
    %% Create output variable
    dataArray = cellfun(@(x) num2cell(x), dataArray, 'UniformOutput', false);
    dataArray2 = cellfun(@(x) num2cell(x), dataArray2, 'UniformOutput', false);
    
    HAR_RAW{k} = [dataArray{1:end-1} dataArray2{1:end-1}]; 
    %% Clear temporary variables
    clearvars filename delimiter formatSpec fileID dataArray ans ;
    
end



filename = [folder_path 'labels.txt'];
delimiter = ' ';

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
dataArray = cellfun(@(x) num2cell(x), dataArray, 'UniformOutput', false);
HAR_raw_data_labels = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;

s_1 = get_activity_vector( HAR_raw_data_labels,HAR_RAW,1);
s_2 = get_activity_vector( HAR_raw_data_labels,HAR_RAW,2);
s_3 = get_activity_vector( HAR_raw_data_labels,HAR_RAW,3);
s_4 = get_activity_vector( HAR_raw_data_labels,HAR_RAW,4);
s_5 = get_activity_vector( HAR_raw_data_labels,HAR_RAW,5);
s_6 = get_activity_vector( HAR_raw_data_labels,HAR_RAW,6);

a_x = [s_1(:,1);s_2(:,1);s_3(:,1);s_4(:,1);s_5(:,1);s_6(:,1)];
a_y = [s_1(:,2);s_2(:,2);s_3(:,2);s_4(:,2);s_5(:,1);s_6(:,2)];
a_z = [s_1(:,3);s_2(:,3);s_3(:,3);s_4(:,3);s_5(:,3);s_6(:,3)];
g_x = [s_1(:,4);s_2(:,4);s_3(:,4);s_4(:,4);s_5(:,4);s_6(:,4)];
g_y = [s_1(:,5);s_2(:,5);s_3(:,5);s_4(:,5);s_5(:,5);s_6(:,5)];
g_z = [s_1(:,6);s_2(:,6);s_3(:,6);s_4(:,6);s_5(:,6);s_6(:,6)];


y_true = [...
    1*ones(length(s_1),1);...
    2*ones(length(s_2),1);...
    3*ones(length(s_3),1);...
    4*ones(length(s_4),1);...
    5*ones(length(s_5),1);...
    6*ones(length(s_6),1);...
    ];


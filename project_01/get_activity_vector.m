function [ activity_vector ] = get_activity_vector( HAR_raw_data_labels,HAR_RAW,activity)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
HAR_raw_data_labels_mat=cell2mat(HAR_raw_data_labels);
activity_indeces=find(HAR_raw_data_labels_mat(:,3) ==activity);
activity_vector = [];
exp_id_old = 0;
for k = 1:length(activity_indeces)
    exp_id = HAR_raw_data_labels_mat(activity_indeces(k),1);
    %     if exp_id ~=exp_id_old
    exp_data_cell = (HAR_RAW(exp_id));
    exp_data = cell2mat(exp_data_cell{1});
    %     end
    exp_data_activity = exp_data(HAR_raw_data_labels_mat(activity_indeces(k),4)...
        :HAR_raw_data_labels_mat(activity_indeces(k),5),:);
    activity_vector = [ activity_vector;exp_data_activity];
end

end


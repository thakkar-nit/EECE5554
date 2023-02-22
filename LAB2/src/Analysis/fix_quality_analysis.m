bag=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stat_occ.bag')
% bag2=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stsnell_library_stationary_2023-02-05-15-59-45.bag')

bag_readmsg=select(bag,'Topic','/gps')
% bag2_readmsg2=select(bag2,'Topic','/gps')

data1=readMessages(bag_readmsg,'DataFormat','struct')
% data2=readMessages(bag2_readmsg2,'DataFormat','struct')

fix_quality=[];
% altitude_occluded=[];
%%%%%%%%%%%%%%%%%
for i= 1:600
    selected_fix_quality=data1{i}.FixQuality;
    fix_quality=[fix_quality;selected_fix_quality];
end
%%%%%%%%%%%%%%%%%
% for j=1:300
%     selected_altitude2=data2{j}.Altitude;
%     altitude_occluded=[altitude_occluded;selected_altitude2];
% end
%%%%%%%%%%%%%%%%%%
time=1:600

scatter(time,fix_quality,'MarkerEdgeColor','b')
title('fix quality vs Time occluded Moving');
hold on
% scatter(altitude_occluded,time,'MarkerEdgeColor','r');
xlabel('Time in seconds')
ylabel('fix quality in unitless')
% legend('occluded data-moving','occluded data-stationary');
hold off
grid on




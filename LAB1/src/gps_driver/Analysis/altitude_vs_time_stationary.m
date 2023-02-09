bag=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stationary_footballfield_2023-02-05-15-19-33.bag')
bag2=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stsnell_library_stationary_2023-02-05-15-59-45.bag')

bag_readmsg=select(bag,'Topic','/gps')
bag2_readmsg2=select(bag2,'Topic','/gps')

data1=readMessages(bag_readmsg,'DataFormat','struct')
data2=readMessages(bag2_readmsg2,'DataFormat','struct')

altitude_open=[];
altitude_occluded=[];
%%%%%%%%%%%%%%%%%
for i= 1:300
    selected_altitude=data1{i}.Altitude;
    altitude_open=[altitude_open;selected_altitude];
end
%%%%%%%%%%%%%%%%%
for j=1:300
    selected_altitude2=data2{j}.Altitude;
    altitude_occluded=[altitude_occluded;selected_altitude2];
end
%%%%%%%%%%%%%%%%%%
time=1:300

scatter(altitude_open,time,'MarkerEdgeColor','b')
title('Altitude vs Time open and occluded stationary');
hold on
scatter(altitude_occluded,time,'MarkerEdgeColor','r');
xlabel('Altitude in meters')
ylabel('Time in seconds')
legend('open data-stationary','occluded data-stationary');
hold off
grid on




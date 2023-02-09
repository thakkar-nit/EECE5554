bag=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stwalking_footballfield_2023-02-05-15-29-06.bag')
bag2=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\walking_snell_2023-02-05-16-09-47.bag')

bag_readmsg=select(bag,'Topic','/gps')
bag2_readmsg2=select(bag2,'Topic','/gps')

data1=readMessages(bag_readmsg,'DataFormat','struct')
data2=readMessages(bag2_readmsg2,'DataFormat','struct')

altitude_open=[];
altitude_occluded=[];
%%%%%%%%%%%%%%%%%
for i= 1:60
    selected_altitude=data1{i}.Altitude;
    altitude_open=[altitude_open;selected_altitude];
end
%%%%%%%%%%%%%%%%%
for j=1:60
    selected_altitude2=data2{j}.Altitude;
    altitude_occluded=[altitude_occluded;selected_altitude2];
end
%%%%%%%%%%%%%%%%%%
time=1:60

scatter(altitude_open,time,'MarkerEdgeColor','b')
title('Altitude vs Time open and occluded Walking');
hold on
scatter(altitude_occluded,time,'MarkerEdgeColor','r');
xlabel('Altitude in meters')
ylabel('Time in seconds')
legend('open data-Walking','occluded data-Walking');
hold off
grid on




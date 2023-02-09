bag=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stationary_footballfield_2023-02-05-15-19-33.bag')
bag2=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stsnell_library_stationary_2023-02-05-15-59-45.bag')

bag_readmsg=select(bag,'Topic','/gps')
bag2_readmsg2=select(bag2,'Topic','/gps')

data1=readMessages(bag_readmsg,'DataFormat','struct')
data2=readMessages(bag2_readmsg2,'DataFormat','struct')

utm_easting=[];
utm_northing=[];
%%%%%%%%%%%%%%%%%
utm_easting2=[];
utm_northing2=[];
%%%%%%%%%%%%%%%%%
for i= 1:300
    selected_easting=data1{i}.UTMEasting;
    selected_north=data1{i}.UTMNorthing;
    utm_easting=[utm_easting;selected_easting];
    utm_northing=[utm_northing;selected_north];
end
%%%%%%%%%%%%%%%%%
for j=1:300
    selected_easting2=data2{j}.UTMEasting;
    utm_easting2=[utm_easting2;selected_easting2];
    selected_northing2=data2{j}.UTMNorthing;
    utm_northing2=[utm_northing2;selected_northing2];
end
%%%%%%%%%%%%%%%%%%
utm_northing=utm_northing-utm_northing(1);
utm_easting=utm_easting-utm_easting(1);

%%%%%%%%%%%%%%%%%%
utm_northing2=utm_northing2-utm_northing2(1);
utm_easting2=utm_easting2-utm_easting2(1);
%%%%%%%%%%%%%%%%%%

scatter(utm_northing,utm_easting,'MarkerEdgeColor','b')
title('Northing vs Easting open and occluded stationary');
hold on
scatter(utm_northing2,utm_easting2,'MarkerEdgeColor','r');
xlabel('Northing in meters')
ylabel('Easting in meters')
legend('open data-stationary','occluded data-stationary');
hold off
grid on




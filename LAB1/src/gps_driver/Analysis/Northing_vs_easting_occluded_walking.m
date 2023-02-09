bag=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\walking_snell_2023-02-05-16-09-47.bag')

bag_readmsg=select(bag,'Topic','/gps')

data1=readMessages(bag_readmsg,'DataFormat','struct')

utm_easting=[];
utm_northing=[];
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
for i= 1:60
    selected_easting=data1{i}.UTMEasting;
    selected_north=data1{i}.UTMNorthing;
    utm_easting=[utm_easting;selected_easting];
    utm_northing=[utm_northing;selected_north];
end
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%
utm_northing=utm_northing-utm_northing(1);
utm_easting=utm_easting-utm_easting(1);

%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%

scatter(utm_northing,utm_easting,'MarkerEdgeColor','r')
title('Northing vs Easting Occluded Walking');
xlabel('Northing in meters')
ylabel('Easting in meters')
grid on




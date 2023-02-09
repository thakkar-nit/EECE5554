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
p=polyfit(utm_northing,utm_easting,1);
predicted_easting=polyval(p,utm_northing);
RMSE=sqrt(mean((utm_easting-predicted_easting).^2));

%%%%%%%%%%%%%%%%%%

hold on
scatter(utm_northing,utm_easting,'MarkerEdgeColor','b')
plot(utm_northing,predicted_easting,'r','LineWidth',2)
title(sprintf('Northing vs Easting Occluded Walking Line of best fit (RMSE=%.2f)',RMSE));
xlabel('Northing in meters')
ylabel('Easting in meters')
hold off
grid on




bag=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\')
% bag2=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stat_occ.bag')

bag_readmsg=select(bag,'Topic','/gps')
% bag2_readmsg2=select(bag2,'Topic','/gps')

data1=readMessages(bag_readmsg,'DataFormat','struct')
% data2=readMessages(bag2_readmsg2,'DataFormat','struct')

utm_easting=[];
utm_northing=[];
%%%%%%%%%%%%%%%%%
% utm_easting2=[];
% utm_northing2=[];
%%%%%%%%%%%%%%%%%
for i= 1:600
    selected_easting=data1{i}.UTMEasting;
    selected_north=data1{i}.UTMNorthing;
    utm_easting=[utm_easting;selected_easting];
    utm_northing=[utm_northing;selected_north];
end
%%%%%%%%%%%%%%%%%
% for j=1:300
%     selected_easting2=data2{j}.UTMEasting;
%     utm_easting2=[utm_easting2;selected_easting2];
%     selected_northing2=data2{j}.UTMNorthing;
%     utm_northing2=[utm_northing2;selected_northing2];
% end
%%%%%%%%%%%%%%%%%%
known_easting_open=328121.81;
known_northing_open=4689436.05;
utm_northing=utm_northing-known_northing_open;
utm_easting=utm_easting-known_easting_open;

%%%%%%%%%%%%%%%%%%
% utm_northing2=utm_northing2-utm_northing2(1);
% utm_easting2=utm_easting2-utm_easting2(1);
% %%%%%%%%%%%%%%%%%%


scatter(utm_easting,utm_northing,'MarkerEdgeColor','b')
title('Easting vs Northing open stationary compare to known location');
hold on
% scatter(known_easting_open,known_northing_open,'MarkerEdgeColor','r');
xlabel('Easting in meters')
ylabel('Northing in meters')
legend('open data-stationary compare to known location','known location');
hold off
grid on




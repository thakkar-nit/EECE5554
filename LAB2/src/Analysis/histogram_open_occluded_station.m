bag=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stat_open_10_min.bag')
bag2=rosbag('C:\Users\nitin\OneDrive\Desktop\RSN_DATA\stat_occ.bag')

%%%%%%%%%%%%%%%%%%%%%
bag_readmsg=select(bag,'Topic','/gps')
bag2_readmsg=select(bag2,'Topic','/gps')
%%%%%%%%%%%%%%%%%%%%%
data1=readMessages(bag_readmsg,'DataFormat','struct')
data2=readMessages(bag2_readmsg,'DataFormat','struct')
%%%%%%%%%%%%%%%%%%%%%%
utm_easting=[];
utm_northing=[];
%%%%%%%%%%%%%%%%%
utm_easting2=[];
utm_northing2=[];
%%%%%%%%%%%%%%%%%
% for i= 1:600
%     selected_easting=data1{i}.UTMEasting;
%     selected_north=data1{i}.UTMNorthing;
%     utm_easting=[utm_easting;selected_easting];
%     utm_northing=[utm_northing;selected_north];
% end
%%%%%%%%%%%%%%%%%
for j=1:600
    selected_easting2=data2{j}
    selected_easting2=data2{j}.UTMEasting;
    utm_easting2=[utm_easting2;selected_easting2];
    selected_northing2=data2{j}.UTMNorthing;
    utm_northing2=[utm_northing2;selected_northing2];
end
%%%%%%%%%%%%%%%%%%
% known_open_easting=328122.04;
% known_open_northing=4689435.49;

known_occluded_easting=328169.14;
known_occluded_northing=4689413.23;
%%%%%%%%%%%%%%%%%%%
% error_open_easting=utm_easting-known_open_easting;
% error_open_northing=utm_northing-known_open_northing;

error_occluded_easting=utm_easting2-known_occluded_easting;
error_occluded_northing=utm_northing2-known_occluded_northing;

% error_open=sqrt(error_open_easting.^2+error_open_northing.^2);
error_occluded=sqrt(error_occluded_easting.^2+error_occluded_northing.^2);

% histogram(error_open,"NumBins",15,'FaceColor','blue')
hold on
histogram(error_occluded,'NumBins',15,'FaceColor','red')
xlabel('Error in meters')
ylabel('Frequency');
title("Histogram for occluded stationary data")
% legend('open data-stationary','occluded data-stationary')




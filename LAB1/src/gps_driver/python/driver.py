#!/usr/bin/python
import rospy
import serial
from std_msgs.msg import String
from gps_driver.msg import gps_msg
import datetime
import utm

########################################################
## creating gps publisher##
def gps_publisher():
    port=rospy.get_param('port')
    rospy.loginfo(port)
    publish=rospy.Publisher('/gps',gps_msg,queue_size=10)
    rospy.init_node('gps_talker',anonymous=True)
    rate=rospy.Rate(1)
    serial_data=serial.Serial(port,4800)
    
    while not rospy.is_shutdown():
        line=serial_data.readline()
        decoded=line.decode('ASCII')
        splitted=decoded.split(',')
        rospy.loginfo(splitted)
        if '\r$GPGGA' in splitted: 
################ Time MANIPULATION #######################            
            time_select=splitted[1]
            time_hour=int(time_select[:2])*3600
            time_minute=int(time_select[2:4])*60
            time_sec=int(time_select[4:6])
            total_time_sec=time_hour+time_minute+time_sec
            time_nano=int(time_select[7:9])
            utc_time=time_select
            
#################LAT MANIPULATION#########################
            Latitude=splitted[2]
            Lat_degree=float(Latitude[:2])
            Lat_minute_deg=float(Latitude[2:])/60
            Lat_degree+=Lat_minute_deg
            if splitted[3]=="S":
                Lat_degree*=-1
            else:
                Lat_degree
            


############### LONGI MANIPULATION #######################
            Longitude=splitted[4]
            Long_degree=float(Longitude[:3])
            Long_minute_deg=float(Longitude[3:])/60
            Long_degree+=Long_minute_deg
            if splitted[5]=="W":
                Long_degree*=-1
            else:
                Long_degree


            Altitude=float(splitted[9])
            HDOP=float(splitted[8])
            utm_data=utm.from_latlon(Lat_degree,Long_degree)
            UTM_easting=float(utm_data[0])
            UTM_northing=float(utm_data[1])
            Zone=int(utm_data[2])
            Letter=utm_data[3]

################ Putting in msg ############################
            gps_message=gps_msg()
            gps_message.Latitude=Lat_degree
            gps_message.Longitude=Long_degree
            gps_message.Altitude=Altitude
            gps_message.HDOP=HDOP
            gps_message.UTM_easting=UTM_easting
            gps_message.UTM_northing=UTM_northing
            gps_message.UTC=utc_time
            gps_message.Zone=Zone
            gps_message.Letter=Letter
            gps_message.Header.frame_id.upper="GPS1_Frame"
            gps_message.Header.stamp.secs=total_time_sec
            gps_message.Header.stamp.nsecs=time_nano
            # gps_message.Header.seq+
            
            rospy.loginfo(f"Latitude: {Lat_degree}")
            rospy.loginfo(f"Longitude: {Long_degree}")
            rospy.loginfo(f"Altitude: {Altitude}")
            rospy.loginfo(f"HDOP: {HDOP}")
            rospy.loginfo(f"UTM_easting: {UTM_easting}")
            rospy.loginfo(f"UTM_northing: {UTM_northing}")
            rospy.loginfo(f"Zone: {Zone}")
            rospy.loginfo(f"Letter: {Letter}")
            rospy.loginfo(f"UTC : {time_select}")
            publish.publish(gps_message)
            rate.sleep()

        
if __name__=='__main__':
    try:
        gps_publisher()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass




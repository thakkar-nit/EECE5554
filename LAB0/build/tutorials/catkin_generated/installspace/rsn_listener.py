#!/usr/bin/env python3
import rospy
from std_msgs.msg import String

def callback(data):
    # manipulated_data=data[::-1]
    rospy.loginfo("I heard in Reversed %s",data.data[::-1])




def listener():
    rospy.init_node('RSN_listner', anonymous=True)
    rospy.Subscriber('chatter',String,callback)
    rospy.spin()

if __name__=='__main__':
    listener()
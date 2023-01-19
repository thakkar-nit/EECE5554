#!/usr/bin/env python

import rospy
from std_msgs.msg import String


def talker():
    publisher=rospy.Publisher('chatter',String,queue_size=10)
    rospy.init_node('RSN_talker',anonymous=True)
    rate=rospy.Rate(10)
    while not rospy.is_shutdown():
        string_example="I have completed the first assignment"
        rospy.loginfo(string_example)
        publisher.publish(string_example)
        rate.sleep()



if __name__=='__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
    
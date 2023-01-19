#!/usr/bin/env python3

import rospy

from geometry_msgs.msg import Twist
from turtlesim.msg import Pose
from turtlesim.srv import Spawn, SpawnRequest, Kill, KillRequest
import math
import time



class turtlebot:

    def __init__(self):
        rospy.init_node("turtlesim_custom")
        self.rate=rospy.Rate(10)
        cmd_vel_topic="/turtle1/cmd_vel"
        self.velocity_publisher=rospy.Publisher(cmd_vel_topic,Twist,queue_size=10)
        position_topic="/turtle1/pose"
        self.pose_subscriber=rospy.Subscriber(position_topic,Pose,self.poseCallback)
        self.velocity_message= Twist()


    def kill_turtle_client(self,name):
        rospy.wait_for_service('/kill')
        try:
            kill_turtle=rospy.ServiceProxy('/kill', Kill)
            server_response = kill_turtle(name)
            return server_response
        except rospy.ServiceException as e:
            print("Service call failes: %s"%e)

    def spawn_turtle_client(self,x,y,theta,name):
        rospy.wait_for_service('/spawn')
        try:
            spawn_turtle=rospy.ServiceProxy('/spawn',Spawn)
            server_response=spawn_turtle(x,y,theta,name)
            return server_response.name
        except rospy.ServiceException as e:
            print("Service call failes: %s"%e)
    
    def straight_line_1(self,speed,distance,is_forward):
        global scored_x,scored_y
        x0=scored_x
        y0=scored_y

        if (is_forward):
            self.velocity_message.linear.x=abs(speed)
        else:
            self.velocity_message.linear.x=-abs(speed)

        self.distance_moved=0.0
        self.loop_rate=rospy.Rate(10)

        while True:
            rospy.loginfo("Turtlesim executing straightline")
            self.velocity_publisher.publish(self.velocity_message)
            self.loop_rate.sleep()
            self.distance_moved=abs(math.sqrt(((scored_x-x0)**2)+((scored_y-y0)**2)))
            print(self.distance_moved)

            if not (self.distance_moved<distance):
                rospy.loginfo("reached")
                break
        self.velocity_message.linear.x=0
        self.velocity_publisher.publish(self.velocity_message)
    
    def poseCallback(self,pose_message):
        global scored_x
        global scored_y,yaw
        scored_x=pose_message.x
        scored_y=pose_message.y
        yaw=pose_message.theta




    
if __name__=="__main__":
    my_turtle = turtlebot()
    service_response_kill=my_turtle.kill_turtle_client("turtle1")
    service_response_spawn=my_turtle.spawn_turtle_client(2.0, 1.0, 1.57, "turtle1")
    time.sleep(2)
    my_turtle.straight_line_1(1.0,3.0,is_forward=True)
    service_response_kill=my_turtle.kill_turtle_client("turtle1")
    service_response_spawn=my_turtle.spawn_turtle_client(1.9093,4.10267,5.49,"turtle1")
    my_turtle.straight_line_1(1.0,4.6,is_forward=True)
    service_response_kill=my_turtle.kill_turtle_client("turtle1")
    service_response_spawn=my_turtle.spawn_turtle_client(5.2095,0.75063,1.57,"turtle1")
    my_turtle.straight_line_1(1.0,3.0,is_forward=True)


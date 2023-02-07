import bagpy
import pandas as pd
import matplotlib.pyplot as plt

# Load the rosbag file
bag = bagpy.bagreader('/home/nitin/EECE5554/LAB1/src/gps_driver/Data/stationary_footballfield_2023-02-05-15-19-33.bag')
# for t in bag.topics:
#     data=bag.message_by_topic(t)
#     csv.append(data)
# print(csv[0])
data=bag.message_by_topic('/gps')
print("File saved: {}".format(data))
utm_easting=pd.read_csv(data)
print(utm_easting.to_string())
# # Extract the UTM_northing data
# utm_northing = bag.extract_topic_data('/utm_northing', 'UTM_northing')

# # Subtract the first value to scale the data
# utm_easting = [x - utm_easting[0] for x in utm_easting]
# utm_northing = [x - utm_northing[0] for x in utm_northing]

# # Create a DataFrame from the extracted data
# df = pd.DataFrame({'Easting': utm_easting, 'Northing': utm_northing})

# # Create the scatterplot
# plt.scatter(df['Easting'], df['Northing'])
# plt.xlabel('Easting')
# plt.ylabel('Northing')
# plt.title('Scatterplot of Northing vs. Easting')
# plt.show()

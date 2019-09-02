1a)
Threshold value to convert greyscale to binary = 0.4
Number of dilations/erosions to remove noise = 8
Number of dilations/erosions to remove rices = 10


1c) 
Threshold value to convert greyscale to binary = 0.5

On comparing the properties of objects in images with the image database, I noticied that incase of a match, their moment of inertia and roundness are similar. 

All the following conditions should hold true, and only then it is a match :
Condition 1) difference between the moment of inertia < 30
Condition 2) difference between the roundness < 0.03

After using these thresholds, in many_objects_2.png fork was being recognised as spoon. So, I added another condition:-
Condition 3) (difference between the moment of inertia)/(difference between the roundness) < 2100
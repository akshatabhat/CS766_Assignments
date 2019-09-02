Walkthrough 1)
Threshold value for 'Sobel' edge detection = 0.15
Threshold value for 'Canny' edge detection = 0.4


Challenge 1
a) Using 'Canny' method for edge detection with a threshold value of 0.30

b)  Hough Accumulator Generation

	By cacluting the diagonal number of pixels, the maximum possible diagonal was found to be around 800.
	Number of bins for 'theta' = 180, 'theta' varies from -90 to 90. Here, each bin corresponds to 1 degree. Hence it captures all the angles from -180 to 180.
	Number of bins for 'rho' = 1600. 'rho' varies from -800 to 800. Here, each bin corresponds to 1 pixel unit. It captures all possible distances from -800 to 800 at a level of 1pixel/unit.

	Voting Mechanism : Since the resultion used is appropriate - neither too low nor too high, each bin in the accumulator array is used instead of a patch of nearby bins. Also this gives good results.

	In the accumulator matrix, first index corresponds to 'rho' and second index corresponds to 'theta'.

c) Line Generation
	Finding peaks - While looping through the accumulator, if the value an element is greater than the threshold, corresponding 'theta' and 'rho' value are captured as a peak.

	To draw lines, for each pair of theta and rho identified as peak, two x-y coordinates are calculated and 'plot' function in matlab used.

	Hough threshold values used - [90 90 200]. While selecting threshold values, there is a trade of between missing out on cetain edge lines and including additional cluster of lines(unnecessary lines).

d) Line Segment Generation
	Finding peaks - similar to c)

	To draw line segments, the key point is to make use of edge-detection. 'Canny' method for edge detection with a threshold value of 0.30

	For each pair of 'theta' and 'rho' identified as peak, x coordinates ranging from 1:800 considered and corresponding y-coordinate calculated. For each of the x-y coordinate, we check if the corresponding pixel in the edge detected image, to see if it is >0. Incase it is >0, this x-y coordinate is a part of valid boundary. 

	However, the issue here is that the lines calcualted may not exactly lie on the edge - if we check the edge detected image, we can see that pixels corresponding to edge may not lie on a line - there could be slight irregularity at a minute level. Hence, we compare the x-y coordinate with the neighbouring pixels(5 pixels in all directions) as well in the edge detected image.  

	Hough threshold values used - [90 90 200]



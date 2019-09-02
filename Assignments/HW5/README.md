To calculate the normal vector originating from the center of the sphere to its surface, I used equation of the sphere :-
(x-x0)^ 2+(y-y0)^2+(z-z0)^2 = r^2

Since we know the center of the circle - x0,y0 coordinates of the center of the sphere are same as that of the circle. We also obtain the radius from 1a). 
z0 is considered as 0.
Given points x,y - we just need to calculate z :-
z = sqrt(r^2 - (x-x0)^ 2 - (y-y0)^2)

x-coordinate of normal, p = (x-x0)
y-coordinate of normal, q = (y-y0)

N = (p, q, z)

Futher, to scale the normal vector, scaling factor is computer as = magnitude of brightness of brightest pixel in the image/norm of N


For any point on the sphere, if we draw a line form the center to the point, this line is normal to the surface of the sphere.
Consider the surface area of the sphere illuminated by the source. The brightest point is the centroid of this area. The line joining this brightest point to the source corresponds to the direction of the source light. 

Hence, if we have a normal vector to this brightest point on the surface, this gives us the direction of the source light.



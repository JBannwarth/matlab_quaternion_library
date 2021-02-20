# MATLAB Quaternion Library

Simple library implementing quaternion functions.

Functions based on, or inspired by those used in the C++ [PX4-Matrix](https://github.com/PX4/PX4-Matrix/blob/master/matrix/Quaternion.hpp) library.

Jérémie X. J. Bannwarth

## Quaternions

The Hamilton quaternion convention is used alongside the right hand rule convention.

## Euler Angles

For conversions to/from Euler angles, the following sequence of Euler angles is used:

1. Yaw rotation around the world z-axis
2. Pitch rotation around the new body y-axis
3. Roll rotation around the new body x-axis

Rotations are defined positive counterclockwise around their respective axes.
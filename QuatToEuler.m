function [ varargout ] = QuatToEuler( quat )
%QUATTOEULER Convert quaternion to euler angles (roll, pitch, yaw)
%   [ EUL ] = QUATTOEULER( QUAT ) converts Mx4 quaternions to Mx3 Euler angles
%   [ ROLL, PITCH, YAW ] = QUATTOEULER( QUAT ) converts Mx4 QUAT to M Euler angles
%
%   Based on PX4 Firmware code
%   Input:
%       - quat: Either 4x1/1x4 quaternion, or Mx4 matrix of M quaternion
%   Outputs (all values in radians):
%       Either:
%           - eul: Either 3x1/1x3 euler angles, or Mx3 matrix of M angles
%       Or:
%           - roll:  Mx1 vector of roll angles
%           - pitch: Mx1 vector of pitch angles
%           - yaw:   Mx1 vector of yaw angles
%
%   Roll, pitch, and yaw are defined using the following sequence from the
%   world frame:
%       1. Yaw rotation around the world z-axis
%       2. Pitch rotation around the new body y-axis
%       3. Roll rotation around the new body x-axis
%   The quaternions used are Hamilton quaternions in the form
%       q = [ cos(alpha)^2; sin(alpha)^2 * ax ],
%   where ax = [ax1; ax2; ax3] represents the axis of rotation and alpha
%   the rotation angle.
%
%   See also ROTORMAPPX4TOSIM.
%
%   Written: 07/08/2017, J.X.J. Bannwarth

    nout = max(nargout,1);
    if ~( ( nout == 1 ) || ( nout == 3 ) )
        error( 'Invalid number of output: only 1 and 3 output are supported' )
    end

    [m, n] = size( quat );

    if ( (m == 4) && (n == 1) )
        quat = quat';
    end

    eul(:,1) = atan2(2.0 .* (quat(:,1) .* quat(:,2) + quat(:,3) .* quat(:,4)), ...
        1.0 - 2.0 .* (quat(:,2) .* quat(:,2) + quat(:,3) .* quat(:,3)));
    eul(:,2) = asin(2.0 .* (quat(:,1) .* quat(:,3) - quat(:,4) .* quat(:,2)));
    eul(:,3) = atan2(2.0 .* (quat(:,1) .* quat(:,4) + quat(:,2) .* quat(:,3)), ...
        1.0 - 2.0 .* (quat(:,3) .* quat(:,3) + quat(:,4) .* quat(:,4)));

    if ( (m == 4) && (n == 1) )
        eul = eul';
    end

    if ( nout == 3 )
        varargout{1} = eul(:,1);
        varargout{2} = eul(:,2);
        varargout{3} = eul(:,3);
    else
        varargout{1} = eul;
    end

end

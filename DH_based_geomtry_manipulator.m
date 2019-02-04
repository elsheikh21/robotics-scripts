clc; clearvars; close all;
% The DH parameters define the geometry of the robot with relation
% to how each rigid body is attached to its parent.
row1_dh_tbl = [pi/2 0 500.0 pi/2;];
row2_dh_tbl = [pi/2 0 0 0;];
row3_dh_tbl = [pi/2 0 1000.0 2*pi;];
row4_dh_tbl = [0 500.0 0 0];

dhparams = [row1_dh_tbl; row2_dh_tbl; row3_dh_tbl; row4_dh_tbl;];
        
% Create a rigid body tree object to build the robot.
robot = robotics.RigidBodyTree;

% Create the first rigid body and add it to the robot. 
% To add a rigid body:
% 1. Create a RigidBody object and give it a unique name.
% 2. Create a Joint object and give it a unique name.
% 3. Use setFixedTransform to specify the body-to-body transformation 
% using DH parameters. The last element of the DH parameters, theta,
% is ignored because the angle is dependent on the joint position.
% 4. Call addBody to attach the first body joint to the base frame of the robot.
body1 = robotics.RigidBody('body1');
jnt1 = robotics.Joint('jnt1','revolute');

setFixedTransform(jnt1,dhparams(1,:),'dh');
body1.Joint = jnt1;

addBody(robot,body1,'base')

% Create and add other rigid bodies to the robot. 
% Specify the previous body name when calling addBody to attach it.
% Each fixed transform is relative to the previous joint coordinate frame.
body2 = robotics.RigidBody('body2');
jnt2 = robotics.Joint('jnt2','revolute');
body3 = robotics.RigidBody('body3');
jnt3 = robotics.Joint('jnt3','revolute');
body4 = robotics.RigidBody('body4');
jnt4 = robotics.Joint('jnt4','revolute');
body5 = robotics.RigidBody('body5');
jnt5 = robotics.Joint('jnt5','revolute');
body6 = robotics.RigidBody('body6');
jnt6 = robotics.Joint('jnt6','revolute');

setFixedTransform(jnt2,dhparams(2,:),'dh');
setFixedTransform(jnt3,dhparams(3,:),'dh');
setFixedTransform(jnt4,dhparams(4,:),'dh');
setFixedTransform(jnt5,dhparams(5,:),'dh');
setFixedTransform(jnt6,dhparams(6,:),'dh');

body2.Joint = jnt2;
body3.Joint = jnt3;
body4.Joint = jnt4;
body5.Joint = jnt5;
body6.Joint = jnt6;

addBody(robot,body2,'body1')
addBody(robot,body3,'body2')
addBody(robot,body4,'body3')
addBody(robot,body5,'body4')
addBody(robot,body6,'body5')

% Verify that your robot was built properly 
showdetails(robot)

% Visualize robot
show(robot);
% axis([-0.5,0.5,-0.5,0.5,-0.5,0.5])
axis on
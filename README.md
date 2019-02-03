# robotics-scripts

These scripts are built from Matlab documentation,
implemented with the purpose of computing

- Analytical Jacobian from manipulator's kinematics `build_from_DH_table.m`,
- Geometrical Jacobian `Build_geometric_jacobian.m`,
- Jacobian NullSpace,
- Jacobian Range or ColSpace,
- Jacobian transpose,
- Pseudo-inverse of Jacobian
- Build transformation matrices from DH table
  - printing out Rotation and Position matrices
- Elementary rotation around (X, Y, Z) axes `elementary_rotations_SKEW_R(theta, r).m`
- Rotations around specified vector r and angle theta `elementary_rotations_SKEW_R(theta, r).m`
- Build robotic manipulator/arm from DH table `DH_based_geomtry_manipulator.m` [Under development]
- solving polynomials, substitution of values, factoring, differentiation `extra_script.m`

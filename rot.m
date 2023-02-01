function R=rot(k,theta)
  % R=ROT(k,theta)
  % rotation matrix along vector 'k' by angle 'theta'
  hat = [0 -k(3) k(2);k(3) 0 -k(1);-k(2) k(1) 0];
  k=k/norm(k);
  R=eye(3,3)+sin(theta)*hat+(1-cos(theta))*hat*hat;
 
# Temporal Logic Guided Robot Navigation
An MILP Approach for Real-time Optimal Controller Synthesis with Signal Temporal Logic Specifications


# Installing Dependencies

This code depends on YALMIP, which can be obtained with the Multi-Parametric Toolbox, or MPT3, 
see https://yalmip.github.io/tutorial/installation/. MPT is also required for plotting polyhedras.

Computing robustness for the MTL specifications depends on the s-TaLiRo tool, which can be downloaded from
https://sites.google.com/a/asu.edu/s-taliro/s-taliro/download

We use the Gurobi solver as back-end to solve the optimization problem, though other solvers might work as well. 
For the user-interactive example to work without modifications, Gurobi needs to be installed and configured for Matlab. 
See http://www.gurobi.com.

The user-interactive example also uses a customized ginput.m file by Jiro Doke (http://www.mathworks.com/matlabcentral/fileexchange/38703-custom-ginput/content/ginputc.m) and is included here.

# Example

Once everything is installed, you can run the file 'find_OptimalTraj_mpc_m3pi.m' and choose either 

1) Type ```'yes'``` to use a GUI to give inputs to waypoints and obstacles.

2) Type ```'custom'``` to give a custom STL specification:

    Example : ``` "alw ((ev_[10,12] (X(1:2,t) > [0.3;0.5] and X(1:2,t) < [0.5;0.7])) and X(1:2,t) >~ [1.0;1.0] and X(1:2,t) <~ [1.2;1.4])" ```
    * This specification is a standard Go-To-Goal specifcation with goal region diagonal vertices being ```[0.3,0.5]``` and ```[0.5,0.7]``` and the obstacle co-ordinates being ```[1.0,1.0]``` and ```[1.2,1.4]```

    * ```ev_[10,12]``` depicts the time stamps within which the robot will stay within the goal region

3) Simply press ```Enter``` without typing anything to run the in-built example.

# Contact Us

You can contact aparame@clemson.edu for any queries or to report any bugs in the code.
If you feel like using our work, please cite us at :

```
@techreport{parameshwaran2023safety,
  title={Safety Verification and Navigation for Autonomous Vehicles Based on Signal Temporal Logic Constraints},
  author={Parameshwaran, Aditya and Wang, Yue},
  year={2023},
  institution={SAE Technical Paper}
}
```
**Parameshwaran, Aditya**, and Yue Wang. Safety Verification and Navigation for Autonomous Vehicles Based on Signal Temporal Logic Constraints. No. 2023-01-0113. SAE Technical Paper, 2023.

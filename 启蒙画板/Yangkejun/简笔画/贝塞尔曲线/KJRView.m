//
//  KJRView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/24.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJRView.h"

@implementation KJRView

- (UIBezierPath*)drawRecta{
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(331.782, 19.229)];
    [path addLineToPoint:CGPointMake(331.782, 19.229)];
    [path addCurveToPoint:CGPointMake(326.438, 18.641) controlPoint1:CGPointMake(331.578, 18.906) controlPoint2:CGPointMake(329.173, 18.641)];
    [path addLineToPoint:CGPointMake(321.464, 18.641)];
    [path addLineToPoint:CGPointMake(320.998, 23.481)];
    [path addCurveToPoint:CGPointMake(320.526, 37.103) controlPoint1:CGPointMake(320.741, 26.143) controlPoint2:CGPointMake(320.529, 32.273)];
    [path addLineToPoint:CGPointMake(320.521, 45.886)];
    [path addLineToPoint:CGPointMake(322.688, 45.886)];
    [path addCurveToPoint:CGPointMake(325.604, 43.197) controlPoint1:CGPointMake(324.571, 45.886) controlPoint2:CGPointMake(324.953, 45.534)];
    [path addCurveToPoint:CGPointMake(329.253, 30.163) controlPoint1:CGPointMake(326.016, 41.719) controlPoint2:CGPointMake(327.658, 35.853)];
    [path addCurveToPoint:CGPointMake(331.782, 19.229) controlPoint1:CGPointMake(330.848, 24.473) controlPoint2:CGPointMake(331.986, 19.553)];
    [path closePath];
    [path moveToPoint:CGPointMake(309.886, 37.403)];
    [path addLineToPoint:CGPointMake(309.886, 37.403)];
    [path addCurveToPoint:CGPointMake(304.553, 29.414) controlPoint1:CGPointMake(307.226, 32.999) controlPoint2:CGPointMake(304.827, 29.404)];
    [path addCurveToPoint:CGPointMake(297.836, 35.461) controlPoint1:CGPointMake(304.019, 29.433) controlPoint2:CGPointMake(297.836, 34.999)];
    [path addCurveToPoint:CGPointMake(311.938, 46.265) controlPoint1:CGPointMake(297.836, 35.881) controlPoint2:CGPointMake(310.907, 45.895)];
    [path addCurveToPoint:CGPointMake(313.779, 45.999) controlPoint1:CGPointMake(312.433, 46.443) controlPoint2:CGPointMake(313.261, 46.323)];
    [path addCurveToPoint:CGPointMake(309.886, 37.403) controlPoint1:CGPointMake(314.486, 45.557) controlPoint2:CGPointMake(313.515, 43.413)];
    [path closePath];
    [path moveToPoint:CGPointMake(358.982, 36.632)];
    [path addLineToPoint:CGPointMake(358.982, 36.632)];
    [path addCurveToPoint:CGPointMake(356.507, 33.698) controlPoint1:CGPointMake(357.942, 35.018) controlPoint2:CGPointMake(356.828, 33.698)];
    [path addCurveToPoint:CGPointMake(342.795, 41.405) controlPoint1:CGPointMake(356.185, 33.698) controlPoint2:CGPointMake(350.015, 37.166)];
    [path addCurveToPoint:CGPointMake(329.668, 50.905) controlPoint1:CGPointMake(331.379, 48.108) controlPoint2:CGPointMake(329.668, 49.346)];
    [path addCurveToPoint:CGPointMake(330.424, 52.697) controlPoint1:CGPointMake(329.668, 51.891) controlPoint2:CGPointMake(330.008, 52.697)];
    [path addCurveToPoint:CGPointMake(360.54, 40.416) controlPoint1:CGPointMake(332.064, 52.697) controlPoint2:CGPointMake(360.229, 41.212)];
    [path addCurveToPoint:CGPointMake(358.982, 36.632) controlPoint1:CGPointMake(360.723, 39.949) controlPoint2:CGPointMake(360.022, 38.246)];
    [path closePath];
    [path moveToPoint:CGPointMake(296.738, 53.405)];
    [path addLineToPoint:CGPointMake(296.738, 53.405)];
    [path addCurveToPoint:CGPointMake(233.779, 62.613) controlPoint1:CGPointMake(277.817, 50.716) controlPoint2:CGPointMake(255.664, 53.956)];
    [path addLineToPoint:CGPointMake(224.24, 66.387)];
    [path addLineToPoint:CGPointMake(217.679, 63.322)];
    [path addCurveToPoint:CGPointMake(209.078, 60.242) controlPoint1:CGPointMake(214.071, 61.637) controlPoint2:CGPointMake(210.201, 60.25)];
    [path addCurveToPoint:CGPointMake(197.609, 66.364) controlPoint1:CGPointMake(206.227, 60.219) controlPoint2:CGPointMake(201.645, 62.665)];
    [path addLineToPoint:CGPointMake(194.185, 69.501)];
    [path addLineToPoint:CGPointMake(185.455, 66.067)];
    [path addCurveToPoint:CGPointMake(121.298, 55.353) controlPoint1:CGPointMake(163.35, 57.372) controlPoint2:CGPointMake(143.527, 54.062)];
    [path addCurveToPoint:CGPointMake(31.341, 105.715) controlPoint1:CGPointMake(85.039, 57.459) controlPoint2:CGPointMake(51.555, 76.205)];
    [path addCurveToPoint:CGPointMake(9.513, 180.33) controlPoint1:CGPointMake(16.916, 126.775) controlPoint2:CGPointMake(9.513, 152.079)];
    [path addCurveToPoint:CGPointMake(40.342, 264.341) controlPoint1:CGPointMake(9.513, 213.367) controlPoint2:CGPointMake(20.151, 242.356)];
    [path addCurveToPoint:CGPointMake(99.722, 298.214) controlPoint1:CGPointMake(55.251, 280.576) controlPoint2:CGPointMake(75.431, 292.087)];
    [path addCurveToPoint:CGPointMake(182.194, 295.656) controlPoint1:CGPointMake(125.779, 304.787) controlPoint2:CGPointMake(156.924, 303.821)];
    [path addCurveToPoint:CGPointMake(217.339, 278.358) controlPoint1:CGPointMake(192.458, 292.34) controlPoint2:CGPointMake(208.762, 284.315)];
    [path addCurveToPoint:CGPointMake(247.437, 248.854) controlPoint1:CGPointMake(226.281, 272.148) controlPoint2:CGPointMake(241.235, 257.489)];
    [path addCurveToPoint:CGPointMake(264.899, 153.755) controlPoint1:CGPointMake(268.03, 220.185) controlPoint2:CGPointMake(273.923, 188.09)];
    [path addCurveToPoint:CGPointMake(245.476, 110.047) controlPoint1:CGPointMake(261.184, 139.62) controlPoint2:CGPointMake(253.51, 122.352)];
    [path addCurveToPoint:CGPointMake(242.952, 105.07) controlPoint1:CGPointMake(244.088, 107.92) controlPoint2:CGPointMake(242.952, 105.681)];
    [path addCurveToPoint:CGPointMake(242.257, 103.961) controlPoint1:CGPointMake(242.952, 104.46) controlPoint2:CGPointMake(242.639, 103.961)];
    [path addCurveToPoint:CGPointMake(239.67, 101.53) controlPoint1:CGPointMake(241.875, 103.961) controlPoint2:CGPointMake(240.711, 102.867)];
    [path addLineToPoint:CGPointMake(237.778, 99.099)];
    [path addLineToPoint:CGPointMake(239, 93.003)];
    [path addCurveToPoint:CGPointMake(239.785, 85.199) controlPoint1:CGPointMake(239.673, 89.65) controlPoint2:CGPointMake(240.026, 86.138)];
    [path addCurveToPoint:CGPointMake(228.96, 70.372) controlPoint1:CGPointMake(239.137, 82.668) controlPoint2:CGPointMake(230.591, 70.963)];
    [path addCurveToPoint:CGPointMake(260.515, 61.315) controlPoint1:CGPointMake(226.355, 69.427) controlPoint2:CGPointMake(247.016, 63.497)];
    [path addCurveToPoint:CGPointMake(294.139, 60.183) controlPoint1:CGPointMake(270.815, 59.65) controlPoint2:CGPointMake(285.227, 59.165)];
    [path addCurveToPoint:CGPointMake(318.39, 65.993) controlPoint1:CGPointMake(302.91, 61.186) controlPoint2:CGPointMake(314.167, 63.883)];
    [path addCurveToPoint:CGPointMake(322.241, 62.987) controlPoint1:CGPointMake(321.633, 67.614) controlPoint2:CGPointMake(322.035, 67.301)];
    [path addCurveToPoint:CGPointMake(317.96, 58.945) controlPoint1:CGPointMake(322.344, 60.846) controlPoint2:CGPointMake(322.084, 60.601)];
    [path addCurveToPoint:CGPointMake(296.738, 53.405) controlPoint1:CGPointMake(311.18, 56.224) controlPoint2:CGPointMake(304.737, 54.542)];
    [path closePath];
    [path moveToPoint:CGPointMake(353.085, 61.718)];
    [path addLineToPoint:CGPointMake(353.085, 61.718)];
    [path addCurveToPoint:CGPointMake(338.815, 60.817) controlPoint1:CGPointMake(340.029, 60.047) controlPoint2:CGPointMake(338.815, 59.97)];
    [path addCurveToPoint:CGPointMake(355.505, 69.583) controlPoint1:CGPointMake(338.815, 62.887) controlPoint2:CGPointMake(343.97, 65.595)];
    [path addLineToPoint:CGPointMake(361.809, 71.763)];
    [path addLineToPoint:CGPointMake(363.093, 70.117)];
    [path addCurveToPoint:CGPointMake(365.448, 63.832) controlPoint1:CGPointMake(365.037, 67.625) controlPoint2:CGPointMake(366.195, 64.534)];
    [path addCurveToPoint:CGPointMake(353.085, 61.718) controlPoint1:CGPointMake(365.088, 63.494) controlPoint2:CGPointMake(359.525, 62.543)];
    [path closePath];
    [path moveToPoint:CGPointMake(342.889, 77.71)];
    [path addLineToPoint:CGPointMake(342.889, 77.71)];
    [path addCurveToPoint:CGPointMake(334.106, 76.495) controlPoint1:CGPointMake(335.254, 74.924) controlPoint2:CGPointMake(334.749, 74.854)];
    [path addCurveToPoint:CGPointMake(342.249, 86.174) controlPoint1:CGPointMake(333.755, 77.391) controlPoint2:CGPointMake(335.885, 79.923)];
    [path addCurveToPoint:CGPointMake(351.685, 94.64) controlPoint1:CGPointMake(346.989, 90.83) controlPoint2:CGPointMake(351.235, 94.64)];
    [path addCurveToPoint:CGPointMake(359.305, 85.455) controlPoint1:CGPointMake(352.599, 94.64) controlPoint2:CGPointMake(359.305, 86.556)];
    [path addCurveToPoint:CGPointMake(342.889, 77.71) controlPoint1:CGPointMake(359.305, 84.549) controlPoint2:CGPointMake(351.355, 80.798)];
    [path closePath];
    [path moveToPoint:CGPointMake(334.394, 91.441)];
    [path addLineToPoint:CGPointMake(334.394, 91.441)];
    [path addCurveToPoint:CGPointMake(326.809, 83.777) controlPoint1:CGPointMake(330.537, 85.028) controlPoint2:CGPointMake(327.779, 82.24)];
    [path addCurveToPoint:CGPointMake(330.388, 101.633) controlPoint1:CGPointMake(326.506, 84.258) controlPoint2:CGPointMake(329.52, 99.294)];
    [path addCurveToPoint:CGPointMake(333.854, 101.35) controlPoint1:CGPointMake(330.647, 102.329) controlPoint2:CGPointMake(331.429, 102.265)];
    [path addCurveToPoint:CGPointMake(334.394, 91.441) controlPoint1:CGPointMake(339.138, 99.355) controlPoint2:CGPointMake(339.139, 99.333)];
    [path closePath];
    [path moveToPoint:CGPointMake(119.984, 82.466)];
    [path addCurveToPoint:CGPointMake(111.387, 85.206) controlPoint1:CGPointMake(118.157, 82.763) controlPoint2:CGPointMake(114.288, 83.996)];
    [path addCurveToPoint:CGPointMake(52.747, 139.873) controlPoint1:CGPointMake(87.374, 95.217) controlPoint2:CGPointMake(63.428, 117.541)];
    [path addCurveToPoint:CGPointMake(49.915, 174.076) controlPoint1:CGPointMake(43.769, 158.643) controlPoint2:CGPointMake(42.834, 169.927)];
    [path addCurveToPoint:CGPointMake(60.766, 163.3) controlPoint1:CGPointMake(54.179, 176.575) controlPoint2:CGPointMake(57.767, 173.012)];
    [path addCurveToPoint:CGPointMake(120.561, 100.033) controlPoint1:CGPointMake(68.013, 139.83) controlPoint2:CGPointMake(91.763, 114.701)];
    [path addCurveToPoint:CGPointMake(133.172, 89.65) controlPoint1:CGPointMake(126.834, 96.837) controlPoint2:CGPointMake(131.895, 92.671)];
    [path addCurveToPoint:CGPointMake(132.906, 85.707) controlPoint1:CGPointMake(133.948, 87.816) controlPoint2:CGPointMake(133.906, 87.204)];
    [path addCurveToPoint:CGPointMake(130.44, 83.292) controlPoint1:CGPointMake(132.254, 84.733) controlPoint2:CGPointMake(131.145, 83.646)];
    [path addCurveToPoint:CGPointMake(119.984, 82.466) controlPoint1:CGPointMake(128.391, 82.262) controlPoint2:CGPointMake(123.577, 81.881)];
    [path closePath];
    [path moveToPoint:CGPointMake(41.131, 193.926)];
    [path addCurveToPoint:CGPointMake(37.479, 205.384) controlPoint1:CGPointMake(37.933, 196.562) controlPoint2:CGPointMake(37.077, 199.249)];
    [path addCurveToPoint:CGPointMake(44.061, 220.376) controlPoint1:CGPointMake(37.879, 211.497) controlPoint2:CGPointMake(40.746, 218.027)];
    [path addCurveToPoint:CGPointMake(54.107, 220.246) controlPoint1:CGPointMake(46.544, 222.135) controlPoint2:CGPointMake(51.604, 222.07)];
    [path addCurveToPoint:CGPointMake(58.909, 208.765) controlPoint1:CGPointMake(58.112, 217.327) controlPoint2:CGPointMake(58.909, 215.422)];
    [path addCurveToPoint:CGPointMake(54.043, 193.961) controlPoint1:CGPointMake(58.909, 201.429) controlPoint2:CGPointMake(57.35, 196.687)];
    [path addCurveToPoint:CGPointMake(41.131, 193.926) controlPoint1:CGPointMake(50.899, 191.369) controlPoint2:CGPointMake(44.254, 191.351)];
    [path closePath];
    
    
    //Path color fill
    [[UIColor colorWithRed:0.955 green: 0.954 blue:0.954 alpha:1] setFill];
    [path fill];
    
    [[UIColor blackColor] setStroke];
    path.lineWidth = 1;
    [path stroke];

    return path;
}

@end

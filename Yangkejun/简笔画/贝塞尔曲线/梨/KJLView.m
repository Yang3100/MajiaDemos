//
//  KJLView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJLView.h"

@implementation KJLView
- (UIBezierPath*)drawRecta{
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(209.839, 1.847)];
    [path addCurveToPoint:CGPointMake(174.083, 62.109) controlPoint1:CGPointMake(197.554, 10.406) controlPoint2:CGPointMake(183.306, 34.42)];
    [path addCurveToPoint:CGPointMake(170.499, 71.328) controlPoint1:CGPointMake(172.571, 66.647) controlPoint2:CGPointMake(170.959, 70.796)];
    [path addCurveToPoint:CGPointMake(170.215, 73.678) controlPoint1:CGPointMake(170.04, 71.861) controlPoint2:CGPointMake(169.911, 72.918)];
    [path addCurveToPoint:CGPointMake(166.851, 72.43) controlPoint1:CGPointMake(171.146, 76.012) controlPoint2:CGPointMake(168.978, 75.208)];
    [path addCurveToPoint:CGPointMake(148.252, 59.228) controlPoint1:CGPointMake(164.109, 68.848) controlPoint2:CGPointMake(155.504, 62.741)];
    [path addCurveToPoint:CGPointMake(126.748, 50.339) controlPoint1:CGPointMake(144.955, 57.632) controlPoint2:CGPointMake(135.278, 53.632)];
    [path addCurveToPoint:CGPointMake(81.939, 27.632) controlPoint1:CGPointMake(99.419, 39.792) controlPoint2:CGPointMake(88.41, 34.213)];
    [path addCurveToPoint:CGPointMake(78.615, 25.478) controlPoint1:CGPointMake(80.529, 26.198) controlPoint2:CGPointMake(79.033, 25.229)];
    [path addCurveToPoint:CGPointMake(76.005, 29.418) controlPoint1:CGPointMake(78.197, 25.726) controlPoint2:CGPointMake(77.022, 27.499)];
    [path addCurveToPoint:CGPointMake(77.305, 43.298) controlPoint1:CGPointMake(73.658, 33.842) controlPoint2:CGPointMake(74.109, 38.652)];
    [path addCurveToPoint:CGPointMake(165.501, 77.129) controlPoint1:CGPointMake(86.027, 55.973) controlPoint2:CGPointMake(122.347, 69.905)];
    [path addCurveToPoint:CGPointMake(168.811, 79.233) controlPoint1:CGPointMake(167.907, 77.532) controlPoint2:CGPointMake(168.811, 78.106)];
    [path addCurveToPoint:CGPointMake(164.263, 81.364) controlPoint1:CGPointMake(168.811, 80.459) controlPoint2:CGPointMake(167.858, 80.905)];
    [path addCurveToPoint:CGPointMake(135.142, 91.693) controlPoint1:CGPointMake(156.77, 82.32) controlPoint2:CGPointMake(142.863, 87.253)];
    [path addCurveToPoint:CGPointMake(106.067, 118.66) controlPoint1:CGPointMake(125.266, 97.372) controlPoint2:CGPointMake(112.605, 109.115)];
    [path addCurveToPoint:CGPointMake(92.464, 150.199) controlPoint1:CGPointMake(100.17, 127.268) controlPoint2:CGPointMake(94.604, 140.173)];
    [path addCurveToPoint:CGPointMake(90.328, 172.699) controlPoint1:CGPointMake(91.666, 153.935) controlPoint2:CGPointMake(90.705, 164.06)];
    [path addCurveToPoint:CGPointMake(73.485, 207.504) controlPoint1:CGPointMake(89.427, 193.323) controlPoint2:CGPointMake(89.678, 192.804)];
    [path addCurveToPoint:CGPointMake(40.765, 243.859) controlPoint1:CGPointMake(59.042, 220.616) controlPoint2:CGPointMake(49.411, 231.317)];
    [path addCurveToPoint:CGPointMake(12.464, 310.864) controlPoint1:CGPointMake(26.706, 264.254) controlPoint2:CGPointMake(17.976, 284.922)];
    [path addCurveToPoint:CGPointMake(10.731, 359.183) controlPoint1:CGPointMake(10.153, 321.737) controlPoint2:CGPointMake(9.231, 347.455)];
    [path addCurveToPoint:CGPointMake(129.629, 486.067) controlPoint1:CGPointMake(19.048, 424.227) controlPoint2:CGPointMake(62.655, 470.762)];
    [path addCurveToPoint:CGPointMake(229.475, 486.401) controlPoint1:CGPointMake(157.365, 492.405) controlPoint2:CGPointMake(197.942, 492.541)];
    [path addCurveToPoint:CGPointMake(347.135, 398.783) controlPoint1:CGPointMake(286.014, 475.391) controlPoint2:CGPointMake(329.319, 443.143)];
    [path addCurveToPoint:CGPointMake(356.848, 346.438) controlPoint1:CGPointMake(354.091, 381.465) controlPoint2:CGPointMake(356.84, 366.648)];
    [path addCurveToPoint:CGPointMake(338.78, 273.311) controlPoint1:CGPointMake(356.858, 319.739) controlPoint2:CGPointMake(351.641, 298.624)];
    [path addCurveToPoint:CGPointMake(281.241, 205.188) controlPoint1:CGPointMake(325.346, 246.872) controlPoint2:CGPointMake(307.122, 225.295)];
    [path addCurveToPoint:CGPointMake(267.576, 189.498) controlPoint1:CGPointMake(272.286, 198.23) controlPoint2:CGPointMake(269.248, 194.742)];
    [path addCurveToPoint:CGPointMake(265.913, 171.426) controlPoint1:CGPointMake(267.086, 187.964) controlPoint2:CGPointMake(266.338, 179.831)];
    [path addCurveToPoint:CGPointMake(263.821, 150.186) controlPoint1:CGPointMake(265.488, 163.02) controlPoint2:CGPointMake(264.547, 153.462)];
    [path addCurveToPoint:CGPointMake(205.465, 84.678) controlPoint1:CGPointMake(256.998, 119.38) controlPoint2:CGPointMake(234.598, 94.235)];
    [path addCurveToPoint:CGPointMake(180.172, 80.153) controlPoint1:CGPointMake(198.178, 82.288) controlPoint2:CGPointMake(186.246, 80.153)];
    [path addCurveToPoint:CGPointMake(178.193, 71.501) controlPoint1:CGPointMake(175.041, 80.153) controlPoint2:CGPointMake(175.01, 80.018)];
    [path addCurveToPoint:CGPointMake(226.022, 8.182) controlPoint1:CGPointMake(187.119, 47.61) controlPoint2:CGPointMake(206.935, 21.378)];
    [path addLineToPoint:CGPointMake(229.822, 5.555)];
    [path addLineToPoint:CGPointMake(225.581, 4.967)];
    [path addCurveToPoint:CGPointMake(214.344, 0.713) controlPoint1:CGPointMake(220.385, 4.247) controlPoint2:CGPointMake(215.675, 2.464)];
    [path addCurveToPoint:CGPointMake(209.839, 1.847) controlPoint1:CGPointMake(213.472, -0.434) controlPoint2:CGPointMake(212.912, -0.294)];
    [path closePath];
    [path moveToPoint:CGPointMake(166.371, 92.144)];
    [path addLineToPoint:CGPointMake(166.371, 92.144)];
    [path addCurveToPoint:CGPointMake(161.841, 91.1) controlPoint1:CGPointMake(166.637, 90.57) controlPoint2:CGPointMake(163.756, 89.906)];
    [path addCurveToPoint:CGPointMake(169.799, 95.214) controlPoint1:CGPointMake(158.608, 93.116) controlPoint2:CGPointMake(164.477, 96.15)];
    [path addCurveToPoint:CGPointMake(169.019, 94.182) controlPoint1:CGPointMake(171.704, 94.878) controlPoint2:CGPointMake(171.631, 94.782)];
    [path addCurveToPoint:CGPointMake(166.371, 92.144) controlPoint1:CGPointMake(167.063, 93.733) controlPoint2:CGPointMake(166.212, 93.078)];
    [path closePath];
    [path moveToPoint:CGPointMake(178.49, 92.427)];
    [path addLineToPoint:CGPointMake(178.49, 92.427)];
    [path addCurveToPoint:CGPointMake(173.892, 93.313) controlPoint1:CGPointMake(176.792, 90.46) controlPoint2:CGPointMake(174.366, 90.928)];
    [path addCurveToPoint:CGPointMake(175.944, 95.436) controlPoint1:CGPointMake(173.523, 95.169) controlPoint2:CGPointMake(173.781, 95.436)];
    [path addCurveToPoint:CGPointMake(178.49, 92.427) controlPoint1:CGPointMake(178.88, 95.436) controlPoint2:CGPointMake(179.973, 94.145)];
    [path closePath];
    [path moveToPoint:CGPointMake(90.903, 245.859)];
    [path addLineToPoint:CGPointMake(90.903, 245.859)];
    [path addCurveToPoint:CGPointMake(58.809, 257.918) controlPoint1:CGPointMake(79.558, 243.112) controlPoint2:CGPointMake(69.027, 247.069)];
    [path addCurveToPoint:CGPointMake(43.45, 295.194) controlPoint1:CGPointMake(50.159, 267.102) controlPoint2:CGPointMake(43.45, 283.386)];
    [path addCurveToPoint:CGPointMake(52.44, 319.609) controlPoint1:CGPointMake(43.45, 304.802) controlPoint2:CGPointMake(46.962, 314.34)];
    [path addCurveToPoint:CGPointMake(96.094, 309.916) controlPoint1:CGPointMake(63.745, 330.481) controlPoint2:CGPointMake(83.437, 326.108)];
    [path addCurveToPoint:CGPointMake(106.103, 260.575) controlPoint1:CGPointMake(107.723, 295.039) controlPoint2:CGPointMake(111.745, 275.213)];
    [path addCurveToPoint:CGPointMake(90.903, 245.859) controlPoint1:CGPointMake(103.498, 253.815) controlPoint2:CGPointMake(96.741, 247.273)];
    [path closePath];
    [path moveToPoint:CGPointMake(76.314, 332.918)];
    [path addLineToPoint:CGPointMake(76.314, 332.918)];
    [path addCurveToPoint:CGPointMake(65.03, 332.182) controlPoint1:CGPointMake(73.676, 330.622) controlPoint2:CGPointMake(69.166, 330.328)];
    [path addCurveToPoint:CGPointMake(57.248, 364.524) controlPoint1:CGPointMake(52.614, 337.748) controlPoint2:CGPointMake(47.881, 357.414)];
    [path addCurveToPoint:CGPointMake(63.938, 366.068) controlPoint1:CGPointMake(59.299, 366.081) controlPoint2:CGPointMake(60.575, 366.376)];
    [path addCurveToPoint:CGPointMake(80.051, 349.748) controlPoint1:CGPointMake(71.404, 365.386) controlPoint2:CGPointMake(77.503, 359.207)];
    [path addCurveToPoint:CGPointMake(76.314, 332.918) controlPoint1:CGPointMake(81.949, 342.702) controlPoint2:CGPointMake(80.606, 336.654)];
    [path closePath];
    [path moveToPoint:CGPointMake(82.294, 24.378)];
    [path addCurveToPoint:CGPointMake(88.386, 28.612) controlPoint1:CGPointMake(82.294, 24.564) controlPoint2:CGPointMake(85.036, 26.469)];
    [path addCurveToPoint:CGPointMake(130.472, 49) controlPoint1:CGPointMake(95.944, 33.445) controlPoint2:CGPointMake(108.686, 39.618)];
    [path addCurveToPoint:CGPointMake(163.671, 66.761) controlPoint1:CGPointMake(149.766, 57.31) controlPoint2:CGPointMake(156.085, 60.69)];
    [path addLineToPoint:CGPointMake(169.09, 71.099)];
    [path addLineToPoint:CGPointMake(168.541, 67.846)];
    [path addCurveToPoint:CGPointMake(146.105, 42.055) controlPoint1:CGPointMake(167.072, 59.138) controlPoint2:CGPointMake(158.153, 48.886)];
    [path addCurveToPoint:CGPointMake(115.4, 30.173) controlPoint1:CGPointMake(138.631, 37.818) controlPoint2:CGPointMake(124.678, 32.418)];
    [path addCurveToPoint:CGPointMake(82.294, 24.378) controlPoint1:CGPointMake(105.654, 27.815) controlPoint2:CGPointMake(82.294, 23.725)];
    [path closePath];
    
    
    //Path color fill
    [[UIColor colorWithRed:0.972 green: 0.777 blue:0.124 alpha:1] setFill];
    [path fill];
    
    [[UIColor blackColor] setStroke];
    path.lineWidth = 1;
    [path stroke];

    return path;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

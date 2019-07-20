//
//  KJCView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJCView.h"

@implementation KJCView

- (UIBezierPath*)drawRecta{
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(171.699, 11.496)];
    [path addLineToPoint:CGPointMake(171.699, 11.496)];
    [path addCurveToPoint:CGPointMake(142.891, 12.865) controlPoint1:CGPointMake(164.412, 6.164) controlPoint2:CGPointMake(150.85, 6.809)];
    [path addCurveToPoint:CGPointMake(132.088, 18.01) controlPoint1:CGPointMake(139.172, 15.695) controlPoint2:CGPointMake(134.311, 18.01)];
    [path addCurveToPoint:CGPointMake(106.289, 53.766) controlPoint1:CGPointMake(125.3, 18.01) controlPoint2:CGPointMake(112.752, 35.401)];
    [path addCurveToPoint:CGPointMake(85.422, 78.642) controlPoint1:CGPointMake(100.441, 70.383) controlPoint2:CGPointMake(99.49, 71.516)];
    [path addCurveToPoint:CGPointMake(33.555, 131.32) controlPoint1:CGPointMake(64.796, 89.089) controlPoint2:CGPointMake(44.993, 109.201)];
    [path addCurveToPoint:CGPointMake(23.936, 154.34) controlPoint1:CGPointMake(28.265, 141.551) controlPoint2:CGPointMake(23.936, 151.909)];
    [path addCurveToPoint:CGPointMake(77.793, 181.492) controlPoint1:CGPointMake(23.936, 158.856) controlPoint2:CGPointMake(40.48, 167.196)];
    [path addCurveToPoint:CGPointMake(95.67, 190.026) controlPoint1:CGPointMake(87.666, 185.275) controlPoint2:CGPointMake(95.711, 189.116)];
    [path addCurveToPoint:CGPointMake(73.729, 203.866) controlPoint1:CGPointMake(95.629, 190.937) controlPoint2:CGPointMake(85.756, 197.165)];
    [path addCurveToPoint:CGPointMake(45.225, 221.077) controlPoint1:CGPointMake(61.702, 210.566) controlPoint2:CGPointMake(48.875, 218.311)];
    [path addLineToPoint:CGPointMake(38.589, 226.105)];
    [path addLineToPoint:CGPointMake(46.049, 233.637)];
    [path addCurveToPoint:CGPointMake(101.004, 259.967) controlPoint1:CGPointMake(55.488, 243.168) controlPoint2:CGPointMake(78.768, 254.323)];
    [path addCurveToPoint:CGPointMake(124.004, 274.324) controlPoint1:CGPointMake(116.353, 263.864) controlPoint2:CGPointMake(118.86, 265.428)];
    [path addCurveToPoint:CGPointMake(153.254, 294.342) controlPoint1:CGPointMake(131.69, 287.616) controlPoint2:CGPointMake(141.518, 294.342)];
    [path addCurveToPoint:CGPointMake(166.16, 269.639) controlPoint1:CGPointMake(168.087, 294.342) controlPoint2:CGPointMake(172.562, 285.777)];
    [path addCurveToPoint:CGPointMake(182.771, 260.41) controlPoint1:CGPointMake(165.151, 267.093) controlPoint2:CGPointMake(169.913, 264.447)];
    [path addCurveToPoint:CGPointMake(208.545, 249.777) controlPoint1:CGPointMake(192.686, 257.297) controlPoint2:CGPointMake(204.284, 252.512)];
    [path addLineToPoint:CGPointMake(216.291, 244.804)];
    [path addLineToPoint:CGPointMake(225.205, 251.382)];
    [path addCurveToPoint:CGPointMake(245.357, 256.501) controlPoint1:CGPointMake(232.615, 256.849) controlPoint2:CGPointMake(236.016, 257.713)];
    [path addCurveToPoint:CGPointMake(265.957, 236.996) controlPoint1:CGPointMake(258.193, 254.836) controlPoint2:CGPointMake(265.957, 247.484)];
    [path addCurveToPoint:CGPointMake(254.87, 216.01) controlPoint1:CGPointMake(265.957, 230.731) controlPoint2:CGPointMake(260, 219.455)];
    [path addCurveToPoint:CGPointMake(259.636, 205.293) controlPoint1:CGPointMake(253.723, 215.24) controlPoint2:CGPointMake(255.867, 210.417)];
    [path addLineToPoint:CGPointMake(266.488, 195.976)];
    [path addLineToPoint:CGPointMake(282.395, 208.376)];
    [path addCurveToPoint:CGPointMake(341.456, 237.75) controlPoint1:CGPointMake(302.778, 224.266) controlPoint2:CGPointMake(334.833, 240.209)];
    [path addCurveToPoint:CGPointMake(344.997, 224.358) controlPoint1:CGPointMake(345.507, 236.246) controlPoint2:CGPointMake(346.115, 233.949)];
    [path addCurveToPoint:CGPointMake(348.676, 204.804) controlPoint1:CGPointMake(344, 215.801) controlPoint2:CGPointMake(344.96, 210.7)];
    [path addCurveToPoint:CGPointMake(349.706, 180.846) controlPoint1:CGPointMake(354.757, 195.157) controlPoint2:CGPointMake(355.055, 188.234)];
    [path addCurveToPoint:CGPointMake(348.54, 173.591) controlPoint1:CGPointMake(346.981, 177.083) controlPoint2:CGPointMake(346.606, 174.747)];
    [path addCurveToPoint:CGPointMake(353.323, 148.95) controlPoint1:CGPointMake(354.414, 170.079) controlPoint2:CGPointMake(356.515, 159.257)];
    [path addCurveToPoint:CGPointMake(355.952, 132.95) controlPoint1:CGPointMake(350.503, 139.847) controlPoint2:CGPointMake(350.758, 138.298)];
    [path addCurveToPoint:CGPointMake(356.493, 105.698) controlPoint1:CGPointMake(363.075, 125.614) controlPoint2:CGPointMake(363.217, 118.449)];
    [path addCurveToPoint:CGPointMake(354.402, 87.826) controlPoint1:CGPointMake(352.083, 97.336) controlPoint2:CGPointMake(351.762, 94.592)];
    [path addCurveToPoint:CGPointMake(333.211, 79.36) controlPoint1:CGPointMake(359.469, 74.841) controlPoint2:CGPointMake(354.858, 72.999)];
    [path addCurveToPoint:CGPointMake(273.36, 113.797) controlPoint1:CGPointMake(313.91, 85.031) controlPoint2:CGPointMake(289.812, 98.897)];
    [path addLineToPoint:CGPointMake(263.476, 122.75)];
    [path addLineToPoint:CGPointMake(253.179, 110.904)];
    [path addCurveToPoint:CGPointMake(241.04, 87.479) controlPoint1:CGPointMake(246.039, 102.691) controlPoint2:CGPointMake(242.316, 95.506)];
    [path addCurveToPoint:CGPointMake(216.94, 43.85) controlPoint1:CGPointMake(238.265, 70.03) controlPoint2:CGPointMake(227.189, 49.978)];
    [path addCurveToPoint:CGPointMake(204.734, 30.75) controlPoint1:CGPointMake(212.063, 40.934) controlPoint2:CGPointMake(206.57, 35.039)];
    [path addCurveToPoint:CGPointMake(183.584, 15.356) controlPoint1:CGPointMake(200.696, 21.319) controlPoint2:CGPointMake(192.655, 15.466)];
    [path addCurveToPoint:CGPointMake(171.699, 11.496) controlPoint1:CGPointMake(179.887, 15.311) controlPoint2:CGPointMake(174.539, 13.574)];
    [path closePath];
    [path moveToPoint:CGPointMake(146.647, 25.815)];
    [path addCurveToPoint:CGPointMake(136.786, 30.875) controlPoint1:CGPointMake(143.194, 28.598) controlPoint2:CGPointMake(138.756, 30.875)];
    [path addCurveToPoint:CGPointMake(118.41, 59.177) controlPoint1:CGPointMake(132.815, 30.875) controlPoint2:CGPointMake(120.964, 49.129)];
    [path addLineToPoint:CGPointMake(116.775, 65.609)];
    [path addLineToPoint:CGPointMake(150.808, 65.609)];
    [path addCurveToPoint:CGPointMake(205.452, 75.131) controlPoint1:CGPointMake(184.568, 65.609) controlPoint2:CGPointMake(185.006, 65.686)];
    [path addCurveToPoint:CGPointMake(226.064, 80.503) controlPoint1:CGPointMake(222.119, 82.831) controlPoint2:CGPointMake(226.064, 83.859)];
    [path addCurveToPoint:CGPointMake(204.992, 51.134) controlPoint1:CGPointMake(226.064, 72.864) controlPoint2:CGPointMake(212.903, 54.522)];
    [path addCurveToPoint:CGPointMake(193.213, 38.043) controlPoint1:CGPointMake(199.955, 48.977) controlPoint2:CGPointMake(195.759, 44.313)];
    [path addCurveToPoint:CGPointMake(177.217, 28.097) controlPoint1:CGPointMake(189.613, 29.178) controlPoint2:CGPointMake(185.529, 26.638)];
    [path addCurveToPoint:CGPointMake(168.667, 24.543) controlPoint1:CGPointMake(175.95, 28.32) controlPoint2:CGPointMake(172.102, 26.72)];
    [path addCurveToPoint:CGPointMake(146.647, 25.815) controlPoint1:CGPointMake(160.412, 19.31) controlPoint2:CGPointMake(154.278, 19.664)];
    [path closePath];
    [path moveToPoint:CGPointMake(159.312, 89.378)];
    [path addCurveToPoint:CGPointMake(174.587, 121.81) controlPoint1:CGPointMake(166.172, 99.1) controlPoint2:CGPointMake(171.892, 111.246)];
    [path addCurveToPoint:CGPointMake(171.783, 160.766) controlPoint1:CGPointMake(178.852, 138.531) controlPoint2:CGPointMake(178.824, 138.92)];
    [path addCurveToPoint:CGPointMake(149.928, 214.273) controlPoint1:CGPointMake(167.872, 172.902) controlPoint2:CGPointMake(158.037, 196.981)];
    [path addCurveToPoint:CGPointMake(146.05, 254.719) controlPoint1:CGPointMake(129.486, 257.863) controlPoint2:CGPointMake(129.787, 254.719)];
    [path addCurveToPoint:CGPointMake(204.787, 237.326) controlPoint1:CGPointMake(161.706, 254.719) controlPoint2:CGPointMake(187.289, 247.143)];
    [path addCurveToPoint:CGPointMake(251.882, 193.294) controlPoint1:CGPointMake(221.13, 228.157) controlPoint2:CGPointMake(243.039, 207.673)];
    [path addCurveToPoint:CGPointMake(252.702, 132.857) controlPoint1:CGPointMake(262.023, 176.805) controlPoint2:CGPointMake(262.371, 151.17)];
    [path addCurveToPoint:CGPointMake(163.546, 75.353) controlPoint1:CGPointMake(238.648, 106.235) controlPoint2:CGPointMake(195.754, 78.569)];
    [path addLineToPoint:CGPointMake(148.346, 73.836)];
    [path addLineToPoint:CGPointMake(159.312, 89.378)];
    [path closePath];
    [path moveToPoint:CGPointMake(113.942, 80.763)];
    [path addCurveToPoint:CGPointMake(60.407, 114.495) controlPoint1:CGPointMake(95.289, 85.623) controlPoint2:CGPointMake(72.342, 100.082)];
    [path addCurveToPoint:CGPointMake(39.952, 150.697) controlPoint1:CGPointMake(50.265, 126.742) controlPoint2:CGPointMake(40.078, 144.773)];
    [path addCurveToPoint:CGPointMake(78.454, 168.306) controlPoint1:CGPointMake(39.92, 152.213) controlPoint2:CGPointMake(57.246, 160.136)];
    [path addCurveToPoint:CGPointMake(118.577, 185.604) controlPoint1:CGPointMake(99.663, 176.475) controlPoint2:CGPointMake(117.718, 184.26)];
    [path addCurveToPoint:CGPointMake(85.893, 211.41) controlPoint1:CGPointMake(121.247, 189.783) controlPoint2:CGPointMake(114.712, 194.943)];
    [path addLineToPoint:CGPointMake(58.031, 227.331)];
    [path addLineToPoint:CGPointMake(64.255, 231.923)];
    [path addCurveToPoint:CGPointMake(112.519, 249.482) controlPoint1:CGPointMake(72.109, 237.719) controlPoint2:CGPointMake(104.778, 249.603)];
    [path addCurveToPoint:CGPointMake(130.863, 223.109) controlPoint1:CGPointMake(117.296, 249.407) controlPoint2:CGPointMake(120.614, 244.636)];
    [path addCurveToPoint:CGPointMake(143.306, 89.978) controlPoint1:CGPointMake(169.043, 142.911) controlPoint2:CGPointMake(170.841, 123.677)];
    [path addCurveToPoint:CGPointMake(113.942, 80.763) controlPoint1:CGPointMake(131.919, 76.042) controlPoint2:CGPointMake(131.983, 76.062)];
    [path closePath];
    [path moveToPoint:CGPointMake(116.795, 104.09)];
    [path addLineToPoint:CGPointMake(116.795, 104.09)];
    [path addCurveToPoint:CGPointMake(76.871, 113.208) controlPoint1:CGPointMake(102.494, 96.936) controlPoint2:CGPointMake(86.148, 100.669)];
    [path addCurveToPoint:CGPointMake(71.493, 135.979) controlPoint1:CGPointMake(71.681, 120.223) controlPoint2:CGPointMake(71.02, 123.022)];
    [path addCurveToPoint:CGPointMake(99.723, 162.094) controlPoint1:CGPointMake(71.955, 148.599) controlPoint2:CGPointMake(86.542, 162.094)];
    [path addCurveToPoint:CGPointMake(132.979, 131.219) controlPoint1:CGPointMake(117.467, 162.094) controlPoint2:CGPointMake(132.979, 147.693)];
    [path addCurveToPoint:CGPointMake(116.795, 104.09) controlPoint1:CGPointMake(132.979, 121.853) controlPoint2:CGPointMake(124.759, 108.074)];
    [path closePath];
    [path moveToPoint:CGPointMake(320.479, 96.499)];
    [path addCurveToPoint:CGPointMake(272.884, 132.561) controlPoint1:CGPointMake(306.448, 103.104) controlPoint2:CGPointMake(279.16, 123.779)];
    [path addCurveToPoint:CGPointMake(292.163, 137.707) controlPoint1:CGPointMake(269.241, 137.658) controlPoint2:CGPointMake(269.627, 137.761)];
    [path addCurveToPoint:CGPointMake(315.16, 141.511) controlPoint1:CGPointMake(310.857, 137.662) controlPoint2:CGPointMake(315.16, 138.373)];
    [path addCurveToPoint:CGPointMake(297.121, 146.869) controlPoint1:CGPointMake(315.16, 144.414) controlPoint2:CGPointMake(310.693, 145.741)];
    [path addCurveToPoint:CGPointMake(276.318, 151.041) controlPoint1:CGPointMake(287.199, 147.694) controlPoint2:CGPointMake(277.838, 149.571)];
    [path addCurveToPoint:CGPointMake(292.363, 152.413) controlPoint1:CGPointMake(274.407, 152.89) controlPoint2:CGPointMake(279.355, 153.313)];
    [path addCurveToPoint:CGPointMake(311.17, 156.602) controlPoint1:CGPointMake(310.212, 151.177) controlPoint2:CGPointMake(311.17, 151.391)];
    [path addCurveToPoint:CGPointMake(301.197, 162.35) controlPoint1:CGPointMake(311.17, 161.187) controlPoint2:CGPointMake(309.524, 162.136)];
    [path addCurveToPoint:CGPointMake(284.601, 164.39) controlPoint1:CGPointMake(295.711, 162.491) controlPoint2:CGPointMake(288.243, 163.409)];
    [path addCurveToPoint:CGPointMake(299.107, 173.716) controlPoint1:CGPointMake(276.011, 166.703) controlPoint2:CGPointMake(280.67, 169.699)];
    [path addCurveToPoint:CGPointMake(312.5, 180.299) controlPoint1:CGPointMake(307.511, 175.547) controlPoint2:CGPointMake(312.5, 177.999)];
    [path addCurveToPoint:CGPointMake(281.817, 181.342) controlPoint1:CGPointMake(312.5, 185.767) controlPoint2:CGPointMake(292.052, 186.462)];
    [path addCurveToPoint:CGPointMake(272.018, 178.529) controlPoint1:CGPointMake(277.211, 179.038) controlPoint2:CGPointMake(272.801, 177.772)];
    [path addCurveToPoint:CGPointMake(315.93, 215.633) controlPoint1:CGPointMake(269.116, 181.337) controlPoint2:CGPointMake(299.968, 207.406)];
    [path addLineToPoint:CGPointMake(332.447, 224.146)];
    [path addLineToPoint:CGPointMake(332.447, 215.481)];
    [path addCurveToPoint:CGPointMake(336.352, 201.823) controlPoint1:CGPointMake(332.447, 210.716) controlPoint2:CGPointMake(334.204, 204.57)];
    [path addCurveToPoint:CGPointMake(336.436, 182.677) controlPoint1:CGPointMake(341.427, 195.331) controlPoint2:CGPointMake(341.465, 186.715)];
    [path addCurveToPoint:CGPointMake(337.498, 166.188) controlPoint1:CGPointMake(330.989, 178.304) controlPoint2:CGPointMake(331.428, 171.503)];
    [path addCurveToPoint:CGPointMake(341.172, 147.061) controlPoint1:CGPointMake(341.706, 162.504) controlPoint2:CGPointMake(342.32, 159.309)];
    [path addCurveToPoint:CGPointMake(344.099, 128.9) controlPoint1:CGPointMake(340.088, 135.495) controlPoint2:CGPointMake(340.712, 131.619)];
    [path addCurveToPoint:CGPointMake(344.499, 109.198) controlPoint1:CGPointMake(349.46, 124.595) controlPoint2:CGPointMake(349.64, 115.772)];
    [path addCurveToPoint:CGPointMake(340.51, 97.128) controlPoint1:CGPointMake(342.352, 106.451) controlPoint2:CGPointMake(340.557, 101.019)];
    [path addCurveToPoint:CGPointMake(320.479, 96.499) controlPoint1:CGPointMake(340.407, 88.513) controlPoint2:CGPointMake(337.63, 88.426)];
    [path closePath];
    [path moveToPoint:CGPointMake(235.684, 231.248)];
    [path addCurveToPoint:CGPointMake(242.396, 244.427) controlPoint1:CGPointMake(227.636, 239.375) controlPoint2:CGPointMake(230.209, 244.427)];
    [path addCurveToPoint:CGPointMake(251.603, 232.987) controlPoint1:CGPointMake(251.07, 244.427) controlPoint2:CGPointMake(253.718, 241.137)];
    [path addCurveToPoint:CGPointMake(235.684, 231.248) controlPoint1:CGPointMake(249.277, 224.021) controlPoint2:CGPointMake(243.47, 223.386)];
    [path closePath];
    [path moveToPoint:CGPointMake(138.265, 272.671)];
    [path addCurveToPoint:CGPointMake(153.473, 282.063) controlPoint1:CGPointMake(141.321, 278.194) controlPoint2:CGPointMake(151.179, 284.282)];
    [path addCurveToPoint:CGPointMake(153.194, 274.136) controlPoint1:CGPointMake(154.254, 281.307) controlPoint2:CGPointMake(154.129, 277.739)];
    [path addCurveToPoint:CGPointMake(143.473, 267.584) controlPoint1:CGPointMake(151.843, 268.927) controlPoint2:CGPointMake(149.85, 267.584)];
    [path addCurveToPoint:CGPointMake(138.265, 272.671) controlPoint1:CGPointMake(136.306, 267.584) controlPoint2:CGPointMake(135.751, 268.126)];
    [path closePath];
    [path moveToPoint:CGPointMake(113.966, 132.254)];
    [path addCurveToPoint:CGPointMake(116.331, 139.814) controlPoint1:CGPointMake(113.132, 142.396) controlPoint2:CGPointMake(113.497, 143.563)];
    [path addCurveToPoint:CGPointMake(117.276, 123.81) controlPoint1:CGPointMake(120.223, 134.663) controlPoint2:CGPointMake(120.567, 128.838)];
    [path addCurveToPoint:CGPointMake(113.966, 132.254) controlPoint1:CGPointMake(115.707, 121.414) controlPoint2:CGPointMake(114.632, 124.158)];
    [path closePath];
    
    
    //Path color fill
    [[UIColor colorWithRed:0.99 green: 0.982 blue:0.991 alpha:1] setFill];
    [path fill];
    
    [[UIColor blackColor] setStroke];
    path.lineWidth = 1;
    [path stroke];

    return path;
}

@end

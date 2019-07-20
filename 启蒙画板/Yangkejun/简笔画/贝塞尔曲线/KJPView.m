//
//  KJPView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/24.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJPView.h"

@implementation KJPView
- (UIBezierPath*)drawRecta{
    
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, 235.82)];
    [path addLineToPoint:CGPointMake(0, 466.318)];
    [path addLineToPoint:CGPointMake(181.8, 466.117)];
    [path addCurveToPoint:CGPointMake(314.224, 465.46) controlPoint1:CGPointMake(281.79, 466.006) controlPoint2:CGPointMake(341.381, 465.711)];
    [path addCurveToPoint:CGPointMake(263.931, 463.495) controlPoint1:CGPointMake(268.595, 465.039) controlPoint2:CGPointMake(264.778, 464.89)];
    [path addCurveToPoint:CGPointMake(262.056, 413.985) controlPoint1:CGPointMake(262.965, 461.905) controlPoint2:CGPointMake(262.06, 437.994)];
    [path addLineToPoint:CGPointMake(262.054, 401.504)];
    [path addLineToPoint:CGPointMake(265.68, 401.504)];
    [path addCurveToPoint:CGPointMake(269.749, 403.913) controlPoint1:CGPointMake(269.043, 401.504) controlPoint2:CGPointMake(269.338, 401.679)];
    [path addCurveToPoint:CGPointMake(283.892, 421.507) controlPoint1:CGPointMake(271.435, 413.076) controlPoint2:CGPointMake(273.482, 415.622)];
    [path addCurveToPoint:CGPointMake(355.271, 393.741) controlPoint1:CGPointMake(324.866, 444.672) controlPoint2:CGPointMake(349.797, 434.974)];
    [path addCurveToPoint:CGPointMake(355.994, 375.311) controlPoint1:CGPointMake(355.684, 390.635) controlPoint2:CGPointMake(356.009, 382.342)];
    [path addCurveToPoint:CGPointMake(349.406, 333.951) controlPoint1:CGPointMake(355.964, 360.926) controlPoint2:CGPointMake(354.788, 353.541)];
    [path addCurveToPoint:CGPointMake(311.769, 278.778) controlPoint1:CGPointMake(339.89, 299.314) controlPoint2:CGPointMake(325.913, 278.824)];
    [path addCurveToPoint:CGPointMake(297.565, 295.962) controlPoint1:CGPointMake(302.303, 278.748) controlPoint2:CGPointMake(297.593, 284.446)];
    [path addCurveToPoint:CGPointMake(307.744, 329.477) controlPoint1:CGPointMake(297.538, 306.556) controlPoint2:CGPointMake(299.691, 313.645)];
    [path addCurveToPoint:CGPointMake(314.805, 385.656) controlPoint1:CGPointMake(319.027, 351.659) controlPoint2:CGPointMake(322.082, 375.964)];
    [path addCurveToPoint:CGPointMake(301.146, 393.621) controlPoint1:CGPointMake(311.419, 390.165) controlPoint2:CGPointMake(305.492, 393.621)];
    [path addCurveToPoint:CGPointMake(289.351, 387.73) controlPoint1:CGPointMake(297.643, 393.621) controlPoint2:CGPointMake(292.432, 391.019)];
    [path addCurveToPoint:CGPointMake(272.98, 357.711) controlPoint1:CGPointMake(283.788, 381.792) controlPoint2:CGPointMake(277.645, 370.528)];
    [path addCurveToPoint:CGPointMake(269.437, 348.748) controlPoint1:CGPointMake(271.315, 353.134) controlPoint2:CGPointMake(269.72, 349.101)];
    [path addCurveToPoint:CGPointMake(260.918, 351.904) controlPoint1:CGPointMake(269.153, 348.395) controlPoint2:CGPointMake(265.32, 349.815)];
    [path addCurveToPoint:CGPointMake(240.362, 358.681) controlPoint1:CGPointMake(248.709, 357.697) controlPoint2:CGPointMake(242.179, 359.85)];
    [path addCurveToPoint:CGPointMake(238.405, 355.993) controlPoint1:CGPointMake(239.536, 358.148) controlPoint2:CGPointMake(238.655, 356.939)];
    [path addCurveToPoint:CGPointMake(248.372, 347.443) controlPoint1:CGPointMake(237.487, 352.512) controlPoint2:CGPointMake(239.17, 351.069)];
    [path addCurveToPoint:CGPointMake(277.705, 332.035) controlPoint1:CGPointMake(258.571, 343.425) controlPoint2:CGPointMake(270.251, 337.289)];
    [path addCurveToPoint:CGPointMake(293.346, 318.51) controlPoint1:CGPointMake(283.662, 327.835) controlPoint2:CGPointMake(293.359, 319.45)];
    [path addCurveToPoint:CGPointMake(291.771, 312.166) controlPoint1:CGPointMake(293.341, 318.152) controlPoint2:CGPointMake(292.632, 315.297)];
    [path addCurveToPoint:CGPointMake(290.146, 296.4) controlPoint1:CGPointMake(290.557, 307.75) controlPoint2:CGPointMake(290.193, 304.214)];
    [path addCurveToPoint:CGPointMake(292.074, 281.784) controlPoint1:CGPointMake(290.09, 287.049) controlPoint2:CGPointMake(290.228, 286.002)];
    [path addCurveToPoint:CGPointMake(311.553, 269.733) controlPoint1:CGPointMake(295.721, 273.446) controlPoint2:CGPointMake(301.842, 269.66)];
    [path addCurveToPoint:CGPointMake(328.803, 276.772) controlPoint1:CGPointMake(318.45, 269.785) controlPoint2:CGPointMake(322.629, 271.49)];
    [path addCurveToPoint:CGPointMake(333.638, 278.2) controlPoint1:CGPointMake(332.078, 279.574) controlPoint2:CGPointMake(332.296, 279.638)];
    [path addCurveToPoint:CGPointMake(350.878, 242.973) controlPoint1:CGPointMake(338.735, 272.735) controlPoint2:CGPointMake(347.593, 254.634)];
    [path addCurveToPoint:CGPointMake(353.063, 183.271) controlPoint1:CGPointMake(354.619, 229.689) controlPoint2:CGPointMake(355.596, 203.013)];
    [path addCurveToPoint:CGPointMake(322.854, 111.98) controlPoint1:CGPointMake(349.421, 154.881) controlPoint2:CGPointMake(340.016, 132.686)];
    [path addCurveToPoint:CGPointMake(276.83, 78.777) controlPoint1:CGPointMake(308.499, 94.659) controlPoint2:CGPointMake(292.278, 82.957)];
    [path addCurveToPoint:CGPointMake(209.643, 70.692) controlPoint1:CGPointMake(252.804, 72.276) controlPoint2:CGPointMake(233.728, 69.981)];
    [path addCurveToPoint:CGPointMake(151.702, 82.739) controlPoint1:CGPointMake(186.995, 71.36) controlPoint2:CGPointMake(170.754, 74.737)];
    [path addCurveToPoint:CGPointMake(110.645, 109.705) controlPoint1:CGPointMake(138.591, 88.245) controlPoint2:CGPointMake(121.168, 99.689)];
    [path addCurveToPoint:CGPointMake(75.019, 153.526) controlPoint1:CGPointMake(104.436, 115.615) controlPoint2:CGPointMake(78.145, 147.953)];
    [path addCurveToPoint:CGPointMake(60.877, 217.135) controlPoint1:CGPointMake(65.564, 170.381) controlPoint2:CGPointMake(60.952, 191.123)];
    [path addCurveToPoint:CGPointMake(73.225, 287.336) controlPoint1:CGPointMake(60.805, 242.058) controlPoint2:CGPointMake(65.187, 266.972)];
    [path addCurveToPoint:CGPointMake(140.126, 353.828) controlPoint1:CGPointMake(86.318, 320.511) controlPoint2:CGPointMake(111.493, 345.531)];
    [path addCurveToPoint:CGPointMake(146.86, 356.528) controlPoint1:CGPointMake(142.929, 354.64) controlPoint2:CGPointMake(145.959, 355.855)];
    [path addCurveToPoint:CGPointMake(147.111, 363.328) controlPoint1:CGPointMake(148.872, 358.031) controlPoint2:CGPointMake(148.992, 361.28)];
    [path addCurveToPoint:CGPointMake(141.47, 363.895) controlPoint1:CGPointMake(145.903, 364.644) controlPoint2:CGPointMake(145.178, 364.716)];
    [path addCurveToPoint:CGPointMake(132.664, 361.136) controlPoint1:CGPointMake(139.129, 363.377) controlPoint2:CGPointMake(135.167, 362.136)];
    [path addCurveToPoint:CGPointMake(125.432, 360.924) controlPoint1:CGPointMake(128.214, 359.359) controlPoint2:CGPointMake(128.055, 359.354)];
    [path addCurveToPoint:CGPointMake(121.439, 367.246) controlPoint1:CGPointMake(123.228, 362.242) controlPoint2:CGPointMake(122.516, 363.37)];
    [path addCurveToPoint:CGPointMake(116.472, 441.087) controlPoint1:CGPointMake(118.355, 378.353) controlPoint2:CGPointMake(116.477, 406.261)];
    [path addCurveToPoint:CGPointMake(114.875, 464.058) controlPoint1:CGPointMake(116.469, 462.341) controlPoint2:CGPointMake(116.441, 462.738)];
    [path addCurveToPoint:CGPointMake(57.004, 465.431) controlPoint1:CGPointMake(113.478, 465.235) controlPoint2:CGPointMake(106.36, 465.404)];
    [path addLineToPoint:CGPointMake(0.725, 465.462)];
    [path addLineToPoint:CGPointMake(0.731, 235.835)];
    [path addCurveToPoint:CGPointMake(0.368, 5.765) controlPoint1:CGPointMake(0.734, 109.54) controlPoint2:CGPointMake(0.571, 6.008)];
    [path addCurveToPoint:CGPointMake(0, 235.82) controlPoint1:CGPointMake(0.166, 5.521) controlPoint2:CGPointMake(0, 109.046)];
    [path closePath];
    [path moveToPoint:CGPointMake(308.48, 126.97)];
    [path addLineToPoint:CGPointMake(308.48, 126.97)];
    [path addCurveToPoint:CGPointMake(306.478, 125.644) controlPoint1:CGPointMake(307.59, 126.22) controlPoint2:CGPointMake(306.689, 125.623)];
    [path addCurveToPoint:CGPointMake(287.896, 135.432) controlPoint1:CGPointMake(305.739, 125.715) controlPoint2:CGPointMake(298, 129.791)];
    [path addCurveToPoint:CGPointMake(262.51, 149.327) controlPoint1:CGPointMake(282.291, 138.56) controlPoint2:CGPointMake(270.867, 144.813)];
    [path addCurveToPoint:CGPointMake(247.045, 163.671) controlPoint1:CGPointMake(246.032, 158.227) controlPoint2:CGPointMake(244.735, 159.429)];
    [path addCurveToPoint:CGPointMake(255.819, 163.295) controlPoint1:CGPointMake(248.605, 166.536) controlPoint2:CGPointMake(250.052, 166.474)];
    [path addCurveToPoint:CGPointMake(284.044, 147.885) controlPoint1:CGPointMake(258.415, 161.865) controlPoint2:CGPointMake(271.116, 154.93)];
    [path addCurveToPoint:CGPointMake(308.824, 133.709) controlPoint1:CGPointMake(296.972, 140.84) controlPoint2:CGPointMake(308.123, 134.461)];
    [path addCurveToPoint:CGPointMake(308.48, 126.97) controlPoint1:CGPointMake(310.583, 131.822) controlPoint2:CGPointMake(310.418, 128.604)];
    [path closePath];
    [path moveToPoint:CGPointMake(213.162, 176.929)];
    [path addLineToPoint:CGPointMake(213.162, 176.929)];
    [path addCurveToPoint:CGPointMake(211.119, 175.539) controlPoint1:CGPointMake(212.25, 176.16) controlPoint2:CGPointMake(211.33, 175.535)];
    [path addCurveToPoint:CGPointMake(177.251, 193.904) controlPoint1:CGPointMake(210.8, 175.545) controlPoint2:CGPointMake(191.183, 186.183)];
    [path addCurveToPoint:CGPointMake(149.592, 208.996) controlPoint1:CGPointMake(175.249, 195.014) controlPoint2:CGPointMake(162.802, 201.805)];
    [path addCurveToPoint:CGPointMake(124.296, 223.461) controlPoint1:CGPointMake(136.381, 216.188) controlPoint2:CGPointMake(124.998, 222.697)];
    [path addCurveToPoint:CGPointMake(124.513, 229.879) controlPoint1:CGPointMake(122.603, 225.305) controlPoint2:CGPointMake(122.683, 227.678)];
    [path addCurveToPoint:CGPointMake(127.607, 231.073) controlPoint1:CGPointMake(125.561, 231.14) controlPoint2:CGPointMake(126.484, 231.496)];
    [path addCurveToPoint:CGPointMake(202.728, 190.215) controlPoint1:CGPointMake(129.133, 230.497) controlPoint2:CGPointMake(178.115, 203.857)];
    [path addCurveToPoint:CGPointMake(214.598, 181.043) controlPoint1:CGPointMake(213.868, 184.041) controlPoint2:CGPointMake(214.385, 183.642)];
    [path addCurveToPoint:CGPointMake(213.162, 176.929) controlPoint1:CGPointMake(214.764, 179.02) controlPoint2:CGPointMake(214.397, 177.97)];
    [path closePath];
    [path moveToPoint:CGPointMake(169.925, 402.514)];
    [path addLineToPoint:CGPointMake(169.925, 402.514)];
    [path addCurveToPoint:CGPointMake(165.88, 403.362) controlPoint1:CGPointMake(167.557, 401.215) controlPoint2:CGPointMake(167.686, 401.188)];
    [path addCurveToPoint:CGPointMake(164.776, 414.529) controlPoint1:CGPointMake(164.438, 405.097) controlPoint2:CGPointMake(164.365, 405.832)];
    [path addCurveToPoint:CGPointMake(165.615, 438.728) controlPoint1:CGPointMake(165.018, 419.649) controlPoint2:CGPointMake(165.396, 430.539)];
    [path addCurveToPoint:CGPointMake(168.57, 464.252) controlPoint1:CGPointMake(166.192, 460.306) controlPoint2:CGPointMake(166.456, 462.585)];
    [path addCurveToPoint:CGPointMake(172.155, 464.209) controlPoint1:CGPointMake(170.187, 465.527) controlPoint2:CGPointMake(170.488, 465.523)];
    [path addCurveToPoint:CGPointMake(173.214, 429.532) controlPoint1:CGPointMake(174.35, 462.478) controlPoint2:CGPointMake(174.403, 460.742)];
    [path addCurveToPoint:CGPointMake(169.925, 402.514) controlPoint1:CGPointMake(172.234, 403.84) controlPoint2:CGPointMake(172.226, 403.776)];
    [path closePath];
    [path moveToPoint:CGPointMake(94.267, 14.953)];
    [path addCurveToPoint:CGPointMake(89.551, 21.751) controlPoint1:CGPointMake(91.683, 15.787) controlPoint2:CGPointMake(89.534, 18.884)];
    [path addCurveToPoint:CGPointMake(129.391, 75.141) controlPoint1:CGPointMake(89.608, 31.344) controlPoint2:CGPointMake(103.635, 50.141)];
    [path addCurveToPoint:CGPointMake(146.678, 75.318) controlPoint1:CGPointMake(135.462, 81.033) controlPoint2:CGPointMake(134.225, 81.02)];
    [path addCurveToPoint:CGPointMake(159.598, 69.935) controlPoint1:CGPointMake(151.482, 73.119) controlPoint2:CGPointMake(157.296, 70.696)];
    [path addCurveToPoint:CGPointMake(163.784, 67.493) controlPoint1:CGPointMake(161.9, 69.174) controlPoint2:CGPointMake(163.784, 68.075)];
    [path addCurveToPoint:CGPointMake(138.911, 36.981) controlPoint1:CGPointMake(163.784, 66.027) controlPoint2:CGPointMake(146.587, 44.931)];
    [path addCurveToPoint:CGPointMake(115.338, 17.714) controlPoint1:CGPointMake(131.162, 28.956) controlPoint2:CGPointMake(122.049, 21.507)];
    [path addCurveToPoint:CGPointMake(103.002, 14.669) controlPoint1:CGPointMake(110.806, 15.153) controlPoint2:CGPointMake(109.526, 14.837)];
    [path addCurveToPoint:CGPointMake(94.267, 14.953) controlPoint1:CGPointMake(98.998, 14.567) controlPoint2:CGPointMake(95.067, 14.694)];
    [path closePath];
    [path moveToPoint:CGPointMake(14.831, 58.769)];
    [path addCurveToPoint:CGPointMake(9.511, 77.649) controlPoint1:CGPointMake(10.629, 59.761) controlPoint2:CGPointMake(7.775, 69.891)];
    [path addCurveToPoint:CGPointMake(71.133, 133.015) controlPoint1:CGPointMake(12.85, 92.567) controlPoint2:CGPointMake(32.573, 110.289)];
    [path addLineToPoint:CGPointMake(76.389, 136.113)];
    [path addLineToPoint:CGPointMake(81.437, 130.641)];
    [path addCurveToPoint:CGPointMake(90.942, 119.315) controlPoint1:CGPointMake(84.213, 127.631) controlPoint2:CGPointMake(88.49, 122.535)];
    [path addLineToPoint:CGPointMake(95.399, 113.461)];
    [path addLineToPoint:CGPointMake(93.017, 110.196)];
    [path addCurveToPoint:CGPointMake(69.995, 87.171) controlPoint1:CGPointMake(89.685, 105.631) controlPoint2:CGPointMake(78.345, 94.288)];
    [path addCurveToPoint:CGPointMake(14.831, 58.769) controlPoint1:CGPointMake(46.456, 67.105) controlPoint2:CGPointMake(25.413, 56.271)];
    [path closePath];
    [path moveToPoint:CGPointMake(292.608, 331.543)];
    [path addCurveToPoint:CGPointMake(282.954, 339.125) controlPoint1:CGPointMake(290.416, 333.529) controlPoint2:CGPointMake(286.072, 336.941)];
    [path addCurveToPoint:CGPointMake(276.935, 343.778) controlPoint1:CGPointMake(279.836, 341.309) controlPoint2:CGPointMake(277.128, 343.403)];
    [path addCurveToPoint:CGPointMake(286.818, 369.412) controlPoint1:CGPointMake(276.328, 344.959) controlPoint2:CGPointMake(283.237, 362.879)];
    [path addCurveToPoint:CGPointMake(301.355, 383.111) controlPoint1:CGPointMake(292.206, 379.242) controlPoint2:CGPointMake(296.311, 383.111)];
    [path addCurveToPoint:CGPointMake(310.507, 375.903) controlPoint1:CGPointMake(305.708, 383.111) controlPoint2:CGPointMake(309.761, 379.919)];
    [path addCurveToPoint:CGPointMake(309.429, 356.453) controlPoint1:CGPointMake(311.439, 370.887) controlPoint2:CGPointMake(311.027, 363.464)];
    [path addCurveToPoint:CGPointMake(297.339, 327.963) controlPoint1:CGPointMake(307.227, 346.797) controlPoint2:CGPointMake(299.27, 328.046)];
    [path addCurveToPoint:CGPointMake(292.608, 331.543) controlPoint1:CGPointMake(296.928, 327.946) controlPoint2:CGPointMake(294.799, 329.556)];
    [path closePath];
    [path moveToPoint:CGPointMake(364.106, 370.411)];
    [path addCurveToPoint:CGPointMake(364.469, 371.489) controlPoint1:CGPointMake(364.121, 371.856) controlPoint2:CGPointMake(364.284, 372.341)];
    [path addCurveToPoint:CGPointMake(364.442, 368.861) controlPoint1:CGPointMake(364.653, 370.637) controlPoint2:CGPointMake(364.641, 369.454)];
    [path addCurveToPoint:CGPointMake(364.106, 370.411) controlPoint1:CGPointMake(364.242, 368.268) controlPoint2:CGPointMake(364.091, 368.966)];
    [path closePath];
    [path moveToPoint:CGPointMake(364.133, 384.863)];
    [path addCurveToPoint:CGPointMake(364.466, 386.395) controlPoint1:CGPointMake(364.133, 386.549) controlPoint2:CGPointMake(364.283, 387.238)];
    [path addCurveToPoint:CGPointMake(364.466, 383.33) controlPoint1:CGPointMake(364.649, 385.552) controlPoint2:CGPointMake(364.649, 384.173)];
    [path addCurveToPoint:CGPointMake(364.133, 384.863) controlPoint1:CGPointMake(364.283, 382.487) controlPoint2:CGPointMake(364.133, 383.177)];
    [path closePath];
    
    
    //Path color fill
    [[UIColor colorWithRed:0.993 green: 0.993 blue:0.992 alpha:1] setFill];
    [path fill];
    
    [[UIColor blackColor] setStroke];
    path.lineWidth = 1;
    [path stroke];

    return path;
}

@end

//
//  KJIView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJIView.h"

@implementation KJIView

- (UIBezierPath*)drawRecta{
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(294.98, 38.198)];
    [path addCurveToPoint:CGPointMake(271.194, 54.815) controlPoint1:CGPointMake(285.421, 39.53) controlPoint2:CGPointMake(276.783, 45.565)];
    [path addCurveToPoint:CGPointMake(265.858, 69.217) controlPoint1:CGPointMake(268.306, 59.596) controlPoint2:CGPointMake(267.044, 63.001)];
    [path addCurveToPoint:CGPointMake(268.202, 88.524) controlPoint1:CGPointMake(263.975, 79.082) controlPoint2:CGPointMake(264.779, 85.706)];
    [path addCurveToPoint:CGPointMake(283.044, 85.311) controlPoint1:CGPointMake(272.368, 91.955) controlPoint2:CGPointMake(281.137, 90.057)];
    [path addCurveToPoint:CGPointMake(283.195, 81.204) controlPoint1:CGPointMake(283.508, 84.156) controlPoint2:CGPointMake(283.572, 82.423)];
    [path addCurveToPoint:CGPointMake(280.225, 76.914) controlPoint1:CGPointMake(282.82, 79.989) controlPoint2:CGPointMake(281.547, 78.15)];
    [path addCurveToPoint:CGPointMake(278.696, 75.062) controlPoint1:CGPointMake(279.578, 76.309) controlPoint2:CGPointMake(278.89, 75.476)];
    [path addCurveToPoint:CGPointMake(287.114, 65.378) controlPoint1:CGPointMake(277.123, 71.718) controlPoint2:CGPointMake(281.227, 66.997)];
    [path addCurveToPoint:CGPointMake(295.622, 65.812) controlPoint1:CGPointMake(289.415, 64.746) controlPoint2:CGPointMake(293.698, 64.964)];
    [path addCurveToPoint:CGPointMake(306.399, 83.301) controlPoint1:CGPointMake(301.696, 68.49) controlPoint2:CGPointMake(305.29, 74.323)];
    [path addCurveToPoint:CGPointMake(306.327, 95.863) controlPoint1:CGPointMake(306.799, 86.536) controlPoint2:CGPointMake(306.766, 92.261)];
    [path addCurveToPoint:CGPointMake(297.85, 118.629) controlPoint1:CGPointMake(305.105, 105.892) controlPoint2:CGPointMake(301.836, 114.671)];
    [path addCurveToPoint:CGPointMake(278.137, 112.651) controlPoint1:CGPointMake(292.995, 123.449) controlPoint2:CGPointMake(285.794, 121.265)];
    [path addCurveToPoint:CGPointMake(275.309, 109.366) controlPoint1:CGPointMake(276.846, 111.198) controlPoint2:CGPointMake(275.574, 109.72)];
    [path addCurveToPoint:CGPointMake(274.769, 108.85) controlPoint1:CGPointMake(275.045, 109.012) controlPoint2:CGPointMake(274.801, 108.78)];
    [path addCurveToPoint:CGPointMake(271.041, 125.02) controlPoint1:CGPointMake(274.736, 108.92) controlPoint2:CGPointMake(273.058, 116.197)];
    [path addCurveToPoint:CGPointMake(267.242, 141.314) controlPoint1:CGPointMake(269.023, 133.844) controlPoint2:CGPointMake(267.314, 141.176)];
    [path addCurveToPoint:CGPointMake(258.697, 128.583) controlPoint1:CGPointMake(267.171, 141.453) controlPoint2:CGPointMake(263.325, 135.724)];
    [path addCurveToPoint:CGPointMake(250.156, 115.601) controlPoint1:CGPointMake(254.069, 121.443) controlPoint2:CGPointMake(250.225, 115.601)];
    [path addCurveToPoint:CGPointMake(243.049, 127.007) controlPoint1:CGPointMake(250.086, 115.601) controlPoint2:CGPointMake(246.888, 120.733)];
    [path addCurveToPoint:CGPointMake(235.855, 138.382) controlPoint1:CGPointMake(239.21, 133.281) controlPoint2:CGPointMake(235.973, 138.399)];
    [path addCurveToPoint:CGPointMake(227.491, 127.546) controlPoint1:CGPointMake(235.737, 138.364) controlPoint2:CGPointMake(231.973, 133.488)];
    [path addCurveToPoint:CGPointMake(219.143, 116.879) controlPoint1:CGPointMake(223.009, 121.604) controlPoint2:CGPointMake(219.253, 116.804)];
    [path addCurveToPoint:CGPointMake(212.544, 126.431) controlPoint1:CGPointMake(219.034, 116.955) controlPoint2:CGPointMake(216.065, 121.253)];
    [path addLineToPoint:CGPointMake(206.144, 135.846)];
    [path addLineToPoint:CGPointMake(205.144, 133.892)];
    [path addCurveToPoint:CGPointMake(199.683, 122.96) controlPoint1:CGPointMake(204.594, 132.817) controlPoint2:CGPointMake(202.136, 127.897)];
    [path addCurveToPoint:CGPointMake(195.086, 113.725) controlPoint1:CGPointMake(197.229, 118.022) controlPoint2:CGPointMake(195.161, 113.866)];
    [path addCurveToPoint:CGPointMake(187.955, 123.365) controlPoint1:CGPointMake(195.011, 113.584) controlPoint2:CGPointMake(191.802, 117.922)];
    [path addCurveToPoint:CGPointMake(180.855, 133.262) controlPoint1:CGPointMake(184.108, 128.809) controlPoint2:CGPointMake(180.913, 133.262)];
    [path addCurveToPoint:CGPointMake(179.263, 119.285) controlPoint1:CGPointMake(180.796, 133.262) controlPoint2:CGPointMake(180.08, 126.973)];
    [path addCurveToPoint:CGPointMake(177.471, 105.671) controlPoint1:CGPointMake(177.883, 106.31) controlPoint2:CGPointMake(177.755, 105.334)];
    [path addCurveToPoint:CGPointMake(171.505, 112.503) controlPoint1:CGPointMake(174.052, 109.73) controlPoint2:CGPointMake(173.054, 110.873)];
    [path addCurveToPoint:CGPointMake(160.881, 120.606) controlPoint1:CGPointMake(167.873, 116.323) controlPoint2:CGPointMake(163.37, 119.757)];
    [path addLineToPoint:CGPointMake(159.839, 120.962)];
    [path addLineToPoint:CGPointMake(159.212, 119.679)];
    [path addCurveToPoint:CGPointMake(147.044, 105.604) controlPoint1:CGPointMake(155.766, 112.627) controlPoint2:CGPointMake(151.1, 107.231)];
    [path addCurveToPoint:CGPointMake(140.782, 105.462) controlPoint1:CGPointMake(145.223, 104.874) controlPoint2:CGPointMake(142.653, 104.816)];
    [path addCurveToPoint:CGPointMake(125.416, 120.717) controlPoint1:CGPointMake(135.765, 107.195) controlPoint2:CGPointMake(130.052, 112.867)];
    [path addLineToPoint:CGPointMake(123.93, 123.232)];
    [path addLineToPoint:CGPointMake(122.275, 120.298)];
    [path addCurveToPoint:CGPointMake(112.47, 109.665) controlPoint1:CGPointMake(119.306, 115.034) controlPoint2:CGPointMake(115.807, 111.239)];
    [path addCurveToPoint:CGPointMake(105.43, 109.665) controlPoint1:CGPointMake(110.483, 108.728) controlPoint2:CGPointMake(107.417, 108.728)];
    [path addCurveToPoint:CGPointMake(97.204, 118.027) controlPoint1:CGPointMake(102.429, 111.08) controlPoint2:CGPointMake(99.559, 113.997)];
    [path addCurveToPoint:CGPointMake(92.033, 132.489) controlPoint1:CGPointMake(95.132, 121.572) controlPoint2:CGPointMake(92.901, 127.81)];
    [path addCurveToPoint:CGPointMake(91.356, 134.475) controlPoint1:CGPointMake(91.825, 133.61) controlPoint2:CGPointMake(91.587, 134.308)];
    [path addCurveToPoint:CGPointMake(73.964, 139.866) controlPoint1:CGPointMake(90.291, 135.243) controlPoint2:CGPointMake(80.134, 138.391)];
    [path addCurveToPoint:CGPointMake(39.169, 143.219) controlPoint1:CGPointMake(61.43, 142.862) controlPoint2:CGPointMake(56.442, 143.343)];
    [path addCurveToPoint:CGPointMake(24.49, 143.66) controlPoint1:CGPointMake(26.817, 143.13) controlPoint2:CGPointMake(25.783, 143.161)];
    [path addCurveToPoint:CGPointMake(17.419, 155.46) controlPoint1:CGPointMake(20.098, 145.353) controlPoint2:CGPointMake(18.316, 148.328)];
    [path addCurveToPoint:CGPointMake(16.866, 166.998) controlPoint1:CGPointMake(17.128, 157.77) controlPoint2:CGPointMake(16.699, 166.719)];
    [path addCurveToPoint:CGPointMake(31.953, 171.378) controlPoint1:CGPointMake(17.084, 167.363) controlPoint2:CGPointMake(25.38, 169.772)];
    [path addCurveToPoint:CGPointMake(95.706, 175.411) controlPoint1:CGPointMake(56.526, 177.383) controlPoint2:CGPointMake(79.519, 178.838)];
    [path addCurveToPoint:CGPointMake(97.436, 177.694) controlPoint1:CGPointMake(98.538, 174.811) controlPoint2:CGPointMake(98.489, 174.748)];
    [path addCurveToPoint:CGPointMake(81.474, 194.757) controlPoint1:CGPointMake(94.398, 186.19) controlPoint2:CGPointMake(88.66, 192.323)];
    [path addCurveToPoint:CGPointMake(71.912, 195.874) controlPoint1:CGPointMake(78.498, 195.765) controlPoint2:CGPointMake(75.996, 196.057)];
    [path addCurveToPoint:CGPointMake(55.8, 192.997) controlPoint1:CGPointMake(67.637, 195.682) controlPoint2:CGPointMake(64.429, 195.109)];
    [path addCurveToPoint:CGPointMake(39.471, 189.746) controlPoint1:CGPointMake(47.396, 190.939) controlPoint2:CGPointMake(43.485, 190.16)];
    [path addCurveToPoint:CGPointMake(22.263, 197.899) controlPoint1:CGPointMake(30.52, 188.821) controlPoint2:CGPointMake(24.903, 191.483)];
    [path addCurveToPoint:CGPointMake(22.053, 199.311) controlPoint1:CGPointMake(21.802, 199.021) controlPoint2:CGPointMake(21.779, 199.176)];
    [path addCurveToPoint:CGPointMake(53.248, 208.919) controlPoint1:CGPointMake(23.214, 199.884) controlPoint2:CGPointMake(42.768, 205.907)];
    [path addCurveToPoint:CGPointMake(123.101, 223.925) controlPoint1:CGPointMake(82.956, 217.458) controlPoint2:CGPointMake(105.836, 222.373)];
    [path addCurveToPoint:CGPointMake(126.388, 224.293) controlPoint1:CGPointMake(124.883, 224.085) controlPoint2:CGPointMake(126.362, 224.251)];
    [path addCurveToPoint:CGPointMake(124.847, 229.32) controlPoint1:CGPointMake(126.413, 224.336) controlPoint2:CGPointMake(125.72, 226.598)];
    [path addCurveToPoint:CGPointMake(123.335, 234.396) controlPoint1:CGPointMake(123.974, 232.042) controlPoint2:CGPointMake(123.293, 234.326)];
    [path addCurveToPoint:CGPointMake(128.194, 232.609) controlPoint1:CGPointMake(123.376, 234.465) controlPoint2:CGPointMake(125.563, 233.661)];
    [path addCurveToPoint:CGPointMake(133.064, 230.696) controlPoint1:CGPointMake(130.826, 231.557) controlPoint2:CGPointMake(133.017, 230.696)];
    [path addCurveToPoint:CGPointMake(133.149, 233.07) controlPoint1:CGPointMake(133.11, 230.696) controlPoint2:CGPointMake(133.149, 231.764)];
    [path addCurveToPoint:CGPointMake(133.545, 235.239) controlPoint1:CGPointMake(133.149, 235.398) controlPoint2:CGPointMake(133.157, 235.441)];
    [path addCurveToPoint:CGPointMake(137.02, 233.148) controlPoint1:CGPointMake(133.762, 235.125) controlPoint2:CGPointMake(135.327, 234.184)];
    [path addLineToPoint:CGPointMake(140.1, 231.265)];
    [path addLineToPoint:CGPointMake(140.716, 232.381)];
    [path addCurveToPoint:CGPointMake(142.153, 235.043) controlPoint1:CGPointMake(141.055, 232.994) controlPoint2:CGPointMake(141.701, 234.192)];
    [path addLineToPoint:CGPointMake(142.973, 236.589)];
    [path addLineToPoint:CGPointMake(143.52, 235.819)];
    [path addCurveToPoint:CGPointMake(145.644, 227.921) controlPoint1:CGPointMake(144.535, 234.391) controlPoint2:CGPointMake(145.644, 230.266)];
    [path addLineToPoint:CGPointMake(145.644, 226.964)];
    [path addLineToPoint:CGPointMake(152.009, 226.769)];
    [path addCurveToPoint:CGPointMake(213.285, 226.769) controlPoint1:CGPointMake(160.262, 226.517) controlPoint2:CGPointMake(207.414, 226.516)];
    [path addCurveToPoint:CGPointMake(217.801, 227.154) controlPoint1:CGPointMake(215.769, 226.876) controlPoint2:CGPointMake(217.801, 227.049)];
    [path addCurveToPoint:CGPointMake(214.204, 230.86) controlPoint1:CGPointMake(217.801, 227.259) controlPoint2:CGPointMake(216.182, 228.927)];
    [path addCurveToPoint:CGPointMake(210.728, 234.555) controlPoint1:CGPointMake(212.226, 232.793) controlPoint2:CGPointMake(210.662, 234.456)];
    [path addCurveToPoint:CGPointMake(215.161, 235.085) controlPoint1:CGPointMake(210.795, 234.653) controlPoint2:CGPointMake(212.789, 234.892)];
    [path addCurveToPoint:CGPointMake(220.326, 235.609) controlPoint1:CGPointMake(217.532, 235.278) controlPoint2:CGPointMake(219.857, 235.514)];
    [path addLineToPoint:CGPointMake(221.18, 235.783)];
    [path addLineToPoint:CGPointMake(221.117, 238.096)];
    [path addCurveToPoint:CGPointMake(221.126, 240.409) controlPoint1:CGPointMake(221.082, 239.369) controlPoint2:CGPointMake(221.086, 240.409)];
    [path addCurveToPoint:CGPointMake(223.57, 238.349) controlPoint1:CGPointMake(221.165, 240.409) controlPoint2:CGPointMake(222.265, 239.482)];
    [path addCurveToPoint:CGPointMake(226.139, 236.3) controlPoint1:CGPointMake(224.874, 237.216) controlPoint2:CGPointMake(226.031, 236.294)];
    [path addCurveToPoint:CGPointMake(227.92, 238.064) controlPoint1:CGPointMake(226.248, 236.307) controlPoint2:CGPointMake(227.049, 237.1)];
    [path addLineToPoint:CGPointMake(229.504, 239.817)];
    [path addLineToPoint:CGPointMake(229.916, 239.009)];
    [path addCurveToPoint:CGPointMake(233.092, 228.399) controlPoint1:CGPointMake(231.376, 236.148) controlPoint2:CGPointMake(232.554, 232.212)];
    [path addLineToPoint:CGPointMake(233.411, 226.133)];
    [path addLineToPoint:CGPointMake(237.969, 225.944)];
    [path addCurveToPoint:CGPointMake(309.508, 202.868) controlPoint1:CGPointMake(263.515, 224.884) controlPoint2:CGPointMake(289.126, 216.622)];
    [path addCurveToPoint:CGPointMake(330.26, 185.895) controlPoint1:CGPointMake(315.528, 198.806) controlPoint2:CGPointMake(324.283, 191.644)];
    [path addCurveToPoint:CGPointMake(358.071, 132.351) controlPoint1:CGPointMake(348.563, 168.286) controlPoint2:CGPointMake(356.971, 152.097)];
    [path addCurveToPoint:CGPointMake(357.18, 113.936) controlPoint1:CGPointMake(358.367, 127.022) controlPoint2:CGPointMake(357.991, 119.24)];
    [path addCurveToPoint:CGPointMake(340.487, 71.809) controlPoint1:CGPointMake(355.354, 101.999) controlPoint2:CGPointMake(348.97, 85.887)];
    [path addCurveToPoint:CGPointMake(308.606, 39.689) controlPoint1:CGPointMake(330.175, 54.695) controlPoint2:CGPointMake(318.924, 43.36)];
    [path addCurveToPoint:CGPointMake(294.98, 38.198) controlPoint1:CGPointMake(304.626, 38.273) controlPoint2:CGPointMake(298.922, 37.649)];
    [path closePath];
    [path moveToPoint:CGPointMake(143.221, 120.207)];
    [path addLineToPoint:CGPointMake(143.221, 120.207)];
    [path addCurveToPoint:CGPointMake(139.308, 120.388) controlPoint1:CGPointMake(142.215, 119.356) controlPoint2:CGPointMake(140.648, 119.428)];
    [path addCurveToPoint:CGPointMake(137.372, 130.851) controlPoint1:CGPointMake(136.336, 122.517) controlPoint2:CGPointMake(135.243, 128.424)];
    [path addCurveToPoint:CGPointMake(139.062, 131.415) controlPoint1:CGPointMake(137.902, 131.454) controlPoint2:CGPointMake(138.14, 131.534)];
    [path addCurveToPoint:CGPointMake(143.815, 126.05) controlPoint1:CGPointMake(141.033, 131.161) controlPoint2:CGPointMake(142.994, 128.947)];
    [path addCurveToPoint:CGPointMake(143.221, 120.207) controlPoint1:CGPointMake(144.52, 123.566) controlPoint2:CGPointMake(144.268, 121.094)];
    [path closePath];
    [path moveToPoint:CGPointMake(110.83, 122.381)];
    [path addLineToPoint:CGPointMake(110.83, 122.381)];
    [path addCurveToPoint:CGPointMake(108.321, 122.479) controlPoint1:CGPointMake(110.004, 121.997) controlPoint2:CGPointMake(109.331, 122.024)];
    [path addCurveToPoint:CGPointMake(104.463, 129.789) controlPoint1:CGPointMake(106.018, 123.518) controlPoint2:CGPointMake(104.461, 126.468)];
    [path addCurveToPoint:CGPointMake(109.116, 133.16) controlPoint1:CGPointMake(104.464, 133.756) controlPoint2:CGPointMake(106.455, 135.198)];
    [path addCurveToPoint:CGPointMake(110.83, 122.381) controlPoint1:CGPointMake(112.48, 130.584) controlPoint2:CGPointMake(113.581, 123.659)];
    [path closePath];
    [path moveToPoint:CGPointMake(299.276, 140.761)];
    [path addLineToPoint:CGPointMake(299.276, 140.761)];
    [path addCurveToPoint:CGPointMake(292.334, 140.289) controlPoint1:CGPointMake(298.221, 140.203) controlPoint2:CGPointMake(293.298, 139.869)];
    [path addCurveToPoint:CGPointMake(291.859, 148.676) controlPoint1:CGPointMake(289.875, 141.36) controlPoint2:CGPointMake(289.675, 144.895)];
    [path addCurveToPoint:CGPointMake(298.004, 150.919) controlPoint1:CGPointMake(293.666, 151.807) controlPoint2:CGPointMake(295.946, 152.639)];
    [path addCurveToPoint:CGPointMake(301.397, 144.283) controlPoint1:CGPointMake(300.062, 149.199) controlPoint2:CGPointMake(301.397, 146.587)];
    [path addCurveToPoint:CGPointMake(299.276, 140.761) controlPoint1:CGPointMake(301.397, 142.833) controlPoint2:CGPointMake(300.556, 141.437)];
    [path closePath];
    [path moveToPoint:CGPointMake(216.103, 144.785)];
    [path addLineToPoint:CGPointMake(216.103, 144.785)];
    [path addCurveToPoint:CGPointMake(212.873, 144.607) controlPoint1:CGPointMake(215.443, 144.216) controlPoint2:CGPointMake(213.903, 144.131)];
    [path addCurveToPoint:CGPointMake(209.077, 156.057) controlPoint1:CGPointMake(209.813, 146.022) controlPoint2:CGPointMake(208.166, 150.991)];
    [path addCurveToPoint:CGPointMake(215.268, 160.67) controlPoint1:CGPointMake(209.932, 160.808) controlPoint2:CGPointMake(212.59, 162.789)];
    [path addCurveToPoint:CGPointMake(218.132, 155.953) controlPoint1:CGPointMake(216.607, 159.61) controlPoint2:CGPointMake(217.535, 158.082)];
    [path addCurveToPoint:CGPointMake(218.102, 148.072) controlPoint1:CGPointMake(218.791, 153.601) controlPoint2:CGPointMake(218.779, 150.263)];
    [path addCurveToPoint:CGPointMake(216.103, 144.785) controlPoint1:CGPointMake(217.661, 146.646) controlPoint2:CGPointMake(216.998, 145.556)];
    [path closePath];
    [path moveToPoint:CGPointMake(176.927, 147.12)];
    [path addLineToPoint:CGPointMake(176.927, 147.12)];
    [path addCurveToPoint:CGPointMake(172.929, 146.375) controlPoint1:CGPointMake(175.566, 146.01) controlPoint2:CGPointMake(174.241, 145.763)];
    [path addCurveToPoint:CGPointMake(168.767, 166.355) controlPoint1:CGPointMake(167.913, 148.714) controlPoint2:CGPointMake(165.234, 161.576)];
    [path addCurveToPoint:CGPointMake(170.96, 167.257) controlPoint1:CGPointMake(169.4, 167.211) controlPoint2:CGPointMake(169.52, 167.261)];
    [path addCurveToPoint:CGPointMake(173.632, 166.316) controlPoint1:CGPointMake(172.311, 167.254) controlPoint2:CGPointMake(172.613, 167.148)];
    [path addCurveToPoint:CGPointMake(177.783, 161.137) controlPoint1:CGPointMake(175.039, 165.169) controlPoint2:CGPointMake(176.852, 162.907)];
    [path addCurveToPoint:CGPointMake(176.927, 147.12) controlPoint1:CGPointMake(180.517, 155.943) controlPoint2:CGPointMake(180.138, 149.74)];
    [path closePath];
    [path moveToPoint:CGPointMake(255.399, 149.622)];
    [path addLineToPoint:CGPointMake(255.399, 149.622)];
    [path addCurveToPoint:CGPointMake(253.028, 148.655) controlPoint1:CGPointMake(254.662, 148.86) controlPoint2:CGPointMake(254.358, 148.736)];
    [path addCurveToPoint:CGPointMake(250.688, 149.112) controlPoint1:CGPointMake(251.85, 148.583) controlPoint2:CGPointMake(251.318, 148.687)];
    [path addCurveToPoint:CGPointMake(248.094, 159.179) controlPoint1:CGPointMake(247.965, 150.952) controlPoint2:CGPointMake(246.928, 154.976)];
    [path addCurveToPoint:CGPointMake(252.559, 164.593) controlPoint1:CGPointMake(249.043, 162.598) controlPoint2:CGPointMake(250.696, 164.603)];
    [path addCurveToPoint:CGPointMake(254.209, 164.058) controlPoint1:CGPointMake(253.233, 164.589) controlPoint2:CGPointMake(253.831, 164.395)];
    [path addCurveToPoint:CGPointMake(256.817, 159.23) controlPoint1:CGPointMake(255.106, 163.259) controlPoint2:CGPointMake(256.263, 161.115)];
    [path addCurveToPoint:CGPointMake(257.311, 155.291) controlPoint1:CGPointMake(257.228, 157.83) controlPoint2:CGPointMake(257.311, 157.167)];
    [path addCurveToPoint:CGPointMake(256.778, 151.766) controlPoint1:CGPointMake(257.311, 153.255) controlPoint2:CGPointMake(257.259, 152.911)];
    [path addCurveToPoint:CGPointMake(255.399, 149.622) controlPoint1:CGPointMake(256.484, 151.067) controlPoint2:CGPointMake(255.864, 150.103)];
    [path closePath];
    [path moveToPoint:CGPointMake(151.98, 156.472)];
    [path addLineToPoint:CGPointMake(151.98, 156.472)];
    [path addCurveToPoint:CGPointMake(147.136, 157.711) controlPoint1:CGPointMake(150.931, 155.183) controlPoint2:CGPointMake(149.228, 155.619)];
    [path addCurveToPoint:CGPointMake(143.274, 167.543) controlPoint1:CGPointMake(145.448, 159.399) controlPoint2:CGPointMake(143.932, 163.258)];
    [path addCurveToPoint:CGPointMake(143.244, 175.144) controlPoint1:CGPointMake(142.938, 169.73) controlPoint2:CGPointMake(142.922, 173.871)];
    [path addCurveToPoint:CGPointMake(148.414, 175.075) controlPoint1:CGPointMake(143.993, 178.106) controlPoint2:CGPointMake(145.855, 178.081)];
    [path addCurveToPoint:CGPointMake(151.98, 156.472) controlPoint1:CGPointMake(153.039, 169.643) controlPoint2:CGPointMake(154.88, 160.035)];
    [path closePath];
    [path moveToPoint:CGPointMake(277.712, 163.413)];
    [path addLineToPoint:CGPointMake(277.712, 163.413)];
    [path addCurveToPoint:CGPointMake(270.222, 167.218) controlPoint1:CGPointMake(275.171, 162.133) controlPoint2:CGPointMake(271.652, 163.921)];
    [path addCurveToPoint:CGPointMake(271.375, 182.977) controlPoint1:CGPointMake(268.177, 171.935) controlPoint2:CGPointMake(268.774, 180.098)];
    [path addCurveToPoint:CGPointMake(275.086, 183.028) controlPoint1:CGPointMake(272.325, 184.028) controlPoint2:CGPointMake(273.833, 184.049)];
    [path addCurveToPoint:CGPointMake(279.165, 176.209) controlPoint1:CGPointMake(276.229, 182.097) controlPoint2:CGPointMake(278.066, 179.026)];
    [path addCurveToPoint:CGPointMake(277.712, 163.413) controlPoint1:CGPointMake(281.555, 170.085) controlPoint2:CGPointMake(280.985, 165.06)];
    [path closePath];
    [path moveToPoint:CGPointMake(194.533, 165.025)];
    [path addLineToPoint:CGPointMake(194.533, 165.025)];
    [path addCurveToPoint:CGPointMake(189.56, 167.533) controlPoint1:CGPointMake(193.1, 163.796) controlPoint2:CGPointMake(191.289, 164.709)];
    [path addCurveToPoint:CGPointMake(189.688, 178.462) controlPoint1:CGPointMake(187.056, 171.623) controlPoint2:CGPointMake(187.115, 176.674)];
    [path addCurveToPoint:CGPointMake(194.355, 178.299) controlPoint1:CGPointMake(190.808, 179.24) controlPoint2:CGPointMake(193.162, 179.158)];
    [path addCurveToPoint:CGPointMake(196.809, 171.213) controlPoint1:CGPointMake(196.115, 177.033) controlPoint2:CGPointMake(196.986, 174.517)];
    [path addCurveToPoint:CGPointMake(194.533, 165.025) controlPoint1:CGPointMake(196.662, 168.485) controlPoint2:CGPointMake(195.785, 166.098)];
    [path closePath];
    [path moveToPoint:CGPointMake(230.764, 167.107)];
    [path addLineToPoint:CGPointMake(230.764, 167.107)];
    [path addCurveToPoint:CGPointMake(227.392, 166.691) controlPoint1:CGPointMake(229.713, 166.099) controlPoint2:CGPointMake(228.281, 165.922)];
    [path addCurveToPoint:CGPointMake(224.13, 174.971) controlPoint1:CGPointMake(225.985, 167.909) controlPoint2:CGPointMake(224.556, 171.537)];
    [path addCurveToPoint:CGPointMake(226.062, 181.861) controlPoint1:CGPointMake(223.714, 178.317) controlPoint2:CGPointMake(224.487, 181.072)];
    [path addCurveToPoint:CGPointMake(227.97, 181.739) controlPoint1:CGPointMake(226.716, 182.189) controlPoint2:CGPointMake(226.984, 182.172)];
    [path addCurveToPoint:CGPointMake(232.614, 176.149) controlPoint1:CGPointMake(230.037, 180.833) controlPoint2:CGPointMake(231.845, 178.656)];
    [path addCurveToPoint:CGPointMake(230.764, 167.107) controlPoint1:CGPointMake(233.569, 173.032) controlPoint2:CGPointMake(232.746, 169.008)];
    [path closePath];
    
    
    //Path color fill
    [[UIColor colorWithRed:0.137 green: 0.627 blue:0.169 alpha:1] setFill];
    [path fill];
    
    [[UIColor blackColor] setStroke];
    path.lineWidth = 1;
    [path stroke];

    return path;
}

@end

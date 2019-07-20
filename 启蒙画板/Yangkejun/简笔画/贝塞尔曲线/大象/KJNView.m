//
//  KJNView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/24.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJNView.h"

@implementation KJNView

- (UIBezierPath*)drawRecta{
    
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(165.546, 1.587)];
    [path addCurveToPoint:CGPointMake(110.998, 20.148) controlPoint1:CGPointMake(138.476, 5.328) controlPoint2:CGPointMake(123.38, 10.465)];
    [path addCurveToPoint:CGPointMake(78.94, 82.472) controlPoint1:CGPointMake(94.851, 32.775) controlPoint2:CGPointMake(84.209, 53.463)];
    [path addCurveToPoint:CGPointMake(74.599, 95.046) controlPoint1:CGPointMake(77.257, 91.738) controlPoint2:CGPointMake(76.907, 92.751)];
    [path addCurveToPoint:CGPointMake(56.41, 100.067) controlPoint1:CGPointMake(71.088, 98.536) controlPoint2:CGPointMake(65.388, 100.11)];
    [path addCurveToPoint:CGPointMake(41.785, 96.401) controlPoint1:CGPointMake(48.729, 100.031) controlPoint2:CGPointMake(44.45, 98.958)];
    [path addCurveToPoint:CGPointMake(36.833, 82.586) controlPoint1:CGPointMake(38.901, 93.634) controlPoint2:CGPointMake(37.186, 88.849)];
    [path addCurveToPoint:CGPointMake(48.671, 49.621) controlPoint1:CGPointMake(36.178, 70.954) controlPoint2:CGPointMake(38.884, 63.419)];
    [path addCurveToPoint:CGPointMake(55.855, 38.4) controlPoint1:CGPointMake(52.083, 44.811) controlPoint2:CGPointMake(55.315, 39.762)];
    [path addCurveToPoint:CGPointMake(39.091, 18.461) controlPoint1:CGPointMake(58.742, 31.111) controlPoint2:CGPointMake(49.332, 19.918)];
    [path addCurveToPoint:CGPointMake(12.283, 52.654) controlPoint1:CGPointMake(28.88, 17.008) controlPoint2:CGPointMake(16.198, 33.183)];
    [path addCurveToPoint:CGPointMake(25.686, 113.44) controlPoint1:CGPointMake(8.291, 72.512) controlPoint2:CGPointMake(14.557, 100.932)];
    [path addCurveToPoint:CGPointMake(65.37, 134.745) controlPoint1:CGPointMake(35.401, 124.358) controlPoint2:CGPointMake(48.086, 131.168)];
    [path addCurveToPoint:CGPointMake(84.262, 159.328) controlPoint1:CGPointMake(77.939, 137.347) controlPoint2:CGPointMake(83.813, 144.991)];
    [path addLineToPoint:CGPointMake(84.461, 165.688)];
    [path addLineToPoint:CGPointMake(89.225, 166.596)];
    [path addCurveToPoint:CGPointMake(97.174, 167.59) controlPoint1:CGPointMake(91.846, 167.095) controlPoint2:CGPointMake(95.423, 167.542)];
    [path addLineToPoint:CGPointMake(100.358, 167.675)];
    [path addLineToPoint:CGPointMake(100.358, 162.952)];
    [path addCurveToPoint:CGPointMake(101.114, 157.734) controlPoint1:CGPointMake(100.358, 160.355) controlPoint2:CGPointMake(100.699, 158.006)];
    [path addCurveToPoint:CGPointMake(106.353, 163.723) controlPoint1:CGPointMake(103.224, 156.35) controlPoint2:CGPointMake(106.353, 159.928)];
    [path addCurveToPoint:CGPointMake(115.929, 165.581) controlPoint1:CGPointMake(106.353, 165.878) controlPoint2:CGPointMake(109.046, 166.401)];
    [path addCurveToPoint:CGPointMake(121.954, 162.666) controlPoint1:CGPointMake(121.526, 164.915) controlPoint2:CGPointMake(121.721, 164.821)];
    [path addCurveToPoint:CGPointMake(131.828, 158.238) controlPoint1:CGPointMake(122.247, 159.949) controlPoint2:CGPointMake(123.414, 159.426)];
    [path addCurveToPoint:CGPointMake(278.329, 158.142) controlPoint1:CGPointMake(155.301, 154.924) controlPoint2:CGPointMake(270.165, 154.849)];
    [path addCurveToPoint:CGPointMake(280.609, 160.84) controlPoint1:CGPointMake(279.327, 158.545) controlPoint2:CGPointMake(280.353, 159.759)];
    [path addCurveToPoint:CGPointMake(284.788, 163.65) controlPoint1:CGPointMake(280.985, 162.431) controlPoint2:CGPointMake(281.782, 162.966)];
    [path addCurveToPoint:CGPointMake(291.462, 164.495) controlPoint1:CGPointMake(286.83, 164.115) controlPoint2:CGPointMake(289.834, 164.495)];
    [path addLineToPoint:CGPointMake(294.422, 164.495)];
    [path addLineToPoint:CGPointMake(294.422, 161.07)];
    [path addCurveToPoint:CGPointMake(301.014, 158.533) controlPoint1:CGPointMake(294.422, 154.268) controlPoint2:CGPointMake(298.821, 152.576)];
    [path addCurveToPoint:CGPointMake(302.986, 162.297) controlPoint1:CGPointMake(301.657, 160.282) controlPoint2:CGPointMake(302.545, 161.976)];
    [path addCurveToPoint:CGPointMake(313.836, 162.172) controlPoint1:CGPointMake(304.119, 163.122) controlPoint2:CGPointMake(312.565, 163.025)];
    [path addCurveToPoint:CGPointMake(313.656, 148.471) controlPoint1:CGPointMake(314.742, 161.563) controlPoint2:CGPointMake(314.716, 159.618)];
    [path addCurveToPoint:CGPointMake(312.112, 93.976) controlPoint1:CGPointMake(310.885, 119.324) controlPoint2:CGPointMake(310.186, 94.653)];
    [path addCurveToPoint:CGPointMake(318.004, 98.551) controlPoint1:CGPointMake(312.569, 93.816) controlPoint2:CGPointMake(315.22, 95.874)];
    [path addCurveToPoint:CGPointMake(352.153, 110.495) controlPoint1:CGPointMake(330.698, 110.756) controlPoint2:CGPointMake(341.839, 114.653)];
    [path addCurveToPoint:CGPointMake(364.597, 93.752) controlPoint1:CGPointMake(360.108, 107.288) controlPoint2:CGPointMake(363.746, 102.394)];
    [path addLineToPoint:CGPointMake(365.068, 88.972)];
    [path addLineToPoint:CGPointMake(360.465, 88.972)];
    [path addLineToPoint:CGPointMake(355.863, 88.972)];
    [path addLineToPoint:CGPointMake(355.863, 93.318)];
    [path addCurveToPoint:CGPointMake(353.265, 100.42) controlPoint1:CGPointMake(355.863, 97.217) controlPoint2:CGPointMake(355.596, 97.948)];
    [path addCurveToPoint:CGPointMake(339.947, 103.729) controlPoint1:CGPointMake(350.28, 103.587) controlPoint2:CGPointMake(346.179, 104.606)];
    [path addCurveToPoint:CGPointMake(322.145, 93.013) controlPoint1:CGPointMake(333.587, 102.834) controlPoint2:CGPointMake(328.341, 99.676)];
    [path addCurveToPoint:CGPointMake(304.609, 65.728) controlPoint1:CGPointMake(317.372, 87.881) controlPoint2:CGPointMake(314.731, 83.771)];
    [path addCurveToPoint:CGPointMake(278.113, 27.802) controlPoint1:CGPointMake(291.302, 42.005) controlPoint2:CGPointMake(285.523, 33.734)];
    [path addCurveToPoint:CGPointMake(232.157, 6.384) controlPoint1:CGPointMake(268.067, 19.762) controlPoint2:CGPointMake(250.074, 11.376)];
    [path addCurveToPoint:CGPointMake(165.546, 1.587) controlPoint1:CGPointMake(209.007, -0.065) controlPoint2:CGPointMake(188.291, -1.557)];
    [path closePath];
    [path moveToPoint:CGPointMake(184.635, 10.743)];
    [path addLineToPoint:CGPointMake(184.635, 10.743)];
    [path addCurveToPoint:CGPointMake(155.831, 12.443) controlPoint1:CGPointMake(172.463, 8.168) controlPoint2:CGPointMake(162.642, 8.747)];
    [path addCurveToPoint:CGPointMake(149.179, 26.42) controlPoint1:CGPointMake(149.467, 15.896) controlPoint2:CGPointMake(146.763, 21.578)];
    [path addCurveToPoint:CGPointMake(154.751, 33.565) controlPoint1:CGPointMake(149.655, 27.375) controlPoint2:CGPointMake(152.163, 30.59)];
    [path addCurveToPoint:CGPointMake(162.378, 53.079) controlPoint1:CGPointMake(161.637, 41.479) controlPoint2:CGPointMake(162.837, 44.549)];
    [path addCurveToPoint:CGPointMake(160.105, 63.937) controlPoint1:CGPointMake(162.096, 58.343) controlPoint2:CGPointMake(161.559, 60.905)];
    [path addCurveToPoint:CGPointMake(143.132, 73.611) controlPoint1:CGPointMake(156.538, 71.374) controlPoint2:CGPointMake(153.867, 72.896)];
    [path addCurveToPoint:CGPointMake(125.834, 87.828) controlPoint1:CGPointMake(131.265, 74.401) controlPoint2:CGPointMake(125.834, 78.864)];
    [path addCurveToPoint:CGPointMake(145.181, 115.067) controlPoint1:CGPointMake(125.834, 95.551) controlPoint2:CGPointMake(136.013, 109.882)];
    [path addCurveToPoint:CGPointMake(206.258, 100.067) controlPoint1:CGPointMake(163.616, 125.492) controlPoint2:CGPointMake(189.65, 119.098)];
    [path addCurveToPoint:CGPointMake(217.982, 64.096) controlPoint1:CGPointMake(214.949, 90.106) controlPoint2:CGPointMake(217.959, 80.872)];
    [path addCurveToPoint:CGPointMake(208.539, 27.561) controlPoint1:CGPointMake(218.004, 48.787) controlPoint2:CGPointMake(215.204, 37.958)];
    [path addCurveToPoint:CGPointMake(184.635, 10.743) controlPoint1:CGPointMake(202.795, 18.601) controlPoint2:CGPointMake(194.631, 12.858)];
    [path closePath];
    [path moveToPoint:CGPointMake(129.126, 36.966)];
    [path addLineToPoint:CGPointMake(129.126, 36.966)];
    [path addCurveToPoint:CGPointMake(122.961, 39.429) controlPoint1:CGPointMake(128.241, 34.521) controlPoint2:CGPointMake(124.718, 35.929)];
    [path addCurveToPoint:CGPointMake(123.266, 42.411) controlPoint1:CGPointMake(122.26, 40.825) controlPoint2:CGPointMake(122.32, 41.407)];
    [path addCurveToPoint:CGPointMake(127.915, 42.421) controlPoint1:CGPointMake(124.746, 43.981) controlPoint2:CGPointMake(125.813, 43.983)];
    [path addCurveToPoint:CGPointMake(129.126, 36.966) controlPoint1:CGPointMake(129.577, 41.186) controlPoint2:CGPointMake(129.986, 39.344)];
    [path closePath];
    
    
    //Path color fill
    [[UIColor colorWithRed:0.466 green: 0.451 blue:0.439 alpha:1] setFill];
    [path fill];
    
    [[UIColor blackColor] setStroke];
    path.lineWidth = 1;
    [path stroke];
    return path;
}

@end

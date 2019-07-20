//
//  KJOView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/24.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJOView.h"

@implementation KJOView

- (UIBezierPath*)drawRecta{
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(220.054, 1.152)];
    [path addCurveToPoint:CGPointMake(219.58, 10.613) controlPoint1:CGPointMake(218.282, 2.318) controlPoint2:CGPointMake(217.958, 8.782)];
    [path addCurveToPoint:CGPointMake(224.184, 11.781) controlPoint1:CGPointMake(220.149, 11.256) controlPoint2:CGPointMake(222.221, 11.781)];
    [path addCurveToPoint:CGPointMake(228.757, 9.292) controlPoint1:CGPointMake(227.175, 11.781) controlPoint2:CGPointMake(227.915, 11.379)];
    [path addCurveToPoint:CGPointMake(220.054, 1.152) controlPoint1:CGPointMake(231.31, 2.966) controlPoint2:CGPointMake(225.525, -2.445)];
    [path closePath];
    [path moveToPoint:CGPointMake(223.687, 2.492)];
    [path addLineToPoint:CGPointMake(223.687, 2.492)];
    [path addCurveToPoint:CGPointMake(220.597, 2.488) controlPoint1:CGPointMake(222.361, 0.687) controlPoint2:CGPointMake(221.21, 0.686)];
    [path addCurveToPoint:CGPointMake(222.425, 5.941) controlPoint1:CGPointMake(219.991, 4.273) controlPoint2:CGPointMake(220.874, 5.941)];
    [path addCurveToPoint:CGPointMake(223.687, 2.492) controlPoint1:CGPointMake(224.2, 5.941) controlPoint2:CGPointMake(224.872, 4.103)];
    [path closePath];
    [path moveToPoint:CGPointMake(213.719, 18.57)];
    [path addCurveToPoint:CGPointMake(191.903, 29.828) controlPoint1:CGPointMake(204.439, 20.153) controlPoint2:CGPointMake(196.067, 24.474)];
    [path addCurveToPoint:CGPointMake(189.489, 33.81) controlPoint1:CGPointMake(190.375, 31.793) controlPoint2:CGPointMake(189.289, 33.584)];
    [path addCurveToPoint:CGPointMake(197.948, 32.739) controlPoint1:CGPointMake(189.689, 34.036) controlPoint2:CGPointMake(193.495, 33.554)];
    [path addCurveToPoint:CGPointMake(251.94, 36.113) controlPoint1:CGPointMake(214.666, 29.678) controlPoint2:CGPointMake(239.659, 31.24)];
    [path addLineToPoint:CGPointMake(256.747, 38.02)];
    [path addLineToPoint:CGPointMake(254.841, 35.73)];
    [path addCurveToPoint:CGPointMake(207.913, 29.208) controlPoint1:CGPointMake(250.936, 31.037) controlPoint2:CGPointMake(223.984, 27.291)];
    [path addCurveToPoint:CGPointMake(195.913, 30.916) controlPoint1:CGPointMake(202.617, 29.84) controlPoint2:CGPointMake(197.217, 30.608)];
    [path addCurveToPoint:CGPointMake(193.542, 30.455) controlPoint1:CGPointMake(194.519, 31.245) controlPoint2:CGPointMake(193.542, 31.055)];
    [path addCurveToPoint:CGPointMake(200.224, 27.665) controlPoint1:CGPointMake(193.542, 29.894) controlPoint2:CGPointMake(196.549, 28.638)];
    [path addCurveToPoint:CGPointMake(242.426, 27.606) controlPoint1:CGPointMake(209.501, 25.208) controlPoint2:CGPointMake(233.527, 25.174)];
    [path addCurveToPoint:CGPointMake(249.174, 29.302) controlPoint1:CGPointMake(245.839, 28.539) controlPoint2:CGPointMake(248.875, 29.302)];
    [path addCurveToPoint:CGPointMake(242.687, 23.326) controlPoint1:CGPointMake(249.857, 29.302) controlPoint2:CGPointMake(245.552, 25.336)];
    [path addCurveToPoint:CGPointMake(213.719, 18.57) controlPoint1:CGPointMake(236.906, 19.27) controlPoint2:CGPointMake(222.997, 16.986)];
    [path closePath];
    [path moveToPoint:CGPointMake(203.457, 39.527)];
    [path addCurveToPoint:CGPointMake(156.38, 62.165) controlPoint1:CGPointMake(187.167, 42.493) controlPoint2:CGPointMake(169.492, 50.993)];
    [path addCurveToPoint:CGPointMake(142.626, 73.916) controlPoint1:CGPointMake(152.774, 65.236) controlPoint2:CGPointMake(146.585, 70.525)];
    [path addCurveToPoint:CGPointMake(122.646, 86.68) controlPoint1:CGPointMake(135.005, 80.445) controlPoint2:CGPointMake(130.053, 83.609)];
    [path addCurveToPoint:CGPointMake(61.671, 78.976) controlPoint1:CGPointMake(100.039, 96.052) controlPoint2:CGPointMake(80.769, 93.618)];
    [path addCurveToPoint:CGPointMake(42.445, 58.583) controlPoint1:CGPointMake(56.116, 74.717) controlPoint2:CGPointMake(46.12, 64.115)];
    [path addLineToPoint:CGPointMake(40.235, 55.256)];
    [path addLineToPoint:CGPointMake(37.668, 57.695)];
    [path addCurveToPoint:CGPointMake(31.172, 61.375) controlPoint1:CGPointMake(36.257, 59.036) controlPoint2:CGPointMake(33.333, 60.692)];
    [path addLineToPoint:CGPointMake(27.242, 62.617)];
    [path addLineToPoint:CGPointMake(36.029, 68.647)];
    [path addCurveToPoint:CGPointMake(90.737, 114.78) controlPoint1:CGPointMake(50.644, 78.675) controlPoint2:CGPointMake(69.047, 94.194)];
    [path addCurveToPoint:CGPointMake(126.102, 145.368) controlPoint1:CGPointMake(108.687, 131.816) controlPoint2:CGPointMake(116.347, 138.441)];
    [path addCurveToPoint:CGPointMake(185.351, 171.958) controlPoint1:CGPointMake(145.861, 159.399) controlPoint2:CGPointMake(164.517, 167.771)];
    [path addCurveToPoint:CGPointMake(230.529, 172.064) controlPoint1:CGPointMake(197.052, 174.31) controlPoint2:CGPointMake(219.412, 174.362)];
    [path addCurveToPoint:CGPointMake(289.638, 116.476) controlPoint1:CGPointMake(263.541, 165.241) controlPoint2:CGPointMake(284.285, 145.733)];
    [path addCurveToPoint:CGPointMake(283.065, 73.133) controlPoint1:CGPointMake(291.903, 104.092) controlPoint2:CGPointMake(289.436, 87.821)];
    [path addCurveToPoint:CGPointMake(245.704, 40.969) controlPoint1:CGPointMake(276.25, 57.42) controlPoint2:CGPointMake(263.215, 46.198)];
    [path addCurveToPoint:CGPointMake(203.457, 39.527) controlPoint1:CGPointMake(236.519, 38.225) controlPoint2:CGPointMake(214.694, 37.48)];
    [path closePath];
    [path moveToPoint:CGPointMake(195.094, 49.937)];
    [path addLineToPoint:CGPointMake(195.094, 49.937)];
    [path addCurveToPoint:CGPointMake(188.369, 49.836) controlPoint1:CGPointMake(193.942, 48.637) controlPoint2:CGPointMake(193.829, 48.635)];
    [path addCurveToPoint:CGPointMake(165.69, 61.734) controlPoint1:CGPointMake(184.198, 50.753) controlPoint2:CGPointMake(175.131, 55.51)];
    [path addCurveToPoint:CGPointMake(151.577, 74.719) controlPoint1:CGPointMake(160.04, 65.458) controlPoint2:CGPointMake(150.858, 73.907)];
    [path addCurveToPoint:CGPointMake(184.058, 67.156) controlPoint1:CGPointMake(152.138, 75.353) controlPoint2:CGPointMake(177.929, 69.348)];
    [path addCurveToPoint:CGPointMake(195.612, 59.863) controlPoint1:CGPointMake(190.438, 64.874) controlPoint2:CGPointMake(194.857, 62.085)];
    [path addCurveToPoint:CGPointMake(195.094, 49.937) controlPoint1:CGPointMake(196.497, 57.26) controlPoint2:CGPointMake(196.179, 51.162)];
    [path closePath];
    [path moveToPoint:CGPointMake(10.329, 47.429)];
    [path addCurveToPoint:CGPointMake(3, 50.8) controlPoint1:CGPointMake(6.832, 48.031) controlPoint2:CGPointMake(3, 49.794)];
    [path addCurveToPoint:CGPointMake(8.116, 53.636) controlPoint1:CGPointMake(3, 51.966) controlPoint2:CGPointMake(6.012, 53.636)];
    [path addCurveToPoint:CGPointMake(9.897, 52.688) controlPoint1:CGPointMake(9.096, 53.636) controlPoint2:CGPointMake(9.897, 53.209)];
    [path addCurveToPoint:CGPointMake(17.992, 48.459) controlPoint1:CGPointMake(9.897, 51.326) controlPoint2:CGPointMake(14.081, 49.141)];
    [path addCurveToPoint:CGPointMake(31.299, 51.737) controlPoint1:CGPointMake(22.348, 47.699) controlPoint2:CGPointMake(29.023, 49.344)];
    [path addCurveToPoint:CGPointMake(35.29, 52.681) controlPoint1:CGPointMake(32.728, 53.24) controlPoint2:CGPointMake(33.539, 53.432)];
    [path addCurveToPoint:CGPointMake(21.968, 47.396) controlPoint1:CGPointMake(40.927, 50.261) controlPoint2:CGPointMake(35.231, 48.001)];
    [path addCurveToPoint:CGPointMake(10.329, 47.429) controlPoint1:CGPointMake(16.989, 47.169) controlPoint2:CGPointMake(11.751, 47.183)];
    [path closePath];
    [path moveToPoint:CGPointMake(329.121, 63.811)];
    [path addCurveToPoint:CGPointMake(299.262, 88.564) controlPoint1:CGPointMake(316.88, 66.952) controlPoint2:CGPointMake(304.76, 77)];
    [path addCurveToPoint:CGPointMake(296.672, 105.945) controlPoint1:CGPointMake(296.929, 93.472) controlPoint2:CGPointMake(296.772, 94.524)];
    [path addCurveToPoint:CGPointMake(298.269, 119.45) controlPoint1:CGPointMake(296.574, 117.028) controlPoint2:CGPointMake(296.715, 118.221)];
    [path addCurveToPoint:CGPointMake(306.842, 117.803) controlPoint1:CGPointMake(301.145, 121.724) controlPoint2:CGPointMake(304.384, 121.101)];
    [path addCurveToPoint:CGPointMake(305.456, 108.656) controlPoint1:CGPointMake(310.167, 113.343) controlPoint2:CGPointMake(309.464, 108.708)];
    [path addCurveToPoint:CGPointMake(303.551, 102.791) controlPoint1:CGPointMake(303.597, 108.632) controlPoint2:CGPointMake(303.476, 108.257)];
    [path addCurveToPoint:CGPointMake(312.574, 82.484) controlPoint1:CGPointMake(303.655, 95.202) controlPoint2:CGPointMake(306.622, 88.525)];
    [path addCurveToPoint:CGPointMake(351.078, 81.367) controlPoint1:CGPointMake(322.467, 72.441) controlPoint2:CGPointMake(341.277, 71.896)];
    [path addCurveToPoint:CGPointMake(355.197, 115.303) controlPoint1:CGPointMake(358.735, 88.766) controlPoint2:CGPointMake(360.5, 103.31)];
    [path addCurveToPoint:CGPointMake(326.639, 139.324) controlPoint1:CGPointMake(350.115, 126.797) controlPoint2:CGPointMake(339.709, 135.55)];
    [path addCurveToPoint:CGPointMake(308.263, 141.003) controlPoint1:CGPointMake(321.278, 140.872) controlPoint2:CGPointMake(317.635, 141.204)];
    [path addCurveToPoint:CGPointMake(292.515, 143.008) controlPoint1:CGPointMake(297.529, 140.772) controlPoint2:CGPointMake(296.241, 140.936)];
    [path addCurveToPoint:CGPointMake(284.078, 171.911) controlPoint1:CGPointMake(282.449, 148.605) controlPoint2:CGPointMake(278.578, 161.865)];
    [path addCurveToPoint:CGPointMake(301.616, 174.331) controlPoint1:CGPointMake(287.542, 178.24) controlPoint2:CGPointMake(296.435, 179.467)];
    [path addCurveToPoint:CGPointMake(301.767, 160.539) controlPoint1:CGPointMake(306.292, 169.696) controlPoint2:CGPointMake(306.366, 162.905)];
    [path addCurveToPoint:CGPointMake(297.87, 161.189) controlPoint1:CGPointMake(299.968, 159.614) controlPoint2:CGPointMake(299.303, 159.725)];
    [path addCurveToPoint:CGPointMake(298.944, 170.845) controlPoint1:CGPointMake(295.204, 163.913) controlPoint2:CGPointMake(295.649, 167.913)];
    [path addLineToPoint:CGPointMake(301.746, 173.338)];
    [path addLineToPoint:CGPointMake(298.858, 173.349)];
    [path addCurveToPoint:CGPointMake(293.038, 170.05) controlPoint1:CGPointMake(296.715, 173.357) controlPoint2:CGPointMake(295.213, 172.505)];
    [path addCurveToPoint:CGPointMake(292.079, 155.739) controlPoint1:CGPointMake(289.396, 165.938) controlPoint2:CGPointMake(289.053, 160.814)];
    [path addCurveToPoint:CGPointMake(314.679, 148.988) controlPoint1:CGPointMake(295.338, 150.273) controlPoint2:CGPointMake(297.479, 149.633)];
    [path addCurveToPoint:CGPointMake(346.053, 140.048) controlPoint1:CGPointMake(332.366, 148.324) controlPoint2:CGPointMake(336.227, 147.224)];
    [path addCurveToPoint:CGPointMake(365.726, 78.864) controlPoint1:CGPointMake(368.049, 123.983) controlPoint2:CGPointMake(376.209, 98.604)];
    [path addCurveToPoint:CGPointMake(329.121, 63.811) controlPoint1:CGPointMake(359, 66.199) controlPoint2:CGPointMake(343.944, 60.008)];
    [path closePath];
    [path moveToPoint:CGPointMake(237.945, 180.842)];
    [path addCurveToPoint:CGPointMake(183.604, 181.522) controlPoint1:CGPointMake(225.285, 184.664) controlPoint2:CGPointMake(208.032, 184.88)];
    [path addLineToPoint:CGPointMake(179.269, 180.926)];
    [path addLineToPoint:CGPointMake(172.395, 188.37)];
    [path addCurveToPoint:CGPointMake(166.815, 196.654) controlPoint1:CGPointMake(166.97, 194.244) controlPoint2:CGPointMake(165.794, 195.99)];
    [path addCurveToPoint:CGPointMake(207.768, 200.834) controlPoint1:CGPointMake(169.941, 198.687) controlPoint2:CGPointMake(191.801, 200.918)];
    [path addCurveToPoint:CGPointMake(261.39, 193.443) controlPoint1:CGPointMake(229.895, 200.717) controlPoint2:CGPointMake(262.26, 196.256)];
    [path addCurveToPoint:CGPointMake(251.308, 194.099) controlPoint1:CGPointMake(260.961, 192.055) controlPoint2:CGPointMake(259.371, 192.159)];
    [path addCurveToPoint:CGPointMake(209.061, 198.091) controlPoint1:CGPointMake(238.448, 197.194) controlPoint2:CGPointMake(228.367, 198.146)];
    [path addCurveToPoint:CGPointMake(170.839, 194.601) controlPoint1:CGPointMake(190.243, 198.036) controlPoint2:CGPointMake(174.084, 196.561)];
    [path addCurveToPoint:CGPointMake(169.568, 193.288) controlPoint1:CGPointMake(169.967, 194.073) controlPoint2:CGPointMake(169.395, 193.483)];
    [path addCurveToPoint:CGPointMake(178.479, 193.894) controlPoint1:CGPointMake(169.74, 193.092) controlPoint2:CGPointMake(173.75, 193.365)];
    [path addCurveToPoint:CGPointMake(230.616, 193.857) controlPoint1:CGPointMake(190.472, 195.234) controlPoint2:CGPointMake(217.757, 195.215)];
    [path addCurveToPoint:CGPointMake(257.981, 188.538) controlPoint1:CGPointMake(240.228, 192.842) controlPoint2:CGPointMake(257.068, 189.568)];
    [path addCurveToPoint:CGPointMake(246.737, 178.363) controlPoint1:CGPointMake(258.552, 187.893) controlPoint2:CGPointMake(247.856, 178.215)];
    [path addCurveToPoint:CGPointMake(237.945, 180.842) controlPoint1:CGPointMake(246.169, 178.438) controlPoint2:CGPointMake(242.212, 179.554)];
    [path closePath];
    
    
    //Path color fill
    [[UIColor colorWithRed:0.937 green: 0.628 blue:0.0395 alpha:1] setFill];
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

//
//  KJEView.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJEView.h"

@implementation KJEView

- (UIBezierPath*)drawRecta{
    
    //// Path drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(260.341, 52.59)];
    [path addLineToPoint:CGPointMake(260.341, 52.59)];
    [path addCurveToPoint:CGPointMake(245.028, 47.565) controlPoint1:CGPointMake(254.489, 49.527) controlPoint2:CGPointMake(247.598, 47.265)];
    [path addCurveToPoint:CGPointMake(193.251, 49.524) controlPoint1:CGPointMake(242.458, 47.864) controlPoint2:CGPointMake(219.158, 48.746)];
    [path addCurveToPoint:CGPointMake(140.957, 54.153) controlPoint1:CGPointMake(162.656, 50.443) controlPoint2:CGPointMake(144.327, 52.065)];
    [path addCurveToPoint:CGPointMake(111.179, 96.479) controlPoint1:CGPointMake(131.154, 60.226) controlPoint2:CGPointMake(116.526, 81.018)];
    [path addCurveToPoint:CGPointMake(102.236, 113.448) controlPoint1:CGPointMake(108.235, 104.993) controlPoint2:CGPointMake(104.21, 112.629)];
    [path addCurveToPoint:CGPointMake(81.542, 114.938) controlPoint1:CGPointMake(100.261, 114.267) controlPoint2:CGPointMake(90.949, 114.938)];
    [path addCurveToPoint:CGPointMake(54.541, 121.21) controlPoint1:CGPointMake(67.844, 114.938) controlPoint2:CGPointMake(62.468, 116.187)];
    [path addCurveToPoint:CGPointMake(18.197, 192.375) controlPoint1:CGPointMake(37.281, 132.149) controlPoint2:CGPointMake(23.06, 159.995)];
    [path addCurveToPoint:CGPointMake(53.649, 211.59) controlPoint1:CGPointMake(15.737, 208.758) controlPoint2:CGPointMake(20.962, 211.59)];
    [path addLineToPoint:CGPointMake(79.651, 211.59)];
    [path addLineToPoint:CGPointMake(82.996, 220.08)];
    [path addCurveToPoint:CGPointMake(92.087, 234.213) controlPoint1:CGPointMake(84.835, 224.749) controlPoint2:CGPointMake(88.926, 231.109)];
    [path addCurveToPoint:CGPointMake(127.257, 244.327) controlPoint1:CGPointMake(99.451, 241.446) controlPoint2:CGPointMake(116.827, 246.443)];
    [path addCurveToPoint:CGPointMake(153.415, 219.317) controlPoint1:CGPointMake(137.784, 242.191) controlPoint2:CGPointMake(151.416, 229.157)];
    [path addLineToPoint:CGPointMake(154.984, 211.59)];
    [path addLineToPoint:CGPointMake(194.71, 211.59)];
    [path addLineToPoint:CGPointMake(234.436, 211.59)];
    [path addLineToPoint:CGPointMake(236.945, 218.774)];
    [path addCurveToPoint:CGPointMake(281.376, 244.424) controlPoint1:CGPointMake(243.088, 236.358) controlPoint2:CGPointMake(263.383, 248.075)];
    [path addCurveToPoint:CGPointMake(308.015, 219.317) controlPoint1:CGPointMake(292.324, 242.203) controlPoint2:CGPointMake(305.981, 229.331)];
    [path addLineToPoint:CGPointMake(309.585, 211.59)];
    [path addLineToPoint:CGPointMake(331.737, 211.55)];
    [path addCurveToPoint:CGPointMake(356.573, 209.591) controlPoint1:CGPointMake(343.921, 211.528) controlPoint2:CGPointMake(355.097, 210.646)];
    [path addCurveToPoint:CGPointMake(367.176, 187.612) controlPoint1:CGPointMake(359.901, 207.209) controlPoint2:CGPointMake(367.176, 192.13)];
    [path addCurveToPoint:CGPointMake(347.099, 136.086) controlPoint1:CGPointMake(367.176, 180.779) controlPoint2:CGPointMake(354.091, 147.198)];
    [path addCurveToPoint:CGPointMake(315.74, 114.938) controlPoint1:CGPointMake(334.663, 116.324) controlPoint2:CGPointMake(332.608, 114.938)];
    [path addLineToPoint:CGPointMake(300.539, 114.938)];
    [path addLineToPoint:CGPointMake(296.088, 100.779)];
    [path addCurveToPoint:CGPointMake(260.341, 52.59) controlPoint1:CGPointMake(290.094, 81.71) controlPoint2:CGPointMake(273.668, 59.567)];
    [path closePath];
    [path moveToPoint:CGPointMake(141.041, 76.408)];
    [path addCurveToPoint:CGPointMake(137.094, 88.338) controlPoint1:CGPointMake(132.269, 86.89) controlPoint2:CGPointMake(132.049, 87.556)];
    [path addCurveToPoint:CGPointMake(157.016, 111.615) controlPoint1:CGPointMake(142.712, 89.209) controlPoint2:CGPointMake(157.016, 105.923)];
    [path addCurveToPoint:CGPointMake(177.549, 114.938) controlPoint1:CGPointMake(157.016, 114.043) controlPoint2:CGPointMake(162.542, 114.938)];
    [path addLineToPoint:CGPointMake(198.082, 114.938)];
    [path addLineToPoint:CGPointMake(198.082, 90.122)];
    [path addLineToPoint:CGPointMake(198.082, 65.306)];
    [path addLineToPoint:CGPointMake(174.207, 65.306)];
    [path addLineToPoint:CGPointMake(150.331, 65.306)];
    [path addLineToPoint:CGPointMake(141.041, 76.408)];
    [path closePath];
    [path moveToPoint:CGPointMake(213.525, 69.438)];
    [path addCurveToPoint:CGPointMake(214.991, 93.97) controlPoint1:CGPointMake(214.331, 71.71) controlPoint2:CGPointMake(214.991, 82.75)];
    [path addLineToPoint:CGPointMake(214.991, 114.371)];
    [path addLineToPoint:CGPointMake(248.81, 114.605)];
    [path addCurveToPoint:CGPointMake(282.641, 111.622) controlPoint1:CGPointMake(274.085, 114.779) controlPoint2:CGPointMake(282.632, 114.025)];
    [path addCurveToPoint:CGPointMake(265.155, 74.208) controlPoint1:CGPointMake(282.676, 102.218) controlPoint2:CGPointMake(273.308, 82.172)];
    [path addCurveToPoint:CGPointMake(234.051, 65.306) controlPoint1:CGPointMake(256.194, 65.453) controlPoint2:CGPointMake(255.679, 65.306)];
    [path addCurveToPoint:CGPointMake(213.525, 69.438) controlPoint1:CGPointMake(214.989, 65.306) controlPoint2:CGPointMake(212.254, 65.856)];
    [path closePath];
    [path moveToPoint:CGPointMake(128.029, 95.916)];
    [path addCurveToPoint:CGPointMake(126.478, 103.622) controlPoint1:CGPointMake(128.029, 97.523) controlPoint2:CGPointMake(127.331, 100.99)];
    [path addCurveToPoint:CGPointMake(129.394, 103.855) controlPoint1:CGPointMake(125.001, 108.18) controlPoint2:CGPointMake(125.14, 108.191)];
    [path addCurveToPoint:CGPointMake(130.945, 96.148) controlPoint1:CGPointMake(132.883, 100.299) controlPoint2:CGPointMake(133.222, 98.611)];
    [path addCurveToPoint:CGPointMake(128.029, 95.916) controlPoint1:CGPointMake(128.923, 93.963) controlPoint2:CGPointMake(128.029, 93.891)];
    [path closePath];
    [path moveToPoint:CGPointMake(60.994, 134.628)];
    [path addCurveToPoint:CGPointMake(49.568, 149.879) controlPoint1:CGPointMake(58.045, 136.861) controlPoint2:CGPointMake(52.904, 143.724)];
    [path addCurveToPoint:CGPointMake(35.202, 193.611) controlPoint1:CGPointMake(42.25, 163.383) controlPoint2:CGPointMake(33.372, 190.409)];
    [path addCurveToPoint:CGPointMake(76.092, 193.901) controlPoint1:CGPointMake(36.791, 196.391) controlPoint2:CGPointMake(72.667, 196.646)];
    [path addCurveToPoint:CGPointMake(83.641, 181.533) controlPoint1:CGPointMake(77.421, 192.837) controlPoint2:CGPointMake(80.818, 187.271)];
    [path addCurveToPoint:CGPointMake(131.238, 162.909) controlPoint1:CGPointMake(92.853, 162.809) controlPoint2:CGPointMake(113.306, 154.806)];
    [path addCurveToPoint:CGPointMake(153.655, 189.587) controlPoint1:CGPointMake(140.305, 167.005) controlPoint2:CGPointMake(151.509, 180.339)];
    [path addCurveToPoint:CGPointMake(182.038, 195.894) controlPoint1:CGPointMake(155.1, 195.813) controlPoint2:CGPointMake(155.565, 195.916)];
    [path addCurveToPoint:CGPointMake(221.169, 194.284) controlPoint1:CGPointMake(196.841, 195.882) controlPoint2:CGPointMake(214.45, 195.157)];
    [path addCurveToPoint:CGPointMake(238.191, 181.913) controlPoint1:CGPointMake(232.578, 192.801) controlPoint2:CGPointMake(233.702, 191.984)];
    [path addCurveToPoint:CGPointMake(284.283, 162.124) controlPoint1:CGPointMake(246.31, 163.696) controlPoint2:CGPointMake(266.702, 154.941)];
    [path addCurveToPoint:CGPointMake(306.917, 187.205) controlPoint1:CGPointMake(293.922, 166.062) controlPoint2:CGPointMake(303.807, 177.016)];
    [path addLineToPoint:CGPointMake(309.576, 195.917)];
    [path addLineToPoint:CGPointMake(329.044, 195.917)];
    [path addLineToPoint:CGPointMake(348.512, 195.917)];
    [path addLineToPoint:CGPointMake(347.274, 179.229)];
    [path addCurveToPoint:CGPointMake(339.026, 147.229) controlPoint1:CGPointMake(346.455, 168.2) controlPoint2:CGPointMake(343.658, 157.348)];
    [path addLineToPoint:CGPointMake(332.018, 131.917)];
    [path addLineToPoint:CGPointMake(199.186, 131.242)];
    [path addCurveToPoint:CGPointMake(60.994, 134.628) controlPoint1:CGPointMake(82.284, 130.648) controlPoint2:CGPointMake(65.712, 131.054)];
    [path closePath];
    [path moveToPoint:CGPointMake(99.96, 178.543)];
    [path addCurveToPoint:CGPointMake(92.32, 200.276) controlPoint1:CGPointMake(94.466, 183.653) controlPoint2:CGPointMake(93.188, 187.289)];
    [path addCurveToPoint:CGPointMake(96.974, 223.036) controlPoint1:CGPointMake(91.413, 213.825) controlPoint2:CGPointMake(92.024, 216.813)];
    [path addCurveToPoint:CGPointMake(129.387, 228.703) controlPoint1:CGPointMake(104.417, 232.392) controlPoint2:CGPointMake(120.269, 235.164)];
    [path addCurveToPoint:CGPointMake(142.522, 197.106) controlPoint1:CGPointMake(136.964, 223.334) controlPoint2:CGPointMake(142.522, 209.963)];
    [path addCurveToPoint:CGPointMake(99.96, 178.543) controlPoint1:CGPointMake(142.522, 175.525) controlPoint2:CGPointMake(115.755, 163.851)];
    [path closePath];
    [path moveToPoint:CGPointMake(124.405, 203.753)];
    [path addLineToPoint:CGPointMake(124.405, 203.753)];
    [path addCurveToPoint:CGPointMake(117.925, 193.801) controlPoint1:CGPointMake(124.405, 195.778) controlPoint2:CGPointMake(123.578, 194.507)];
    [path addCurveToPoint:CGPointMake(108.781, 209.134) controlPoint1:CGPointMake(109.646, 192.767) controlPoint2:CGPointMake(104.746, 200.982)];
    [path addCurveToPoint:CGPointMake(117.925, 213.706) controlPoint1:CGPointMake(110.657, 212.925) controlPoint2:CGPointMake(113.359, 214.276)];
    [path addCurveToPoint:CGPointMake(124.405, 203.753) controlPoint1:CGPointMake(123.578, 213) controlPoint2:CGPointMake(124.405, 211.729)];
    [path closePath];
    [path moveToPoint:CGPointMake(254.56, 178.543)];
    [path addCurveToPoint:CGPointMake(246.92, 200.276) controlPoint1:CGPointMake(249.067, 183.653) controlPoint2:CGPointMake(247.789, 187.289)];
    [path addCurveToPoint:CGPointMake(251.575, 223.036) controlPoint1:CGPointMake(246.014, 213.825) controlPoint2:CGPointMake(246.625, 216.813)];
    [path addCurveToPoint:CGPointMake(283.988, 228.703) controlPoint1:CGPointMake(259.017, 232.392) controlPoint2:CGPointMake(274.869, 235.164)];
    [path addCurveToPoint:CGPointMake(297.123, 197.106) controlPoint1:CGPointMake(291.564, 223.334) controlPoint2:CGPointMake(297.123, 209.963)];
    [path addCurveToPoint:CGPointMake(254.56, 178.543) controlPoint1:CGPointMake(297.123, 175.525) controlPoint2:CGPointMake(270.355, 163.851)];
    [path closePath];
    [path moveToPoint:CGPointMake(279.006, 203.753)];
    [path addLineToPoint:CGPointMake(279.006, 203.753)];
    [path addCurveToPoint:CGPointMake(272.525, 193.801) controlPoint1:CGPointMake(279.006, 195.778) controlPoint2:CGPointMake(278.178, 194.507)];
    [path addCurveToPoint:CGPointMake(263.381, 198.372) controlPoint1:CGPointMake(267.96, 193.231) controlPoint2:CGPointMake(265.257, 194.582)];
    [path addCurveToPoint:CGPointMake(272.525, 213.706) controlPoint1:CGPointMake(259.347, 206.524) controlPoint2:CGPointMake(264.246, 214.74)];
    [path addCurveToPoint:CGPointMake(279.006, 203.753) controlPoint1:CGPointMake(278.178, 213) controlPoint2:CGPointMake(279.006, 211.729)];
    [path closePath];
    
    
    //Path color fill
    [[UIColor colorWithRed:0.99 green: 0.986 blue:0.989 alpha:1] setFill];
    [path fill];
    
    [[UIColor blackColor] setStroke];
    path.lineWidth = 1;
    [path stroke];

    return path;
}


@end

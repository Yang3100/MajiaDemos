//
//  KJCodeView.m
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/3.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJCodeView.h"
#import "NSString+Category.h"

@interface KJCodeView (){
    NSMutableArray *textArray;
    //线的条数
    NSInteger lineNum;
    
    UIColor *linecolor,*textcolor;
    UIFont *textFont;
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *underlineArr;
@end

@implementation KJCodeView

- (void)_config{
    self.backgroundColor = [UIColor clearColor];
    self.LineBottomHeight = 5;
    self.Radius = 5;
    
    self.emptyEditEnd = NO;
    self.hasSpaceLine = NO;
    self.hasUnderLine = YES;
}

- (instancetype)initWithFrame:(CGRect)frame LineColor:(UIColor* )lColor TextFont:(CGFloat)font;{
    if (self = [super initWithFrame:frame]) {
        /// 初始化配置信息
        [self _config];
        
        //数字样式是的颜色和线条颜色相同
        if (!lColor) {
            lColor = UIColor.blackColor;
        }
        linecolor = textcolor = lColor;
        textFont = [UIFont boldSystemFontOfSize:font * 0.3];
        
        //设置的字体高度小于self的高
        NSAssert(textFont.lineHeight < self.frame.size.height, @"设置的字体高度应该小于self的高");
        [self addSubview:self.textField];
    }
    return self;
}
-(void)setWithNum:(NSInteger)num{
    textArray = [NSMutableArray arrayWithCapacity:num];
    CGRect rect = self.frame;
    if (num > kBaseLineNum) {
        rect.size.width = kScreenWidth * 0.8;
    }else{
        rect.size.width = kScreenWidth * 0.8 / kBaseLineNum * num;
    }
    self.frame = rect;
    lineNum = num;
    [self addUnderLine];
}

-(void)setContent:(NSString *)content{
    _content = content;
    if (_content) {
        NSArray* words = [_content words];
        textArray = [words mutableCopy];
        _textField.text = _content;
        [self viewUpdate];
    }
}

-(void)viewUpdate{
    NSInteger length = _textField.text.length;
    
    //改变数组，存储需要画的字符
    //通过判断textfield的长度和数组中的长度比较，选择删除还是添加
    if (length<=lineNum) {
        //标记为需要重绘
        [self setNeedsDisplay];
    }
    
    if (_underlineArr.count > 0) {
        //判断底部的view隐藏还是显示
        for (NSInteger i = 0; i < lineNum; i ++) {
            CAShapeLayer *obj = [_underlineArr objectAtIndex:i];
            if (i < _textField.text.length) {
                obj.hidden = YES;
            } else {
                obj.hidden = NO;
            }
        }
    }
    
    if (length == lineNum && self.EndEditBlcok) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.EndEditBlcok(self.textField.text);
            [self emptyAndDisplay];
        });
        
    }
    if (length > lineNum) {
        _textField.text = [_textField.text substringToIndex:lineNum];
        [self emptyAndDisplay];
        
    }
}

- (void)setHasSpaceLine:(BOOL)hasSpaceLine {
    _hasSpaceLine = hasSpaceLine;
    if (hasSpaceLine) {
        [self addSpaceLine];
    }
}

//置空 重绘
- (void)emptyAndDisplay {
    if (_emptyEditEnd) {
        _textField.text = @"";
        [textArray removeAllObjects];
        [self setNeedsDisplay];
    }
    
    if (_hasSpaceLine) {
        [self addSpaceLine];
    }
    
    if (_hasUnderLine) {
        [self addUnderLine];
    }
}

//键盘弹出
- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.hidden = YES;
        _textField.userInteractionEnabled = NO;
    }
    return _textField;
}

//添加下划线
- (void)addUnderLine {
    if (_underlineArr.count > 0) {
        for (CAShapeLayer *obj in _underlineArr) {
            [obj removeFromSuperlayer];
        }
        [_underlineArr removeAllObjects];
    }
    for (NSInteger i = _textField.text.length; i < lineNum; i ++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        line.fillColor = linecolor.CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(kSpace * (2 *i + 1) + i * kLineWidth, self.frame.size.height - _LineBottomHeight, kLineWidth, kLineHeight)];
        line.path = path.CGPath;
        line.hidden = NO;
        [self.layer addSublayer:line];
        [self.underlineArr addObject:line];
    }
}

//添加分割线
- (void)addSpaceLine {
    for (NSInteger i = 0; i < lineNum - 1; i ++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        line.fillColor = linecolor.CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(self.frame.size.width/lineNum * (i + 1), 1, .5, self.frame.size.height - 1)];
        line.path = path.CGPath;
        line.hidden = NO;
        [self.layer addSublayer:line];
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)underlineArr{
    if (_underlineArr == nil) {
        _underlineArr = [NSMutableArray array];
    }
    return _underlineArr;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    switch (_codeType) {
        case CodeViewTypeCustom:{//画字
            CGContextRef context = UIGraphicsGetCurrentContext();
            for (NSInteger i = 0; i < textArray.count; i ++) {
                NSString *num = textArray[i];
                CGFloat wordWidth = [num stringSizeWithFont:textFont Size:CGSizeMake(MAXFLOAT, textFont.lineHeight)].width;
                //起点
                CGFloat startX = self.frame.size.width/lineNum * i + (self.frame.size.width/lineNum - wordWidth)/2;
                [num drawInRect:CGRectMake(startX, (self.frame.size.height - textFont.lineHeight - _LineBottomHeight - kLineHeight)/2, wordWidth, textFont.lineHeight + 5) withAttributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:textcolor}];
            }
            CGContextDrawPath(context, kCGPathFill);
        }
            break;
        case CodeViewTypeSecret:{//画圆
            CGContextRef context = UIGraphicsGetCurrentContext();
            for (NSInteger i = 0; i < textArray.count; i ++) {
                //圆点
                CGFloat pointX = self.frame.size.width/lineNum/2 * (2 * i + 1);
                CGFloat pointY = self.frame.size.height/2;
                CGContextSetFillColorWithColor(context, textcolor.CGColor);//填充颜色
                CGContextAddArc(context, pointX, pointY, _Radius, 0, 2*M_PI, 0);//添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充
            }
            CGContextDrawPath(context, kCGPathFill);//绘制路径加填充
        }
            break;
        default:
            break;
    }
}

@end

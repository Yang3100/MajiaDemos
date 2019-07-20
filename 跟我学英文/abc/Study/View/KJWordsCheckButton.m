//
//  KJWordsCheckButton.m
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/3.
//  Copyright © 2018 杨科军. All rights reserved.
//


#import "KJWordsCheckButton.h"
#import "KJCodeView.h"

//color
#define kBlueColor     [UIColor colorWithRed:96/255.0 green:189/255.0 blue:250/255.0 alpha:1.0]
#define kGreenColor    [UIColor colorWithRed:122/255.0 green:205/255.0 blue:137/255.0 alpha:1.0]
#define kRedColor      [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]

@interface KJWordsCheckButton(){
    CGFloat height;
}

@property(nonatomic,strong)UIImageView *kj_ImageView;
@property(nonatomic,strong)KJCodeView *kj_CodeView;

@end

@implementation KJWordsCheckButton


-(void)awakeFromNib{
    [super awakeFromNib];
    
    height = CGRectGetHeight(self.frame);
    
    [self addSubview:self.kj_ImageView];
    [self addSubview:self.kj_CodeView];
}

-(void)setAnswer:(NSString *)answer{
    _answer = answer;
    NSArray *words = [_answer words];
    if (_answer.length > 0) {
        [_kj_CodeView setWithNum:words.count];
        _kj_CodeView.center = CGPointMake(kScreenWidth * 0.5 - _kj_ImageView.frame.origin.x, height * 0.5);
        _content = @"";
        _kj_CodeView.content = _content;
        __block KJWordsCheckButton *weakSelf = self;
        _kj_CodeView.EndEditBlcok = ^(NSString *text){
            if (weakSelf.endEditBlock) {
                weakSelf.endEditBlock(text);
            }
        };
    }
}

-(void)setContent:(NSString *)content{
    _content = content;
    if (_content != nil) {
        _kj_CodeView.content = _content;
    }
}

-(void)setBtnType:(KJBtnType)btnType{
    self.layer.borderWidth = 1.0;
    switch (btnType) {
        case KJBtnTypeNomal:{
            [self setTitle:@"" forState:UIControlStateNormal];
            self.answer  = @"";
            self.content = @"";
            [self setBackgroundColor:[UIColor clearColor]];
            self.layer.borderColor = kBlueColor.CGColor;
            [self setTintColor:kBlueColor];
            self.enabled = YES;
            [_kj_CodeView setHidden:NO];
        }
            break;
        case KJBtnTypeRight:{
            [self setBackgroundColor:kGreenColor];
            self.layer.borderColor = kGreenColor.CGColor;
            [_kj_ImageView setImage:[UIImage imageNamed:@"ia09_right"]];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.enabled = NO;
            [_kj_CodeView setHidden:YES];
        }
            break;
        case KJBtnTypeEorror:{
            [self setBackgroundColor:kRedColor];
            self.layer.borderColor = kRedColor.CGColor;
            [_kj_ImageView setImage:[UIImage imageNamed:@"ia09_wrong"]];
            [self setTintColor:[UIColor whiteColor]];
            self.enabled = NO;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_kj_CodeView setHidden:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - lazzing
- (UIImageView*)kj_ImageView{
    if (!_kj_ImageView) {
        _kj_ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, height * 0.25, height * 0.5, height * 0.5)];
    }
    return _kj_ImageView;
}

- (KJCodeView*)kj_CodeView{
    if (!_kj_CodeView) {
        _kj_CodeView = [[KJCodeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.5, height * 0.5) LineColor:kBlueColor TextFont:height];
        _kj_CodeView.codeType = CodeViewTypeCustom;
        _kj_CodeView.userInteractionEnabled = NO;
    }
    return _kj_CodeView;
}

@end

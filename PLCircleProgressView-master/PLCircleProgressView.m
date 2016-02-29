//
//  PLCircleProgressView.m
//  iOS-Core-Animation-Advanced-Techniques
//
//  Created by LINEWIN on 15/12/17.
//  Copyright © 2015年 gykj. All rights reserved.
//

#import "PLCircleProgressView.h"


#define KCircleProgressTintColor   [UIColor colorWithRed:0 green:122/255.0 blue:255.0 alpha:1.0]
#define KCircleProgressTrackColor  [[UIColor lightGrayColor]colorWithAlphaComponent:0.5]



@interface PLCircleProgressView ()

@property(nonatomic,strong)CAShapeLayer * backgroundLayer;
@property(nonatomic,strong)CALayer * foregroundLayer;
@property(nonatomic,strong)CAShapeLayer * pathLayer;
@property(nonatomic,strong)CAGradientLayer * gradientLayer;
@end

@implementation PLCircleProgressView

-(id)init{
    if(self=[super init]){
        [self commonInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super initWithCoder:aDecoder]){
        [self commonInit];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self commonInit];
    }
    return self;
}


-(void)commonInit{
    
   
    [self.layer addSublayer:self.backgroundLayer];
    [self.layer addSublayer:self.foregroundLayer];
    
    self.progressViewStyle=PLProgressViewStyleDefualt;
    self.progressTintColor=KCircleProgressTintColor;
    self.trackTintColor=KCircleProgressTrackColor;
    self.progress=0.0;
    self.lineWidth=5.0;

}

-(CAShapeLayer *)backgroundLayer{
    if(!_backgroundLayer){
        _backgroundLayer=[CAShapeLayer layer];
        [_backgroundLayer setFillColor:[UIColor clearColor].CGColor];
        [_backgroundLayer setLineCap:kCALineCapRound];
    }
    return _backgroundLayer;
}

-(CALayer *)foregroundLayer{
    if(!_foregroundLayer){
        _foregroundLayer=[CALayer layer];
        _foregroundLayer.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _foregroundLayer.mask=self.pathLayer;
 
    }
    return _foregroundLayer;
}

-(CAShapeLayer *)pathLayer{
   
    if(!_pathLayer){
        _pathLayer=[CAShapeLayer layer];
        [_pathLayer setFillColor:[UIColor clearColor].CGColor];
        [_pathLayer setStrokeColor:[UIColor blackColor].CGColor];
        [_pathLayer setLineCap:kCALineCapRound];
    }
    return _pathLayer;
}

-(CAGradientLayer *)gradientLayer{
    if(!_gradientLayer){
        _gradientLayer=[CAGradientLayer layer];
        _gradientLayer.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
    return _gradientLayer;

}

-(NSArray *)gradientColorsWithColor:(UIColor *)color withProgress:(CGFloat)progress{
    
    NSMutableArray * array=@[].mutableCopy;
    [array addObject:(__bridge id)[color colorWithAlphaComponent:0.0].CGColor];
    [array addObject:(__bridge id)[color colorWithAlphaComponent:progress].CGColor];
    return array;
}

-(void)setProgressTintColor:(UIColor *)progressTintColor{
    if(_progressTintColor !=progressTintColor){
        _progressTintColor=progressTintColor;

        [self configUIWithStyle:self.progressViewStyle];
 
    }
}

-(void)setTrackTintColor:(UIColor *)trackTintColor{
    if(_trackTintColor !=trackTintColor){
        _trackTintColor=trackTintColor;
        self.backgroundLayer.strokeColor=_trackTintColor.CGColor;
    }
}

-(void)setLineWidth:(float)lineWidth{
    if(_lineWidth != lineWidth){
        _lineWidth =lineWidth;

        self.backgroundLayer.lineWidth=_lineWidth;
        [self.backgroundLayer setPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(_lineWidth, _lineWidth, CGRectGetWidth(self.frame)-2*_lineWidth, CGRectGetHeight(self.frame)-2*_lineWidth) cornerRadius:CGRectGetWidth(self.frame)/2.0].CGPath ];
        self.pathLayer.lineWidth=_lineWidth;
        [self updateProgressView];
    }
}

-(void)setProgress:(float)progress{
    if(_progress!=progress){
        _progress =progress;
        
        [self configUIWithStyle:self.progressViewStyle];
        [self updateProgressView];
    }
}

-(void)setProgress:(float)progress animated:(BOOL)animated{
    if(animated){
        
            if(progress != self.progress){
                if(progress > self.progress){
                     self.progress += 0.02;
                }
                if(progress < self.progress){
                     self.progress -= 0.02;
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self setProgress:progress animated:animated];
                });
               
            }
    
    }
    else{
        self.progress=progress;
    }
}


-(void)setProgressViewStyle:(PLProgressViewStyle)progressViewStyle{
    if(_progressViewStyle !=progressViewStyle){
        _progressViewStyle = progressViewStyle;
        
        [self configUIWithStyle:_progressViewStyle];
        
    }
}

-(void)configUIWithStyle:(PLProgressViewStyle)style{
    
    if(self.progressViewStyle == PLProgressViewStyleGradient){
        [self.foregroundLayer insertSublayer:self.gradientLayer atIndex:0];
        self.gradientLayer.colors=[self gradientColorsWithColor:self.progressTintColor withProgress:self.progress];
        self.foregroundLayer.backgroundColor=[UIColor clearColor].CGColor;
    }
    else{
        self.foregroundLayer.backgroundColor=self.progressTintColor.CGColor;
    }
}

-(void)updateProgressView {
    CGFloat angle = [self getAngleFromProgress:self.progress];
    [self.pathLayer setPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetWidth(self.frame)/2.0) radius:CGRectGetWidth(self.frame)/2.0-self.lineWidth startAngle:-M_PI_2 endAngle:angle clockwise:YES].CGPath ];
}


-(CGFloat)getAngleFromProgress:(CGFloat)progress{
    CGFloat angle = -M_PI_2 + 2*M_PI*progress;
    return angle;
}

@end

//
//  ViewController.m
//  PLCircleProgressView-master
//
//  Created by LINEWIN on 16/2/29.
//  Copyright © 2016年 LINEWIN. All rights reserved.
//

#import "ViewController.h"
#import "PLCircleProgressView.h"
@interface ViewController ()
{
    PLCircleProgressView * _progressView;
    CGFloat _value;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _value =0.0;
    _progressView =[[PLCircleProgressView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _progressView.center =self.view.center;
//    _progressView.progressViewStyle=PLProgressViewStyleGradient;
    _progressView.lineWidth=5.0;
    _progressView.trackTintColor =[UIColor clearColor];
    [self.view addSubview:_progressView];
    

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changeValue];
        
    });
    
}

-(void)changeValue{
    
    _progressView.progress=_value;
    _value+=0.01;
    if(_value < 1){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1/30.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self changeValue];
        });
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

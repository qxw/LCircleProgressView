//
//  PLCircleProgressView.h
//  iOS-Core-Animation-Advanced-Techniques
//
//  Created by LINEWIN on 15/12/17.
//  Copyright © 2015年 gykj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,PLProgressViewStyle){
    PLProgressViewStyleDefualt,
    PLProgressViewStyleGradient
};

@interface PLCircleProgressView : UIView

@property(nonatomic) PLProgressViewStyle progressViewStyle; // default is PLProgressViewStyleDefualt
@property(nonatomic) float progress;                        // 0.0 .. 1.0, default is 0.0. values outside are pinned.
@property(nonatomic) float lineWidth;                       //default is 5.0

@property(nonatomic, strong) UIColor* progressTintColor;
@property(nonatomic, strong) UIColor* trackTintColor;


-(void)setProgress:(float)progress animated:(BOOL)animated;
@end

/* 
    tableView
        cell.collcetionView
                cell
 
 
 
*/
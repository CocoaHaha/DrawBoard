//
//  DrawView.h
//  DrawingBoard
//
//  Created by CocoaSXF on 2018/7/12.
//  Copyright © 2018年 CocoHaHa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property (nonatomic,strong) UIImage *image;

- (void)clear;
- (void)undo;
- (void)erase;
- (void)setLineWidth:(CGFloat)lineWidth;
- (void)setLineColor:(UIColor *)color;


@end

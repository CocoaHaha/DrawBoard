//
//  HandleImageV.h
//  DrawingBoard
//
//  Created by CocoaSXF on 2018/7/12.
//  Copyright © 2018年 CocoHaHa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HandleImageV;
@protocol handleImageVDelegate <NSObject>

-(void)handleImageV:(HandleImageV *)handleImageV newImage:(UIImage *)newImage;

@end
@interface HandleImageV : UIView

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,weak) id<handleImageVDelegate>delegate;
@end

//
//  HandleImageV.m
//  DrawingBoard
//
//  Created by CocoaSXF on 2018/7/12.
//  Copyright © 2018年 CocoHaHa. All rights reserved.
//

#import "HandleImageV.h"
@interface HandleImageV ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImageView *imageV;

@end
@implementation HandleImageV

- (UIImageView *)imageV{
    
    if (_imageV ==nil) {
        _imageV = [[UIImageView alloc]init];
        _imageV.frame =self.bounds;
        _imageV.userInteractionEnabled = YES;
        [self addSubview:_imageV];
        [self addGes];
        
    }
    return _imageV;
}
- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageV.image = image;
}
- (void)addGes{
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.imageV addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self.imageV addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    [self.imageV addGestureRecognizer:rotation];
    
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longP:)];
    longP.delegate = self;
    [self.imageV addGestureRecognizer:longP];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint transP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y);
    [pan setTranslation:CGPointZero inView:pan.view];
    
}
- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    [pinch setScale:1];
}
- (void)rotation:(UIRotationGestureRecognizer *)rotation{
    
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    rotation.rotation = 0;
    
}
- (void)longP:(UILongPressGestureRecognizer *)longP{
    
    if (longP.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.5 animations:^{
            
            longP.view.alpha = 0;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                longP.view.alpha = 1;
            }completion:^(BOOL finished) {
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:ctx];
                
                UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
                
                UIGraphicsEndImageContext();
                
                if ([self.delegate respondsToSelector:@selector(handleImageV:newImage:)]) {
                    [self.delegate handleImageV:self newImage:newImage];
                }
                [self removeFromSuperview];
            }];
            
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end

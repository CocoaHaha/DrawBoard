//
//  DrawView.m
//  DrawingBoard
//
//  Created by CocoaSXF on 2018/7/12.
//  Copyright © 2018年 CocoHaHa. All rights reserved.
//

#import "DrawView.h"
#import "MyBezierPath.h"

@interface DrawView ()

@property (nonatomic,strong) UIBezierPath *path;
@property (nonatomic,strong) NSMutableArray *allPathArray;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,strong) UIColor *color;

@end

@implementation DrawView

- (void)clear{
    
    [self.allPathArray removeAllObjects];
    [self setNeedsDisplay];
    
}
- (void)undo{
    
    [self.allPathArray removeLastObject];
    [self setNeedsDisplay];
}
- (void)erase{
    [self setLineColor:[UIColor whiteColor]];
    
}
- (void)setLineWidth:(CGFloat)lineWidth{
    self.width =lineWidth;
}
- (void)setLineColor:(UIColor *)color{
    
    self.color =color;
    
}

- (void)setImage:(UIImage *)image{
    
    _image = image;
    [self.allPathArray addObject:image];
    [self setNeedsDisplay];
}
- (NSMutableArray*)allPathArray{
    if (_allPathArray ==nil) {
       
        _allPathArray =[NSMutableArray array];
    }
    return _allPathArray;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    self.width = 2;
    self.color = [UIColor blackColor];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint curP = [pan locationInView:self];
    if (pan.state ==UIGestureRecognizerStateBegan) {
        MyBezierPath *path = [MyBezierPath bezierPath];
        self.path = path;
        [path moveToPoint:curP];
        [path setLineWidth:self.width];
        path.color = self.color;
        [self.allPathArray addObject:path];
    }else if (pan.state ==UIGestureRecognizerStateChanged){
        
        [self.path addLineToPoint:curP];
        //重绘
        [self setNeedsDisplay];
    }
    
}
- (void)drawRect:(CGRect)rect {
    
    for (MyBezierPath *path in self.allPathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image  = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            [path.color set];
            [path stroke];
        }
    }
}

@end

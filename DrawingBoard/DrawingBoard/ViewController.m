//
//  ViewController.m
//  DrawingBoard
//
//  Created by CocoaSXF on 2018/7/12.
//  Copyright © 2018年 CocoHaHa. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "HandleImageV.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,handleImageVDelegate>
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
- (IBAction)erase:(id)sender {
    [self.drawView erase];
}
- (IBAction)setLineWidth:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value];
}
- (IBAction)setLineColor:(UIButton *)sender {
    [self.drawView setLineColor:sender.backgroundColor];
}
- (IBAction)photo:(id)sender {
    
    UIImagePickerController * pickerVC = [[UIImagePickerController alloc]init];
    pickerVC.sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}
- (IBAction)save:(id)sender {
    
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"保存成功");
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"保存成功,请在相册查看" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image  =info[UIImagePickerControllerOriginalImage];
    HandleImageV *handleV = [[HandleImageV alloc]initWithFrame:self.drawView.frame];
    handleV.backgroundColor = [UIColor clearColor];
    handleV.image = image;
    handleV.delegate = self;
    [self.view addSubview:handleV];
    
//    NSData *data = UIImagePNGRepresentation(image);
//    [data writeToFile:@"/Users/SXF/Desktop/photo.png" atomically:YES];
//
//    NSData *data1 =UIImageJPEGRepresentation(image, 1);
//    [data1 writeToFile:@"/Users/SXF/Desktop/photo.jpg" atomically:YES];

    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)handleImageV:(HandleImageV *)handleImageV newImage:(UIImage *)newImage{
    
    self.drawView.image = newImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(BOOL)prefersStatusBarHidden{
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

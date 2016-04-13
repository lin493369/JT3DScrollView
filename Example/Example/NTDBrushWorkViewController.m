//
//  NTDBrushWorkViewController.m
//  Example
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 Jonathan Tribouharet. All rights reserved.
//

#import "NTDBrushWorkViewController.h"
#define BOTTOMVIEW_HEIGHT CGRectGetHeight(_BottomView.frame)
#define BottomViewBottomLayoutConstraintConstant _bottomViewBottomLayoutConstraint.constant
@interface NTDBrushWorkViewController ()
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *recognizer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomLayoutConstraint;

@end

@implementation NTDBrushWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    _bottomViewBottomLayoutConstraint.constant = - CGRectGetHeight(_BottomView.frame)+30;
    NSLog(@"%f",BOTTOMVIEW_HEIGHT);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dragView:(id)sender {
    CGPoint translatedPoint = [_recognizer translationInView:self.view];
//    NSLog(@"y : %f",translatedPoint.y);
    CGFloat translatedPointY = translatedPoint.y > 0 ? translatedPoint.y : -translatedPoint.y;
    UIGestureRecognizerState state = [_recognizer state];
    if (translatedPoint.y < 0) {
        if (BottomViewBottomLayoutConstraintConstant == 0) {
            return;
        }
        _bottomViewBottomLayoutConstraint.constant  = - (BOTTOMVIEW_HEIGHT - translatedPointY);//向上滑动

    }else
        _bottomViewBottomLayoutConstraint.constant  =  - translatedPointY;//向下滑动
    
    
    if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        if ((-BottomViewBottomLayoutConstraintConstant < BOTTOMVIEW_HEIGHT/2 && translatedPoint.y<0)|| BottomViewBottomLayoutConstraintConstant > 0) {
            _bottomViewBottomLayoutConstraint.constant = 0;
            [_recognizer.view layoutIfNeeded];
            return;
        }else
            _bottomViewBottomLayoutConstraint.constant = - CGRectGetHeight(_BottomView.frame)+30;
    }
  
    [_recognizer.view layoutIfNeeded];

//    CGFloat x = _recognizer.view.center.x + translatedPoint.x;
//    CGFloat y = _recognizer.view.center.y + translatedPoint.y;
//    _recognizer.view.center = CGPointMake(x, y);
//    [_recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

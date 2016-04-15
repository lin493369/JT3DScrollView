//
//  NTDBrushWorkViewController.m
//  Example
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 Jonathan Tribouharet. All rights reserved.
//

#import "NTDBrushWorkViewController.h"
#define BOTTOMVIEW_HEIGHT CGRectGetHeight(_BottomView.frame)
#define BOTTOMVIEW_TOP 0
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
    _bottomViewBottomLayoutConstraint.constant = - CGRectGetHeight(_BottomView.frame)+BOTTOMVIEW_TOP;
    NSLog(@"%f",BOTTOMVIEW_HEIGHT);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dragView:(id)sender {
    CGPoint translatedPoint = [_recognizer translationInView:self.view];
    NSLog(@"y : %f",translatedPoint.y);
    UIGestureRecognizerState state = [_recognizer state];
    if (fabs(translatedPoint.y)>20) {//设置滑动手势 上拉和下拉
        if (translatedPoint.y > 0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomViewBottomLayoutConstraint.constant = - CGRectGetHeight(_BottomView.frame)+BOTTOMVIEW_TOP;
                [self.view layoutIfNeeded];
            }];
            return;
        }else{
            [UIView animateWithDuration:.5 animations:^{
                self.bottomViewBottomLayoutConstraint.constant = 0;
                [self.view layoutIfNeeded];
            }];
            [_recognizer.view layoutIfNeeded];
            return;
        }
    }
    if (BottomViewBottomLayoutConstraintConstant < 0 || translatedPoint.y > 0 ) {
        _bottomViewBottomLayoutConstraint.constant  = BottomViewBottomLayoutConstraintConstant - translatedPoint.y;
        [_recognizer.view layoutIfNeeded];
    }
    
    if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        [self updateBottomView];
    }
  

//    CGFloat x = _recognizer.view.center.x + translatedPoint.x;
//    CGFloat y = _recognizer.view.center.y + translatedPoint.y;
//    _recognizer.view.center = CGPointMake(x, y);
    [_recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}
-(void)updateBottomView{
    if (-BottomViewBottomLayoutConstraintConstant < BOTTOMVIEW_HEIGHT/2 ) {
        [UIView animateWithDuration:.5 animations:^{
            self.bottomViewBottomLayoutConstraint.constant = 0;
            [self.view layoutIfNeeded];
        }];
        [_recognizer.view layoutIfNeeded];
    }else
    {
        [UIView animateWithDuration:.5 animations:^{
            self.bottomViewBottomLayoutConstraint.constant = - CGRectGetHeight(_BottomView.frame)+BOTTOMVIEW_TOP;
            [self.view layoutIfNeeded];
        }];
    }
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

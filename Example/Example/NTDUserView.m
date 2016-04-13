//
//  NTDUserView.m
//  Example
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 Jonathan Tribouharet. All rights reserved.
//

#import "NTDUserView.h"

@implementation NTDUserView

-(void)awakeFromNib{
    _headImageView.layer.masksToBounds = YES;//隐藏边界
    _headImageView.layer.cornerRadius = 5.;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _cancleBindBtn.layer.cornerRadius = 5.;
}
-(void)changeToEditorMode{
    _deleteBtn.hidden = NO;
    _cancleBindBtn.hidden = NO;
}
-(void)removeEditorMode{
    _deleteBtn.hidden = YES;
    _cancleBindBtn.hidden = YES;
}

- (IBAction)deleteUserView:(id)sender {
    _deleteUserCallback();
}
- (IBAction)cancleBindBrush:(id)sender {
}

@end

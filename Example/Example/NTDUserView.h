//
//  NTDUserView.h
//  Example
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 Jonathan Tribouharet. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DeleteUserCallback)(void);
@interface NTDUserView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coreLabel;
@property (nonatomic,copy)DeleteUserCallback deleteUserCallback;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBindBtn;

-(void)changeToEditorMode;
-(void)removeEditorMode;

@end

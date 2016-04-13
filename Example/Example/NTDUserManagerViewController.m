//
//  ViewController.m
//  Example
//
//  Created by Jonathan Tribouharet
//

#import "NTDUserManagerViewController.h"
#import "NTDUserView.h"
#define SCROLLVIEW_COUNT self.scrollView.subviews.count
@interface NTDUserManagerViewController ()

@end

@implementation NTDUserManagerViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.scrollView.effect = JT3DScrollViewEffectCarousel;
    
    self.scrollView.delegate = self; // Use only for animate nextButton and previousButton
    [self initScrollViewWithNumberOfUser:5];
    
}
-(void)initScrollViewWithNumberOfUser:(NSUInteger)numberOfUsr{
    for (NTDUserView *view in self.scrollView.subviews) {
        [UIView animateWithDuration:1. animations:^{
            [view removeFromSuperview];
        }];
    }
    for (int i = 0; i<numberOfUsr; i++) {
        [self createCardWithColor];
    }
}
- (void)createCardWithColor
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
    CGFloat x = SCROLLVIEW_COUNT * width;
    
    NTDUserView *view = [[[NSBundle mainBundle]loadNibNamed:@"NTDUserView" owner:self options:nil]firstObject];
    view.headImageView.image = [UIImage imageNamed:@"head.jpg"];
    view.frame = CGRectMake(x, 0, width, height);
//    view.backgroundColor = [UIColor colorWithRed:33/255. green:158/255. blue:238/255. alpha:.5];
    
    view.layer.cornerRadius = 8.;
    
    [self.scrollView addSubview:view];
    view.tag = SCROLLVIEW_COUNT;
    __weak NTDUserManagerViewController *weakSelf = self;
    view.deleteUserCallback = ^{
        [weakSelf initScrollViewWithNumberOfUser:4];
    };
    _pageControlView.numberOfPages = SCROLLVIEW_COUNT;
    self.scrollView.contentSize = CGSizeMake(x + width, height);
}

#pragma mark - SegmentControl

- (IBAction)didChangeMode:(UISegmentedControl *)sender
{
    JT3DScrollViewEffect effect;
    switch (sender.selectedSegmentIndex) {
        case 0:
            effect = JT3DScrollViewEffectCards;
            break;
        case 1:
            effect = JT3DScrollViewEffectCarousel;
            break;
        case 2:
            effect = JT3DScrollViewEffectDepth;
            break;
        case 3:
            effect = JT3DScrollViewEffectTranslation;
            break;
            
        default:
            break;
    }
    
    self.scrollView.effect = effect;
}

#pragma mark - Next / Previous buttons

- (IBAction)loadNextPage:(id)sender
{
    [self.scrollView loadNextPage:YES];
}

- (IBAction)loadPreviousPage:(id)sender
{
    [self.scrollView loadPreviousPage:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateButtons];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateButtons];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeEditorMode];
}
- (void)updateButtons
{

    _pageControlView.currentPage = self.scrollView.currentPage;
    if(self.scrollView.currentPage >= self.scrollView.subviews.count - 1){
        [self showPreviousButton];
    }
    else{
        [self showNextButton];
    }
}

- (void)showNextButton
{
    [UIView animateWithDuration:.3
                     animations:^{
                         //                         self.leftNextButtonConstraint.constant = 40;
                         [self.view layoutIfNeeded];
                     }];
}

- (void)showPreviousButton
{
    [UIView animateWithDuration:.3
                     animations:^{
                         //                         self.leftNextButtonConstraint.constant = - CGRectGetWidth(self.view.frame);
                         [self.view layoutIfNeeded];
                     }];
}
- (IBAction)popViewAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)editorAction:(id)sender {
    for (NTDUserView *view in self.scrollView.subviews) {
        if (self.scrollView.currentPage == view.tag-1) {
            view.headImageView.alpha = 0.5;
            [view changeToEditorMode];
        }
    }
}
-(void)removeEditorMode{
    for (NTDUserView *view in self.scrollView.subviews) {
        if (self.scrollView.currentPage == view.tag-1) {
            [view removeEditorMode];
            view.headImageView.alpha = 1.;
        }
    }
}

@end

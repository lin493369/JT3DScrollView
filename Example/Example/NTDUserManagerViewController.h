//
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import <JT3DScrollView.h>

@interface NTDUserManagerViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet JT3DScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlView;


@end


//
//  showViewController.h
//  hikkake
//
//  Created by Genki Ishibashi on 12/08/03.
//  Copyright (c) 2012年 Genki Ishibashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "imobileAds/IMAdView.h"

@interface showViewController : UIViewController
{
    NSString *arQuestion,*arAnswer;
}
@property (nonatomic,retain)NSString *strBody;
@property (retain, nonatomic) IBOutlet UIButton *moveBtn;

@property (retain, nonatomic) IBOutlet UITextView *txvViewBody;
@property (retain, nonatomic) IBOutlet UITextView *txViewAnswer;
- (IBAction)hikkakatta:(UIButton *)sender;
- (IBAction)showAnswer:(UIButton *)sender;
@end

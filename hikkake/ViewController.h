//
//  ViewController.h
//  hikkake
//
//  Created by Genki Ishibashi on 12/08/03.
//  Copyright (c) 2012年 Genki Ishibashi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Twitter/Twitter.h>

#import "TableViewController.h"

@interface ViewController : UIViewController<UIActionSheetDelegate>


@property (retain, nonatomic) IBOutlet UILabel *lblTop3;
@property (retain, nonatomic) IBOutlet UILabel *lblTop2;
@property (retain, nonatomic) IBOutlet UILabel *lblTop1;
@property (retain, nonatomic) IBOutlet UILabel *lblTopNum;
@property (retain, nonatomic) IBOutlet UIButton *btnShare;

- (IBAction)showQuestion:(id)sender;
- (IBAction)btnShare:(id)sender;
@end

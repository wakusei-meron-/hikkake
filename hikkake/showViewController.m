//
//  showViewController.m
//  hikkake
//
//  Created by Genki Ishibashi on 12/08/03.
//  Copyright (c) 2012年 Genki Ishibashi. All rights reserved.
//

#import "showViewController.h"

@interface showViewController ()

@end

@implementation showViewController
@synthesize moveBtn;
@synthesize txViewAnswer;
@synthesize txvViewBody, strBody = _strBody ;

#define publisherID 8438
#define mediaID 30621
#define spotID 56867

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    moveBtn.frame = CGRectMake(20, 232, 280, 130);
    
    //広告
    IMobileAdView *adView = [[IMobileAdView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, 320, 50) publisherId:publisherID mediaId:mediaID spotId:spotID testMode:NO];
//    adView.backgroundColor = [UIColor blackColor];
//    adView.alpha = 0.5;
    [self.view addSubview:adView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStyleBordered target:self action:@selector(backView)];
    
}

- (void)backView
{
        [[self.navigationController.viewControllers objectAtIndex:0] navigationItem].title = @"選択して下さい";
    [self.navigationController popViewControllerAnimated:YES];
}
                                             

- (void)viewWillAppear:(BOOL)animated
{
    NSArray *ar = [_strBody componentsSeparatedByString:@"=>"];
    _strBody = [NSString stringWithString:[ar objectAtIndex:0]];
    txvViewBody.text = _strBody;
    txvViewBody.editable = NO;
    txViewAnswer.text = [NSString stringWithString:[ar objectAtIndex:1]];
    txViewAnswer.layer.cornerRadius = 10;
    txViewAnswer.layer.shadowOffset = CGSizeMake(10, 10);
    txViewAnswer.editable = NO;
}

- (void)viewDidUnload
{
    [self setTxvViewBody:nil];
    [self setTxViewAnswer:nil];
    [self setMoveBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (void)dealloc {
    [txvViewBody release];
    [txViewAnswer release];
    [moveBtn release];
    [super dealloc];
}
- (IBAction)hikkakatta:(UIButton *)sender {
    
    BOOL tag;
    if (sender.tag == 0) {
        NSLog(@"ひっかかった");
        NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
        int i = [uf integerForKey:@"key_num"];
        i++;
        NSLog(@"%d",i);
        [uf setInteger:i forKey:@"key_num"];
        tag = YES;
    }else if (sender.tag == 1){
        NSLog(@"ひっかからなーい");
        tag = NO;
    }
    
    [[self.navigationController.viewControllers objectAtIndex:0] navigationItem].title = [self setNavigationItemTitle:tag];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)setNavigationItemTitle:(BOOL)tag
{
    NSString *strTitle;
    int i = arc4random()%10;
    switch (tag) {
        case YES:
            switch (i) {
                case 0:
                    strTitle = @"ひっかかったなー！w";
                    break;
                    
                case 1:
                    strTitle = @"よし！ひっかかった！";
                    break;
                    
                case 2:
                    strTitle =@"おひかかりになりましたね";
                    break;
                    
                case 3:
                    strTitle =@"ひっかかったネ！";
                    break;
                    
                case 4:
                    strTitle = @"やーい！ひっかかったー！";
                    break;
                    
                case 5:
                    strTitle = @"ハハッ！ひっかかった！";
                    break;
                    
                case 6:
                    strTitle = @"HikkakattaNa!";
                    break;
                    
                case 7:
                    strTitle = @"ひっかかったアルね";
                    break;
                    
                case 8:
                    strTitle = @"ひっかかったYO!";
                    break;
                    
                case 9:
                    strTitle = @"ひっかかったわね！！";
                    
                default:
                    break;
            }

            break;
            
        default:
            
            switch (i) {
                case 0:
                    strTitle = @"ひっかからない…だと！？";
                    break;
                    
                case 1:
                    strTitle = @"まぁ…簡単だったな";
                    break;
                
                case 2:
                    strTitle =@"なんでひっかからないのよ";
                    break;
                    
                case 3:
                    strTitle =@"ひっかかってよ。。。";
                    break;
                    
                case 4:
                    strTitle = @"ひっかからないのか。残念";
                    break;
                    
                case 5:
                    strTitle = @"ハハハ…残念だよ";
                    break;
                    
                case 6:
                    strTitle = @"Hikkakarana-i!";
                    break;
                    
                case 7:
                    strTitle = @"ひっかからないアルか";
                    break;
                    
                case 8:
                    strTitle = @"ひっかかってなーい！";
                    break;
                    
                case 9:
                    strTitle = @"ひっかかりなさいよ！";
                    
                    
                default:
                    break;
            }
            NSLog(@"i is %d",i);
            break;
    }
    return strTitle;
}

- (IBAction)showAnswer:(UIButton *)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    sender.center = CGPointMake(sender.center.x * 3, sender.center.y);
    [UIView commitAnimations];
}
@end

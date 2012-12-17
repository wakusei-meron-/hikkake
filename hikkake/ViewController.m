//
//  ViewController.m
//  hikkake
//
//  Created by Genki Ishibashi on 12/08/03.
//  Copyright (c) 2012年 Genki Ishibashi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize lblTop3;
@synthesize lblTop2;
@synthesize lblTop1;
@synthesize lblTopNum;
@synthesize btnShare;

#define publisherID 8438
#define mediaID 30621
#define spotID 56860


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor clearColor];
    
    // NSUserDefaultsに初期値を登録する
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:@"0" forKey:@"key_num"];  // をKEY_Iというキーの初期値は99
    [ud registerDefaults:defaults];
    
    //初期値
    if ([ud integerForKey:@"key_num"] == 0) {
        lblTop1.hidden = YES;
        lblTop2.hidden = YES;
        lblTop3.hidden = YES;
        lblTopNum.hidden = YES;
        btnShare.hidden = YES;
    }else{
        lblTop1.hidden = NO;
        lblTop2.hidden = NO;
        lblTop3.hidden = NO;
        lblTopNum.hidden = NO;
        btnShare.hidden = YES;
        lblTopNum.text = [ud stringForKey:@"key_num"];
    }
    
    //広告
    IMobileAdView *adView = [[IMobileAdView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, 320, 50) publisherId:publisherID mediaId:mediaID spotId:spotID testMode:NO];
    //    adView.backgroundColor = [UIColor blackColor];
    //    adView.alpha = 0.5;
    [self.view addSubview:adView];
    
}

- (void)viewDidUnload
{
    [self setLblTop1:nil];
    [self setLblTopNum:nil];
    [self setLblTop2:nil];
    [self setLblTop3:nil];
//    [self setBtnShare:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    // NSUserDefaultsに初期値を登録する
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    //初期値
    if ([ud integerForKey:@"key_num"] == 0) {
        lblTop1.hidden = YES;
        lblTop2.hidden = YES;
        lblTop3.hidden = YES;
        lblTopNum.hidden = YES;
        btnShare.hidden = YES;
    }else{
        lblTop1.hidden = NO;
        lblTop2.hidden = NO;
        lblTop3.hidden = NO;
        lblTopNum.hidden = NO;
        btnShare.hidden = YES;
        lblTopNum.text = [ud stringForKey:@"key_num"];
    }
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

- (IBAction)showQuestion:(id)sender {
    

    TableViewController *tvc = [[TableViewController alloc]initWithStyle:UITableViewStylePlain];

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tvc];
    nav.navigationBarHidden = NO;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStyleBordered target:self action:nil];
    nav.navigationItem.leftBarButtonItem = leftButton;

    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:nav animated:YES];
}

- (IBAction)btnShare:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"ひっかかったのでつぶやく", @"ひっかかったのでレビューを書く", nil];
    [as showInView:self.view];
}

#pragma  mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(nil);
            TWTweetComposeViewController *tvc = [[TWTweetComposeViewController alloc] init];
            int i = [[NSUserDefaults standardUserDefaults] integerForKey:@"key_num"];
            NSString *strBody = [NSString stringWithFormat:@"このアプリで%d回っかかりました。", i];
            NSURL *url = [NSURL URLWithString:@"http:~"];
            [tvc addURL:url];
            
            //スクリーンショット
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGSize size = { 480, 320 };
            UIGraphicsBeginImageContextWithOptions(size, NO, 0);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            [[UIColor blackColor] set];
            CGContextFillRect(ctx, screenRect);
            // 保存するビューを指定
            [self.view.layer renderInContext:ctx];
            // 指定したビューをPNGで取得
            NSData *pngData = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext());
            UIImage *screenImage = [UIImage imageWithData:pngData];
            [tvc addImage:screenImage];

            [tvc setInitialText:strBody];
            [self presentModalViewController:tvc animated:YES];
            break;
            
        default:
            break;
    }
    
}

- (void)dealloc {
    [lblTop1 release];
    [lblTopNum release];
    [lblTop2 release];
    [lblTop3 release];
    [btnShare release];
    [super dealloc];
}
@end

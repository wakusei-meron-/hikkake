//
//  TableViewController.m
//  hikkake
//
//  Created by Genki Ishibashi on 12/08/03.
//  Copyright (c) 2012年 Genki Ishibashi. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

#define publisherID 8438
#define mediaID 30621
#define spotID 56866

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStyleBordered target:self action:@selector(backView)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //広告
    IMobileAdView *adView = [[IMobileAdView alloc] initWithFrame:CGRectMake(0, self.navigationController.view.bounds.size.height - 50, 320, 50) publisherId:publisherID mediaId:mediaID spotId:spotID testMode:NO];
    //    adView.backgroundColor = [UIColor blackColor];
    //    adView.alpha = 0.5;
    [self.navigationController.view addSubview:adView];
    
    self.navigationItem.title = @"選択して下さい";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [[self readText] count] + 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 36) {
        return 50;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (indexPath.row <= 35) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSMutableString *strTitle = [NSMutableString stringWithFormat:@" ",indexPath.row+1];
        [strTitle appendString:[[self readText] objectAtIndex:indexPath.row]];//[arAll objectAtIndex:indexPath.row]];
        cell.textLabel.text = strTitle;
    }else{
        UIView *altView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] autorelease];
        altView.backgroundColor = [UIColor whiteColor];
        [cell addSubview:altView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row%2 == 1) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
    

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    showViewController *svc = [[showViewController alloc] initWithNibName:@"showViewController" bundle:nil];
    svc.strBody = [[self readText] objectAtIndex:indexPath.row];
//    NSLog(@"%@", svc.strBody);
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark 自作関数
- (NSArray *)readText
{
    //テキストのパス指定
    NSString *textFilePath = [[NSBundle mainBundle] pathForResource:@"question" ofType:@"txt"];
    
    //準備
    NSString *fileData;
    NSError *is_error;
    
    fileData = [NSString stringWithContentsOfFile:textFilePath encoding:NSUTF8StringEncoding error:&is_error];
    
    arAll = [fileData componentsSeparatedByString:@",\n"];
    
    
    return arAll;
}

- (void)backView{
    
    [self dismissModalViewControllerAnimated:YES];
}

@end

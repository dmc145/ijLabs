//
//  SecondViewController.m
//  secondone
//
//  Created by Daniel Muñoz on 06/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize _UITableviewExample;

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
    _UITableviewExample = [[NSArray alloc] initWithObjects:@"Iphone Developer",@"Android Developer",@"BlackBerry Developer", nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"[_appEventsArray count] = %d  -- pageNumber = %d", [_appEventsArray count] , _pageNumber);
    return [_UITableviewExample count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"section = %d -- row = %d", indexPath.section, indexPath.row);
    
    cell.textLabel.text = [_UITableviewExample objectAtIndex:indexPath.row];
    
    return cell;
}


@end

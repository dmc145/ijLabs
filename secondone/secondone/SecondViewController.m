//
//  SecondViewController.m
//  secondone
//
//  Created by Daniel Muñoz on 06/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "SecondViewController.h"

#import "CustomCell.h"

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

# pragma - UITableViewDataSource methods
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    
    if (cell == nil) {
        UIViewController *auxVC = [[UIViewController alloc] initWithNibName:@"CustomCell" bundle:nil];
        cell = (CustomCell*)auxVC.view;
        //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [[cell _label] setText: [NSString stringWithFormat:@"%@ %d - %@ %d", NSLocalizedString(@"Sección", nil), indexPath.section, NSLocalizedString(@"Fila", nil), indexPath.row]];
    [[cell _label] setTextColor:[UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:59.0/255.0 alpha:1]];
    /*[[cell _label] setentavo:[UIFont fontWithName:@"Helvetica" size:15]];*/
    [[cell _label] setShadowColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:191.0/255.0 alpha:1]];
    [[cell _label] setShadowOffset:CGSizeMake(0, 2)];
    
    return cell;
}

# pragma - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[self navigationItem] setTitle: NSLocalizedString(@"Atrás", @"")];
    
    SecondViewController *secondViewController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [[self navigationController] pushViewController:secondViewController animated:YES];
}

@end

//
//  ViewController.m
//  secondone
//
//  Created by Daniel Muñoz on 06/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLogin:(id)sender {
    NSLog(@"username = %@", [[self username] text]);
    
    SecondViewController *loginVC = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentModalViewController:navController animated:YES];
    //UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
}
@end

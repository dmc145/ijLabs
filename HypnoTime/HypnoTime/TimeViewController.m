//
//  TimeViewController.m
//  HypnoTime
//
//  Created by Daniel Muñoz on 08/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "TimeViewController.h"

@implementation TimeViewController

/*
 
 A TimeViewController’s screen will show a UILabel and a UIButton that updates that label to the current time.
 Thus, the TimeViewController’s view will be a blank, full-screen UIView that has two subviews – the button and label
 
 When a view controller’s view has subviews, it is best to create and load its view hierarchy in a XIB file instead of overriding loadView
 
 */

- (IBAction)showCurrentTime:(id)sender
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    [timeLabel setText:[formatter stringFromDate:now]];
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    /*
    // Call the superclass's designated initializer
    self = [super initWithNibName:nil
                           bundle:nil];
    */
    
    // Get a pointer to the application bundle object
    NSBundle *appBundle = [NSBundle mainBundle];
    
    self = [super initWithNibName:@"TimeViewController"
                           bundle:appBundle];
    
    /* */
    
    if (self) {
        // Get the tab bar item
        UITabBarItem *tbi = [self tabBarItem];
        
        // Give it a label
        [tbi setTitle:@"Time"];
        
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        [tbi setImage:i];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"TimeViewController loaded its view.");
    
    [[self view] setBackgroundColor:[UIColor greenColor]];
}

/*

 The view controller, then, has ownership of its view, which owns all of its subviews. All of the objects continue to exist as long as you need them to. Therefore, you do not need to implement viewDidUnload to release subviews of a view controller’s view. In TimeViewController.m, you can delete the implementation of this method...
 
- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"Unloading TimeViewController's subviews");
    
    // If you specify that timeLabel is a weak reference, then the view would keep the only strong reference to the UILabel, and when the view was destroyed, the UILabel would be destroyed, and timeLabel would automatically be set to nil.
    // timeLabel = nil;

    NSLog(@"timeLabel = %@", timeLabel);
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"CurrentTimeViewController will appear");
    [super viewWillAppear:animated];
    [self showCurrentTime:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"CurrentTimeViewController will DISappear");
    [super viewWillDisappear:animated];
}

@end

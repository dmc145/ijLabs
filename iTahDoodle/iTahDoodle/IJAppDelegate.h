//
//  IJAppDelegate.h
//  iTahDoodle
//
//  Created by Daniel Muñoz on 16/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>

// Declare a helper function that we will use to get a path
// to the location on disk where we can save the to-do list
NSString *docPath(void);
/*
 Notice that you declare docPath() above the class declaration. That’s because even though docPath() is declared in the file BNRAppDelegate.h, it is not part of the BNRAppDelegate class. In fact, this function could have its own pair of files in the iTahDoodle project. However, because there is just one of these helper functions in iTahDoodle, we’re putting it the app delegate’s class files to keep things simple.
 */

@interface IJAppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>

{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}
- (void)addTask:(id)sender;

@property (strong, nonatomic) UIWindow *window;

@end

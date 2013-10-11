//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Daniel Muñoz on 09/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsViewController : UITableViewController<UITableViewDataSource>

{
    //IBOutlet UIView *headerView;
}

//- (UIView *)headerView;
- (IBAction)addNewItem:(id)sender;
//- (IBAction)toggleEditingMode:(id)sender;

@end

//
//  DateViewController.h
//  Homepwner
//
//  Created by Daniel Muñoz on 10/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DateViewController : UIViewController

{
    __weak IBOutlet UIDatePicker *datePicker;
}

@property (nonatomic, strong) BNRItem *item;

@end

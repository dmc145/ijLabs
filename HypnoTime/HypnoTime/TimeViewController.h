//
//  TimeViewController.h
//  HypnoTime
//
//  Created by Daniel Muñoz on 08/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeViewController : UIViewController

{
    __weak IBOutlet UILabel *timeLabel;
}

- (IBAction)showCurrentTime:(id)sender;

- (void)spinTimeLabel;
- (void)bounceTimeLabel;

@end

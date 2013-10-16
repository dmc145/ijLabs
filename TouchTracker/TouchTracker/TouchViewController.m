//
//  TouchViewController.m
//  TouchTracker
//
//  Created by Daniel Muñoz on 15/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "TouchViewController.h"
#import "TouchDrawView.h"

@implementation TouchViewController

- (void)loadView
{
    [self setView:[[TouchDrawView alloc] initWithFrame:CGRectZero]];
}

@end

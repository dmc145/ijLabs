//
//  DateViewController.m
//  Homepwner
//
//  Created by Daniel Muñoz on 10/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "DateViewController.h"
#import "BNRItem.h"

@implementation DateViewController

@synthesize item;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [datePicker setDate:[item dateCreated]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [item setDateCreated:[datePicker date]];
}

@end

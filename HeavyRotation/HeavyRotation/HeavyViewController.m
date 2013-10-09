//
//  HeavyViewController.m
//  HeavyRotation
//
//  Created by Daniel Muñoz on 08/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "HeavyViewController.h"

@interface HeavyViewController ()

@end

@implementation HeavyViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait) || UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

@end

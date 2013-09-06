//
//  DetailViewController.h
//  firstone
//
//  Created by Daniel Muñoz on 06/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

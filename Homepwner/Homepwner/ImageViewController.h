//
//  ImageViewController.h
//  Homepwner
//
//  Created by Daniel Muñoz on 15/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *imageView;
    
}

@property (nonatomic, strong) UIImage *image;

@end

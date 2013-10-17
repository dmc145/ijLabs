//
//  WebViewController.h
//  Nerdfeed
//
//  Created by Daniel Muñoz on 16/10/13.
//  Copyright (c) 2013 net.infojobs. All rights reserved.
//

#import <Foundation/Foundation.h>

// Must import this file as it is where ListViewControllerDelegate is declared
#import "ListViewController.h"

@interface WebViewController : UIViewController <ListViewControllerDelegate>

@property (nonatomic, readonly) UIWebView *webView;

@end

//
//  ListViewController.h
//  Nerdfeed
//
//  Created by Daniel Muñoz on 16/10/13.
//  Copyright (c) 2013 net.infojobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;
@class WebViewController;

@interface ListViewController : UITableViewController <NSXMLParserDelegate>

{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    RSSChannel *channel;
}

@property (nonatomic, strong) WebViewController *webViewController;

- (void)fetchEntries;

@end

// A new protocol named ListViewControllerDelegate
@protocol ListViewControllerDelegate

// Classes that conform to this protocol must implement this method:
- (void)listViewController:(ListViewController *)lvc handleObject:(id)object;

@end

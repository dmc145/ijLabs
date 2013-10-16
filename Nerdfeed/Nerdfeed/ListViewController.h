//
//  ListViewController.h
//  Nerdfeed
//
//  Created by Daniel Muñoz on 16/10/13.
//  Copyright (c) 2013 net.infojobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;

@interface ListViewController : UITableViewController <NSXMLParserDelegate>

{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    RSSChannel *channel;
}

- (void)fetchEntries;

@end

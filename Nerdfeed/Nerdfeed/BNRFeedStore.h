//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by Daniel Muñoz on 17/10/13.
//  Copyright (c) 2013 net.infojobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RSSChannel, RSSItem;

@interface BNRFeedStore : NSObject

{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

@property (nonatomic, strong) NSDate *topSongsCacheDate;

+ (BNRFeedStore *)sharedStore;
- (RSSChannel *)fetchRSSFeedWithCompletion:(void (^)(RSSChannel *obj, NSError *err))block;
- (void)fetchTopSongs:(int)count
       withCompletion:(void (^)(RSSChannel *obj, NSError *err))block;

- (void)markItemAsRead:(RSSItem *)item;
- (BOOL)hasItemBeenRead:(RSSItem *)item;

@end

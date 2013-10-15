//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Daniel Muñoz on 09/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;


@interface BNRItemStore : NSObject

{
    NSMutableArray *allItems;
}

// Notice that this is a class method and prefixed with a + instead of a -
+ (BNRItemStore *)sharedStore;

- (NSArray *)allItems;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)p;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (NSString *)itemArchivePath;
- (BOOL)saveChanges;



@end

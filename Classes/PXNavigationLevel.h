//
//  PXNavigationLevel.h
//  PXNavigationBar
//
//  Created by Alex Rozanski on 14/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import <Cocoa/Cocoa.h>

@class PXNavigationItem;

@interface PXNavigationLevel : NSObject <NSCopying> {
	NSMutableArray *_items;
	PXNavigationItem *_currentItem;
	
	id _representedObject;
}

@property (readonly) NSArray *items;
@property (readwrite, assign) PXNavigationItem *currentItem;
@property (readwrite) NSInteger currentItemIndex;
@property (assign) id representedObject;

- (id)initWithItems:(NSArray*)itemArray;			//Designated initializer
- (id)initWithItem:(PXNavigationItem*)item;
+ (id)navigationLevelWithItems:(NSArray*)itemArray;	//Convenience initializer

- (void)setCurrentItem:(PXNavigationItem*)item;

@end

//
//  PXNavigationBar.h
//  PXNavigationBar
//
//  Created by Alex Rozanski on 14/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import <Cocoa/Cocoa.h>

#import "PXNavigationLevel.h"
#import "PXNavigationItem.h"

@interface PXNavigationBar : NSView {
	NSMutableArray *_navigationLevels;
	
	id _delegate;
}

@property (retain) NSArray *navigationLevels;
@property (assign) id delegate;

- (void)pushNavigationLevel:(PXNavigationLevel*)level;
- (void)popNavigationLevel;

- (PXNavigationLevel*)currentNavigationLevel;
- (PXNavigationItem*)currentNavigationItem;
- (PXNavigationLevel*)parentLevel;
- (PXNavigationItem*)parentItem;

@end

@protocol PXNavigationBarDelegate

@optional
- (BOOL)navigationBar:(PXNavigationBar*)aNavigationBar shouldPushLevel:(PXNavigationLevel*)aLevel;
- (void)navigationBar:(PXNavigationBar*)aNavigationBar didPushLevel:(PXNavigationLevel*)aLevel;

- (BOOL)navigationBar:(PXNavigationBar*)aNavigationBar shouldPopLevel:(PXNavigationLevel*)aLevel;
- (void)navigationBar:(PXNavigationBar*)aNavigationBar didPopLevel:(PXNavigationLevel*)aLevel;

@end



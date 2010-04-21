//
//  PXNavigationBarAppDelegate.m
//  PXNavigationBar
//
//  Created by Alex Rozanski on 14/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import "AppDelegate.h"

#import "PXNavigationBar.h"

@implementation AppDelegate

- (void)awakeFromNib
{
	PXNavigationItem *item = [PXNavigationItem itemWithTitle:@"Root"];
	PXNavigationLevel *rootLevel = [[PXNavigationLevel alloc] initWithItem:item];
	
	[navigationBar pushNavigationLevel:rootLevel];
}

/* This method is simply to demonstrate pushing a level to the navigation hierarchy
   so that the effects of moving up levels or between items in the current level can be seen */
- (IBAction)pushLevel:(id)sender
{
	
	//Set up the navigation level
	NSArray *itemArray = [NSArray arrayWithObjects:[PXNavigationItem itemWithTitle:@"Item 1"],
						  [PXNavigationItem itemWithTitle:@"Item 2"],
						  [PXNavigationItem itemWithTitle:@"Item 3"],
						  [PXNavigationItem itemWithTitle:@"Item 4"], nil];
	PXNavigationLevel *level = [[PXNavigationLevel alloc] initWithItems:itemArray];
	
	//Set the selected item to a random index
	[level setCurrentItemIndex:random()%4];
	
	[navigationBar pushNavigationLevel:level];
}

@end

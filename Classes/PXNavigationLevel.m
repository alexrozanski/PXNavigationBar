//
//  PXNavigationLevel.m
//  PXNavigationBar
//
//  Created by Alex Rozanski on 14/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import "PXNavigationLevel.h"

@interface PXNavigationLevel ()
- (void)setItems:(NSArray*)newItems;
@end


@implementation PXNavigationLevel

@synthesize items = _items;
@synthesize currentItem = _currentItem;
@synthesize representedObject = _representedObject;

#pragma mark -
#pragma mark Init/Dealloc

- (id)initWithItems:(NSArray*)itemArray
{
	if(self=[super init]) {
		_items = [itemArray mutableCopy];
		_currentItem = [itemArray objectAtIndex:0];
	}
	
	return self;
}

- (id)initWithItem:(PXNavigationItem*)item
{	
	return [self initWithItems:[NSArray arrayWithObject:item]];
}

+ (id)navigationLevelWithItems:(NSArray*)itemArray
{
	return [[[[self class] alloc] initWithItems:nil] autorelease];
}

- (void)dealloc
{
	[_items release], _items = nil;
	_currentItem = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setItems:(NSArray *)newItems
{
	if(newItems!=_items) {
		//-setItems: is only used internally so we don't need to do a -mutableCopy
		_items = [newItems copy];
	}
}

#pragma mark -
#pragma mark Item Handling

- (void)setCurrentItem:(PXNavigationItem*)item
{
	if([_items containsObject:item]) {
		_currentItem = item;
	}
}

- (NSInteger)currentItemIndex
{
	return [_items indexOfObject:_currentItem];
}

- (void)setCurrentItemIndex:(NSInteger)index
{
	if(index>=0&&index<=([_items count]-1)) {
		_currentItem = [_items objectAtIndex:index];
	}
}

#pragma mark -
#pragma mark NSCopying Methods

- (id)copyWithZone:(NSZone *)zone
{
	id newLevel = [[[self class] allocWithZone:zone] initWithItems:nil];
	
	NSArray *newItems = [[self items] copy];
	[newLevel setItems:newItems];
	[newLevel setCurrentItem:[self currentItem]];
	[newItems release];
	
	return newLevel;
}

@end

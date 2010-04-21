//
//  PXNavigationBar.m
//  PXNavigationBar
//
//  Created by Alex Rozanski on 14/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import "PXNavigationBar.h"

#import "PXNavigationLevel.h"
#import "PXNavigationItem.h"

#import "PXNavigationButtonCell.h"
#import "PXBackButtonCell.h"

//View tag constants
#define BACKBUTTON_VIEW_TAG			1
#define LEFT_NAVBUTTON_VIEW_TAG		2
#define RIGHT_NAVBUTTON_VIEW_TAG	3

//Button sizes
#define NAVBUTTON_WIDTH				25
#define SIDE_MARGIN					10
#define BUTTON_HEIGHT				21

//Drawing defines
#define BORDER_COLOR				[NSColor colorWithCalibratedWhite:(167/255.0f) alpha:1]
#define TITLE_FONT					[NSFont boldSystemFontOfSize:14]

#pragma mark -

@interface PXNavigationBar ()

- (NSButton*)navButtonWithDirection:(NSInteger)direction;
- (void)adjustSubviews;
- (void)updateState;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)navButtonPressed:(id)sender;

@end

#pragma mark -

@implementation PXNavigationBar

@synthesize navigationLevels;
@synthesize delegate;

#pragma mark Init/Dealloc

- (id)initWithFrame:(NSRect)frameRect
{
	if(self=[super initWithFrame:frameRect]) {
		_navigationLevels = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)dealloc
{
	[_navigationLevels release], _navigationLevels=nil;
	
	[super dealloc];
}

- (void)awakeFromNib
{	
	if([super respondsToSelector:@selector(awakeFromNib)]) {
		[super awakeFromNib];
	}
	
	//Create the buttons
	NSButton *backButton = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)];
	[backButton setCell:[[[PXBackButtonCell alloc] init] autorelease]];
	[backButton setBezelStyle:NSRoundedBezelStyle];
	[backButton setTag:BACKBUTTON_VIEW_TAG];
	[backButton setTarget:self];
	[backButton setAction:@selector(backButtonPressed:)];
	
	//Create the navigation buttons
	NSButton *leftNavButton = [self navButtonWithDirection:PXNavigationButtonCellNavDirectionLeft];
	NSButton *rightNavButton = [self navButtonWithDirection:PXNavigationButtonCellNavDirectionRight];
	
	//Add the views
	[self addSubview:backButton];
	[self addSubview:leftNavButton];
	[self addSubview:rightNavButton];
	 
	//Adjust everything
	[self updateState];
}

- (NSButton*)navButtonWithDirection:(NSInteger)direction
{
	NSButton *navButton = [[[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)] autorelease];
	PXNavigationButtonCell *cell = [[PXNavigationButtonCell alloc] initTextCell:@""];
	[navButton setCell:cell];
	[cell release];
	[[navButton cell] setNavDirection:direction];
	
	if(direction==PXNavigationButtonCellNavDirectionRight) {
		[navButton setTag:RIGHT_NAVBUTTON_VIEW_TAG];
		[navButton setImage:[NSImage imageNamed:@"NavButtonRightArrow"]];
	}
	else {
		[navButton setTag:LEFT_NAVBUTTON_VIEW_TAG];
		[navButton setImage:[NSImage imageNamed:@"NavButtonLeftArrow"]];
	}
	[navButton setBezelStyle:NSRegularSquareBezelStyle];
	[navButton setTarget:self];
	[navButton setAction:@selector(navButtonPressed:)];
	
	return navButton;
}

#pragma mark -
#pragma mark Sizing

- (void)resizeSubviewsWithOldSize:(NSSize)oldBoundsSize
{
	[super resizeSubviewsWithOldSize:oldBoundsSize];
	[self adjustSubviews];
}

- (void)adjustSubviews
{
	NSRect bounds = [self bounds];
	
	NSButton *backButton = (NSButton*)[self viewWithTag:BACKBUTTON_VIEW_TAG];
	NSButton *leftNavButton = (NSButton*)[self viewWithTag:LEFT_NAVBUTTON_VIEW_TAG];
	NSButton *rightNavButton = (NSButton*)[self viewWithTag:RIGHT_NAVBUTTON_VIEW_TAG];
	
	NSSize minBackButtonSize = [[backButton cell] cellSize];
	
	//Resize the buttons
	[backButton setFrame:NSMakeRect(SIDE_MARGIN, NSMidY(bounds)-(BUTTON_HEIGHT/2), minBackButtonSize.width,
									BUTTON_HEIGHT)];
	[leftNavButton setFrame:NSMakeRect(NSMaxX(bounds)-SIDE_MARGIN-(NAVBUTTON_WIDTH*2),
									   NSMidY(bounds)-(BUTTON_HEIGHT/2),
									   NAVBUTTON_WIDTH,
									   BUTTON_HEIGHT)];
	[rightNavButton setFrame:NSMakeRect(NSMaxX(bounds)-SIDE_MARGIN-NAVBUTTON_WIDTH,
									   NSMidY(bounds)-(BUTTON_HEIGHT/2),
									   NAVBUTTON_WIDTH,
									   BUTTON_HEIGHT)];
										   
}

#pragma mark -
#pragma mark Button Actions

- (IBAction)backButtonPressed:(id)sender
{
	[self popNavigationLevel];
}

- (IBAction)navButtonPressed:(id)sender
{
	PXNavigationLevel *level = [self currentNavigationLevel];
	NSInteger newIndex;
	
	if([sender tag]==LEFT_NAVBUTTON_VIEW_TAG) {
		newIndex = [level currentItemIndex]-1;
	}
	else {
		newIndex = [level currentItemIndex]+1;
	}
	
	[level setCurrentItemIndex:newIndex];
	
	[self updateState];
}

#pragma mark -
#pragma mark Working with the Navigation Stack

- (void)pushNavigationLevel:(PXNavigationLevel*)level
{
	BOOL shouldPush = YES;
	
	//Ask the delegate if we can push
	if([[self delegate] respondsToSelector:@selector(navigationBar:shouldPushLevel:)]) {
		shouldPush = [[self delegate] navigationBar:self shouldPushLevel:level];
	}
	
	if(shouldPush)
	{
		//Ordinarily we wouldn't _want_ to copy the represented object over because a copy of the level should be
		//a new level in itself, if the represented object is being used as an identifier. However we are copying
		//here to force immutability of the passed in level.
		PXNavigationLevel *copiedLevel = [level copy];
		[copiedLevel setRepresentedObject:[level representedObject]];
		
		[_navigationLevels addObject:copiedLevel];
		[self updateState];
		
		//Notify the delegate that we pushed
		if([[self delegate] respondsToSelector:@selector(navigationBar:didPushLevel:)]) {
			[[self delegate] navigationBar:self didPushLevel:level];
		}
	}
}

- (void)popNavigationLevel
{
	BOOL shouldPop = YES;
	PXNavigationLevel *lastLevel = [_navigationLevels lastObject];
	
	//Make sure this is not the root level
	if([_navigationLevels count]==1) {
		return;
	}
	
	//Ask the delegate if we can pop
	if([[self delegate] respondsToSelector:@selector(navigationBar:shouldPopLevel:)]) {
		shouldPop = [[self delegate] navigationBar:self shouldPopLevel:lastLevel];
	}
	
	if(shouldPop)
	{
		[_navigationLevels removeLastObject];
		[self updateState];
		
		//Notify the delegate that we popped
		if([[self delegate] respondsToSelector:@selector(navigationBar:didPopLevel:)]) {
			[[self delegate] navigationBar:self didPopLevel:[lastLevel autorelease]];
		}
	}
}

- (void)setLevels:(NSArray*)levels
{
	if(levels!=_navigationLevels) {
		[_navigationLevels release];
		_navigationLevels = [levels mutableCopy];
		
		[self updateState];
	}
}

- (PXNavigationLevel*)currentNavigationLevel
{
	return [_navigationLevels lastObject];
}

- (PXNavigationItem*)currentNavigationItem
{
	return [[self currentNavigationLevel] currentItem];
}

- (PXNavigationLevel*)parentLevel
{
	if([_navigationLevels count]<=1) {
		return nil;
	}
	else {
		return [_navigationLevels objectAtIndex:([_navigationLevels count]-2)];
	}
}

- (PXNavigationItem*)parentItem
{
	//If there is no parent level then -parentLevel will return nil anyway
	return [[self parentLevel] currentItem];
}

- (void)updateState
{
	PXNavigationItem *parent = [self parentItem];
	NSButton *backButton = [self viewWithTag:BACKBUTTON_VIEW_TAG];
	NSButton *leftNavButton = [self viewWithTag:LEFT_NAVBUTTON_VIEW_TAG];
	NSButton *rightNavButton = [self viewWithTag:RIGHT_NAVBUTTON_VIEW_TAG];
	
	//Show or hide the back button, depending on whether we are at the "top" of the hierarchy or not
	if(parent!=nil) {
		[backButton setHidden:NO];
		[backButton setTitle:[parent title]];
	}
	else {
		[backButton setHidden:YES];
	}
	
	NSArray *items = [[self currentNavigationLevel] items];
	
	if([items count]<=1) {
		[leftNavButton setHidden:YES];
		[rightNavButton setHidden:YES];
	}
	else {
		[leftNavButton setHidden:NO];
		[rightNavButton setHidden:NO];
		
		PXNavigationItem *currentItem = [self currentNavigationItem];
		
		if([items indexOfObject:currentItem]==0) {
			[leftNavButton setEnabled:NO];
		}
		else {
			[leftNavButton setEnabled:YES];
		}
		
		if([items indexOfObject:currentItem]==([items count]-1)) {
			[rightNavButton setEnabled:NO];
		}
		else {
			[rightNavButton setEnabled:YES];
		}
	}
	
	[self adjustSubviews];
	
	//We need to redraw the title
	[self setNeedsDisplay:YES];
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(NSRect)dirtyRect
{
	NSRect bounds = [self bounds];
	
	//Draw the bar image
	NSImage *barImage = [NSImage imageNamed:@"navBar"];
	NSRect barImageRect = NSMakeRect(0, 0, NSWidth(bounds), 27);
	[barImage drawInRect:barImageRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
	
	//Draw the border at the bottom
	NSRect borderRect = NSMakeRect(0, 0, NSWidth(bounds), 1);
	[BORDER_COLOR set];
	[NSBezierPath fillRect:borderRect];
	
	//Draw the title of the current item
	PXNavigationItem *item = [self currentNavigationItem];
	
	if(item!=nil&&[item title]!=nil) {
		NSString *title = [item title];
		
		NSShadow *textShadow = [[NSShadow alloc] init];
		[textShadow setShadowColor:[NSColor whiteColor]];
		[textShadow setShadowOffset:NSMakeSize(0, -1)];
		
		NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:TITLE_FONT, NSFontAttributeName, 
									textShadow, NSShadowAttributeName, nil];
		[textShadow release];
		NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:title attributes:attributes];
		
		//TODO: constrain to the available width between the back button and nav buttons
		NSSize stringSize = [attrTitle size];
		NSRect drawingRect = NSMakeRect(NSMidX(bounds)-(stringSize.width/2),
										NSMidY(bounds)-(stringSize.height/2),
										stringSize.width,
										stringSize.height);
		
		[attrTitle drawInRect:drawingRect];
	}
}

@end

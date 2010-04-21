//
//  PXNavigationButtonCell.m
//  PXNavigationBar
//
//  Created by Alex Rozanski on 15/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import "PXNavigationButtonCell.h"


@implementation PXNavigationButtonCell

@synthesize navDirection;

#pragma mark -
#pragma mark Drawing

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
	NSImage *buttonImage;
	
	if(navDirection==PXNavigationButtonCellNavDirectionLeft) {
		if([self isHighlighted]) {
			buttonImage = [NSImage imageNamed:@"LeftNavButtonPressed"];
		}
		else {
			buttonImage = [NSImage imageNamed:@"LeftNavButton"];
		}
	}
	else {
		if([self isHighlighted]) {
			buttonImage = [NSImage imageNamed:@"RightNavButtonPressed"];
		}
		else {
			buttonImage = [NSImage imageNamed:@"RightNavButton"];
		}
	}
	
	[buttonImage setFlipped:[[self controlView] isFlipped]];
	[buttonImage drawInRect:frame fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
}

- (void)drawImage:(NSImage *)image withFrame:(NSRect)frame inView:(NSView *)controlView
{
	//Offset the frame
	frame.origin.y+=1;
	frame.origin.x-=1;
	
	[super drawImage:image withFrame:frame inView:controlView];
}

@end

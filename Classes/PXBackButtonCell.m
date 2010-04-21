//
//  PXBackButtonCell.m
//  PXNavigationBar
//
//  Created by Alex Rozanski on 15/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import "PXBackButtonCell.h"


#define BUTTON_FONT			[NSFont boldSystemFontOfSize:11]

@implementation PXBackButtonCell

#pragma mark -
#pragma mark Sizing

- (NSSize)cellSize
{
	NSAttributedString *string = [self attributedTitle];
	NSSize size = [string size];
	
	return NSMakeSize(size.width+20, size.height+10);
}

- (NSRect)titleRectForBounds:(NSRect)bounds
{	
	NSSize titleSize = [[self attributedTitle] size];
	NSRect titleRect = NSMakeRect(NSMidX(bounds)-(titleSize.width/2)+3, NSMidY(bounds)-(titleSize.height/2),
								  titleSize.width, titleSize.height);
	
	titleRect.origin.y-=1;
	
	return titleRect;
}

#pragma mark -
#pragma mark Drawing

- (NSAttributedString*)attributedTitle
{
	NSShadow *textShadow = [[[NSShadow alloc] init] autorelease];
	[textShadow setShadowColor:[NSColor whiteColor]];
	[textShadow setShadowOffset:NSMakeSize(0, -1)];
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:BUTTON_FONT, NSFontAttributeName,
								textShadow, NSShadowAttributeName, nil];
	
	NSAttributedString *string = [[[NSAttributedString alloc] initWithString:[self title]
																  attributes:attributes] autorelease];
	
	return string;
}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
	NSImage *leftImage, *middleImage, *rightImage;
	
	//Load the images based on the button state
	if([self isHighlighted]) {
		leftImage = [NSImage imageNamed:@"BackButtonPressedLeft"];
		middleImage = [NSImage imageNamed:@"BackButtonPressedMiddle"];
		rightImage = [NSImage imageNamed:@"BackButtonPressedRight"];
	}
	else {
		leftImage = [NSImage imageNamed:@"BackButtonNormalLeft"];
		middleImage = [NSImage imageNamed:@"BackButtonNormalMiddle"];
		rightImage = [NSImage imageNamed:@"BackButtonNormalRight"];
	}
	
	NSDrawThreePartImage(frame, leftImage, middleImage, rightImage,
						 NO, NSCompositeSourceOver, 1, [[self controlView] isFlipped]);
}

@end

//
//  PXNavigationButtonCell.h
//  PXNavigationBar
//
//  Created by Alex Rozanski on 15/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import <Cocoa/Cocoa.h>

typedef enum {
	PXNavigationButtonCellNavDirectionLeft,
	PXNavigationButtonCellNavDirectionRight
} PXNavigationButtonCellNavDirection;

@interface PXNavigationButtonCell : NSButtonCell {
}

@property (readwrite) NSInteger navDirection;

@end

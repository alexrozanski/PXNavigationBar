//
//  PXNavigationItem.h
//  PXNavigationBar
//
//  Created by Alex Rozanski on 14/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import <Cocoa/Cocoa.h>

@interface PXNavigationItem : NSObject {
	NSString *_title;
	NSString *_identifier;
}

@property (copy) NSString *title;
@property (copy) NSString *identifier;

- (id)initWithTitle:(NSString*)aTitle identifier:(NSString*)anIdentifier;	//Designated initializer
+ (id)itemWithTitle:(NSString*)aTitle;
+ (id)itemWithTitle:(NSString*)aTitle identifier:(NSString*)anIdentifier;

@end

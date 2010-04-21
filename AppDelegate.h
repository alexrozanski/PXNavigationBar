//
//  PXNavigationBarAppDelegate.h
//  PXNavigationBar
//
//  Created by Alex Rozanski on 14/02/2010.
//  Copyright 2010 Alex Rozanski http://perspx.com
//

#import <Cocoa/Cocoa.h>

@class PXNavigationBar;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSWindow *window;
	IBOutlet PXNavigationBar *navigationBar;
}

- (IBAction)pushLevel:(id)sender;

@end

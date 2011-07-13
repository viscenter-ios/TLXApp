//
//  MainMenu.h
//  TLX
//
//  Created by Justin Proffitt on 6/1/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//  Simple main menu.  Just pushes or presents a view controller based on which button is pushed.

#import <UIKit/UIKit.h>
#import "TLXAppDelegate.h"
#import "CoreDataTableVC.h"

@interface MainMenu : UIViewController {
    
}
-(IBAction) newEntry;
-(IBAction) existingEntry;
-(IBAction) emailData;
-(IBAction) goToAbout;
-(IBAction) goToDownload;

@end

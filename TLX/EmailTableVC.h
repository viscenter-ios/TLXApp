//
//  EmailTableVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/6/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//
//This class inherits from CoreDataTableVC and allows the user to email out a csv file that they select from the table view presented.

#import <UIKit/UIKit.h>
#import "CoreDataTableVC.h"
#import <MessageUI/MessageUI.h>

@interface EmailTableVC : CoreDataTableVC<MFMailComposeViewControllerDelegate> {
    NSIndexPath * resultIndex;
}

-(void)showActionMenu;

@end

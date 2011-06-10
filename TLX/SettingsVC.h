//
//  SettingsVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/1/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//
//This VC inherits from the CoreDataTableVC and allows the user to input
//the Subject name, the Trial number, an optional filename, and finally
//select the questionnaire file from a tableview.

#import <UIKit/UIKit.h>
#import "CoreDataTableVC.h"

@interface SettingsVC : CoreDataTableVC {
  IBOutlet UITextField *subjectText;
  IBOutlet UITextField *trialText;
  IBOutlet UITextField *fileNameText;
}
-(IBAction) hideKeyboard: (UITextField *) text;
@end

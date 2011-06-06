//
//  SettingsVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/1/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLXAppDelegate.h"


@interface SettingsVC : UIViewController {
  IBOutlet UITextField *subjectText;
  IBOutlet UITextField *trialText;
  IBOutlet UITextField *addInfoText;
  IBOutlet UITextField *fileNameText;
}
-(IBAction) startEntry;
-(IBAction) goToMain;
-(IBAction) hideKeyboard: (UITextField *) text;
@end

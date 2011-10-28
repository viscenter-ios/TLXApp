//
//  AppendTableVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/6/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//
//This VC inherits from CoreDataTableVC and allows the user to select the an
//existing CSV file and append information to it with the DynamicFormVC.
#import <UIKit/UIKit.h>
#import "CoreDataTableVC.h"

@interface AppendTableVC : CoreDataTableVC {
  IBOutlet UITextField *subjectText;
}
@property (retain, nonatomic) IBOutlet UITextField *subjectText;
-(IBAction)hideKeyboard: (UITextField*)text;
-(IBAction) done;
@end

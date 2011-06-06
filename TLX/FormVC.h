//
//  FormVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/2/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLXAppDelegate.h"


@interface FormVC : UIViewController {
  IBOutlet UISlider *performanceSlider;
  IBOutlet UISlider *temporalSlider;
  IBOutlet UISlider *physicalSlider;
  IBOutlet UISlider *mentalSlider;
  IBOutlet UISlider *effortSlider;
  
  IBOutlet UITextField *trialText;
  IBOutlet UITextField *addInfoText;
  IBOutlet UILabel *subjectLabel;
  
  NSString *fileName;
  NSString *subjectName;
  NSManagedObjectContext *moContext;
  
}
@property(nonatomic, retain) NSString *fileName;
@property(nonatomic, retain) NSString *subjectName;
@property(nonatomic, retain) UISlider *performancSlider;
@property(nonatomic, retain) UISlider *temporalSlider;
@property(nonatomic, retain) UISlider *physicalSlider;
@property(nonatomic, retain) UISlider *mentalSlider;

@property(nonatomic, retain) UISlider *effortSlider;
@property(nonatomic, retain) UITextField *trialText;
@property(nonatomic, retain) UITextField *addInfoText;
@property(nonatomic, retain) UILabel *subjectLabel;

@property(nonatomic, retain) NSManagedObjectContext *moContext;

-(IBAction)hideKeyboard: (UITextField*)text;
-(IBAction) nextEntry;
-(IBAction) goToMainMenu;
-(IBAction) updateSlider: (UISlider *) slider;
-(void) resetAndUpdateState;
-(void) setSubjectLabelText: (NSString *) s;
-(void) setTrialTextValue: (NSString *) s;
-(void) saveData;
-(void) printDatabase;
@end

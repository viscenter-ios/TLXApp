//
//  DynamicFormVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/8/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DynamicFormVC : UIViewController {
  
  NSArray *questionLabels;
  NSArray *lowLabels;
  NSArray *highLabels;
  NSArray *sliderBars;
  
  NSString *questionFileName;
  
  int numOfQuestions;
  int rangeLow;
  int rangeHigh;
  int rangeIncrement;
  
  IBOutlet UIScrollView *scrollView;
  IBOutlet UILabel *subjectLabel;
  IBOutlet UITextField *trialText;
  IBOutlet UITextField *addInfoText;
  
  NSString *fileName;
  NSString *subjectName;
  NSManagedObjectContext *moContext;

}
@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, retain) NSString *fileName;
@property(nonatomic, retain) NSString *subjectName;
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

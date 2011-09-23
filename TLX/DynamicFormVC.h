//
//  DynamicFormVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/8/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//
//This VC generates forms based on the questionfile information that is passed
//to it from the view before it.

#import <UIKit/UIKit.h>


@interface DynamicFormVC : UIViewController {
  int scrollViewWidth;
  int scrollViewHeight;
  float sliderBarStartVal;
  NSArray *questionLabels;
  NSArray *lowLabels;
  NSArray *highLabels;
  NSArray *sliderBars;
  NSNumber *numOfQuestions;
  NSNumber *lowRangeBound;
  NSNumber *highRangeBound;
  NSNumber *rangeIncrement;
  NSString *questionFileName;
  
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

@property(nonatomic, retain) NSString *questionFileName;

@property(nonatomic, retain) NSArray *questionLabels;
@property(nonatomic, retain) NSArray *lowLabels;
@property(nonatomic, retain) NSArray *highLabels;

@property(nonatomic, retain) NSArray *sliderBars;

@property(nonatomic, retain) NSNumber *numOfQuestions;
@property(nonatomic, retain) NSNumber *lowRangeBound;
@property(nonatomic, retain) NSNumber *highRangeBound;
@property(nonatomic, retain) NSNumber *rangeIncrement;


-(IBAction)hideKeyboard: (UITextField*)text;
-(IBAction) nextEntry;
-(IBAction) goToMainMenu;
-(IBAction) updateSlider: (UISlider *) slider;
-(void) resetAndUpdateState;
-(void) setSubjectLabelText: (NSString *) s;
-(void) setTrialTextValue: (NSString *) s;
-(void) saveData;
-(void) printDatabase;
-(void) generateForm;
-(UILabel *) makeLabelWithText: (NSString *)s withRect:(CGRect) rect withFont: (UIFont *) f;
-(NSString *) getDataString;
-(NSString *) getHeader;
@end

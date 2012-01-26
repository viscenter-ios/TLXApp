//
//  QFileGrabberVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/8/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//
//This VC grabs downloads questionnaire data from the given URL and 
//parses and saves the data to Core Data when the Save button is pressed.
//Currently this VC does not make sure that the URL is valid, so a bad URL
//or bad CSV file may cause the app to crash.
//The format of the QFile needs to be:
/*
TITLE NAME_OF_QUESTIONNAIRE

QUESTIONS_PER_FRAME INTEGER
RANGE LOWER_BOUND_INTEGER UPPER_BOUND_INTEGER
RANGE_INCREMENT INTEGER


QUESTION NAME_OF_QUESTION
RANGE_MIN_LABEL NAME_OF_LABEL
RANGE_MAX_LABEL NAME_OF_LABEL

(repeat the above three lines QUESTIONS_PER_FRAME number of times)
The full NASA-TLX in this format can be found at the bottom of this file.
*/
#import <UIKit/UIKit.h>


@interface QFileGrabberVC : UIViewController {
  IBOutlet UITextField *addressText;
  IBOutlet UIWebView *webView;
  IBOutlet UILabel *infoLabel;
  NSString *questionString;
  IBOutlet UITextView *textView;
  NSManagedObjectContext *moContext;
  NSString *qFileString;
  NSString *qTitle;
  NSString *numOfQuestions;
  NSString *range;
  NSString *rangeIncrement;
  
  NSString *questionNames;
  NSString *lowLabelNames;
  NSString *highLabelNames;
  
  NSString *questionName;
  NSString *qLowLabel;
  NSString *qHighLabel;
  
  NSNumber *questionNum;
  NSNumber *lowRange;
  NSNumber *highRange;
  NSNumber *rangeInc;
  
  NSScanner *scanner;
  BOOL needsSaved;
}
@property(retain, nonatomic) NSManagedObjectContext *moContext;
@property(retain, nonatomic) NSScanner *scanner;
@property(retain, nonatomic) NSString *qTitle;
@property(retain, nonatomic) NSString *numOfQuestions;
@property(retain, nonatomic) NSString *range;
@property(retain, nonatomic) NSString *rangeIncrement;

@property(retain, nonatomic) NSString *questionNames;
@property(retain, nonatomic) NSString *lowLabelNames;
@property(retain, nonatomic) NSString *highLabelNames;

@property(retain, nonatomic) NSString *questionName;
@property(retain, nonatomic) NSString *qLowLabel;
@property(retain, nonatomic) NSString *qHighLabel;
@property(retain, nonatomic) NSString *qFileString;

@property(retain, nonatomic) NSNumber *questionNum;
@property(retain, nonatomic) NSNumber *lowRange;
@property(retain, nonatomic) NSNumber *highRange;
@property(retain, nonatomic) NSNumber *rangeInc;
-(IBAction) saveQFile;
-(IBAction) downloadQFile;
-(void) printDatabase;
-(IBAction) done;
- (IBAction)hideKeyboard: (UITextField*)text;
@end

/*
 TITLE NASA-TLX
 
 QUESTIONS_PER_FRAME 6
 RANGE 0 20
 RANGE_INCREMENT	1
 
 
 QUESTION Mental Demand
 RANGE_MIN_LABEL Low	
 RANGE_MAX_LABEL High
 
 
 QUESTION Physical Demand
 RANGE_MIN_LABEL Low	
 RANGE_MAX_LABEL High
 
 
 QUESTION Temporal Demand
 RANGE_MIN_LABEL Low	
 RANGE_MAX_LABEL High
 
 
 QUESTION Effort
 RANGE_MIN_LABEL Good
 RANGE_MAX_LABEL Bad
 
 QUESTION Performance
 RANGE_MIN_LABEL Low	
 RANGE_MAX_LABEL High
 
 
It is important to note that the file should not contain any tab characters, all whitespace
should be newlines and spaces.

 */

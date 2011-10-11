//
//  QFileCreator.h
//  TLX
//
//  Created by Jack Bandy on 7/5/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//  I created this class because I thought it was silly to have to download a questionnaire file. This class allows the user to do it right in the app. 



@interface QFileCreator : UIViewController{
    //the scroll view holds all the other elements
    IBOutlet UIScrollView *settings;
    //these buttons either add or remove textfields from the scrollview
    IBOutlet UIButton *addButton;
    IBOutlet UIButton *removeButton;
    //these elements set universal settings for the questionnaire
    IBOutlet UITextField *qtitle;
    IBOutlet UITextField *qmin;
    IBOutlet UITextField *qmax;
    //these elements hold the question, minimum label, and maximum label for a question
    NSMutableArray *questions;
    
    //this string is parsed to store to the database as a questionnaire
    NSMutableString *ps;
    //this interval is used when adding questions to the "ps" string
    int qcount;
    
    //these are all elements used for parsing and saving the string to the database
    NSString *questionString;
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
}

@property (nonatomic)  int qcount;

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

-(IBAction)addQuestion;
-(IBAction)removeQuestion;
-(IBAction)done;
-(IBAction)cancel;
-(IBAction)rangeInfo;
-(void) saveQFile;
-(void) printDatabase;
//-(void) checkerrs;

@end


@interface QuestionFields : NSObject <UITextFieldDelegate>
{
    UITextField *question;
    UITextField *lowLabel;
    UITextField *highLabel;
}
@property (retain, nonatomic) UITextField *question;
@property (retain, nonatomic) UITextField *lowLabel;
@property (retain, nonatomic) UITextField *highLabel;

-(id)initAtPos:(int)x y:(int)y;
-(void)release;
-(void)setSuperview:(UIView*)view;
@end

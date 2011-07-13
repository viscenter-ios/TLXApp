//
//  QFileCreator.h
//  TLX
//
//  Created by Jack Bandy on 7/5/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//  I created this class because I thought it was silly to have to download a questionnaire file. This class allows the user to do it right in the app. 



@interface QFileCreator : UIViewController <UITextFieldDelegate>{
    //the scroll view holds all the other elements
    IBOutlet UIScrollView *settings;
    //these buttons either add or remove textfields from the scrollview
    IBOutlet UIButton *addButton;
    IBOutlet UIButton *removeButton;
    //these elements set universal settings for the questionnaire
    IBOutlet UITextField *qtitle;
    IBOutlet UITextField *qmin;
    IBOutlet UITextField *qmax;
    //these elements hold the question, minimum label, and maximum label for a question, up to 9
    IBOutlet UITextField *qst1;
    IBOutlet UITextField *mnl1;
    IBOutlet UITextField *mxl1;
    UITextField *qst2;
    UITextField *mnl2;
    UITextField *mxl2;
    UITextField *qst3;
    UITextField *mnl3;
    UITextField *mxl3;
    UITextField *qst4;
    UITextField *mnl4;
    UITextField *mxl4;
    UITextField *qst5;
    UITextField *mnl5;
    UITextField *mxl5;
    UITextField *qst6;
    UITextField *mnl6;
    UITextField *mxl6;
    UITextField *qst7;
    UITextField *mnl7;
    UITextField *mxl7;
    UITextField *qst8;
    UITextField *mnl8;
    UITextField *mxl8;
    UITextField *qst9;
    UITextField *mnl9;
    UITextField *mxl9;
    
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

@property (nonatomic, retain) IBOutlet UITextField *qst1;
@property (nonatomic, retain) IBOutlet UITextField *mnl1;
@property (nonatomic, retain) IBOutlet UITextField *mxl1;
@property (nonatomic, retain) UITextField *qst2;
@property (nonatomic, retain) UITextField *mnl2;
@property (nonatomic, retain) UITextField *mxl2;
@property (nonatomic, retain) UITextField *qst3;
@property (nonatomic, retain) UITextField *mnl3;
@property (nonatomic, retain) UITextField *mxl3;
@property (nonatomic, retain) UITextField *qst4;
@property (nonatomic, retain) UITextField *mnl4;
@property (nonatomic, retain) UITextField *mxl4;
@property (nonatomic, retain) UITextField *qst5;
@property (nonatomic, retain) UITextField *mnl5;
@property (nonatomic, retain) UITextField *mxl5;
@property (nonatomic, retain) UITextField *qst6;
@property (nonatomic, retain) UITextField *mnl6;
@property (nonatomic, retain) UITextField *mxl6;
@property (nonatomic, retain) UITextField *qst7;
@property (nonatomic, retain) UITextField *mnl7;
@property (nonatomic, retain) UITextField *mxl7;
@property (nonatomic, retain) UITextField *qst8;
@property (nonatomic, retain) UITextField *mnl8;
@property (nonatomic, retain) UITextField *mxl8;
@property (nonatomic, retain) UITextField *qst9;
@property (nonatomic, retain) UITextField *mnl9;
@property (nonatomic, retain) UITextField *mxl9;

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
-(void) checkerrs;

@end

//
//  QFileCreator.m
//  TLX
//
//  Created by Jack Bandy on 7/5/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "QFileCreator.h"
#import "TLXAppDelegate.h"

@implementation QFileCreator
@synthesize  qst1,mnl1, mxl1, qst2,mnl2,mxl2,qst3,mnl3,mxl3,qst4,mnl4,mxl4,qst5,mnl5,mxl5,qst6,mnl6,mxl6,qst7,mnl7,mxl7,qst8,mnl8,mxl8,qst9,mnl9,mxl9;
@synthesize qcount;

@synthesize moContext,qTitle ,numOfQuestions, range, rangeIncrement, questionNames, lowLabelNames,qFileString;
@synthesize highLabelNames, questionName, qLowLabel, qHighLabel, questionNum,lowRange, highRange, rangeInc, scanner;


NSMutableArray *questionsarray;
NSMutableDictionary *tmpdic;
int qcount;


///////////////////////////////////////////////////////////////////////////////////////////
    //When the view loads we update the scroll view dimensions.
- (void)viewDidLoad {
	[super viewDidLoad];
    [self becomeFirstResponder];
    qcount = 1;
    self.title = @"New Questionnaire";
    settings.frame = CGRectMake(0, 44, 320, 416);
    settings.contentSize = CGSizeMake(320, 417);
    [self.view addSubview:settings];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //This function handles the action when the user selects the "Add Question" button I've only commented one of the initializations, because it's quite repetitive
-(IBAction)addQuestion{
    NSLog(@"addQuestion");
    if (qcount == 1){
        NSLog(@"qcount == 1");
        //allocate memory, initialize, and set the frame
        qst2 = [[UITextField alloc] initWithFrame: CGRectMake(20, 200, 280, 31)];
        //basic borderstyle
        qst2.borderStyle = UITextBorderStyleRoundedRect;
        //sort of self-explanitory
		qst2.textColor = [UIColor blackColor];
        //yeah...
		qst2.font = [UIFont systemFontOfSize:14.0];
        //this shows up "grayed out" before editing begins, almost like... a placeholder!
		qst2.placeholder = @"Question two title";
        //delicious background color
		qst2.backgroundColor = [UIColor whiteColor];
        //this aligns the text so it's not flying up top or sinking at the bottom
        qst2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //the return key says "next" and, when clicked, goes to the next field
        qst2.returnKeyType = UIReturnKeyNext;
        //this automaticaly capitalizes the first word of each sentence
        qst2.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        //The alpha is set to 0 for a fade-in animation
        qst2.alpha = 0.0;
        //the delegate has to be set to this controller so that when the "Next" (return) key is pressed, we recognize it
        qst2.delegate = self;
        
        mnl2 = [[UITextField alloc] initWithFrame: CGRectMake(20, 239, 130, 31)];
        mnl2.alpha = 0.0;
        mnl2.delegate = self;
        mnl2.borderStyle = UITextBorderStyleRoundedRect;
		mnl2.textColor = [UIColor blackColor];
		mnl2.font = [UIFont systemFontOfSize:14.0];
		mnl2.placeholder = @"Minimum label";
		mnl2.backgroundColor = [UIColor whiteColor];
        mnl2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mnl2.returnKeyType = UIReturnKeyNext;
        mnl2.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mnl2.alpha = 0.0;
        mnl2.delegate = self;
        
        mxl2 = [[UITextField alloc] initWithFrame: CGRectMake(170, 239, 130, 31)];
        mxl2.alpha = 0.0;
        mxl2.delegate = self;
        mxl2.borderStyle = UITextBorderStyleRoundedRect;
		mxl2.textColor = [UIColor blackColor];
		mxl2.font = [UIFont systemFontOfSize:14.0];
		mxl2.placeholder = @"Maximum label";
		mxl2.backgroundColor = [UIColor whiteColor];
        mxl2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mxl2.returnKeyType = UIReturnKeyDone;
        mxl2.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mxl2.alpha = 0.0;
        mxl2.delegate = self;
        
        //all the subviews have to be added to the scrollview
        [settings addSubview:qst2];
        [settings addSubview:mnl2];
        [settings addSubview:mxl2];
        
        //this is code for a basic
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        //this is where you put anything you want the animation to change
        //resize the scrollview to fit the new elements
        settings.contentSize = CGSizeMake(320, settings.contentSize.height+90);
        //adjust the add button, moving it down and resizing it to make room for...
        addButton.frame = CGRectMake(20, addButton.frame.origin.y+90, 130, 40);
        //... the remove button!, just fading in
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y+90, 130, 40);
        removeButton.alpha = 1.0;
        //fade in all the textfields
        qst2.alpha = 1.0;
        mnl2.alpha = 1.0;
        mxl2.alpha = 1.0;
        [UIView commitAnimations];
        qcount ++;
    }
    else if (qcount == 2){
        NSLog(@"qcount == 2");
        qst3 = [[UITextField alloc] initWithFrame: CGRectMake(20, 290, 280, 31)];
        qst3.borderStyle = UITextBorderStyleRoundedRect;
		qst3.textColor = [UIColor blackColor];
		qst3.font = [UIFont systemFontOfSize:14.0];
		qst3.placeholder = @"Question three title";
		qst3.backgroundColor = [UIColor whiteColor];
        qst3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        qst3.returnKeyType = UIReturnKeyNext;
        qst3.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        qst3.alpha = 0.0;
        qst3.delegate = self;
        
        mnl3 = [[UITextField alloc] initWithFrame: CGRectMake(20, 329, 130, 31)];
        mnl3.alpha = 0.0;
        mnl3.delegate = self;
        mnl3.borderStyle = UITextBorderStyleRoundedRect;
		mnl3.textColor = [UIColor blackColor];
		mnl3.font = [UIFont systemFontOfSize:14.0];
		mnl3.placeholder = @"Minimum label";
		mnl3.backgroundColor = [UIColor whiteColor];
        mnl3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mnl3.returnKeyType = UIReturnKeyNext;
        mnl3.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mnl3.alpha = 0.0;
        mnl3.delegate = self;
        
        mxl3 = [[UITextField alloc] initWithFrame: CGRectMake(170, 329, 130, 31)];
        mxl3.alpha = 0.0;
        mxl3.delegate = self;
        mxl3.borderStyle = UITextBorderStyleRoundedRect;
		mxl3.textColor = [UIColor blackColor];
		mxl3.font = [UIFont systemFontOfSize:14.0];
		mxl3.placeholder = @"Maximum label";
		mxl3.backgroundColor = [UIColor whiteColor];
        mxl3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mxl3.returnKeyType = UIReturnKeyDone;
        mxl3.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mxl3.alpha = 0.0;
        mxl3.delegate = self;
        
        [settings addSubview:qst3];
        [settings addSubview:mnl3];
        [settings addSubview:mxl3];
        
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height+90);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y+90, 130, 40);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y+90, 130, 40);
        qst3.alpha = 1.0;
        mnl3.alpha = 1.0;
        mxl3.alpha = 1.0;
        [UIView commitAnimations];
        qcount ++;
    }
    else if (qcount == 3){
        NSLog(@"qcount == 3");
        qst4 = [[UITextField alloc] initWithFrame: CGRectMake(20, 380, 280, 31)];
        qst4.borderStyle = UITextBorderStyleRoundedRect;
		qst4.textColor = [UIColor blackColor];
		qst4.font = [UIFont systemFontOfSize:14.0];
		qst4.placeholder = @"Question four title";
		qst4.backgroundColor = [UIColor whiteColor];
        qst4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        qst4.returnKeyType = UIReturnKeyNext;
        qst4.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        qst4.alpha = 0.0;
        qst4.delegate = self;
        
        mnl4 = [[UITextField alloc] initWithFrame: CGRectMake(20, 419, 130, 31)];
        mnl4.alpha = 0.0;
        mnl4.delegate = self;
        mnl4.borderStyle = UITextBorderStyleRoundedRect;
		mnl4.textColor = [UIColor blackColor];
		mnl4.font = [UIFont systemFontOfSize:14.0];
		mnl4.placeholder = @"Minimum label";
		mnl4.backgroundColor = [UIColor whiteColor];
        mnl4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mnl4.returnKeyType = UIReturnKeyNext;
        mnl4.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mnl4.alpha = 0.0;
        mnl4.delegate = self;
        
        mxl4 = [[UITextField alloc] initWithFrame: CGRectMake(170, 419, 130, 31)];
        mxl4.alpha = 0.0;
        mxl4.delegate = self;
        mxl4.borderStyle = UITextBorderStyleRoundedRect;
		mxl4.textColor = [UIColor blackColor];
		mxl4.font = [UIFont systemFontOfSize:14.0];
		mxl4.placeholder = @"Maximum label";
		mxl4.backgroundColor = [UIColor whiteColor];
        mxl4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mxl4.returnKeyType = UIReturnKeyDone;
        mxl4.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mxl4.alpha = 0.0;
        mxl4.delegate = self;
        
        [settings addSubview:qst4];
        [settings addSubview:mnl4];
        [settings addSubview:mxl4];
        
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height+90);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y+90, 130, 40);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y+90, 130, 40);
        qst4.alpha = 1.0;
        mnl4.alpha = 1.0;
        mxl4.alpha = 1.0;
        [UIView commitAnimations];
        qcount ++;
    }
    else if (qcount == 4){
        NSLog(@"qcount == 4");
        qst5 = [[UITextField alloc] initWithFrame: CGRectMake(20, 470, 280, 31)];
        qst5.borderStyle = UITextBorderStyleRoundedRect;
		qst5.textColor = [UIColor blackColor];
		qst5.font = [UIFont systemFontOfSize:14.0];
		qst5.placeholder = @"Question five title";
		qst5.backgroundColor = [UIColor whiteColor];
        qst5.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        qst5.returnKeyType = UIReturnKeyNext;
        qst5.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        qst5.alpha = 0.0;
        qst5.delegate = self;
        
        mnl5 = [[UITextField alloc] initWithFrame: CGRectMake(20, 509, 130, 31)];
        mnl5.alpha = 0.0;
        mnl5.delegate = self;
        mnl5.borderStyle = UITextBorderStyleRoundedRect;
		mnl5.textColor = [UIColor blackColor];
		mnl5.font = [UIFont systemFontOfSize:14.0];
		mnl5.placeholder = @"Minimum label";
		mnl5.backgroundColor = [UIColor whiteColor];
        mnl5.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mnl5.returnKeyType = UIReturnKeyNext;
        mnl5.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mnl5.alpha = 0.0;
        mnl5.delegate = self;
        
        mxl5 = [[UITextField alloc] initWithFrame: CGRectMake(170, 509, 130, 31)];
        mxl5.alpha = 0.0;
        mxl5.delegate = self;
        mxl5.borderStyle = UITextBorderStyleRoundedRect;
		mxl5.textColor = [UIColor blackColor];
		mxl5.font = [UIFont systemFontOfSize:14.0];
		mxl5.placeholder = @"Maximum label";
		mxl5.backgroundColor = [UIColor whiteColor];
        mxl5.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mxl5.returnKeyType = UIReturnKeyDone;
        mxl5.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mxl5.alpha = 0.0;
        mxl5.delegate = self;
        
        [settings addSubview:qst5];
        [settings addSubview:mnl5];
        [settings addSubview:mxl5];
        
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height+90);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y+90, 130, 40);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y+90, 130, 40);
        qst5.alpha = 1.0;
        mnl5.alpha = 1.0;
        mxl5.alpha = 1.0;
        [UIView commitAnimations];
        qcount ++;
    }
    else if (qcount == 5){
        NSLog(@"qcount == 5");
        qst6 = [[UITextField alloc] initWithFrame: CGRectMake(20, 560, 280, 31)];
        qst6.borderStyle = UITextBorderStyleRoundedRect;
		qst6.textColor = [UIColor blackColor];
		qst6.font = [UIFont systemFontOfSize:14.0];
		qst6.placeholder = @"Question six title";
		qst6.backgroundColor = [UIColor whiteColor];
        qst6.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        qst6.returnKeyType = UIReturnKeyNext;
        qst6.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        qst6.alpha = 0.0;
        qst6.delegate = self;
        
        mnl6 = [[UITextField alloc] initWithFrame: CGRectMake(20, 599, 130, 31)];
        mnl6.alpha = 0.0;
        mnl6.delegate = self;
        mnl6.borderStyle = UITextBorderStyleRoundedRect;
		mnl6.textColor = [UIColor blackColor];
		mnl6.font = [UIFont systemFontOfSize:14.0];
		mnl6.placeholder = @"Minimum label";
		mnl6.backgroundColor = [UIColor whiteColor];
        mnl6.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mnl6.returnKeyType = UIReturnKeyNext;
        mnl6.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mnl6.alpha = 0.0;
        mnl6.delegate = self;
        
        mxl6 = [[UITextField alloc] initWithFrame: CGRectMake(170, 599, 130, 31)];
        mxl6.alpha = 0.0;
        mxl6.delegate = self;
        mxl6.borderStyle = UITextBorderStyleRoundedRect;
		mxl6.textColor = [UIColor blackColor];
		mxl6.font = [UIFont systemFontOfSize:14.0];
		mxl6.placeholder = @"Maximum label";
		mxl6.backgroundColor = [UIColor whiteColor];
        mxl6.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mxl6.returnKeyType = UIReturnKeyDone;
        mxl6.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mxl6.alpha = 0.0;
        mxl6.delegate = self;
        
        [settings addSubview:qst6];
        [settings addSubview:mnl6];
        [settings addSubview:mxl6];
        
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height+90);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y+90, 130, 40);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y+90, 130, 40);
        qst6.alpha = 1.0;
        mnl6.alpha = 1.0;
        mxl6.alpha = 1.0;
        [UIView commitAnimations];
        qcount ++;
    }
    else if (qcount == 6){
        NSLog(@"qcount == 6");
        qst7 = [[UITextField alloc] initWithFrame: CGRectMake(20, 650, 280, 31)];
        qst7.borderStyle = UITextBorderStyleRoundedRect;
		qst7.textColor = [UIColor blackColor];
		qst7.font = [UIFont systemFontOfSize:14.0];
		qst7.placeholder = @"Question seven title";
		qst7.backgroundColor = [UIColor whiteColor];
        qst7.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        qst7.returnKeyType = UIReturnKeyNext;
        qst7.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        qst7.alpha = 0.0;
        qst7.delegate = self;
        
        mnl7 = [[UITextField alloc] initWithFrame: CGRectMake(20, 689, 130, 31)];
        mnl7.alpha = 0.0;
        mnl7.delegate = self;
        mnl7.borderStyle = UITextBorderStyleRoundedRect;
		mnl7.textColor = [UIColor blackColor];
		mnl7.font = [UIFont systemFontOfSize:14.0];
		mnl7.placeholder = @"Minimum label";
		mnl7.backgroundColor = [UIColor whiteColor];
        mnl7.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mnl7.returnKeyType = UIReturnKeyNext;
        mnl7.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mnl7.alpha = 0.0;
        mnl7.delegate = self;
        
        mxl7 = [[UITextField alloc] initWithFrame: CGRectMake(170, 689, 130, 31)];
        mxl7.alpha = 0.0;
        mxl7.delegate = self;
        mxl7.borderStyle = UITextBorderStyleRoundedRect;
		mxl7.textColor = [UIColor blackColor];
		mxl7.font = [UIFont systemFontOfSize:14.0];
		mxl7.placeholder = @"Maximum label";
		mxl7.backgroundColor = [UIColor whiteColor];
        mxl7.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mxl7.returnKeyType = UIReturnKeyDone;
        mxl7.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mxl7.alpha = 0.0;
        mxl7.delegate = self;
        
        [settings addSubview:qst7];
        [settings addSubview:mnl7];
        [settings addSubview:mxl7];
        
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height+90);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y+90, 130, 40);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y+90, 130, 40);
        qst7.alpha = 1.0;
        mnl7.alpha = 1.0;
        mxl7.alpha = 1.0;
        [UIView commitAnimations];
        qcount ++;
    }
    else if (qcount == 7){
        NSLog(@"qcount == 7");
        qst8 = [[UITextField alloc] initWithFrame: CGRectMake(20, 740, 280, 31)];
        qst8.borderStyle = UITextBorderStyleRoundedRect;
		qst8.textColor = [UIColor blackColor];
		qst8.font = [UIFont systemFontOfSize:14.0];
		qst8.placeholder = @"Question eight title";
		qst8.backgroundColor = [UIColor whiteColor];
        qst8.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        qst8.returnKeyType = UIReturnKeyNext;
        qst8.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        qst8.alpha = 0.0;
        qst8.delegate = self;
        
        mnl8 = [[UITextField alloc] initWithFrame: CGRectMake(20, 779, 130, 31)];
        mnl8.alpha = 0.0;
        mnl8.delegate = self;
        mnl8.borderStyle = UITextBorderStyleRoundedRect;
		mnl8.textColor = [UIColor blackColor];
		mnl8.font = [UIFont systemFontOfSize:14.0];
		mnl8.placeholder = @"Minimum label";
		mnl8.backgroundColor = [UIColor whiteColor];
        mnl8.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mnl8.returnKeyType = UIReturnKeyNext;
        mnl8.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mnl8.alpha = 0.0;
        mnl8.delegate = self;
        
        mxl8 = [[UITextField alloc] initWithFrame: CGRectMake(170, 779, 130, 31)];
        mxl8.alpha = 0.0;
        mxl8.delegate = self;
        mxl8.borderStyle = UITextBorderStyleRoundedRect;
		mxl8.textColor = [UIColor blackColor];
		mxl8.font = [UIFont systemFontOfSize:14.0];
		mxl8.placeholder = @"Maximum label";
		mxl8.backgroundColor = [UIColor whiteColor];
        mxl8.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mxl8.returnKeyType = UIReturnKeyDone;
        mxl8.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mxl8.alpha = 0.0;
        mxl8.delegate = self;
        
        [settings addSubview:qst8];
        [settings addSubview:mnl8];
        [settings addSubview:mxl8];
        
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height+90);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y+90, 130, 40);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y+90, 130, 40);
        qst8.alpha = 1.0;
        mnl8.alpha = 1.0;
        mxl8.alpha = 1.0;
        [UIView commitAnimations];
        qcount ++;
    }
    else if (qcount == 8){
        NSLog(@"qcount == 8");
        qst9 = [[UITextField alloc] initWithFrame: CGRectMake(20, 830, 280, 31)];
        qst9.borderStyle = UITextBorderStyleRoundedRect;
		qst9.textColor = [UIColor blackColor];
		qst9.font = [UIFont systemFontOfSize:14.0];
		qst9.placeholder = @"Question nine title";
		qst9.backgroundColor = [UIColor whiteColor];
        qst9.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        qst9.returnKeyType = UIReturnKeyNext;
        qst9.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        qst9.alpha = 0.0;
        qst9.delegate = self;
        
        mnl9 = [[UITextField alloc] initWithFrame: CGRectMake(20, 869, 130, 31)];
        mnl9.alpha = 0.0;
        mnl9.delegate = self;
        mnl9.borderStyle = UITextBorderStyleRoundedRect;
		mnl9.textColor = [UIColor blackColor];
		mnl9.font = [UIFont systemFontOfSize:14.0];
		mnl9.placeholder = @"Minimum label";
		mnl9.backgroundColor = [UIColor whiteColor];
        mnl9.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mnl9.returnKeyType = UIReturnKeyNext;
        mnl9.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mnl9.alpha = 0.0;
        mnl9.delegate = self;
        
        mxl9 = [[UITextField alloc] initWithFrame: CGRectMake(170, 869, 130, 31)];
        mxl9.alpha = 0.0;
        mxl9.delegate = self;
        mxl9.borderStyle = UITextBorderStyleRoundedRect;
		mxl9.textColor = [UIColor blackColor];
		mxl9.font = [UIFont systemFontOfSize:14.0];
		mxl9.placeholder = @"Maximum label";
		mxl9.backgroundColor = [UIColor whiteColor];
        mxl9.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        mxl9.returnKeyType = UIReturnKeyDone;
        mxl9.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        mxl9.alpha = 0.0;
        mxl9.delegate = self;
        
        [settings addSubview:qst9];
        [settings addSubview:mnl9];
        [settings addSubview:mxl9];
        
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height+90);
        removeButton.frame = CGRectMake(20, removeButton.frame.origin.y+90, 280, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y+90, 130, 40);
        addButton.alpha = 0.0;
        qst9.alpha = 1.0;
        mnl9.alpha = 1.0;
        mxl9.alpha = 1.0;
        [UIView commitAnimations];
        qcount ++;
    }
    else if (qcount == 9){
        //you shouldn't be able to add a question if you already have the maximum
        NSLog(@"qcount == 9; should not happen");
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //This function handles the action when the user selects the "Add Question" button
-(IBAction)removeQuestion{
    if (qcount == 1){
        //you shouldn't be able to remove a question if you already have the minimum
        NSLog(@"qcount == 1; should not happen");
    }
    else if (qcount == 2){
        NSLog(@"qcount == 2");
        //initialize the animations
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        //get rid of the text fields
        [qst2 removeFromSuperview];
        [mnl2 removeFromSuperview];
        [mxl2 removeFromSuperview];
        //release all the textfields from the memory, watch them fly away
        [qst2 release];
        [mnl2 release];
        [mxl2 release];
        //change the size of the scrollview and move the buttons accordingly
        settings.contentSize = CGSizeMake(320, settings.contentSize.height-90);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 280, 40);
        removeButton.alpha = 0.0;
        [UIView commitAnimations];
        qcount --;
    }
    else if (qcount == 3){
        NSLog(@"qcount == 3");
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [qst3 removeFromSuperview];
        [mnl3 removeFromSuperview];
        [mxl3 removeFromSuperview];
        [qst3 release];
        [mnl3 release];
        [mxl3 release];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height-90);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 130, 40);
        removeButton.alpha = 1.0;
        [UIView commitAnimations];
        qcount --;
    }
    else if (qcount == 4){
        NSLog(@"qcount == 4");
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [qst4 removeFromSuperview];
        [mnl4 removeFromSuperview];
        [mxl4 removeFromSuperview];
        [qst4 release];
        [mnl4 release];
        [mxl4 release];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height-90);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 130, 40);
        [UIView commitAnimations];
        qcount --;
    }
    else if (qcount == 5){
        NSLog(@"qcount == 5");
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [qst5 removeFromSuperview];
        [mnl5 removeFromSuperview];
        [mxl5 removeFromSuperview];
        [qst5 release];
        [mnl5 release];
        [mxl5 release];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height-90);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 130, 40);
        [UIView commitAnimations];
        qcount --;
    }
    else if (qcount == 6){
        NSLog(@"qcount == 6");
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [qst6 removeFromSuperview];
        [mnl6 removeFromSuperview];
        [mxl6 removeFromSuperview];
        [qst6 release];
        [mnl6 release];
        [mxl6 release];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height-90);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 130, 40);
        [UIView commitAnimations];
        qcount --;
    }
    else if (qcount == 7){
        NSLog(@"qcount == 7");
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [qst7 removeFromSuperview];
        [mnl7 removeFromSuperview];
        [mxl7 removeFromSuperview];
        [qst7 release];
        [mnl7 release];
        [mxl7 release];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height-90);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 130, 40);
        [UIView commitAnimations];
        qcount --;
    }
    else if (qcount == 8){
        NSLog(@"qcount == 8");
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [qst8 removeFromSuperview];
        [mnl8 removeFromSuperview];
        [mxl8 removeFromSuperview];
        [qst8 release];
        [mnl8 release];
        [mxl8 release];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height-90);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 130, 40);
        [UIView commitAnimations];
        qcount --;
    }
    else if (qcount == 9){
        NSLog(@"qcount == 9;");
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [qst9 removeFromSuperview];
        [mnl9 removeFromSuperview];
        [mxl9 removeFromSuperview];
        [qst9 release];
        [mnl9 release];
        [mxl9 release];
        settings.contentSize = CGSizeMake(320, settings.contentSize.height-90);
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 130, 40);
        addButton.alpha = 1.0;
        [UIView commitAnimations];
        qcount --;
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



///////////////////////////////////////////////////////////////////////////////////////////
    //This function uses the NSScanner class to parse the question file provided and extract the necessary information. I had some issue with memory management in this function,so it is a bit longer than I had hoped.
-(void)parseQFile {
    scanner = [NSScanner scannerWithString:ps];
    
    questionNames = @"";
    lowLabelNames = @"";
    highLabelNames = @"";
    NSString *temp;
    
    [scanner scanString:@"TITLE " intoString:NULL];
    [scanner scanUpToString:@"\n" intoString:&temp];
    [self setQTitle:[NSString stringWithFormat:@"%@", temp]];
    [scanner scanString:@"QUESTIONS_PER_FRAME" intoString:NULL];
    [scanner scanUpToString:@"\n" intoString:&temp];
    [self setNumOfQuestions:[NSString stringWithFormat:@"%@", temp]];
    [scanner scanString:@"RANGE " intoString:NULL];
    int tempInt;
    [scanner scanInt:&tempInt];
    [self setLowRange:[NSNumber numberWithInt:tempInt]];
    [scanner scanInt:&tempInt];
    [self setHighRange:[NSNumber numberWithInt:tempInt]];
    NSLog(@"%d, %d", [lowRange intValue], [highRange intValue]);
    [scanner scanString:@"RANGE_INCREMENT " intoString:NULL];
    [scanner scanUpToString:@"\n" intoString:&temp];
    [self setRangeIncrement:[NSString stringWithFormat:@"%@", temp]];
    [self setQuestionNum:[NSNumber numberWithInt:[numOfQuestions intValue]]];
    [self setRangeInc:[NSNumber numberWithInt:[rangeIncrement intValue]]];
    
    for(int i = 0; i < [questionNum intValue]; ++i){
        [scanner scanString:@"QUESTION " intoString:NULL];
        
        [scanner scanUpToString:@"\n" intoString:&temp];
        [self setQuestionName:[NSString stringWithFormat:@"%@", temp]];
        
        [scanner scanString:@"RANGE_MIN_LABEL" intoString:NULL];
        
        [scanner scanUpToString:@"\n" intoString:&temp];
        [self setQLowLabel:[NSString stringWithFormat:@"%@", temp]] ;
        
        [scanner scanString:@"RANGE_MAX_LABEL" intoString:NULL];
        
        [scanner scanUpToString:@"\n" intoString:&temp];
        [self setQHighLabel:[NSString stringWithFormat:@"%@", temp]];
        
        [self setQuestionNames:[questionNames stringByAppendingFormat:@"%@\n", questionName]];
        [self setLowLabelNames:[lowLabelNames stringByAppendingFormat:@"%@\n", qLowLabel]];
        [self setHighLabelNames:[highLabelNames stringByAppendingFormat:@"%@\n", qHighLabel]];
    }
    [self saveQFile];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //This Function saves the information into coredata under the propery keys. See the DynamicFormVC for more information.
-(void) saveQFile {
    if(moContext == nil){
        moContext = 
        [(TLXAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    NSError *error;
    NSLog(@"%@", qTitle);
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title matches %@)", qTitle];
    
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"QFile" inManagedObjectContext:moContext];
    
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entity];
	[request setPredicate:predicate];
	
    NSArray *fetchedObjects = [moContext executeFetchRequest:request error:&error];
    
    if([fetchedObjects count] < 1){
        NSManagedObject *questionObj = [NSEntityDescription insertNewObjectForEntityForName:@"QFile" inManagedObjectContext:moContext];
        [questionObj setValue:qTitle forKey:@"title"];
        [questionObj setValue:questionNum forKey:@"numOfQuestions"];
        [questionObj setValue:questionNames forKey:@"questionNames"];
        [questionObj setValue:lowLabelNames forKey:@"lowLabelNames"];
        [questionObj setValue:highLabelNames forKey:@"highLabelNames"];
        [questionObj setValue:rangeInc forKey:@"rangeIncrement"];
        [questionObj setValue:lowRange forKey:@"rangeLowerBound"];
        [questionObj setValue:highRange forKey:@"rangeUpperBound"];
    }
	else{
        //we do nothing if there were returned results.
	}
    
    //Finally, we save our changes to the managed object context.
	if([moContext save:&error]){
        
	}
    [self printDatabase];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //Used for debugging.
- (void) printDatabase {
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"QFile"
                                              inManagedObjectContext:moContext];
	[fetchRequest setEntity: entity];
	NSArray *fetchedObjects = [moContext executeFetchRequest:fetchRequest error:&error];
	if([fetchedObjects count] == 0) NSLog(@"empty");
	for(NSManagedObject *info in fetchedObjects) {
		NSLog(@"Title: %@", [info valueForKey:@"title"]);
		NSLog(@"Question Names: %@", [info valueForKey:@"questionNames"]);
        NSNumber *temp = [info valueForKey:@"rangeLowerBound"];
        NSLog(@"lower: %d", [temp intValue]);
	}
	[fetchRequest release];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //When the user clicks the return key (which says next) this function is called.  It moves the user to the next field, unless they are editing the last field
-(BOOL)textFieldShouldReturn:(UITextField *)sender {
    if(sender == qtitle){
        [qtitle resignFirstResponder];
        [qmin becomeFirstResponder];
        NSLog(@"qtitle");
    }
    else if(sender == qmin){
        [qmin resignFirstResponder];
        [qmax becomeFirstResponder];
        NSLog(@"qmin");
    }
    else if(sender == qmax){
        [qmax resignFirstResponder];
        [qst1 becomeFirstResponder];
        NSLog(@"qmax");
    }
    
    
    
    else if(sender == qst1){
        [qst1 resignFirstResponder];
        [mnl1 becomeFirstResponder];
        NSLog(@"qst1");
    }
    else if(sender == mnl1){
        [mnl1 resignFirstResponder];
        [mxl1 becomeFirstResponder];
        NSLog(@"mnl1");
    }
    else if(sender == mxl1){
        [mxl1 resignFirstResponder];
        [qst2 becomeFirstResponder];
        NSLog(@"mxl1");
    }
    
    
    else if(sender == qst2){
        [qst2 resignFirstResponder];
        [mnl2 becomeFirstResponder];
        NSLog(@"qst2");
    }
    else if(sender == mnl2){
        [mnl2 resignFirstResponder];
        [mxl2 becomeFirstResponder];
        NSLog(@"mnl2");
    }
    else if(sender == mxl2){
        [mxl2 resignFirstResponder];
        [qst3 becomeFirstResponder];
        NSLog(@"mxl2");
    }
    
    
    else if(sender == qst3){
        [qst3 resignFirstResponder];
        [mnl3 becomeFirstResponder];
        NSLog(@"qst3");
    }
    else if(sender == mnl3){
        [mnl3 resignFirstResponder];
        [mxl3 becomeFirstResponder];
        NSLog(@"mnl3");
    }
    else if(sender == mxl3){
        [mxl3 resignFirstResponder];
        [qst4 becomeFirstResponder];
        NSLog(@"mxl3");
    }
    
    
    else if(sender == qst4){
        [qst4 resignFirstResponder];
        [mnl4 becomeFirstResponder];
        NSLog(@"qst4");
    }
    else if(sender == mnl4){
        [mnl4 resignFirstResponder];
        [mxl4 becomeFirstResponder];
        NSLog(@"mnl4");
    }
    else if(sender == mxl4){
        [mxl4 resignFirstResponder];
        [qst5 becomeFirstResponder];
        NSLog(@"mxl4");
    }
    
    
    else if(sender == qst5){
        [qst5 resignFirstResponder];
        [mnl5 becomeFirstResponder];
        NSLog(@"qst5");
    }
    else if(sender == mnl5){
        [mnl5 resignFirstResponder];
        [mxl5 becomeFirstResponder];
        NSLog(@"mnl5");
    }
    else if(sender == mxl5){
        [mxl5 resignFirstResponder];
        [qst6 becomeFirstResponder];
        NSLog(@"mxl5");
    }
    
    
    else if(sender == qst6){
        [qst6 resignFirstResponder];
        [mnl6 becomeFirstResponder];
        NSLog(@"qst6");
    }
    else if(sender == mnl6){
        [mnl6 resignFirstResponder];
        [mxl6 becomeFirstResponder];
        NSLog(@"mnl6");
    }
    else if(sender == mxl6){
        [mxl6 resignFirstResponder];
        [qst7 becomeFirstResponder];
        NSLog(@"mxl6");
    }
    
    
    else if(sender == qst7){
        [qst7 resignFirstResponder];
        [mnl7 becomeFirstResponder];
        NSLog(@"qst7");
    }
    else if(sender == mnl7){
        [mnl7 resignFirstResponder];
        [mxl7 becomeFirstResponder];
        NSLog(@"mnl7");
    }
    else if(sender == mxl7){
        [mxl7 resignFirstResponder];
        [qst8 becomeFirstResponder];
        NSLog(@"mxl7");
    }
    
    
    else if(sender == qst8){
        [qst8 resignFirstResponder];
        [mnl8 becomeFirstResponder];
        NSLog(@"qst8");
    }
    else if(sender == mnl8){
        [mnl8 resignFirstResponder];
        [mxl8 becomeFirstResponder];
        NSLog(@"mnl8");
    }
    else if(sender == mxl8){
        [mxl8 resignFirstResponder];
        [qst9 becomeFirstResponder];
        NSLog(@"mxl8");
    }
    
    
    else if(sender == qst9){
        [qst9 resignFirstResponder];
        [mnl9 becomeFirstResponder];
        NSLog(@"qst9");
    }
    else if(sender == mnl9){
        [mnl9 resignFirstResponder];
        [mxl9 becomeFirstResponder];
        NSLog(@"mnl9");
    }
    else if(sender == mxl9){
        [mxl9 resignFirstResponder];
        NSLog(@"mxl9");
    }
    return YES;
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //This function shrinks the view to fit the screen when the keyboard is visible.
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Code for animation
    [UIView beginAnimations:@"Move" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    //The new size the view has to be when the keyboard shows
    settings.frame = CGRectMake(0, 44, 320, 200);
    [UIView commitAnimations];
    
    //Now scroll the view to the proper location for the textField
    [settings setContentOffset:CGPointMake(0, textField.frame.origin.y - 20) animated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //This function returns the view to its original size when the keyboard hides
-(void)textFieldDidEndEditing:(UITextField *)textField {
    settings.frame = CGRectMake(0, 44, 320, 416);
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //this function checks for errors and handles them by either dismissing the view or showing the user the error
-(IBAction)done{
    if(([[qst1 text] length] != 0) || ([[mnl1 text] length] != 0) || ([[mxl1 text] length] != 0)){
        qcount = 1;
        if(([[qst2 text] length] != 0) || ([[mnl2 text] length] != 0) || ([[mxl2 text] length] != 0)){
            qcount = 2;
            if(([[qst3 text] length] != 0) || ([[mnl3 text] length] != 0) || ([[mxl3 text] length] != 0)){
                qcount = 3;
                if(([[qst4 text] length] != 0) || ([[mnl4 text] length] != 0) || ([[mxl4 text] length] != 0)){
                    qcount = 4;
                    if(([[qst5 text] length] != 0) || ([[mnl5 text] length] != 0) || ([[mxl5 text] length] != 0)){
                        qcount = 5;
                        if(([[qst6 text] length] != 0) || ([[mnl6 text] length] != 0) || ([[mxl6 text] length] != 0)){
                            qcount = 6;
                            if(([[qst7 text] length] != 0) || ([[mnl7 text] length] != 0) || ([[mxl7 text] length] != 0)){
                                qcount = 7;
                                if(([[qst8 text] length] != 0) || ([[mnl8 text] length] != 0) || ([[mxl8 text] length] != 0)){
                                    qcount = 8;
                                    if(([[qst9 text] length] != 0) || ([[mnl9 text] length] != 0) || ([[mxl9 text] length] != 0)){
                                        qcount = 9;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    [self checkerrs]; 
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
-(void)checkerrs{
    BOOL error = NO;
    int errCnt = 0;
    NSString* errMsg = @"The following errors were found:\n";
    UIAlertView* alert;
    NSPredicate* isNumeric = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]+$'"];
    
    //These statements check the text fields that are required to be filled in.
    if([[qtitle text] length] == 0){
        errMsg = [errMsg stringByAppendingFormat:
                  @"%d. Questionnaire title cannot be empty\n", ++errCnt];
        error = YES;
    }
    if(![isNumeric evaluateWithObject:[qmin text]]){
        errMsg = [errMsg stringByAppendingFormat:
                  @"%d. Minimum data range must be an integer.\n", ++errCnt];
        error = YES;
    }
    if(![isNumeric evaluateWithObject:[qmax text]]){
        errMsg = [errMsg stringByAppendingFormat:
                  @"%d. Maximum data range must be an integer.\n", ++errCnt];
        error = YES;
    }
    
    if([[qst1 text] length] == 0){
        errMsg = [errMsg stringByAppendingFormat:@"%d. Question (one) title cannot be empty\n", ++errCnt];
        error = YES;
    }
    if([[mnl1 text] length] == 0){
        errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (one) cannot be empty.\n", ++errCnt];
        error = YES;
    }
    if([[mxl1 text] length] == 0){
        errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (one) cannot be empty.\n", ++errCnt];
        error = YES;
    }
    
    if(qcount >= 2){
        if([[qst2 text] length] == 0){
            errMsg = [errMsg stringByAppendingFormat:@"%d. Question (two) title cannot be empty\n", ++errCnt];
            error = YES;
        }
        if([[mnl2 text] length] == 0){
            errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (two) cannot be empty.\n", ++errCnt];
            error = YES;
        }
        if([[mxl2 text] length] == 0){
            errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (two) cannot be empty.\n", ++errCnt];
            error = YES;
        }
        if(qcount >= 3){
            if([[qst3 text] length] == 0){
                errMsg = [errMsg stringByAppendingFormat:@"%d. Question (three) title cannot be empty\n", ++errCnt];
                error = YES;
            }
            if([[qst3 text] length] == 0){
                errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (three) cannot be empty.\n", ++errCnt];
                error = YES;
            }
            if([[qst3 text] length] == 0){
                errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (three) cannot be empty.\n", ++errCnt];
                error = YES;
            }
            if(qcount >= 4){
                if([[qst4 text] length] == 0){
                    errMsg = [errMsg stringByAppendingFormat:@"%d. Question (four) title cannot be empty\n", ++errCnt];
                    error = YES;
                }
                if([[qst4 text] length] == 0){
                    errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (four) cannot be empty.\n", ++errCnt];
                    error = YES;
                }
                if([[qst4 text] length] == 0){
                    errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (four) cannot be empty.\n", ++errCnt];
                    error = YES;
                }
                if(qcount >= 5){
                    if([[qst5 text] length] == 0){
                        errMsg = [errMsg stringByAppendingFormat:@"%d. Question (five) title cannot be empty\n", ++errCnt];
                        error = YES;
                    }
                    if([[qst5 text] length] == 0){
                        errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (five) cannot be empty.\n", ++errCnt];
                        error = YES;
                    }
                    if([[qst5 text] length] == 0){
                        errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (five) cannot be empty.\n", ++errCnt];
                        error = YES;
                    }
                    if(qcount >= 6){
                        if([[qst6 text] length] == 0){
                            errMsg = [errMsg stringByAppendingFormat:@"%d. Question (six) title cannot be empty\n", ++errCnt];
                            error = YES;
                        }
                        if([[qst6 text] length] == 0){
                            errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (six) cannot be empty.\n", ++errCnt];
                            error = YES;
                        }
                        if([[qst6 text] length] == 0){
                            errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (six) cannot be empty.\n", ++errCnt];
                            error = YES;
                        }
                        if(qcount >= 7){
                            if([[qst7 text] length] == 0){
                                errMsg = [errMsg stringByAppendingFormat:@"%d. Question (seven) title cannot be empty\n", ++errCnt];
                                error = YES;
                            }
                            if([[qst7 text] length] == 0){
                                errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (seven) cannot be empty.\n", ++errCnt];
                                error = YES;
                            }
                            if([[qst7 text] length] == 0){
                                errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (seven) cannot be empty.\n", ++errCnt];
                                error = YES;
                            }
                            if(qcount >= 8){
                                if([[qst8 text] length] == 0){
                                    errMsg = [errMsg stringByAppendingFormat:@"%d. Question (eight) title cannot be empty\n", ++errCnt];
                                    error = YES;
                                }
                                if([[qst8 text] length] == 0){
                                    errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (eight) cannot be empty.\n", ++errCnt];
                                    error = YES;
                                }
                                if([[qst8 text] length] == 0){
                                    errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (eight) cannot be empty.\n", ++errCnt];
                                    error = YES;
                                }
                                if(qcount >= 9){
                                    if([[qst9 text] length] == 0){
                                        errMsg = [errMsg stringByAppendingFormat:@"%d. Question (nine) title cannot be empty\n", ++errCnt];
                                        error = YES;
                                    }
                                    if([[qst9 text] length] == 0){
                                        errMsg = [errMsg stringByAppendingFormat:@"%d. Minimum label (nine) cannot be empty.\n", ++errCnt];
                                        error = YES;
                                    }
                                    if([[qst9 text] length] == 0){
                                        errMsg = [errMsg stringByAppendingFormat:@"%d. Maximum label (nine) cannot be empty.\n", ++errCnt];
                                        error = YES;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //If an error was found, an alert is presented with error details and return.
    if(error){
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    
    
    [self resignFirstResponder];
    //this creates the string to be parsed and put in the coredata
    ps = [NSMutableString stringWithFormat:@"TITLE %@\n\nQUESTIONS_PER_FRAME%u\n\nRANGE %u %u\n\nRANGE_INCREMENT 1\n\nQUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qtitle text], qcount, [[qmin text] intValue], [[qmax text] intValue], [qst1 text], [mnl1 text], [mxl1 text]];
    if(qcount >= 2){
        [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qst2 text], [mnl2 text], [mxl2 text]]];
        if(qcount >= 3){
            [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qst3 text], [mnl3 text], [mxl3 text]]];
            if(qcount >= 4){
                [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qst4 text], [mnl4 text], [mxl4 text]]];
                if(qcount >= 5){
                    [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qst5 text], [mnl5 text], [mxl5 text]]];
                    if(qcount >= 6){
                        [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qst6 text], [mnl6 text], [mxl6 text]]];
                        if(qcount >= 7){
                            [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qst7 text], [mnl7 text], [mxl7 text]]];
                            if(qcount >= 8){
                                [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qst8 text], [mnl8 text], [mxl8 text]]];
                                if(qcount >= 9){
                                    [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [qst9 text], [mnl9 text], [mxl9 text]]];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    [self parseQFile];
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"ps: %@", ps);
    NSLog(@"done");
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //If the user cancels, we just dismiss the view controller without saving anything. that's all, nothing to see here.  but really...
-(IBAction)cancel{
    [self dismissModalViewControllerAnimated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


///////////////////////////////////////////////////////////////////////////////////////////
    //this displays an explanation in an alert if the user clicks the "i" next to data range
-(IBAction)rangeInfo{
    UIAlertView *info;
    info = [[UIAlertView alloc] initWithTitle:@"Info" message:@"When you use the questionnaire, a slider will appear for data collection.  Specify the minimum and maximum values for the slider." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [info show];
    [info release];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

///////////////////////////////////////////////////////////////////////////////////////////
-(BOOL)canBecomeFirstResponder{
    return YES;
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



@end

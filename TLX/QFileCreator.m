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
@synthesize qcount;

@synthesize moContext,qTitle ,numOfQuestions, range, rangeIncrement, questionNames, lowLabelNames,qFileString;
@synthesize highLabelNames, questionName, qLowLabel, qHighLabel, questionNum,lowRange, highRange, rangeInc, scanner;

int qcount;


///////////////////////////////////////////////////////////////////////////////////////////
    //When the view loads we update the scroll view dimensions.
- (void)viewDidLoad {
	[super viewDidLoad];
    [self becomeFirstResponder];
    self.title = @"New Questionnaire";
    settings.frame = CGRectMake(0, 44, 320, 416);
    settings.contentSize = CGSizeMake(320, 417);
    [self.view addSubview:settings];
    [self addQuestion];
    // Initialize question array
    questions = [[NSMutableArray alloc] init];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //This function handles the action when the user selects the "Add Question" button I've only commented one of the initializations, because it's quite repetitive
-(IBAction)addQuestion{
    NSLog(@"addQuestion");
    
    // TODO: fix magic numbers (110 is the height above the first question, 90 is the height of a question object)
    QuestionFields *question = [[QuestionFields alloc] initAtPos:20 y:110+90*[questions count]];
    [questions addObject:question];
    
    [question setSuperview:settings];
    
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
    question.question.alpha = 1.0;
    question.lowLabel.alpha = 1.0;
    question.highLabel.alpha = 1.0;
    [UIView commitAnimations];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //This function handles the action when the user selects the "Add Question" button
-(IBAction)removeQuestion{
    if([questions count]==1)
    {
        return;
    }
    [UIView beginAnimations:@"Move" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // Delete the QuestionFields
    [questions removeLastObject];
    
    //change the size of the scrollview and move the buttons accordingly
    settings.contentSize = CGSizeMake(settings.contentSize.width, settings.contentSize.height-90);
    if([questions count]==1)
    {
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 280, 40);
        removeButton.alpha = 0.0;
    }
    else
    {
        removeButton.frame = CGRectMake(170, removeButton.frame.origin.y-90, 130, 40);
        addButton.frame = CGRectMake(20, addButton.frame.origin.y-90, 130, 40);
        removeButton.alpha = 1.0;
    }
    [UIView commitAnimations];
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
    //if(([[qst1 text] length] != 0) || ([[mnl1 text] length] != 0) || ([[mxl1 text] length] != 0)){
    //    qcount = 1;
    //}
    //[self checkerrs];
    
    [self resignFirstResponder];
    [self parseQFile];
    [self dismissModalViewControllerAnimated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



/*
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
*/



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
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



@end

@implementation QuestionFields

@synthesize question,lowLabel,highLabel;

-(id)initAtPos:(int)x y:(int)y
{
    if (self = [super init])
    {
        //allocate memory, initialize, and set the frame
        question = [[UITextField alloc] initWithFrame: CGRectMake(x, y, 280, 31)];
        
        //set up style
        question.borderStyle = UITextBorderStyleRoundedRect;
		question.textColor = [UIColor blackColor];
		question.font = [UIFont systemFontOfSize:14.0];
        
        //this shows up "grayed out" before editing begins, almost like... a placeholder!
		question.placeholder = @"Question two title";
        
        //delicious background color
        // TODO: change this to be the owner's background color
		question.backgroundColor = [UIColor whiteColor];
        
        //this aligns the text so it's not flying up top or sinking at the bottom
        question.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //the return key says "next" and, when clicked, goes to the next field
        question.returnKeyType = UIReturnKeyNext;
        
        //this automaticaly capitalizes the first word of each sentence
        question.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        
        //The alpha is set to 0 for a fade-in animation
        question.alpha = 0.0;
        
        //the delegate has to be set to this controller so that when the "Next" (return) key is pressed, we recognize it
        question.delegate = self;
        
        // Make sure the view resizes properly
        question.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
        
        lowLabel = [[UITextField alloc] initWithFrame: CGRectMake(x, y+39, 130, 31)];
        lowLabel.alpha = 0.0;
        lowLabel.delegate = self;
        lowLabel.borderStyle = UITextBorderStyleRoundedRect;
		lowLabel.textColor = [UIColor blackColor];
		lowLabel.font = [UIFont systemFontOfSize:14.0];
		lowLabel.placeholder = @"Minimum label";
		lowLabel.backgroundColor = [UIColor whiteColor];
        lowLabel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        lowLabel.returnKeyType = UIReturnKeyNext;
        lowLabel.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        lowLabel.alpha = 0.0;
        lowLabel.delegate = self;
        lowLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleWidth;
        
        highLabel = [[UITextField alloc] initWithFrame: CGRectMake(x+150, y+39, 130, 31)];
        highLabel.alpha = 0.0;
        highLabel.delegate = self;
        highLabel.borderStyle = UITextBorderStyleRoundedRect;
		highLabel.textColor = [UIColor blackColor];
		highLabel.font = [UIFont systemFontOfSize:14.0];
		highLabel.placeholder = @"Maximum label";
		highLabel.backgroundColor = [UIColor whiteColor];
        highLabel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        highLabel.returnKeyType = UIReturnKeyDone;
        highLabel.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        highLabel.alpha = 0.0;
        highLabel.delegate = self;
        highLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

-(void)release
{
    //get rid of the text fields
    [question removeFromSuperview];
    [lowLabel removeFromSuperview];
    [highLabel removeFromSuperview];
    
    [question release];
    [lowLabel release];
    [highLabel release];
    [super release];
    
}

-(void)setSuperview:(UIView*)view
{
    
    //all the subviews have to be added to the scrollview
    [view addSubview:question];
    [view addSubview:lowLabel];
    [view addSubview:highLabel];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

//When the user clicks the return key (which says next) this function is called.  It moves the user to the next field, unless they are editing the last field
-(BOOL)textFieldShouldReturn:(UITextField *)sender {
    [sender resignFirstResponder];
    if(sender == question)
    {
        [lowLabel becomeFirstResponder];
    }
    else if(sender == lowLabel)
    {
        [highLabel becomeFirstResponder];
    }
    return YES;
}

//This function shrinks the view to fit the screen when the keyboard is visible.
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Code for animation
    //[UIView beginAnimations:@"Move" context:nil];
    //[UIView setAnimationDuration:.3];
    //[UIView setAnimationBeginsFromCurrentState:YES];
    //The new size the view has to be when the keyboard shows
    //settings.frame = CGRectMake(0, 44, 320, 200);
    //[UIView commitAnimations];
    
    //Now scroll the view to the proper location for the textField
    //[settings setContentOffset:CGPointMake(0, textField.frame.origin.y - 20) animated:YES];
}

@end

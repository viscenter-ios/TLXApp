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
@synthesize activeField, settings;

int qcount;


///////////////////////////////////////////////////////////////////////////////////////////
    //When the view loads we update the scroll view dimensions.
- (void)viewDidLoad {
	[super viewDidLoad];
    [self becomeFirstResponder];
    self.title = @"New Questionnaire";
    [self.view addSubview:settings];
    [self.view layoutIfNeeded];
    needsSaved = YES;
    
    // Initialize question array
    questions = [[NSMutableArray alloc] init];
    [self addQuestion];
    
    // Make keyboard close correctly
    [self registerForKeyboardNotifications];
    [qtitle setDelegate:self];
    [qmin setDelegate:self];
    [qmax setDelegate:self];
    
}

-(void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self setActiveField:textField];
    return YES;
}

-(void)keyboardWasShown:(NSNotification*)aNotification;
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    settings.contentInset = contentInsets;
    settings.scrollIndicatorInsets = contentInsets;
    
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = settings.frame;
    CGPoint aPt  = [settings convertPoint:activeField.frame.origin toView:self.view];
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, aPt) ) {
        CGPoint scrollPoint = CGPointMake(0.0, aPt.y-kbSize.height);
        [settings setContentOffset:scrollPoint animated:YES];
    }
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    settings.contentInset = contentInsets;
    settings.scrollIndicatorInsets = contentInsets;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField == qmin) {
        [qmax becomeFirstResponder];
        [self setActiveField:qmax];
    }
    else
    {
        [self setActiveField:nil];
    }
    return NO;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        return;
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////
    //This function handles the action when the user selects the "Add Question" button I've only commented one of the initializations, because it's quite repetitive
- (IBAction)addQuestion{    
    // TODO: fix magic numbers (110 is the height above the first question, 80 is the height of a question object)
    QuestionFields *question = [[QuestionFields alloc] initAtPosX: 20
                                                                Y: 110+80*[questions count]];
    [question setSuperController:self];
    [questions addObject:question];
    
    
    
    // Resize the scrollview to fit the new elements
    //settings.frame = CGRectMake(0, 44, settings.frame.size.width, settings.frame.size.height+80);
    settings.contentSize = CGSizeMake(settings.contentSize.width, 30+110+[questions count]*80);
    
    // Manage the add and remove buttons
    if([questions count]==1)
    {
        float contentWidth = [settings frame].size.width-2*20;
        float halfWidth = (contentWidth-20.0)/2;
        float spacerWidth = 20.0;
        
        
        
        [[question question] setFrame:CGRectMake(addButton.frame.origin.x,
                                                 addButton.frame.origin.y,
                                                 contentWidth,
                                                 30)];
        [[question lowLabel] setFrame:CGRectMake(addButton.frame.origin.x,
                                                 addButton.frame.origin.y+40,
                                                 halfWidth,
                                                 30)];
        [[question highLabel] setFrame:CGRectMake(removeButton.frame.origin.x,
                                                  addButton.frame.origin.y+40,
                                                  halfWidth,
                                                  30)];
        addButton.frame = CGRectMake(20,
                             addButton.frame.origin.y+80,
                             contentWidth,
                             40);
        removeButton.frame = CGRectMake(20+halfWidth+spacerWidth,
                                        removeButton.frame.origin.y+80,
                                        halfWidth,
                                        40);
        question.question.alpha = 1.0;
        question.lowLabel.alpha = 1.0;
        question.highLabel.alpha = 1.0;
    }
    else
    {
        QuestionFields *question0 = [questions objectAtIndex:0];
        int count = [questions count]-1;
        [[question question] setFrame:CGRectMake(question0.question.frame.origin.x,
                                                 question0.question.frame.origin.y+80*count,
                                                 question0.question.frame.size.width,
                                                 question0.question.frame.size.height)];
        [[question lowLabel] setFrame:CGRectMake(question0.lowLabel.frame.origin.x,
                                                 question0.lowLabel.frame.origin.y+80*count,
                                                 question0.lowLabel.frame.size.width,
                                                 question0.lowLabel.frame.size.height)];
        [[question highLabel] setFrame:CGRectMake(question0.highLabel.frame.origin.x,
                                                  question0.highLabel.frame.origin.y+80*count,
                                                  question0.highLabel.frame.size.width,
                                                  question0.highLabel.frame.size.height)];
        
        // Start animation
        [UIView beginAnimations:@"Move" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        removeButton.alpha = 1.0;
        
        CGRect tmpFrame = [[[questions objectAtIndex:0] lowLabel] frame];
        addButton.frame = CGRectMake(tmpFrame.origin.x,
                                     tmpFrame.origin.y+40+80*count,
                                     tmpFrame.size.width,
                                     tmpFrame.size.height);
        
        tmpFrame = [[[questions objectAtIndex:0] highLabel] frame];
        removeButton.frame = CGRectMake(tmpFrame.origin.x,
                                        tmpFrame.origin.y+40+80*count,
                                        tmpFrame.size.width,
                                        tmpFrame.size.height);
        //fade in all the textfields
        question.question.alpha = 1.0;
        question.lowLabel.alpha = 1.0;
        question.highLabel.alpha = 1.0;
        [UIView commitAnimations];
    }
    

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
    //settings.frame = CGRectMake(0, 44, settings.frame.size.width, settings.frame.size.height-80);
    settings.contentSize = CGSizeMake(settings.contentSize.width, 40+110+[questions count]*80);
    
    int count = [questions count]-1;
    
    CGRect tmpFrame = [[[questions objectAtIndex:0] lowLabel] frame];
    if([questions count]==1)
    {
        addButton.frame = CGRectMake(tmpFrame.origin.x,
                                     tmpFrame.origin.y+40+80*count,
                                     [[questions objectAtIndex:0] question].frame.size.width,
                                     tmpFrame.size.height);
        removeButton.alpha = 0.0;
    }
    else
    {
        addButton.frame = CGRectMake(tmpFrame.origin.x,
                                     tmpFrame.origin.y+40+80*count,
                                     tmpFrame.size.width,
                                     tmpFrame.size.height);
        removeButton.alpha = 1.0;
    }
    
    
    tmpFrame = [[[questions objectAtIndex:0] highLabel] frame];
    removeButton.frame = CGRectMake(tmpFrame.origin.x,
                                    tmpFrame.origin.y+40+80*count,
                                    tmpFrame.size.width,
                                    tmpFrame.size.height);
    
    [UIView commitAnimations];  

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



-(NSMutableString *)getQString{
    
    //this creates the string to be parsed and put in the coredata
    NSMutableString *ps = [NSMutableString stringWithFormat:@"TITLE %@\n\nQUESTIONS_PER_FRAME%u\n\nRANGE %u %u\n\nRANGE_INCREMENT 1\n\n", [qtitle text], [questions count], [[qmin text] intValue], [[qmax text] intValue]];
    for(int i=0; i<[questions count]; i++)
    {
        QuestionFields *qf = [questions objectAtIndex:i];
        [ps appendString:[NSString stringWithFormat:@"QUESTION %@\n\nRANGE_MIN_LABEL %@\n\nRANGE_MAX_LABEL %@\n\n", [[qf question] text], [[qf lowLabel] text], [[qf highLabel] text]]];
    }
    return ps;
}



///////////////////////////////////////////////////////////////////////////////////////////
//This function uses the NSScanner class to parse the question file provided and extract the necessary information. I had some issue with memory management in this function,so it is a bit longer than I had hoped.
-(void)parseQString: (NSMutableString *)qString {
    scanner = [NSScanner scannerWithString:qString];
    
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
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
//This Function saves the information into coredata under the propery keys. See the DynamicFormVC for more information.
-(void) writeQString {
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
	if(![moContext save:&error]){
        
	}
    [self printDatabase];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



///////////////////////////////////////////////////////////////////////////////////////////
    //this function checks for errors and handles them by either dismissing the view or showing the user the error
-(IBAction)save{
    //if(([[qst1 text] length] != 0) || ([[mnl1 text] length] != 0) || ([[mxl1 text] length] != 0)){
    //    qcount = 1;
    //}
    //[self checkerrs];
    
    
    UIAlertView* alert;
    if(![self isComplete]){
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All questions must be filled out." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [alert release];
        return;
    }
    [self parseQString:[self getQString]];
    [self writeQString];
    //[self resignFirstResponder];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Questionnaire saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    [alert show];
    [alert release];
    needsSaved = NO;
    return;
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



-(BOOL)isComplete{
    NSPredicate* isNumeric = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]+$'"];
    
    if([[qtitle text] length] <= 0)
    {
        return NO;
    }
    if(![isNumeric evaluateWithObject:[qmin text]])
    {
        return NO;
    }
    if(![isNumeric evaluateWithObject:[qmax text]])
    {
        return NO;
    }
    for(int i=0; i<[questions count]; i++)
    {
        if(![[questions objectAtIndex:i ] isComplete])
        {
            return NO;
        }
    }
    return YES;
}

/*
    //If an error was found, an alert is presented with error details and return.
    if(error){
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
*/


///////////////////////////////////////////////////////////////////////////////////////////
    //If the user cancels, we just dismiss the view controller without saving anything. that's all, nothing to see here.  but really...
-(IBAction) done
{
    if(needsSaved)
    {
        UIAlertView *info;
        info = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You have not saved your questionnaire. Exit Anyway?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [info show];
        [info release];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


///////////////////////////////////////////////////////////////////////////////////////////
    //this displays an explanation in an alert if the user clicks the "i" next to data range
-(IBAction)rangeInfo{
    UIAlertView *info;
    info = [[UIAlertView alloc] initWithTitle:@"Info" message:@"When you use the questionnaire, a slider will appear for data collection.  Specify the minimum and maximum values for the slider." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [info show];
    [info release];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


@end

@implementation QuestionFields

@synthesize question,lowLabel,highLabel,x,y;

-(id)initAtPosX:(int)x Y:(int)y
{
    if (self = [super init])
    {
        [self setX:x];
        [self setY:y];
        
        //allocate memory, initialize
        question = [[UITextField alloc] init];
        
        //set up style
        question.borderStyle = UITextBorderStyleRoundedRect;
		question.textColor = [UIColor blackColor];
		question.font = [UIFont systemFontOfSize:14.0];
        
        //this shows up "grayed out" before editing begins, almost like... a placeholder!
		question.placeholder = @"Question title";
        
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
        
        lowLabel = [[UITextField alloc] init];
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
        
        highLabel = [[UITextField alloc] init];
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

-(void)setSuperController:(QFileCreator*)qfc
{
    
    superController = qfc;
    //all the subviews have to be added to the scrollview
    [[qfc settings] addSubview:question];
    [[qfc settings] addSubview:lowLabel];
    [[qfc settings] addSubview:highLabel];
    
    // Magic numbers again @_@
    /*int contentWidth = [view frame].size.width-2*x;
    int halfWidth = contentWidth*(130.0/280.0);
    int spacerWidth = contentWidth*(20.0/280.0);
    [question setFrame:CGRectMake(x, y, contentWidth, 30)];
    [lowLabel setFrame:CGRectMake(x, y+40, halfWidth, 30)];
    [highLabel setFrame:CGRectMake(x+halfWidth+spacerWidth, y+40, halfWidth, 30)];
    */
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [superController setActiveField:textField];
    return YES;
}
    /*
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:owner];
    pt = rc.origin;
    pt.x = 0;
    
    if(textField == question)
    {
        pt.y -= 40;
    }
    else
    {
        pt.y -= 80;
    }
    
    if([owner contentOffset].y != pt.y )
    {
        [owner setContentOffset:pt animated:NO];
    }*/

// When the user clicks the return key (which says next) this function is called.
// It moves the user to the next field, unless they are editing the last field
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(textField == question)
    {
        [superController setActiveField:lowLabel];
        [lowLabel becomeFirstResponder];
    }
    else if(textField == lowLabel)
    {
        [superController setActiveField:highLabel];
        [highLabel becomeFirstResponder];
    }
    [superController setActiveField:nil];
    return YES;
}

-(BOOL)isComplete{
    if([[question text] length] <= 0)
    {
        return NO;
    }
    if([[lowLabel text] length] <= 0)
    {
        return NO;
    }
    if([[highLabel text] length] <= 0)
    {
        return NO;
    }
    return YES;
}
@end

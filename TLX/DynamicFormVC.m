//
//  DynamicFormVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/8/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "DynamicFormVC.h"


@implementation DynamicFormVC
@synthesize scrollView, subjectLabel,trialText, addInfoText, fileName, subjectName, moContext;
@synthesize questionFileName, questionLabels, lowLabels, highLabels,sliderBars;
@synthesize numOfQuestions, rangeIncrement, lowRangeBound, highRangeBound;
////////////////////////////////////////////////////////////////////////////////
//Here we initialize some necessary values and set the size of the scrollview.
- (void)viewDidLoad
{
  [super viewDidLoad];
  int QUESTION_SIZE = 60;
  scrollViewHeight = [numOfQuestions intValue] * QUESTION_SIZE;
  scrollViewWidth = 320;
  [self.navigationController setNavigationBarHidden:YES];
  [scrollView setContentSize:CGSizeMake(scrollViewWidth,scrollViewHeight)];
  [self generateForm];
}
////////////////////////////////////////////////////////////////////////////////
//This function generates the labels and slider bars contained in the scrollview
//of this VC.
-(void) generateForm
{
  [self setSliderBars:[[NSArray alloc] init]];
  UIFont *questionFont = [UIFont fontWithName:@"Arial" size:17.0];
  UIFont *labelFont = [UIFont fontWithName:@"Arial" size:12.0];
  
  UIView *tempView = 
  [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, scrollViewWidth, scrollViewHeight)];
  [tempView setBackgroundColor:[UIColor greenColor]];
  for(int i = 0; i < [numOfQuestions intValue]; ++i){
    CGRect qLabelFrame = CGRectMake(20.0, 0.0 + i*60, 284.0, 17.0);
    CGRect sliderFrame = CGRectMake(18.0, 36.0 + i*60, 284.0, 23.0);
    CGRect lowLabelFrame = CGRectMake(20.0, 18.0 + i*60, 284.0, 17.0);
    CGRect highLabelFrame = CGRectMake(272.0, 18.0 + i*60, 284.0, 17.0);
    
    [scrollView addSubview:
     [self makeLabelWithText:[questionLabels objectAtIndex:i]
                    withRect:qLabelFrame
                    withFont:questionFont ]];
    
    [scrollView addSubview:
     [self makeLabelWithText:[lowLabels objectAtIndex:i]
                    withRect:lowLabelFrame 
                    withFont:labelFont ]];
    
    [scrollView addSubview:
     [self makeLabelWithText:[highLabels objectAtIndex:i]
                    withRect:highLabelFrame 
                    withFont:labelFont ]];
    
    UISlider *tempSlider = [[UISlider alloc] initWithFrame:sliderFrame];
    [tempSlider setMaximumValue:[highRangeBound floatValue]/[rangeIncrement intValue]];
    [tempSlider setMinimumValue:[lowRangeBound floatValue]/[rangeIncrement intValue]];
    [tempSlider setValue:
     ([highRangeBound floatValue] + [lowRangeBound floatValue])/
     (2 * [rangeIncrement intValue]) ];
    [tempSlider setContinuous:NO];
    [tempSlider addTarget:self action:@selector(updateSlider:)forControlEvents:UIControlEventTouchUpInside];
    
    [self setSliderBars: [sliderBars arrayByAddingObject:tempSlider]];
    [self updateSlider:tempSlider];
    [scrollView addSubview:tempSlider];
  }
  //[scrollView addSubview:tempView];
}
-(UILabel *) makeLabelWithText: (NSString *)s withRect:(CGRect) rect withFont: (UIFont *) f
{
  UILabel *tempLabel = [[UILabel alloc] initWithFrame:rect];
  [tempLabel setText:s];
  [tempLabel setBackgroundColor:[UIColor clearColor]];
  [tempLabel setFont:f];
  
  return tempLabel;
}

////////////////////////////////////////////////////////////////////////////////
//This function resets all values of the slider bars back to their start value
//and moves the scroll view back to the top of the form.
-(void) resetAndUpdateState
{
  for (UISlider *s in sliderBars) {
    [s setValue:
     ([highRangeBound floatValue] + [lowRangeBound floatValue])/
     (2 * [rangeIncrement intValue]) ];
    [self updateSlider:s];
  }
  int newTrialID = [[trialText text] intValue] + 1;
  [trialText setText:[NSString stringWithFormat:@"%d", newTrialID]];
  [scrollView setContentOffset:CGPointZero];
}
////////////////////////////////////////////////////////////////////////////////
//This function makes sure the trial id is not empty and an integer, then saves
//the data and resets the form.
-(IBAction) nextEntry
{
  BOOL error = NO;
  int errCnt = 0;
  NSString* errMsg = @"The following errors were found:\n";
  UIAlertView* alert;
  NSPredicate* isNumeric = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]+$'"];
  
  //These statements check the text fields that are required to be filled in.
  if([[trialText text] length] == 0){
    errMsg = [errMsg stringByAppendingFormat:
              @"%d. Trial ID cannot be empty\n", ++errCnt];
    error = YES;
  }
  if(![isNumeric evaluateWithObject:[trialText text]]){
    errMsg = [errMsg stringByAppendingFormat:
              @"%d. Trial ID must be an integer.\n", ++errCnt];
    error = YES;
  }
  
  //If an error was found, an alert is presented with error details and return.
  if(error){
    alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    return;
  }

  [self saveData];
  [self resetAndUpdateState];
}
////////////////////////////////////////////////////////////////////////////////
//Resigns the keyboard when it is no longer needed.
- (IBAction)hideKeyboard: (UITextField*)text {
	[text resignFirstResponder];
}
////////////////////////////////////////////////////////////////////////////////
//Pop back to the main menu.
-(IBAction) goToMainMenu
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}
////////////////////////////////////////////////////////////////////////////////
//Update the slider values so that when released they are always on an integer.
-(IBAction) updateSlider: (UISlider *) slider
{
  slider.value = floorf([slider value]);
}
////////////////////////////////////////////////////////////////////////////////
//This function saves the collected data under the fileName variable into the 
//database. This code was taken from iProd2, so some of the comments may be
//redundant if you are familiar with it.
-(void) saveData
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
  NSString *dateString = [formatter stringFromDate:[NSDate date]];	
  
  NSString *data = [self getDataString];
  if(fileName == nil)
  {
    [self setFileName:[NSString stringWithFormat:@"%@-%@.csv", subjectName, dateString]];
  }
  NSError *error;
	NSLog(@"%@",fileName);
  //The predicate is what core data is queried with. In this case we are looking under
  //the expName attribute for any entries that match the experiment name entered in
  //the previous view.
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fileName matches %@)", fileName];
  //The entity is the model in core data that we are looking inside. We pass it the
  //managed object context that was created inside the app delegate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Experiment" inManagedObjectContext:moContext];
  //We create an NSFetchRequest, set its entity and predicate and finally store the
  //the results inside an NSArray.
  if(entity == nil) NSLog(@"no entity");
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entity];
	[request setPredicate:predicate];
	NSArray *fetchedObjects = [moContext executeFetchRequest:request error:&error];
  //If we did not get any results from our fetch, we make a new entry
	if([fetchedObjects count] < 1){
		//This is the header for the csv file and what every data string should begin with
    //inside the experiment entry. The data is concatenated to the end of the header 
    //since this will be the first entry.
    
		NSString *header = [self getHeader];
    header = [header stringByAppendingFormat:@"%@", data];
    //Create a managed object to hold the new information under the current experiments
    //name.
		NSManagedObject *experimentObj = [NSEntityDescription insertNewObjectForEntityForName:@"Experiment" inManagedObjectContext:moContext];
		[experimentObj setValue:fileName forKey:@"fileName"];
		[experimentObj setValue:header forKey:@"dataString"];
    [experimentObj setValue:[NSNumber numberWithInt:[[trialText text] integerValue]] forKey:@"lastTrial"];
    [experimentObj setValue:questionFileName forKey:@"qFileName"];
	}
	else{
    //If an entry exist for the given experiment name we simply use a for each loop to
    //concatenate the data onto the end of the dataString attribute.
		for(NSManagedObject *info in fetchedObjects){
			NSString *temp = [info valueForKey:@"dataString"];
			NSString *newData = [NSString stringWithFormat:@"%@%@", temp, data];
			[info setValue:newData forKey:@"dataString"];
		}
	}
  
  //Finally, we save our changes to the managed object context.
	if([moContext save:&error]){
    
	}
  //[self printDatabase];
}

////////////////////////////////////////////////////////////////////////////////
//Function to generate the header of the csv file. Iterates through the question
//names in order and appends them.
-(NSString *) getHeader{
  
  NSString *temp = @"Subject,Trial,AddInfo,Date,";
  for (NSString *t in questionLabels) {
    temp = [temp stringByAppendingFormat:@"%@,", t];
  }
  temp = [temp stringByAppendingFormat:@"\n"];
  NSLog(@"Header: %@", temp);
  return temp;
}


////////////////////////////////////////////////////////////////////////////////
//Function to generate the data when saving. Iterates through the sliders in
//order and appends them to the string that is returned.
-(NSString *)getDataString{
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
  NSString *dateString = [formatter stringFromDate:[NSDate date]];	
  NSString *temp = [NSString stringWithFormat:@"%@,", subjectName];
  temp = [temp stringByAppendingFormat:@"%@,", [trialText text] ];
  temp = [temp stringByAppendingFormat:@"%@,", [addInfoText text] ];
  temp = [temp stringByAppendingFormat:@"%@,", dateString ];
  for (UISlider *s in sliderBars) {
    temp = [temp stringByAppendingFormat:@"%d,", 
            (int)[s value] * [rangeIncrement intValue]];
  }
  temp = [temp stringByAppendingFormat:@"\n"];
  NSLog(@"Data String: %@", temp);
  return temp;
}


////////////////////////////////////////////////////////////////////////////////
//Used for debugging
- (void) printDatabase {
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Experiment" inManagedObjectContext:moContext];
	[fetchRequest setEntity: entity];
	NSArray *fetchedObjects = [moContext executeFetchRequest:fetchRequest error:&error];
	if([fetchedObjects count] == 0) NSLog(@"empty");
	for(NSManagedObject *info in fetchedObjects) {
		NSLog(@"Filename: %@", [info valueForKey:@"fileName"]);
		NSLog(@"Data: %@", [info valueForKey:@"dataString"]);
	}
	[fetchRequest release];
}
////////////////////////////////////////////////////////////////////////////////
//Sets the NSString of the Subject label, rather than the generated setter from
//@synthesize
-(void) setSubjectLabelText: (NSString *) s
{
  [subjectLabel setText:s];
  NSLog(@"subject set to %@", s);
}
////////////////////////////////////////////////////////////////////////////////
//Similar to setSubjectLabelText:.
-(void) setTrialTextValue: (NSString *) s
{
  [trialText setText: s];
  NSLog(@"trial set to: %@", s);
}







- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  FormVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/2/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "FormVC.h"


@implementation FormVC
@synthesize temporalSlider, physicalSlider, subjectLabel, trialText, fileName, subjectName;
@synthesize addInfoText, moContext, mentalSlider, performancSlider, effortSlider;

////////////////////////////////////////////////////////////////////////////////
//
-(void) resetAndUpdateState
{
  temporalSlider.value = 10.0;
  physicalSlider.value = 10.0;
  mentalSlider.value = 10.0;
  performanceSlider.value = 10.0;
  effortSlider.value = 10.0;
  
  int newTrialID = [[trialText text] intValue] + 1;
  trialText.text = [NSString stringWithFormat:@"%d", newTrialID];
}
////////////////////////////////////////////////////////////////////////////////
//
-(IBAction) nextEntry
{
  [self saveData];
  [self resetAndUpdateState];
}
////////////////////////////////////////////////////////////////////////////////
//
-(IBAction) finishedEntry
{
  
}
////////////////////////////////////////////////////////////////////////////////
//
-(IBAction) goToMainMenu
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}
////////////////////////////////////////////////////////////////////////////////
//
-(IBAction) updateSlider: (UISlider *) slider
{
  slider.value = floorf([slider value]);
}
////////////////////////////////////////////////////////////////////////////////
//
-(void) saveData
{
  if(moContext == nil) NSLog(@"FUCK YOU JUSTIN");
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
  NSString *dateString = [formatter stringFromDate:[NSDate date]];	
  
  NSString *data = [NSString stringWithFormat:@"%@,", subjectName];
  
  data = [data stringByAppendingFormat:@"%@,", [trialText text] ];
  data = [data stringByAppendingFormat:@"%@,", [addInfoText text] ];
  data = [data stringByAppendingFormat:@"%@,", dateString ];
  data = [data stringByAppendingFormat:@"%f,", [mentalSlider value] ];
  data = [data stringByAppendingFormat:@"%f,", [physicalSlider value] ];
  data = [data stringByAppendingFormat:@"%f,", [temporalSlider value] ];
  data = [data stringByAppendingFormat:@"%f,", [effortSlider value]];
  data = [data stringByAppendingFormat:@"%f,\n", [performanceSlider value]];
  if(fileName == nil)
  {
    fileName = [NSString stringWithFormat:@"%@-%@.csv", subjectName, dateString];
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
    //Subject, Trial, ExptText, Date, Questionnaire, Mental Demand, Physical Demand, Temporal Demand, Effort, Performance,

		NSString *header = [NSString stringWithFormat:@"Subject,Trial,AddInfo,Date,Mental Demand, Physical Demand, Temporal Demand, Effort, Performance,\n%@", data];
    //Create a managed object to hold the new information under the current experiments
    //name.
		NSManagedObject *experimentObj = [NSEntityDescription insertNewObjectForEntityForName:@"Experiment" inManagedObjectContext:moContext];
		[experimentObj setValue:fileName forKey:@"fileName"];
		[experimentObj setValue:header forKey:@"dataString"];
    // NSInteger *trial = [[trialText text] integerValue]; Wasn't working
    //[experimentObj setValue:trial forKey:@"lastTrial"];
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
  [self printDatabase];
}
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
//
-(void) setSubjectLabelText: (NSString *) s
{
  [subjectLabel setText:s];
  NSLog(@"%@", s);
}
-(void) setTrialTextValue: (NSString *) s
{
  [trialText setText: s];
}
////////////////////////////////////////////////////////////////////////////////
//

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

- (void)viewDidLoad
{
  [self.navigationController setNavigationBarHidden:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

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

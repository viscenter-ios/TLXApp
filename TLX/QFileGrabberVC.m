//
//  QFileGrabberVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/8/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "QFileGrabberVC.h"
#import "TLXAppDelegate.h"

@implementation QFileGrabberVC
@synthesize moContext,qTitle ,numOfQuestions, range, rangeIncrement, questionNames, lowLabelNames,qFileString;
@synthesize highLabelNames, questionName, qLowLabel, qHighLabel, questionNum,lowRange, highRange, rangeInc, scanner;

///////////////////////////////////////////////////////////////////////////////////////////
//This function uses the NSScanner class to parse the question file provided and extract
//the necessary information. I had some issue with memory management in this function,
//so it is a bit longer than I had hoped.
-(void)parseQFile
{
  scanner = [NSScanner scannerWithString:qFileString];
  
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
///////////////////////////////////////////////////////////////////////////////////////////
//This Function saves the information into coredata under the propery keys.
//See the DynamicFormVC for more information.
-(IBAction) saveQFile
{
  if(moContext == nil)
  {
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
    
		NSManagedObject *questionObj = 
    [NSEntityDescription insertNewObjectForEntityForName:@"QFile" 
                                  inManagedObjectContext:moContext];
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
///////////////////////////////////////////////////////////////////////////////////////////
//This function downloads the file from the URL entered in the addressText box. It then
//displays the contents of the file in the textview and begins parsing the file.
-(IBAction)downloadQFile
{
  NSURL *url = [NSURL URLWithString:[addressText text]];
  [self setQFileString:[NSString stringWithContentsOfURL:url
                                         encoding:NSUTF8StringEncoding
                                            error:nil]];
  if(url){
    [textView setText:qFileString];
    [textView setEditable:NO];
    [self parseQFile];
  }
  else{
    UIAlertView *alert;
    NSString *errMsg = @"Given URL is not Valid";
    alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
  }
  
}
///////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)hideKeyboard: (UITextField*)text {
	[text resignFirstResponder];
}

-(IBAction) done
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}
///////////////////////////////////////////////////////////////////////////////////////////
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

//
//  SettingsVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/1/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "SettingsVC.h"
#import "CoreDataTableVC.h"
#import "TLXAppDelegate.h"

@implementation SettingsVC

////////////////////////////////////////////////////////////////////////////////
- (IBAction)hideKeyboard: (UITextField*)text {
	[text resignFirstResponder];
}
////////////////////////////////////////////////////////////////////////////////
//This functon initiates the transition to the next view. It first checks that 
//the text data on the page is valid, then grabs the information from the 
//selected QFile and pushes the properly initialized DynamicFormVC onto the
//stack.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
  BOOL error = NO;
  int errCnt = 0;
  NSString* errMsg = @"The following errors were found:\n";
  UIAlertView* alert;
  NSPredicate* isNumeric = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]+$'"];
  
  //These statements check the text fields that are required to be filled in.
  if([[subjectText text] length] == 0){
    errMsg = [errMsg stringByAppendingFormat:
              @"%d. Subject Field cannot be empty\n", ++errCnt];
    error = YES;
  }
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
  
  QFile *e = (QFile *) [self objForIndexPath:indexPath];
  DynamicFormVC *form = [[DynamicFormVC alloc] init];
  [form setMoContext:self.moContext];
  

  NSLog(@"%@ %@", [subjectText text], [trialText text]);
  if([[fileNameText text] length] > 0)
    [form setFileName:[NSString stringWithFormat:@"%@.csv", [fileNameText text]]];
  else
    [form setFileName:nil];
  
  [form setQuestionFileName:[e valueForKey:keyName]];
  NSArray *temp = [[e valueForKey:@"questionNames"] componentsSeparatedByString:@"\n"];
  NSArray *qArray = [[NSArray alloc] init];
  for(int i = 0; i < [[e valueForKey:@"numOfQuestions"] intValue]; ++i){
    NSString *s = [temp objectAtIndex:i];
    NSLog(@"%@", s);
    qArray = [qArray arrayByAddingObject:[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    NSLog(@"%@", [qArray objectAtIndex:i]);
  }
  [form setQuestionLabels:qArray];
  [form setHighLabels:[[e valueForKey:@"highLabelNames"] componentsSeparatedByString:@"\n"]];
  [form setLowLabels:[[e valueForKey:@"lowLabelNames"] componentsSeparatedByString:@"\n"]];
  
  [form setRangeIncrement:[e valueForKey:@"rangeIncrement"]];
  [form setLowRangeBound:[e valueForKey:@"rangeLowerBound"]];
  [form setHighRangeBound:[e valueForKey:@"rangeUpperBound"]];
  NSLog(@"%d", [[e valueForKey:@"rangeUpperBound"] intValue]);
  [form setNumOfQuestions:[e valueForKey:@"numOfQuestions"]];
  [self.navigationController pushViewController:form animated:YES];
  [form setSubjectLabelText:[NSString stringWithFormat:@"Subject: %@", [subjectText text]]];
  [form setSubjectName:[subjectText text]];
  [form setTrialTextValue:[trialText text]];
  
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

- (void)viewDidLoad
{
    [super viewDidLoad];
  entityName = @"QFile";
  keyName = @"title";
  
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

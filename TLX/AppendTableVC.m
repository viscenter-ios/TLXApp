//
//  AppendTableVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/6/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "AppendTableVC.h"
@implementation AppendTableVC
@synthesize subjectText;
///////////////////////////////////////////////////////////////////////////////////////////
//This function grabs the information of the experiment found at the selected row, retrieves
//the associated questionfiles information and then loads the DynamicFormVC for appending.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
  //first check that the subject text field is not empty:
  //These statements check the text fields that are required to be filled in.
  BOOL errorFlag = NO;
  int errCnt = 0;
  NSString* errMsg = @"The following errors were found:\n";
  UIAlertView* alert;
  
  if([[subjectText text] length] == 0){
    errMsg = [errMsg stringByAppendingFormat:
              @"%d. Subject Field cannot be empty\n", ++errCnt];
    errorFlag = YES;
  }
  
  //If an error was found, an alert is presented with error details and return.
  if(errorFlag){
    alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    return;
  }
  
  //Get the CSV file from  Core Data.
  Experiment *e = (Experiment *) [self objForIndexPath:indexPath];
  //This is similar to the saveData functions used in DynamicFormVC and QFileGrabberVC.
  //Rather than saving, the question file is retrieved and then information pulled from
  //it.
  NSError *error;
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title matches %@)", [e valueForKey:@"qFileName"]];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"QFile" inManagedObjectContext:moContext];
  if(entity == nil) NSLog(@"no entity");
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entity];
	[request setPredicate:predicate];
	NSArray *fetchedObjects = [moContext executeFetchRequest:request error:&error];
	if([fetchedObjects count] < 1){
    //error message
    errMsg = [errMsg stringByAppendingFormat:
              @"%d. No question file was found for the selected CSV file.\n", ++errCnt];
    alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    return;
  }
  else{
    //if we are here then a question file was found.
    QFile *q = [fetchedObjects objectAtIndex:0];
    DynamicFormVC *form = [[DynamicFormVC alloc] init];
    [form setMoContext:self.moContext];
    
    [form setQuestionFileName:[e valueForKey:keyName]];
    NSArray *temp = [[q valueForKey:@"questionNames"] componentsSeparatedByString:@"\n"];
    NSArray *qArray = [[NSArray alloc] init];
    
    for(int i = 0; i < [[q valueForKey:@"numOfQuestions"] intValue]; ++i){
      NSString *s = [temp objectAtIndex:i];
      NSLog(@"%@", s);
      qArray = [qArray arrayByAddingObject:[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
      NSLog(@"%@", [qArray objectAtIndex:i]);
    }
    [form setQuestionLabels:qArray];
    [form setHighLabels:[[q valueForKey:@"highLabelNames"] componentsSeparatedByString:@"\n"]];
    [form setLowLabels:[[q valueForKey:@"lowLabelNames"] componentsSeparatedByString:@"\n"]];
    
    [form setRangeIncrement:[q valueForKey:@"rangeIncrement"]];
    [form setLowRangeBound:[q valueForKey:@"rangeLowerBound"]];
    [form setHighRangeBound:[q valueForKey:@"rangeUpperBound"]];
    NSLog(@"%d", [[q valueForKey:@"rangeUpperBound"] intValue]);
    [form setNumOfQuestions:[q valueForKey:@"numOfQuestions"]];
    [self.navigationController pushViewController:form animated:YES];
    [form setSubjectLabelText:[NSString stringWithFormat:@"Subject: %@", [subjectText text]]];
    [form setSubjectName:[subjectText text]];
    NSNumber *n = [e valueForKey:@"lastTrial"];
    [form setTrialTextValue:[NSString stringWithFormat:@"%d", [n intValue]]];
  }
  
}
- (IBAction)hideKeyboard: (UITextField*)text {
	[text resignFirstResponder];
}
@end

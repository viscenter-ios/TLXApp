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
#import "QFileCreator.h"

@implementation SettingsVC


///////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)hideKeyboard: (UITextField*)text {
	[text resignFirstResponder];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




-(IBAction) newQf{
    QFileCreator *qf = [[QFileCreator alloc] init];
    [self presentModalViewController:qf animated:YES];
    NSLog(@"special cell");
}



///////////////////////////////////////////////////////////////////////////////////////////
    //This functon initiates the transition to the next view. It first checks that the text data on the page is valid, then grabs the information from the selected QFile and pushes the properly initialized DynamicFormVC onto the stack.
- (void)tableView:(UITableView *)tablView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tablView deselectRowAtIndexPath:indexPath animated:YES];
    if([tablView cellForRowAtIndexPath:indexPath].textLabel.text == @"Add new questionnaire"){
        QFileCreator *qf = [[QFileCreator alloc] init];
        [self presentModalViewController:qf animated:YES];
        NSLog(@"special cell");
    }
    else{
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
            errMsg = [errMsg stringByAppendingFormat:@"%d. Trial ID cannot be empty\n", ++errCnt];
            error = YES;
        }
        if(![isNumeric evaluateWithObject:[trialText text]]){
            errMsg = [errMsg stringByAppendingFormat:@"%d. Trial ID must be an integer.\n", ++errCnt];
            error = YES;
        }
  
        //If an error was found, an alert is presented with error details and return.
        if(error){
            alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
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
        NSLog(@"setNumOfQuestions:%u", [[e valueForKey:@"numOfQuestions"] intValue]);
        [form setSubjectName:[subjectText text]];
        NSLog(@"Subject: %@", [subjectText text]);
        [form setTrialNum:[[trialText text] intValue]];
        [self.navigationController pushViewController:form animated:YES];
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    entityName = @"QFile";
    keyName = @"title";
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
-(BOOL)textFieldShouldReturn:(UITextField *)sender {
    if (sender == subjectText){
        [subjectText resignFirstResponder];
        [trialText becomeFirstResponder];
    }
    if (sender == trialText){
        [trialText resignFirstResponder];
        [fileNameText becomeFirstResponder];
    }
    if (sender == fileNameText){
        [fileNameText resignFirstResponder];
    }
    return  NO;
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //Make sure we don't rotate the view into a landscape mode and mess everything up
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


@end

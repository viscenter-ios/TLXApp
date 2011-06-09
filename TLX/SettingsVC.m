//
//  SettingsVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/1/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "SettingsVC.h"


@implementation SettingsVC

////////////////////////////////////////////////////////////////////////////////
//
-(IBAction) startEntry
{
  DynamicFormVC *form = [[DynamicFormVC alloc] init];
  [self.navigationController pushViewController:form animated:YES];
  [form setMoContext:[(TLXAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext]];
  [form setSubjectLabelText:[NSString stringWithFormat:@"Subject: %@", [subjectText text]]];
  [form setSubjectName:[subjectText text]];
  [form setTrialTextValue:[trialText text]];
  if([[fileNameText text] length] > 0)
    [form setFileName:[NSString stringWithFormat:@"%@.csv", [fileNameText text]]];
  else
    [form setFileName:nil];
}
////////////////////////////////////////////////////////////////////////////////
//
-(IBAction) goToMain
{
  [self.navigationController popToRootViewControllerAnimated:YES];
}
////////////////////////////////////////////////////////////////////////////////
//
- (IBAction)hideKeyboard: (UITextField*)text {
	[text resignFirstResponder];
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

//
//  MainMenu.m
//  TLX
//
//  Created by Justin Proffitt on 6/1/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "MainMenu.h"
#import "AppendTableVC.h"
#import "EmailTableVC.h"
#import "SettingsVC.h"

@implementation MainMenu

////////////////////////////////////////////////////////////////////////////////
//These functions control the flow of the program, pushing the proper VC onto
//the navigation stack.
-(IBAction) newEntry{
  SettingsVC *settings = [[SettingsVC alloc] init];
  [self.navigationController pushViewController:settings animated:YES];
}
-(IBAction) existingEntry{
  AppendTableVC *fSelect = [[AppendTableVC alloc] init];
  [self.navigationController pushViewController:fSelect animated:YES];

}
-(IBAction) emailData{
  EmailTableVC *email = [[EmailTableVC alloc] init];
  [self.navigationController pushViewController:email animated:YES];
}
-(IBAction) goToDownload{
  QFileGrabberVC *fSelect = [[QFileGrabberVC alloc] init];
  [self.navigationController pushViewController:fSelect animated:YES];
}
-(IBAction) goToAbout{
  AboutVC *about = [[AboutVC alloc] init];
  [self.navigationController pushViewController:about animated:YES];
  
}
////////////////////////////////////////////////////////////////////////////////
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
-(void) viewWillAppear:(BOOL)animated
{
  [self.navigationController setNavigationBarHidden:YES];

}
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

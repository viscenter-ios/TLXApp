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
#import "CoreDataTableVC.h"
#import "QFileCreator.h"

@implementation MainMenu


///////////////////////////////////////////////////////////////////////////////////////////
    //When the view loads, we add the webview to the view and load the "about.html" file
- (void)viewDidLoad{
    self.title = @"Main Menu";
    [super viewDidLoad];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //Push the 'settings' View Controller
-(IBAction) newEntry{
    SettingsVC *settings = [[SettingsVC alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //Push the 'entries' View Controller
-(IBAction) existingEntry{
    AppendTableVC *fSelect = [[AppendTableVC alloc] init];
    [self.navigationController pushViewController:fSelect animated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //Push the 'results' View Controller
-(IBAction) emailData{
    EmailTableVC *email = [[EmailTableVC alloc] init];
    [self.navigationController pushViewController:email animated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //Push the 'download' View Controller
-(IBAction) goToDownload{
    QFileCreator *qf = [[QFileCreator alloc] init];
    [self presentModalViewController:qf animated:YES];
    /*QFileGrabberVC *fSelect = [[QFileGrabberVC alloc] init];
    [self.navigationController pushViewController:fSelect animated:YES];*/
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //Push the 'about' View Controller
-(IBAction) goToAbout{
    AboutVC *about = [[AboutVC alloc] init];
    [self.navigationController pushViewController:about animated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //Make sure we don't rotate the view into a landscape mode and mess everything up
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


@end

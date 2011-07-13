//
//  EmailTableVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/6/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//
#import "EmailTableVC.h"


@implementation EmailTableVC



///////////////////////////////////////////////////////////////////////////////////////////
    //This function calls a function which shows an action menu with the option to email the results.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath: %@", indexPath.description);
    NSLog(@"resultIndex before: %@", resultIndex.description);
    resultIndex = indexPath;
    NSLog(@"resultIndex after: %@", resultIndex.description);
    [self showActionMenu];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
    //This function shows the action menu to email the results.
-(void)showActionMenu {
    NSLog(@"showActionMenu begin");
    [self becomeFirstResponder];
    UIMenuItem* mailresults = [[[UIMenuItem alloc] initWithTitle: @"Email Results" action:@selector(emailResult)] autorelease];
    UIMenuController* mc = [UIMenuController sharedMenuController];
    mc.menuItems = [NSArray arrayWithObject: mailresults];
    UITableViewCell *tmpcell = [tableView cellForRowAtIndexPath:resultIndex];
    [mc setTargetRect: CGRectMake(tmpcell.frame.origin.x, tmpcell.frame.origin.y - tableView.contentOffset.y, tmpcell.frame.size.width, tmpcell.frame.size.height) inView: self.view];
    [mc setMenuVisible: YES animated: YES];
    NSLog(@"showActionMenu end");
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
//This function is called when the user selects an action from the modal view that should cause the view to be dismissed.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
//We just make sure if the user is scrolling, no row is selected. Also reset the variable so we can keep checking.
-(void)scrollViewDidScroll:(UIScrollView *)scrolled{
    if(resultIndex){
        [tableView deselectRowAtIndexPath:resultIndex animated:YES];
        resultIndex = nil;
    }
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\




///////////////////////////////////////////////////////////////////////////////////////////
//This function handles the data to email the results as a csv attachment
-(void) emailResult{
    NSLog(@"emailResult begin");
    if(![MFMailComposeViewController canSendMail]) {
        UIAlertView *alrt;
        alrt = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error while trying to send the email.  Try updating to the latest version of iOS." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [alrt release];
		return;
	}
    
    else {
        NSLog(@"Creating experiment at index: %@", resultIndex.description);
        Experiment *e = (Experiment *)[self objForIndexPath:resultIndex];
        
        if(![MFMailComposeViewController canSendMail]){
            NSLog(@"can't send mail");
            return;
        }
        
        //Prepare the time stamp for the CSV filename and email subject.
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yy HH:mm"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        
        //Allocate a modal mail compose view controller.
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        
        //Generate the string that will be the subject of the email, then append .csv to it
        //for the filename.
        
        NSString *subject = [NSString stringWithFormat:@"%@ - %@",
                             [e valueForKey:keyName], dateString];
        csvFileName = [NSString stringWithFormat:@"%@.csv", subject];
        
        //Extract the contents of the data attribute as a string.
        NSString *message = [NSString stringWithFormat:@"%@", [e valueForKey:dataString]];
        
        //Generate a block of data to be used as the attachment.
        NSData *fileData = [message dataUsingEncoding:NSASCIIStringEncoding];
        
        //Set the subject of the email, add the attachment, and finally present the email view.
        [controller setSubject:subject];
        [controller addAttachmentData:fileData mimeType:@"text/csv" fileName:csvFileName];
        [self presentModalViewController:controller animated:YES];
        
        [formatter release];
        [controller release];
    }
    [tableView deselectRowAtIndexPath:resultIndex animated:YES];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\





///////////////////////////////////////////////////////////////////////////////////////////
    //Make sure we don't rotate the view into a landscape mode and mess everything up
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


//////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)canBecomeFirstResponder {
	return TRUE;
}

- (void)dealloc {
	[super dealloc];
}
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

   
@end

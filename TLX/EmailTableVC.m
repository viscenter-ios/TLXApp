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
//This function takes the selected file at the current row and emails it out.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
  
  //We first check to make sure that the phone is configured to send mail.
  
  
  //Grab the experiment data from that is at the index path.
  Experiment *e = (Experiment *)[self objForIndexPath:indexPath];
  
	if(![MFMailComposeViewController canSendMail]){
		NSLog(@"can't send mail");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device not set up to send mail." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
		return;
	}
  
  //Prepare the time stamp for the CSV filename and email subject.
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
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
///////////////////////////////////////////////////////////////////////////////////////////
//This function is called when the user selects an action from the modal view that should
//cause the view to be dismissed.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
   
}
   
@end

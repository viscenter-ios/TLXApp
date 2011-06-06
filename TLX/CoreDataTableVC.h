//
//  CoreDataTableVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/6/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLXAppDelegate.h"
#import "Experiment.h"

#define ENTITY_NAME Experiment
#define ENTITY_NAME_STRING @"Experiment"
#define KEY_NAME @"fileName"
#define DATA_STRING @"dataString"

@interface CoreDataTableVC :UIViewController {
	//Managed object context to get information from core data and save changes.
  NSManagedObjectContext *moContext;
  //Array used in displaying of the table view.
	NSMutableArray *entityArray;
  //This controller is used to display the experiments in the table view.
	NSFetchedResultsController *fetchedResultsController;
  //The filename that the csv will have when sent out.
  NSString *csvFileName;
	IBOutlet UITableView *tableView;
	IBOutlet UITabBarItem *mmButton;
  BOOL appendFile;
}

@property (nonatomic, retain) NSManagedObjectContext *moContext;
@property (nonatomic, retain) NSMutableArray *entityArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSString *csvFileName;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

-(void) fetchRecords;
-(ENTITY_NAME *) objForIndexPath:(NSIndexPath *)indexPath;
-(void) continueEntry: (ENTITY_NAME *) e;
@end


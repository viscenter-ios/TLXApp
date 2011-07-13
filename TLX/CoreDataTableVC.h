//
//  CoreDataTableVC.h
//  TLX
//
//  Created by Justin Proffitt on 6/6/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//
//This VC is taken from one of iProd2's VC's. I have generalized it so that it can easily be used to inherit from when a simple table view is needed to display information from Core Data. entityName, keyName variables should be overridden when a class is inheriting from this class.

#import <UIKit/UIKit.h>
#import "TLXAppDelegate.h"
#import "Experiment.h"

@interface CoreDataTableVC :UIViewController {
	//Managed object context to get information from core data and save changes.
    NSManagedObjectContext *moContext;
    //Array used in displaying of the table view.
	NSMutableArray *entityArray;
    //This controller is used to display the information in the table view.
	NSFetchedResultsController *fetchedResultsController;
    //The filename that the csv will have when sent out.
    NSString *csvFileName;
    IBOutlet UITableView *tableView;
    BOOL appendFile;
    NSString *entityName;
    NSString *keyName;
    NSString *dataString;
}

@property (nonatomic, retain) NSManagedObjectContext *moContext;
@property (nonatomic, retain) NSMutableArray *entityArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSString *csvFileName;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

-(void) fetchRecords;
-(NSManagedObject *) objForIndexPath:(NSIndexPath *)indexPath;
@end


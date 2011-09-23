//
//  CoreDataTableVC.m
//  TLX
//
//  Created by Justin Proffitt on 6/6/11.
//  Copyright 2011 University Of Kentucky. All rights reserved.
//

#import "CoreDataTableVC.h"


@implementation CoreDataTableVC

@synthesize moContext;
@synthesize entityArray;
@synthesize fetchedResultsController;
@synthesize tableView;
@synthesize csvFileName;
///////////////////////////////////////////////////////////////////////////////////////////
//When the view loads we set the title of the navigation bar, add a button to the bar that
//will serve for entering delete mode, and make sure that we have the managed object
//context from main.
- (void)viewDidLoad
{
	[super viewDidLoad];
  entityName = @"Experiment";
  keyName = @"fileName";
  dataString = @"dataString";
	self.title = @"Files";
	[self.navigationController setNavigationBarHidden: FALSE];
	if(self.moContext == nil){
		self.moContext = [(TLXAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
	}
	
  UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                           initWithTitle:@"Edit"
                           style: UIBarButtonItemStyleBordered
                           target:self   
                           action:@selector(edit)];
  
  self.navigationItem.rightBarButtonItem = item;  
	
  [item release];
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function swaps the value of the tableviews editing property, which occurs when the
//edit button is pressed. While editing is true, the entries can be removed from the table
//by pressing the red minus button and then pressing delete.
-(void) edit
{
	self.tableView.editing = !self.tableView.editing;
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function is called when an entry is deleted. It gets the object located at the table
//index that is passed in and deletes it and finally saves the changes and reloads the
//data.
- (void)tableView:(UITableView *)tView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
    {
		NSLog(@"deleted, %u", [indexPath length]);
    //Delete the object.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
		[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
	  // Save the context.
    NSError *error = nil;
    if (![context save:&error])
      {
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
      }
    //Grab the records again so that the old data is no longer present.
		[self fetchRecords];
    //Reload the table.
		[tView reloadData];
    }
	//We do no inserting in this view so nothing occurs.
	if (editingStyle == UITableViewCellEditingStyleInsert){
	}
}
///////////////////////////////////////////////////////////////////////////////////////////
//This returns a reference to teh experiment located at the specified index path. This is
//used when creating the CSV file.
-(NSManagedObject*) objForIndexPath:(NSIndexPath*)indexPath{
	NSManagedObject *e = [self.fetchedResultsController objectAtIndexPath:indexPath];
	return e;
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function grabs the Experiment data from the managed object context and populates the
//table view with the fetched records.
-(void) fetchRecords{
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.moContext];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
  
	[request setEntity:entity];
	//Set the way that we will sort the fetched records. In this case in alphabetical order.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:keyName ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
  //Fetch the proper data from the database.
	fetchedResultsController = [[NSFetchedResultsController alloc]
                              initWithFetchRequest:request
                              managedObjectContext:moContext
                              sectionNameKeyPath:nil
                              cacheName:nil];
	
	NSError *error;
  
	if(![fetchedResultsController performFetch:&error]){
    //Error occured.
  }
  
	[request release];
}
///////////////////////////////////////////////////////////////////////////////////////////
//When the view appears we refetch the records.
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
	[self fetchRecords];
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function returns the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[fetchedResultsController sections] count];
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function will return the number of rows in a section, in our case it is the number
//of experiments found in the database.
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function populates each cell inside the table view. It is called when the table view
//is first loaded and also when scrolling occurs (table views recycle cells to save memory)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = 
  [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
	//Grab the object at the corresponding index in the fetchedResultsController.
  NSManagedObject *managedObject = 
  [fetchedResultsController objectAtIndexPath:indexPath];
  [cell.textLabel setText:[managedObject valueForKey:keyName]];
	return cell;
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function returns the title for the section that it is called on.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section{ 
  id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
  return [sectionInfo name];
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function returns an array containing the section index titles.
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  return [fetchedResultsController sectionIndexTitles];
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function returns an integer corresponding to the index passed in.
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
  return [fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}
///////////////////////////////////////////////////////////////////////////////////////////
//This function is called when a user selects an experiment they wish to email out data
//from.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
  //Override this method when inheriting from this class.
}

///////////////////////////////////////////////////////////////////////////////////////////
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


- (void)viewDidUnload
{
  [self.navigationController setNavigationBarHidden:YES];
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

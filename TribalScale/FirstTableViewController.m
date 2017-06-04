//
//  FirstTableViewController.m
//  TribalScale
//
//  Created by Thinh Le on 2017-06-03.
//  Copyright © 2017 Lac Viet Inc. All rights reserved.
//

#import "FirstTableViewController.h"
#import "SecondViewController.h"

@interface FirstTableViewController ()

@end

@implementation FirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Most Valuable Players";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://randomuser.me/api/?results=50&noinfo" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        
        // array of dictionary
        NSArray *tempArr = [responseObject objectForKey:@"results"];
        //NSLog(@"tempArr: %@", tempArr);
        NSMutableArray *tempPersons = [NSMutableArray array];
        
        for (NSDictionary *item in tempArr) {
            Person *per = [[Person alloc] init];
            
//            NSDictionary *collectionName = [item objectForKey:@"name"];
//            Name *na = [[Name alloc] init];
//            na.first = [collectionName objectForKey:@"first"];
//            na.last = [collectionName objectForKey:@"last"];
//            na.title = [collectionName objectForKey:@"title"];
//            
//            NSDictionary *collectionPicture = [item objectForKey:@"picture"];
//            Picture *pi = [[Picture alloc] init];
//            pi.large = [collectionPicture objectForKey:@"large"];
//            pi.medium = [collectionPicture objectForKey:@"medium"];
//            pi.thumbnail = [collectionPicture objectForKey:@"thumbnail"];
//
            NSString *title = [[item objectForKey:@"name"] objectForKey:@"title"];
            NSString *firstName = [[item objectForKey:@"name"] objectForKey:@"first"];
            NSString *lastName = [[item objectForKey:@"name"] objectForKey:@"last"];
            per.name = [NSString stringWithFormat:@"%@. %@, %@", title, firstName, lastName];
            per.email = [item objectForKey:@"email"];
            per.thumbnailURL = [[item objectForKey:@"picture"] objectForKey:@"thumbnail"];
            per.imageURL = [[item objectForKey:@"picture"] objectForKey:@"large"];
            //NSLog(@"%@, %@, %@", per.name, per.email, per.thumbnailURL);
            [tempPersons addObject:per];
            per = nil;
        }
        
        self.persons = tempPersons;
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persons.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"tableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    Person *tmpPer = [self.persons objectAtIndex:indexPath.row];
    
    NSURL *imageUrl =[NSURL URLWithString:tmpPer.thumbnailURL];
    NSData *thumbnailData = [[NSData alloc] initWithContentsOfURL:imageUrl];
    UIImage *thumbnailImage; // = [UIImage imageWithData:thumbnailData];
    
    if (thumbnailData == nil) {
        thumbnailImage = [UIImage imageNamed:[NSString stringWithFormat:@"icon-64x64.png"]];
    }
    else {
        thumbnailImage = [UIImage imageWithData:thumbnailData];
    }
    cell.imageView.image = thumbnailImage;
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    cell.textLabel.textColor = [UIColor colorWithRed: 0.0 green: 20.0/255.0 blue: 160.0/255.0 alpha:1.0];
    cell.textLabel.text = tmpPer.name;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.detailTextLabel.textColor = [UIColor colorWithRed: 0.0/255.0 green: 116.0/255.0 blue: 255.0/255.0 alpha:1.0];
    cell.detailTextLabel.text = tmpPer.email;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.personSelected = [self.persons objectAtIndex:indexPath.row];
    //NSLog(@"weight = %@", _productSelected.recordWeight);
    [self performSegueWithIdentifier:@"ShowSecondViewController" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowSecondViewController"]) {
        SecondViewController *secondViewController = (SecondViewController *)segue.destinationViewController;
        secondViewController.personSelected = self.personSelected;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
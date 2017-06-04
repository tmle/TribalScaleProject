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
    self.title = @"Most Valuable Employees";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 139.0/255.0 green: 211.0/255.0 blue: 230.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed: 0.0 green: 20.0/255.0 blue: 160.0/255.0 alpha:1.0]}];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://randomuser.me/api/?results=50&noinfo" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        
        // array of dictionary
        NSArray *tempArr = [responseObject objectForKey:@"results"];
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
            NSString *firstName = [[item objectForKey:@"name"] objectForKey:@"first"];
            NSString *lastName = [[item objectForKey:@"name"] objectForKey:@"last"];
            per.name = [NSString stringWithFormat:@"%@, %@", firstName, lastName];
            per.gender = [item objectForKey:@"gender"];
            per.email = [item objectForKey:@"email"];
            per.thumbnailURL = [[item objectForKey:@"picture"] objectForKey:@"thumbnail"];
            per.imageURL = [[item objectForKey:@"picture"] objectForKey:@"large"];
            //NSLog(@"%@, %@, %@, %@", per.name, per.gender, per.email, per.thumbnailURL);
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
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed: 123.0/255.0 green: 175.0/255.0 blue: 212.0/255.0 alpha:1.0];
    } else {
        cell.backgroundColor = [UIColor colorWithRed: 139.0/255.0 green: 211.0/255.0 blue: 230.0/255.0 alpha:1.0];
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    cell.textLabel.textColor = [UIColor colorWithRed: 0.0 green: 20.0/255.0 blue: 160.0/255.0 alpha:1.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.detailTextLabel.textColor = [UIColor colorWithRed: 0.0/255.0 green: 116.0/255.0 blue: 255.0/255.0 alpha:1.0];
    
    Person *tmpPer = [self.persons objectAtIndex:indexPath.row];
    
    if ([tmpPer.gender isEqualToString:@"female"]) {
        cell.imageView.image = [UIImage imageNamed:@"Undefined_Female_Light.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"Undefined_Male_Light.png"];
    }
    
    NSURL *imageUrl =[NSURL URLWithString:tmpPer.thumbnailURL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSData *thumbnailData = [[NSData alloc] initWithContentsOfURL:imageUrl];
        UIImage *thumbnailImage = [UIImage imageWithData:thumbnailData];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            cell.imageView.image = thumbnailImage;
        });
    });
    
    cell.textLabel.text = tmpPer.name;
    
    if ([self validEmail:tmpPer.email]) {
        cell.detailTextLabel.textColor = [UIColor colorWithRed: 0.0/255.0 green: 116.0/255.0 blue: 255.0/255.0 alpha:1.0];
        cell.detailTextLabel.text = tmpPer.email;
    } else {
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.text = @"email not valid";
        tmpPer.email = @"email not valid";
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.personSelected = [self.persons objectAtIndex:indexPath.row];
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

#pragma mark - Test email
- (BOOL)validEmail:(NSString *)emailString {
    
    if([emailString length] == 0) {
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    //NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

- (NSTimeInterval)imageDownloadTime:(Person *)typicalPerson {
    NSURL *imageUrl =[NSURL URLWithString:typicalPerson.imageURL];
    
    NSDate *methodStart = [NSDate date];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSData *largeData = [[NSData alloc] initWithContentsOfURL:imageUrl];
        UIImage *largeImage = [UIImage imageWithData:largeData];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //cell.imageView.image = largeImage;
        });
    });
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %f", executionTime);
    
    return executionTime;

}


@end

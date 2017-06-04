//
//  FirstTableViewController.h
//  TribalScale
//
//  Created by Thinh Le on 2017-06-03.
//  Copyright © 2017 Lac Viet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Person.h"
#import "Name.h"
#import "Picture.h"

@interface FirstTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *persons;
@property (nonatomic, strong) Person *personSelected;

@end

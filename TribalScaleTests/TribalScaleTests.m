//
//  TribalScaleTests.m
//  TribalScaleTests
//
//  Created by Thinh Le on 2017-06-03.
//  Copyright © 2017 Lac Viet Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FirstTableViewController.h"
#import "Person.h"

@interface TribalScaleTests : XCTestCase

@end

@implementation TribalScaleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEmailValidity {
    NSString *myCurrentEmail = @"john.doe@xmail.com";
    //NSString *myOtherEmail = @"▲☆★◇◆■□▽@gmail.com"; // to test for invalid email
    FirstTableViewController *firstTableVC = [[FirstTableViewController alloc] init];
    
    XCTAssertTrue([firstTableVC validEmail:myCurrentEmail], @"invalid email");
    
}

- (void)testPerformanceDownloading {
    FirstTableViewController *firstTableVC = [[FirstTableViewController alloc] init];
    Person *person = [[Person alloc] init];

    person.name = @"Jane, Doe";
    person.gender = @"female";
    person.email = @"john.doe@xmail.com";
    person.thumbnailURL =@"https://randomuser.me/api/portraits/thumb/women/54.jpg";
    person.imageURL = @"https://randomuser.me/api/portraits/women/54.jpg";

    [self measureBlock:^{
        [firstTableVC downloadTime:person];
    }];
}

- (void)testPerformanceImageDownloading {    
    Person *person = [[Person alloc] init];
    
    person.name = @"Jane, Doe";
    person.gender = @"female";
    person.email = @"john.doe@xmail.com";
    person.thumbnailURL =@"https://randomuser.me/api/portraits/thumb/women/54.jpg";
    person.imageURL = @"https://randomuser.me/api/portraits/women/54.jpg";
    
    NSURL *thumbnailUrl = [NSURL URLWithString:person.thumbnailURL];
    NSURL *imageUrl =[NSURL URLWithString:person.imageURL];

    [self measureBlock:^{
        NSData *thumbnailData = [[NSData alloc] initWithContentsOfURL:thumbnailUrl];
        UIImage *thumbnailImage = [UIImage imageWithData:thumbnailData];
        NSData *largeData = [[NSData alloc] initWithContentsOfURL:imageUrl];
        UIImage *largeImage = [UIImage imageWithData:largeData];
    }];
}

@end

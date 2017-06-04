//
//  TribalScaleTests.m
//  TribalScaleTests
//
//  Created by Thinh Le on 2017-06-03.
//  Copyright © 2017 Lac Viet Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FirstTableViewController.h"

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

- (void)testEmail {
    NSString *myCurrentEmail = @"john.doe@xmail.com";
    NSString *myOtherEmail = @"▲☆★◇◆■□▽@gmail.com";
    FirstTableViewController *firstTableVC = [[FirstTableViewController alloc] init];
    
    XCTAssertTrue([firstTableVC validEmail:myCurrentEmail], @"invalid email");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

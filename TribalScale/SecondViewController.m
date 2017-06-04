//
//  SecondViewController.m
//  TribalScale
//
//  Created by Thinh Le on 2017-06-03.
//  Copyright © 2017 Lac Viet Inc. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *personImageView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personEmailLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *imageUrl =[NSURL URLWithString:self.personSelected.imageURL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSData *largeData = [[NSData alloc] initWithContentsOfURL:imageUrl];
        UIImage *largeImage = [UIImage imageWithData:largeData];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.personImageView.image = largeImage;
        });
    });

    self.personNameLabel.text = self.personSelected.name;
    self.personEmailLabel.text = [NSString stringWithFormat:@"Email: %@", self.personSelected.email];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

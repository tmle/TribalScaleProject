//
//  MaterialLabel.m
//  MyFamily
//
//  Created by Thinh Le on 2017-05-20.
//  Copyright © 2017 Lac Viet Inc. All rights reserved.
//

#import "MaterialLabel.h"
#define SHADOW_COLOR 157.0/255.0

@implementation MaterialLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 2.0;
    //self.layer.shadowColor = [UIColor colorWithRed:SHADOW_COLOR green:SHADOW_COLOR blue:SHADOW_COLOR alpha:0.5].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 4.0;
    //self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    
}

@end

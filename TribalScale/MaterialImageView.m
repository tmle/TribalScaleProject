//
//  MaterialImageView.m
//  TribalScale
//
//  Created by Thinh Le on 2017-06-04.
//  Copyright © 2017 Lac Viet Inc. All rights reserved.
//

#import "MaterialImageView.h"
#define SHADOW_COLOR 157.0/255.0

@implementation MaterialImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [UIColor colorWithRed:SHADOW_COLOR green:SHADOW_COLOR blue:SHADOW_COLOR alpha:0.5].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    
}

@end

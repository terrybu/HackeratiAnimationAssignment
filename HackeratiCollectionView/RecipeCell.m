//
//  RecipeCell.m
//  HackeratiCollectionView
//
//  Created by Aditya Narayan on 12/19/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "RecipeCell.h"

@implementation RecipeCell


-(void)prepareForReuse{
    [super prepareForReuse];
    self.imageView.image = nil;
}



- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    self.layer.cornerRadius = 75;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    
    self.layer.masksToBounds = YES;
    
    self.layer.shadowOpacity = 0.75f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeMake(5, 5);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:75].CGPath;
    self.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.layer.shouldRasterize = YES;
}





@end

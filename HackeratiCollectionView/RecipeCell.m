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

@end

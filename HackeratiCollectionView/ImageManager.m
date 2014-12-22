//
//  ImageRandomLoadManager.m
//  HackeratiCollectionView
//
//  Created by Aditya Narayan on 12/19/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "ImageManager.h"


@implementation ImageManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Initialize recipe image array
        self.recipeImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
    }
    return self;
}


-(void) imageDelayMethod:(int)indexPath block:(CompletionBlock)compblock {
    //do stuff
    
    __block UIImage *image;
    int randomDelay;
    
    if (self.isRandomDelayModeOff == TRUE)
        randomDelay = 0;
    else
        randomDelay = arc4random_uniform(3);
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, randomDelay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        image = [self ImageSelectionWithIndex:indexPath];
        compblock(YES, image);
    });
}


- (UIImage *) ImageSelectionWithIndex: (int) indexPath {
    NSString *imageString = [self.recipeImages objectAtIndex:indexPath];
    UIImage* image = [UIImage imageNamed:imageString];
    return image;
}

@end

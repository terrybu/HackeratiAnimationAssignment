//
//  ImageRandomLoadManager.h
//  HackeratiCollectionView
//
//  Created by Aditya Narayan on 12/19/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CompletionBlock)(BOOL finished, UIImage *image);

@interface ImageManager : NSObject




@property (nonatomic, strong)  NSArray *recipeImages;



-(void) imageDelayMethod:(CompletionBlock) compblock;

- (UIImage *) randomImageSelectionOutOfArray: (NSArray *) dataArray;





@end



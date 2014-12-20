//
//  CanvasCollectionViewController.m
//  HackeratiCollectionView
//
//  Created by Aditya Narayan on 12/19/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "CanvasCollectionViewController.h"
#import "RecipeCell.h"
#import "ImageManager.h"


@interface CanvasCollectionViewController () {
    
    ImageManager *imageManager;
}

@end

@implementation CanvasCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    imageManager = [[ImageManager alloc]init];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageManager.recipeImages.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RecipeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    
    [cell prepareForReuse];
    cell.tag = indexPath.row;
    cell.hidden = YES;

    if(cell.tag == indexPath.row) {
        [imageManager imageDelayMethod:^(BOOL finished, UIImage *image) {
            if (finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.hidden = NO;
                    cell.imageView.image = image;
                });
            }
        }];
    }
    
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sea"]];
    
    return cell;
}




#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundView = nil;
    cell.backgroundColor = [UIColor blueColor];
}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = nil;
    
}


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}





@end

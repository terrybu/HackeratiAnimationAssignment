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

    
    UISwitch *onoff = [[UISwitch alloc] initWithFrame: CGRectMake(self.view.frame.size.width/2-32, 50, 32, 32)];
    [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: onoff];
    
}

- (IBAction)flip:(id)sender {
    UISwitch *onoff = (UISwitch *) sender;
    if (onoff.on) {
        NSLog(@"Random Delay Load Mode Off");
        imageManager.isRandomDelayModeOff = TRUE;
        [self.collectionView reloadData];
    }
    else {
        NSLog(@"Random Delay Load Mode Back On");
        imageManager.isRandomDelayModeOff = FALSE;
        [self.collectionView reloadData];
    }
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
    [cell prepareForReuse];
    cell.hidden = YES;

    cell.tag = indexPath.row;
    [imageManager imageDelayMethod:(int) indexPath.row block:^(BOOL finished, UIImage *image) {
        if (finished) {
            if (cell.tag == indexPath.row) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = image;
                cell.hidden = NO;
            });
            }
        }
    }];

    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sea"]];
    
    return cell;
}




#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundView.hidden = YES;
}


- (void) collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundView.hidden = NO;
}





@end

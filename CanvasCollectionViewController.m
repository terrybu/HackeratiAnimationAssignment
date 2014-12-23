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
    UIImageView *starImageView;
}

@property (nonatomic) UIDynamicAnimator *animator;


@end

@implementation CanvasCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageManager = [[ImageManager alloc]init];

    UILabel *offLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-16, 15, 32, 32)];
    offLabel.text = @"Off";
    offLabel.textColor = [UIColor whiteColor];
    UISwitch *onOffSwitch = [[UISwitch alloc] initWithFrame: CGRectMake(self.view.frame.size.width/2-28, 50, 32, 32)];
    [onOffSwitch addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: offLabel];
    [self.view addSubview: onOffSwitch];
    
    self.collectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black"]];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    
    
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.origin.y);
    emitterLayer.emitterZPosition = 5;
    emitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width, 0);
    emitterLayer.emitterShape = kCAEmitterLayerSphere;
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.scale = 0.2;
    emitterCell.scaleRange = 0.4;
    emitterCell.emissionRange = (CGFloat)M_PI_2;
    emitterCell.lifetime = 5.0;
    emitterCell.birthRate = 10;
    emitterCell.velocity = 200;
    emitterCell.velocityRange = 50;
    emitterCell.yAcceleration = 250;
    emitterCell.contents = (id)[[UIImage imageNamed:@"star"] CGImage];
    emitterLayer.emitterCells = [NSArray arrayWithObject:emitterCell];
    [self.view.layer addSublayer:emitterLayer];

    
    UIImage *starImage = [UIImage imageNamed:@"star"];
    starImageView = [[UIImageView alloc]initWithImage:starImage];
    starImageView.frame = CGRectMake(50, 50, 32, 32);
    [self.view addSubview:starImageView];
    
    UIGravityBehavior* gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[starImageView]];
    gravityBehavior.magnitude = 0.5;
    gravityBehavior.angle = 240;
    
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[starImageView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    
    UIDynamicItemBehavior *elasticity = [[UIDynamicItemBehavior alloc]initWithItems:@[starImageView]];
    elasticity.elasticity = 0.75;
    
    [self.animator addBehavior:gravityBehavior];
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:elasticity];

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

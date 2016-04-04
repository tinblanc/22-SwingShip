//
//  ViewController.m
//  SwingShip
//
//  Created by Tin Blanc on 4/4/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *ship;
    UIImageView *galaxy1, *galaxy2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawShipAndGalaxy];
    [self animateShip];
    [self animateGalaxy];
    
}

-(void) drawShipAndGalaxy{
    
    // Draw Galaxy
    galaxy1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1.png"]];
    galaxy1.frame = self.view.bounds;
    [self.view addSubview:galaxy1];
    
    galaxy2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]];
    galaxy2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:galaxy2];
    
    
    // Draw ship
    ship = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (int i = 1; i < 4;  i ++) {
        NSString *fileName = [NSString stringWithFormat:@"ship%d.png", i];
        [images addObject:[UIImage imageNamed:fileName]];
    }
    
    ship.animationImages = images;
    ship.animationDuration = 1;
    ship.animationRepeatCount = 0;
    ship.contentMode = UIViewContentModeScaleAspectFit;
    
    ship.center = self.view.center;
    
    [self.view addSubview:ship];
    [ship startAnimating];
    
    
}


-(void) animateShip {
    [UIView animateWithDuration:1 animations:^{
        ship.transform = CGAffineTransformMakeRotation(-0.03);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            ship.transform = CGAffineTransformMakeRotation(0.03);
        } completion:^(BOOL finished) {
            [self animateShip];
        }];
    }];
    
    
   
}

-(void) animateGalaxy{
    [UIView animateWithDuration:5 animations:^{
        galaxy1.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        galaxy2.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        galaxy1.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
        [UIView animateWithDuration:10 animations:^{
            galaxy1.frame = self.view.bounds;
            galaxy2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        } completion:^(BOOL finished) {
            galaxy2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [self animateGalaxy];
        }];
    }];
}


@end

//
//  FullPicController.h
//  HW_NSURLSession
//
//  Created by Артур Сагидулин on 13.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetManager.h"
#import "FruitModel.h"
#import "FruitCell.h"
#import "ViewController.h"

@interface FullPicController : UIViewController 

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSNumber *index;
@property (strong, nonatomic) FruitModel *fruit;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;





@end

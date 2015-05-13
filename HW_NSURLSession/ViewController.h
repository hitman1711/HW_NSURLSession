//
//  ViewController.h
//  HW_NSURLSession
//
//  Created by Alexander on 13.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetManager.h"
#import "FruitModel.h"
#import "FruitCell.h"
#import "FullPicController.h"

@class NetManager;



@interface ViewController : UIViewController 

@property NetManager *netMgr;
@property NSMutableArray *fruits;

@end


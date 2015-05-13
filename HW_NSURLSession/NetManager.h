//
//  NetManager.h
//  HW_SlicedImages
//
//  Created by Артур Сагидулин on 19.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FruitModel.h"
#import "ViewController.h"

@protocol DataDelegating

-(void)setProgress:(float)percent;
-(void)setupImg:(NSData*)dat;

@end


@interface NetManager : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate>

@property (strong, nonatomic) NSURLSessionDownloadTask *getFruitsImgTask;
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSession *backSession;

+(instancetype)sharedInstance;

@property (nonatomic, weak) id<DataDelegating> delegate;

@property FruitModel* srcF;

-(void)interruptImg;
-(void)getFruits:(void(^)(NSArray *arr, NSError *err))completion;

-(void)getFruitThumb:(void(^)(FruitModel *fruit, NSError *err))completion
                  of:(FruitModel*)srcFruit;

-(void)getFruitImgOf:(FruitModel*)srcFruit;
@end

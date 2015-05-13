//
//  FruitModel.h
//  Test_FMDB
//
//  Created by Alexander on 11.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FruitModel : NSObject <NSCopying>

-(id) copyWithZone: (NSZone *) zone;

- (id)initWithDict:(NSDictionary *)dict;


@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *thumbURL;
@property (nonatomic, strong) NSURL *imageURL;

@property (nonatomic, strong) NSData *cachedImage;
@property (nonatomic, strong) NSData *cachedLargeImage;

@end

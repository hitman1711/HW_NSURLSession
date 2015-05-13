//
//  FruitModel.m
//  Test_FMDB
//
//  Created by Alexander on 11.03.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "FruitModel.h"

@implementation FruitModel

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.thumbURL = [NSURL URLWithString:dict[@"thumb"]];
        self.imageURL = [NSURL URLWithString:dict[@"img"]];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    //FruitModel *copy = [[FruitModel allocWithZone: zone] init];
    FruitModel *copy = [[[self class] allocWithZone:zone] init];
    [copy setTitle: [self title]];
    [copy setThumbURL:[[self thumbURL] copy]];
    [copy setImageURL:[[self imageURL] copy]];
    [copy setCachedImage:[[self cachedImage] copy]];
    [copy setCachedLargeImage:[[self cachedLargeImage] copy]];
    return copy;
}

@end

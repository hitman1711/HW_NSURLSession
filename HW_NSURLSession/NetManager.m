//
//  NetManager.m
//  HW_SlicedImages
//
//  Created by Артур Сагидулин on 19.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager 

-(instancetype)initMe{
    self = [super init];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.backSession = [self backgroundSession];
   
    return self;
}

+(instancetype)sharedInstance{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] initMe];
    });
    return _singleton;
}

-(void)getFruits:(void(^)(NSArray *arr, NSError *err))completion{
    NSURL *jsonUrl = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/Fructs.json"];
    NSURLSessionDataTask *getFruitsTask = [_session dataTaskWithURL:jsonUrl completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error){
         if (!error) {
             NSArray *parsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             if (!error) {
                 NSMutableArray *tempArr = [NSMutableArray new];
                 for (NSDictionary *dic in parsed) {
                     [tempArr addObject:[[FruitModel alloc] initWithDict:dic]];
                 }
                 if ([tempArr count]>0) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         completion(tempArr, nil);
                     });
                 }
                 
                 return;
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             completion(nil, error);
         });
     }];
    [getFruitsTask resume];
}

-(void)getFruitThumb:(void(^)(FruitModel *fruit, NSError *err))completion of:(FruitModel*)srcFruit{
    NSURLSessionDownloadTask *getFruitsThumbTask = [_session downloadTaskWithURL:srcFruit.thumbURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            FruitModel *tempFruit = [srcFruit copy];
            tempFruit.cachedImage = [[NSData dataWithContentsOfURL:location] copy];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(tempFruit,nil);
            });
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil, error);
        });

    }];
    [getFruitsThumbTask resume];
    
}


-(void)getFruitImgOf:(FruitModel*)srcFruit{
    _srcF = nil;
    _srcF = [srcFruit copy];
    _getFruitsImgTask = [_backSession downloadTaskWithURL:srcFruit.imageURL];
    [_getFruitsImgTask resume];
    
}

-(void)interruptImg{
    if ([_getFruitsImgTask state]==NSURLSessionTaskStateRunning) {
        [_getFruitsImgTask cancel];
    }
}

- (NSURLSession *)backgroundSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"myID"];
        
        session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    });
    
    return session;
}


- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    CGFloat percentDone = (double)totalBytesWritten/(double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_delegate setProgress:percentDone];
    });
}


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    [_delegate setupImg:[[NSData dataWithContentsOfURL:location] copy]];
    [_delegate setProgress:1.0];
    
}






@end

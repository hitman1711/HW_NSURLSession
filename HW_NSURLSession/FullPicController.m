//
//  FullPicController.m
//  HW_NSURLSession
//
//  Created by Артур Сагидулин on 13.05.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "FullPicController.h"

@interface FullPicController () <DataDelegating>
-(void)setProgress:(float)percent;
-(void)setupImg:(NSData*)dat;
@property (nonatomic,strong) ViewController *viewC;
@end

@implementation FullPicController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewC = (ViewController*)[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    [self.progressView setProgress:0 animated:YES];
    [_imgView setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [[_viewC netMgr] interruptImg];
    }
}

-(void)setupImg:(NSData*)dat{
    [self setData:dat];
    [_fruit setCachedLargeImage:dat];
    [[_viewC fruits] replaceObjectAtIndex:[_index integerValue] withObject:_fruit];
}

-(void)setData:(NSData *)data{
    _data = [NSData dataWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *temp = [UIImage imageWithData:_data];
        _imgView.image=temp;
    });
}

-(void)setFruit:(FruitModel *)fruit{
    _fruit = fruit;
    if ([_fruit cachedLargeImage]) {
        [self setProgress:1.0];
        [self setData:[_fruit cachedLargeImage]];
    }
}


-(void)setProgress:(float)percent{
    if (percent==1.0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView setAlpha:0];
            [self.progressView removeFromSuperview];
        });
    }
    [self.progressView setProgress:percent animated:YES];
}




@end

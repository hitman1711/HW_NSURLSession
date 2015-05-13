//
//  ViewController.m
//  HW_NSURLSession
//
//  Created by Alexander on 13.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSURLSession *backSession;
    id presented;
}

@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _netMgr = [NetManager sharedInstance];
    
    if (!_fruits) {
        [self updateFruits];
    } else {
        [_table reloadData];
    }
}

-(void)updateFruits{
    
    [_netMgr getFruits:^(NSArray *arr, NSError *err) {
        _fruits = [NSMutableArray arrayWithArray:arr];
        [_table reloadData];
    }];
}

-(void)setupProgressCircle{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fruits.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    FruitModel *tFruit = [_fruits objectAtIndex:indexPath.row];
    FruitCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.nameLabel.text = [tFruit title];
    if (![tFruit cachedImage]) {
        [_netMgr getFruitThumb:^(FruitModel *fruit, NSError *err) {
            [_fruits replaceObjectAtIndex:indexPath.row withObject:[fruit copy]];
            [cell.fruitImageView setImage:[UIImage imageWithData:[[_fruits objectAtIndex:indexPath.row] cachedImage]]];
        } of:tFruit];
    } else {
        [cell.fruitImageView setImage:[UIImage imageWithData:[tFruit cachedImage]]];
    }
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    presented = nil;
    presented = (FullPicController*)segue.destinationViewController;
    [_netMgr setDelegate:presented];
    
    NSIndexPath *indexPath = [_table indexPathForSelectedRow];
    if (indexPath){
        [segue.destinationViewController setIndex:@(indexPath.row)];
        FruitModel __block *tFruit = [_fruits objectAtIndex:indexPath.row];
        if (!tFruit.cachedLargeImage) {
            [segue.destinationViewController setFruit:tFruit];
            [_netMgr getFruitImgOf:tFruit];
        } else {
            tFruit = [_fruits objectAtIndex:indexPath.row];
            [segue.destinationViewController setFruit:tFruit];
        }
    }
}




@end

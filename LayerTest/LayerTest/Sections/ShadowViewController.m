//
//  ShadowViewController.m
//  LayerTest
//
//  Created by 娜娜子 on 19/04/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "ShadowViewController.h"
#import "CorNerTableViewCell.h"
#import "UIView+LFLayer.h"

@interface ShadowViewController ()
@property(nonatomic, strong) NSArray *dataList;
@end

@implementation ShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupLayout];
    self.title = @"阴影";
    self.tableView.backgroundColor = [UIColor colorWithHexVal:0x444123];
    
    self.dataList = @[
                      @{@"title":@"原生角+原生边"},
                      @{@"title":@"mask角+原生边",@"type":@(CornerClipTypeAll)},
                      @{@"title":@"mask角+原生边",@"type":@(CornerClipTypeBothTop)},
                      @{@"title":@"原生角+layer边",@"borderWidth":@5},
                      @{@"title":@"mask角+layer边",@"type":@(CornerClipTypeAll),@"borderWidth":@5},
                      @{@"title":@"mask角+layer边",@"type":@(CornerClipTypeBothTop),@"borderWidth":@5},
                      ];
}

- (void)setupUI
{
    [self.view addSubview:self.tableView];
}
- (void)setupLayout
{
    self.tableView.frame = self.view.bounds;
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = self.dataList[indexPath.row];
    CorNerTableViewCell *cell = [CorNerTableViewCell cellFromXibWithTableView:tableView];
    cell.titleLbl.text = data[@"title"];
    if(data[@"type"]){
        [cell.boxView clipWithType:[data[@"type"] integerValue] radius:20];
        cell.boxView.layer.masksToBounds = NO;
        cell.boxView.layer.cornerRadius = 0;
    }else{
        cell.boxView.lf_clipType = CornerClipTypeNone;
        cell.boxView.layer.masksToBounds = YES;
        cell.boxView.layer.cornerRadius = 20;
    }
    
    
    cell.boxView.backgroundColor = [UIColor randomColor];
    if(data[@"borderWidth"]){
        cell.boxView.lf_borderColor = [UIColor randomColor];
        cell.boxView.lf_borderWidth = 5;
        cell.boxView.layer.borderWidth = 0;
    }else{
        cell.boxView.layer.borderColor = [UIColor randomColor].CGColor;
        cell.boxView.lf_borderWidth = 0;
        cell.boxView.layer.borderWidth = 3;
    }
    cell.boxView.layer.shadowColor = [UIColor redColor].CGColor;
    cell.boxView.layer.shadowRadius = 5.f;
    cell.boxView.layer.shadowOffset = CGSizeMake(10.f, 10.f);
    cell.boxView.layer.shadowOpacity = 1.f;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end

//
//  CornersViewController.m
//  LayerTest
//
//  Created by 娜娜子 on 19/04/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "CornersViewController.h"
#import "UIView+LFLayer.h"
#import "CorNerTableViewCell.h"


@interface CornersViewController()
@property(nonatomic, strong) NSArray *dataList;
@end
@implementation CornersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupLayout];
    self.title = @"切圆角";
    
    self.dataList = @[
                      @{@"title":@"无圆角",@"type":@(CornerClipTypeNone),@"radius":@10},
                      @{@"title":@"左上角",@"type":@(CornerClipTypeTopLeft),@"radius":@10},
                      @{@"title":@"右上角",@"type":@(CornerClipTypeTopRight),@"radius":@10},
                      @{@"title":@"左下角",@"type":@(CornerClipTypeBottomLeft),@"radius":@10},
                      @{@"title":@"右下角",@"type":@(CornerClipTypeBottomRight),@"radius":@10},
                      @{@"title":@"四个角",@"type":@(CornerClipTypeAll),@"radius":@10},
                      
                      @{@"title":@"原生四个角",@"radius":@10},
                      @{@"title":@"上面2个角",@"type":@(CornerClipTypeBothTop),@"radius":@10},
                      @{@"title":@"下面2个角",@"type":@(CornerClipTypeBothBottom),@"radius":@10},
                      @{@"title":@"左面2个角",@"type":@(CornerClipTypeBothLeft),@"radius":@10},
                      @{@"title":@"右面2个角",@"type":@(CornerClipTypeBothRight),@"radius":@10},
                      @{@"title":@"左上右下2个角",@"type":@(CornerClipTypeTopLeft|CornerClipTypeBottomRight),@"radius":@10},
                      @{@"title":@"左下右上2个角",@"type":@(CornerClipTypeBottomLeft|UIRectCornerTopRight),@"radius":@10},
                      
                      @{@"title":@"左下右下右上3个角",@"type":@(CornerClipTypeBottomLeft|CornerClipTypeTopRight|CornerClipTypeBottomRight),@"radius":@10},
                      @{@"title":@"左上左下右下3个角",@"type":@(CornerClipTypeTopLeft|CornerClipTypeBottomLeft|CornerClipTypeBottomRight),@"radius":@10},
                      @{@"title":@"左上左下右上3个角",@"type":@(CornerClipTypeTopLeft|CornerClipTypeTopRight|CornerClipTypeBottomLeft),@"radius":@10},
                      @{@"title":@"左上右上右下3个角",@"type":@(CornerClipTypeTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight),@"radius":@10},
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
- (UIEdgeInsets)tableViewSeperatorInsets
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = self.dataList[indexPath.row];
    CorNerTableViewCell *cell = [CorNerTableViewCell cellFromXibWithTableView:tableView];
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLbl.text = data[@"title"];
    cell.boxView.backgroundColor = [UIColor randomColor];
    if(data[@"type"]){
        [cell.boxView clipWithType:[data[@"type"] integerValue] radius:[data[@"radius"] floatValue]];
        cell.boxView.layer.masksToBounds = NO;
        cell.boxView.layer.cornerRadius = 0;
    }else{
        cell.boxView.lf_clipType = CornerClipTypeNone;
        cell.boxView.layer.masksToBounds = YES;
        cell.boxView.layer.cornerRadius = [data[@"radius"] floatValue];
    }
    
    return cell;
}
@end

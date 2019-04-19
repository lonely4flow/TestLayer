//
//  ViewController.m
//  LayerTest
//
//  Created by 娜娜子 on 19/04/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "ViewController.h"
#import "CornersViewController.h"
#import "BorderViewController.h"
#import "ShadowViewController.h"
#import "ShadowBoxView.h"

@interface ViewController ()
@property(nonatomic, strong) NSArray *dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupLayout];
    self.title = @"功能列表";
    self.tableView.backgroundColor = [UIColor colorWithHexTxt:@"abc123"];
    
    self.dataList = @[
  @{@"title":@"圆角",@"clazz":[CornersViewController class]},
  @{@"title":@"边框",@"clazz":[BorderViewController class]},
  @{@"title":@"阴影",@"clazz":[ShadowViewController class]},
  
   ];
    
    ShadowBoxView* shapeView = [[ShadowBoxView alloc] init];
    shapeView.backgroundColor = [UIColor grayColor];
    shapeView.layer.shadowColor = [UIColor redColor].CGColor;
    shapeView.layer.shadowRadius = 5.f;
    shapeView.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    shapeView.layer.shadowOpacity = 1.f;
    shapeView.frame = CGRectMake(50, 300, 200, 100);
    [self.view addSubview:shapeView];
    
    ShadowBoxView* shapeView2 = [[ShadowBoxView alloc] init];
    shapeView2.backgroundColor = [UIColor grayColor];
    shapeView2.layer.shadowColor = [UIColor redColor].CGColor;
    shapeView2.layer.shadowRadius = 5.f;
    shapeView2.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    shapeView2.layer.shadowOpacity = 1.f;
    shapeView2.frame = CGRectMake(50, 450, 200, 100);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:shapeView2.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10,10)];
    CAShapeLayer* borderLayer = [CAShapeLayer layer];
    borderLayer.path = maskPath.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor greenColor].CGColor;
    borderLayer.frame = shapeView.bounds;
    [shapeView2.layer addSublayer:borderLayer];
    [self.view addSubview:shapeView2];
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
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = self.dataList[indexPath.row];
    UITableViewCell *cell = [UITableViewCell cellFromCodeWithTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = data[@"title"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
    NSDictionary *data = self.dataList[indexPath.row];
    UIViewController *vc = [data[@"clazz"] new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

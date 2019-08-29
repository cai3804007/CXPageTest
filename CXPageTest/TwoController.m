//
//  TwoController.m
//  pageTest
//
//  Created by yoyochecknow on 2019/8/28.
//  Copyright © 2019 SeanOrganization. All rights reserved.
//

#import "TwoController.h"
#import "MJRefresh.h"
@interface TwoController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end
@implementation TwoController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [self tableViewWithTag:1 registerClass:[UITableViewCell class] cellReuseidentifier:@"cell"];
    [self.view addSubview:self.tableView];
  
    //    // 刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];
    self.tableView.mj_footer = [MJRefreshAutoFooter forwardingTargetForSelector:@selector(footer)];
}

- (void)header{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)footer{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
}
//
//- (void)endheader{
//    NSLog(@"2头部停止刷新");
//}
//
//- (void)endfooter{
//    NSLog(@"2尾部停止刷新");
//}
//
//- (void)beginfooter{
//    NSLog(@"2尾部开始刷新");
//    
//}
//- (void)beginheader{
//    NSLog(@"2头部开始刷新");
//}

// MARK: 统一tableView出口
- (UITableView *)tableViewWithTag:(NSInteger)tag registerClass:(nullable Class)cellClass cellReuseidentifier:(NSString *)identifier {
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 50);
    frame = frame;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.tag = tag;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    tableView.showsVerticalScrollIndicator = YES;
    [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.estimatedRowHeight = 100;
    return tableView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld页面,第%ld行",self.view.tag,indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UIView *)listView{
    return self.view;
}

- (UITableView *)listScrollView {
    return self.tableView;
}
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *scrollView))callback{
    self.scrollCallback = callback;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollCallback) {
        self.scrollCallback(scrollView);
    }
}
@end

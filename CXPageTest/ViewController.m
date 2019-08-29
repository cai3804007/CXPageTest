//
//  ViewController.m
//  CXPageTest
//
//  Created by yoyochecknow on 2019/8/29.
//  Copyright © 2019 SeanOrganization. All rights reserved.
//

#import "ViewController.h"
#import "JXCategoryView.h"
#import "OneController.h"
#import "TwoController.h"
#import "MJRefresh.h"
#import "JXPagerListRefreshView.h"

static const CGFloat JXTableHeaderViewHeight = 200;
static const CGFloat JXheightForHeaderInSection = 50;
@interface ViewController ()<JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic,strong) NSArray<id<JXPagerViewListViewDelegate>> *vcs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    _titles = @[@"能力", @"爱好"];
    _vcs = @[[[OneController alloc] init],[[TwoController alloc] init]];
    _userHeaderView = [[UIView alloc] init];
    _userHeaderView.backgroundColor = [UIColor redColor];
    _userHeaderView.userInteractionEnabled = YES;
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    lineView.indicatorLineWidth = 30;
    self.categoryView.indicators = @[lineView];
    
    _pagerView = [self preferredPagingView];
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];
    self.pagerView.mainTableView.bounces = NO;
    self.categoryView.contentScrollView = self.pagerView.listContainerView.collectionView;
    
    //导航栏隐藏的情况，处理扣边返回，下面的代码要加上
    [self.pagerView.listContainerView.collectionView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    [self.pagerView.mainTableView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
//    self.pagerView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.pagerView.mainTableView.mj_header endRefreshing];
//            NSLog(@"%ld",self.categoryView.selectedIndex);
//            OneController *one = (OneController *)self.vcs[self.categoryView.selectedIndex];
//            [one endheader];
//        });
//    }];
//    
//    self.pagerView.mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        NSLog(@"%ld",self.categoryView.selectedIndex);
//            OneController *one = (OneController *)self.vcs[self.categoryView.selectedIndex];
//        [one endfooter];
//        
//    }];
    
    
    
    

}
- (JXPagerView *)preferredPagingView {
    //头部上拉使用这个类
//    return [[JXPagerView alloc] initWithDelegate:self];
    //头部底底部刷新用这个类   需设置bounes = NO;
    return [[JXPagerListRefreshView alloc] initWithDelegate:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagerView.frame = self.view.bounds;
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.categoryView.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    
    return self.vcs[index];
}

-(BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


@end

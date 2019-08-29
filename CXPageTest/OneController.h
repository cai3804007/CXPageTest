//
//  OneController.h
//  pageTest
//
//  Created by yoyochecknow on 2019/8/28.
//  Copyright © 2019 SeanOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface OneController : UIViewController<JXPagerViewListViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
//- (void)endheader;
//- (void)endfooter;
//- (void)beginfooter;
//- (void)beginheader;
@end

NS_ASSUME_NONNULL_END

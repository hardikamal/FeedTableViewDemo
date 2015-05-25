//
//  ViewController.h
//  Feeds
//
//  Created by Hardik Amal on 5/25/15.
//  Copyright (c) 2015 Hardik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *feedsTableView;
@property(strong, nonatomic) NSMutableArray *feedsdataArray;
@property(strong, nonatomic) NSDictionary *feedsDict;
@property(strong, nonatomic) NSDictionary *heightsCache;
@property (nonatomic, assign) BOOL cellHeightCacheEnabled;
@end


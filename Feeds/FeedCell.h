//
//  FeedCell.h
//  Feeds
//
//  Created by Hardik Amal on 5/25/15.
//  Copyright (c) 2015 Hardik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timedateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *feedsImage;

@end

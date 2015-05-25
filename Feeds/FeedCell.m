//
//  FeedCell.m
//  Feeds
//
//  Created by Hardik Amal on 5/25/15.
//  Copyright (c) 2015 Hardik. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (void)awakeFromNib {
    // Initialization code
    // Fix the bug in iOS7 - initial constraints warning
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}

-(void)layoutSubviews
{
     [self cardSetup];
     [self imageSetup];
}

-(void)cardSetup
{

    self.cardView.layer.masksToBounds = NO;
    self.cardView.layer.cornerRadius = 1;
    self.cardView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.cardView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.cardView.layer.shadowOpacity = 0.5f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cardView.bounds];
    self.cardView.layer.shadowPath = path.CGPath;
    
    self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
}

-(void)imageSetup
{
    _profileImage.layer.cornerRadius = _profileImage.frame.size.width/2;
    _profileImage.clipsToBounds = YES;
    _profileImage.contentMode = UIViewContentModeScaleAspectFit;
    _profileImage.backgroundColor = [UIColor whiteColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

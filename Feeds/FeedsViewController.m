//
//  FeedsViewController.m
//  feed
//
//  Created by Hardik Amal on 5/12/15.
//  Copyright (c) 2015 Hardik. All rights reserved.
//

#import "FeedsViewController.h"
#import "FeedCell.h"
#import <ImageIO/ImageIO.h>
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import <ImageIO/ImageIO.h>
#import "UITableView+FDTemplateLayoutCell.h"

@interface FeedsViewController () {
    
}
@end

@implementation FeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.feedsTableView.estimatedRowHeight = 180;
    self.feedsTableView.fd_debugLogEnabled = YES;
    self.cellHeightCacheEnabled = YES;
    
    UINib *cellNib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [self.feedsTableView registerNib:cellNib forCellReuseIdentifier:@"FeedCellIdentifier"];
    
    [self retrieveFeedsData];
    self.feedsTableView.separatorColor = [UIColor clearColor];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}



#pragma mark - Table view data source



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellHeightCacheEnabled) {
        return [tableView fd_heightForCellWithIdentifier:@"FeedCellIdentifier" cacheByIndexPath:indexPath configuration:^(FeedCell *cell) {
            //[self configureCell:cell atIndexPath:indexPath];
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:@"FeedCellIdentifier" configuration:^(FeedCell *cell) {
            //[self configureCell:cell atIndexPath:indexPath];
        }];
        
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.feedsdataArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  NSLog(@"cellForRowAtIndexPath");
    
    NSString *name;
    NSString *imageURL;
    NSString *status;
    NSString *profilePic;
    NSString *timeStamp;
    
    
    
    FeedCell *cell = [self.feedsTableView dequeueReusableCellWithIdentifier:@"FeedCellIdentifier"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[FeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FeedCellIdentifier"];
    }
    
    NSDictionary *tempFeedsDictionary = [self.feedsdataArray objectAtIndex:indexPath.row];
    
    NSMutableDictionary *dict = [tempFeedsDictionary mutableCopy];
    NSArray *keysForNullValues = [dict allKeysForObject:[NSNull null]];
    [dict removeObjectsForKeys:keysForNullValues];
    
    
    name = [dict objectForKey:@"name"];
    
    imageURL = [dict objectForKey:@"image"];
    status = [dict objectForKey:@"status"];
    profilePic = [dict objectForKey:@"profilePic"];
    timeStamp = [dict objectForKey:@"timeStamp"];
    
    
    
    __weak FeedCell *weakCell = cell;
    // NSLog(@"Profile PIC not null--------%@-------",profilePic);
    NSURL *url = [NSURL URLWithString:profilePic];
    //  NSLog(@"nsurl");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"default_avatar"];
    [cell.profileImage setImageWithURLRequest:request
                             placeholderImage:placeholderImage
                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                          
                                          weakCell.profileImage.image = image;
                                          [weakCell setNeedsLayout];
                                          
                                      }
                                      failure:nil];
    
    cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
    cell.profileImage.clipsToBounds = YES;
    [cell.profileImage.layer setBorderColor:[[UIColor greenColor] CGColor]];
    [cell.profileImage.layer setBorderWidth:2.0];
    
    
    cell.titleLabel.text = name;
    cell.descriptionLabel.text = status;
    cell.timedateLabel.text = timeStamp;
    
    //  NSLog(@"Image not null--------%@-------",imageURL);
    if (imageURL != nil) {
        //  [cell.feedsImage setHidden:NO];
        NSURL *url1 = [NSURL URLWithString:imageURL];
        // NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
        [cell.feedsImage setImageWithURL:url1];
        
        
        [cell.feedsImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]]
                               placeholderImage:placeholderImage
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                            
                                            weakCell.feedsImage.image = image;
                                            [weakCell setNeedsLayout];
                                            
                                        }
                                        failure:nil];
        
    }else{
        // [cell.feedsImage setHidden:YES];
    }
    
    return cell;
    
}


- (void)retrieveFeedsData {
    
    //http://api.androidhive.info/feed/feed.json
    NSString *feedsUrl = @"http://api.almosthomevethousing.com/feed/rsrc.json";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:feedsUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *responseDict = responseObject;
             NSLog(@"Response Dict %@",responseDict);
             self.feedsdataArray = [responseDict objectForKey:@"feed"];
             
             [self.feedsTableView reloadData];
             /* do something with responseDict */
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             
             NSLog(@"Response Error %@",operation.responseString);
         }];
}


@end

//
//  ImagesTableViewController.m
//  Blocstagram
//
//  Created by rick m on 6/28/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "Datasource.h"
#import "Media.h"
#import "User.h"
#import "Comment.h"

@interface ImagesTableViewController ()

@end

@implementation ImagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Table view data source

- (NSArray *)items {
    NSArray *items = [Datasource sharedInstance].mediaItems;
    
    return items;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self items].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
// #1
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
 // Configure the cell...
 // #2
 
 static NSInteger imageViewTag = 1234;
     UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:imageViewTag];
 
 // #3
 if (!imageView) {
 // This a new cell, it doesn't have an image view yet
 imageView = [[UIImageView alloc] init];
 imageView.contentMode = UIViewContentModeScaleToFill;
 
 imageView.frame = cell.contentView.bounds;
 
 // #4
 imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
 
 imageView.tag = imageViewTag;
 [cell.contentView addSubview:imageView];
 }
 
     Media *item = [self items][indexPath.row];
     imageView.image = item.image;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Media *item = [self items][indexPath.row];
    UIImage *image = item.image;
    
    return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height;
}
@end

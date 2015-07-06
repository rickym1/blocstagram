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
#import "MediaTableViewCell.h"



@interface ImagesTableViewController ()


@end

@implementation ImagesTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Datasource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
   
    
    [self.tableView registerClass:[MediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
    
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

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Media *item = [Datasource sharedInstance].mediaItems[indexPath.row];
    if (item.image) {
        return 350;
    } else {
        return 150;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Datasource sharedInstance].mediaItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
     MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
     cell.mediaItem = [Datasource sharedInstance].mediaItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Media *item = [Datasource sharedInstance].mediaItems[indexPath.row];
    return [MediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
    
}

- (void) dealloc
{
    [[Datasource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [Datasource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        // We know mediaItems changed. Let's see what kind of change it is.
        NSKeyValueChange kindOfChange = [change [NSKeyValueChangeKindKey] unsignedIntegerValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            // Someone set a brand new images array
            [self.tableView reloadData];
       
        } else if (kindOfChange == NSKeyValueChangeInsertion ||
                   kindOfChange == NSKeyValueChangeRemoval ||
                   kindOfChange == NSKeyValueChangeReplacement) {
            // We have an incremental change: inserted, deleted, or replaced images
            
            // Get a list of the index (or indices) that changed
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            // #1 - Convert this NSIndexSet to an NSArray of NSIndexPaths (which is what the table view animation methods require)
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            // #2 Call 'beginUpdates' to tell the table view we're about to make changes
            [self.tableView beginUpdates];
            
            // Tell the table view what the changes are
            if (kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // Tell the table view that we're done telling it about changes, and to complete the animation
            [self.tableView endUpdates];
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Media *item = [Datasource sharedInstance].mediaItems[indexPath.row];
        [[Datasource sharedInstance] deleteMediaItem:item];
    }
}

- (void) refreshControlDidFire:(UIRefreshControl *) sender {
    [[Datasource sharedInstance] requestNewItemsWithCompletionHandler:^(NSError *error) {
        [sender endRefreshing];
    }];
}
- (void) infiniteScrollIfNecessary {
    // #3
    NSIndexPath *bottomIndexpath = [[self.tableView indexPathsForVisibleRows] lastObject];
    
    if (bottomIndexpath && bottomIndexpath.row == [Datasource sharedInstance].mediaItems.count - 1) {
        // The very last cell is on screen
        [[Datasource sharedInstance] requestOldItemsWithCompletionHandler:nil];
    }
}

# pragma mark - UIScrollViewDelegate

// #4
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self infiniteScrollIfNecessary];
}


@end

//
//  AppViewSearchParamsController.m
//  MusicBrainz
//
//  Created by Yang Jason on 15/8/5.
//  Copyright (c) 2015年 nero. All rights reserved.
//

#import "AppViewSearchParamsController.h"
#import "MbzApi+WebService.h"

@interface AppViewSearchParamsController ()
@property (nonatomic) NSArray *allEntities;
@end

@implementation AppViewSearchParamsController

+ (instancetype)loadFromStoryboard {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass(self.class) bundle:nil];
    id vc = [sb instantiateInitialViewController];
    NSParameterAssert([vc isKindOfClass:self.class]);
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSArray *allEntities = nil;
    if (!allEntities) {
        allEntities =
        @[MbzEntity_Area,
          MbzEntity_Artist,
          MbzEntity_Event,
          MbzEntity_Instrument,
          MbzEntity_Label,
          MbzEntity_Recording,
          MbzEntity_Release,
          MbzEntity_ReleaseGroup,
          MbzEntity_Series,
          MbzEntity_Work,
          MbzEntity_Url];
    }
    
    self.allEntities = allEntities;
    self.selectedEntity = MbzEntity_Artist;
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allEntities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *entity = self.allEntities[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = entity;
    cell.accessoryType = [entity isEqualToString:self.selectedEntity] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *entity = self.allEntities[indexPath.row];
    self.selectedEntity = entity;
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    for (UITableViewCell *cell in tableView.visibleCells) {
        if (cell != selectedCell) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

@end

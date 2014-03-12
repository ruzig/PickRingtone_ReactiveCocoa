//
//  OARingtonePickerViewController.m
//  RingtonePicker
//
//  Created by Phat, Le Tan on 3/12/14.
//  Copyright (c) 2014 75Lab. All rights reserved.
//

#import "OARingtonePickerViewController.h"

NSString *const ringtoneCellIdentifier = @"OARingtonePickerViewControllerIdentifier";

@interface OARingtonePickerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *ringtoneTableView;
@property (strong, nonatomic) NSArray *ringtones;
@property (copy, nonatomic) NSString *selectedRingtone;

@end

@implementation OARingtonePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _ringtones = @[@"Opening (Default)", @"Apex", @"Beacon", @"Bulentin", @"By The Seaside", @"Chimes", @"Circuit", @"Consetellation", @"Cosmic"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ringtoneTableView.delegate = self;
    self.ringtoneTableView.dataSource = self;
    [self.ringtoneTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ringtoneCellIdentifier];
}

- (NSString *)selectedRingtone
{
    if (!_selectedRingtone) {
        _selectedRingtone = @"Opening (Default)";
    }
    return _selectedRingtone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ringtones.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ringtoneCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.ringtones[indexPath.row];
    if ([self.selectedRingtone isEqualToString:self.ringtones[indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Ugly way:
    self.selectedRingtone = self.ringtones[indexPath.row];
    [tableView reloadData];
   [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE_RINGTONE" object:nil userInfo:@{ @"ringtone" : self.selectedRingtone }];
}

@end

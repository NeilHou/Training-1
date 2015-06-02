//
//  YKDetailViewController.m
//  L05_Amos
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import "YKDetailViewController.h"
#import "YKMovie.h"
#import "ViewController.h"
#import "ClickImage.h"

@interface YKDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet ClickImage *images;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularityLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorsLabel; //douban only
@property (weak, nonatomic) IBOutlet UILabel *castsLabel; //douban only
@property (weak, nonatomic) IBOutlet UILabel *durationsLabel; //douban only
@property (weak, nonatomic) IBOutlet UILabel *release_dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *votingLabel;
@property (weak, nonatomic) IBOutlet UILabel *voting_countLabel;
@property (weak, nonatomic) IBOutlet UITextView *overviewTextView;

//@property (strong, nonatomic) YKDetailViewController *detailViewController;

@end

@implementation YKDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images.canClick = YES;
    
    [self.navigationController setNavigationBarHidden:NO];
//    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc]
//                                   initWithTitle:@"换个颜色" style:
//                                   UIBarButtonItemStylePlain target:self
//                                   action: @selector  (changeTextColor)];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)showAvatar:(UITapGestureRecognizer*)sender {
    [YKDetailViewController showImage:(UIImageView*)sender.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    YKMovie *movie = self.movie;
    self.navigationItem.title = movie.title;
    self.titleLabel.text = movie.title;
    self.popularityLabel.text = [NSString stringWithFormat:@"%@", movie.popularity];
    self.release_dateLabel.text = movie.release_date;
    self.votingLabel.text = [NSString stringWithFormat:@"%@", movie.voting];
    self.voting_countLabel.text = [NSString stringWithFormat:@"(%@人评论)", movie.voting_count];
    self.overviewTextView.text = movie.overview;
    self.images.image = movie.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

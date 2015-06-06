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
#import "YKAlternativeTableViewController.h"
#import "YKJsonData.h"


@interface YKDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet ClickImage *images;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularityLabel;
@property (weak, nonatomic) IBOutlet UILabel *release_dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *votingLabel;
@property (weak, nonatomic) IBOutlet UILabel *voting_countLabel;
@property (weak, nonatomic) IBOutlet UITextView *overviewTextView;
@property (weak, nonatomic) IBOutlet UILabel *revenueLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *taglineLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetLabel;

@end


@implementation YKDetailViewController

@synthesize alternativeArray;

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
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"别名" style:UIBarButtonItemStylePlain target:self action:@selector(pushToAlternative)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)pushToAlternative
{
    YKAlternativeTableViewController *alternativeVC = [YKAlternativeTableViewController new];
    
    NSString *alternativeURL = [NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%@/alternative_titles?api_key=e55425032d3d0f371fc776f302e7c09b", self.movie.movieId];
    
    alternativeArray = [NSMutableArray array];
    
    [YKJsonData alternativeDataWithUrl:alternativeURL success:^(id movie) {
        alternativeArray = movie;
        [alternativeVC reloadAlternativeData:alternativeArray];
    } fail:^{
        
    }];
    
    [self.navigationController pushViewController:alternativeVC animated:YES];
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
    self.voting_countLabel.text = [NSString stringWithFormat:@"(%@人评价)", movie.voting_count];
    self.overviewTextView.text = movie.overview;
    self.images.image = movie.detailImage;
    
    //满千使用逗号
    NSNumberFormatter *numFormatter = [NSNumberFormatter new];
    numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    self.revenueLabel.text = [NSString stringWithFormat:@"$%@", [numFormatter stringFromNumber:movie.revenue]];
    self.budgetLabel.text = [NSString stringWithFormat:@"$%@", [numFormatter stringFromNumber:movie.budget]];
    
    self.runtimeLabel.text = [NSString stringWithFormat:@"%@分钟", movie.runTime];
    self.taglineLabel.text = movie.tagline;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

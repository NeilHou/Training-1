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
#import "YKCastsTavleViewC.h"


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

@synthesize alternativeArray, castsArray;

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
    
    UIImage *earthIron = [UIImage imageNamed:@"globe-50@2x.png"];
    UIImage *castsIron = [UIImage imageNamed:@"group_filled-50@2x.png"];
    
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithImage:earthIron style:UIBarButtonItemStylePlain target:self action:@selector(pushToAlternative)];
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc] initWithImage:castsIron style:UIBarButtonItemStylePlain target:self action:@selector(pushToCasts)];
    
    NSArray *rightButtons = [[NSArray alloc] initWithObjects:rightButton1, rightButton2, nil];
    self.navigationItem.rightBarButtonItems = rightButtons;
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

- (void)pushToCasts
{
    YKCastsTavleViewC *castsVC = [YKCastsTavleViewC new];
    
    NSString *castURL = [NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%@/credits?api_key=e55425032d3d0f371fc776f302e7c09b", self.movie.movieId];
    
    castsArray = [NSMutableArray array];
    
    [YKJsonData castsDataWithUrl:castURL success:^(id movie) {
        castsArray = movie;
        [castsVC reloadCastsData:castsArray];
    } fail:^{
        
    }];
    
    [self.navigationController pushViewController:castsVC animated:YES];
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
    
    //满千使用逗号
    NSNumberFormatter *numFormatter = [NSNumberFormatter new];
    numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    self.revenueLabel.text = [NSString stringWithFormat:@"$%@", [numFormatter stringFromNumber:movie.revenue]];
    self.budgetLabel.text = [NSString stringWithFormat:@"$%@", [numFormatter stringFromNumber:movie.budget]];
    
    self.runtimeLabel.text = [NSString stringWithFormat:@"%@分钟", movie.runTime];
    self.taglineLabel.text = movie.tagline;
    
    self.images.image = movie.detailImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

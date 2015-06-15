//
//  YKDetailViewController.m
//  L05_Amos
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

#import "YKDetailViewController.h"
#import "YKMovie.h"
#import "ViewController.h"
#import "ClickImage.h"
#import "YKAlternativeTableViewController.h"
#import "YKJsonData.h"
#import "YKCastsTavleViewC.h"
#import "UIImageView+WebCache.h"


@interface YKDetailViewController ()<UIScrollViewDelegate, UIAlertViewDelegate>

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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *imageBGView;
@property (weak, nonatomic) IBOutlet UIButton *dateSelectButton;

@property (strong, nonatomic) NSString *movieTitlestr;
@property (strong, nonatomic) NSNumber *movieRunTime;
@property (strong, nonatomic) NSNumber *movieVoting;
@property (strong, nonatomic) NSString *movieTagline;
@property (strong, nonatomic) NSString *movieReleaseDate;

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
    
    [_dateSelectButton setBackgroundImage:[UIImage imageNamed:@"date_to-50_selected@2x"] forState:UIControlStateDisabled];
    [_dateSelectButton setBackgroundImage:[UIImage imageNamed:@"date_to-50_selected@2x"] forState:UIControlStateHighlighted];
    
    UIImage *earthIron = [UIImage imageNamed:@"globe-50@2x.png"];
    UIImage *castsIron = [UIImage imageNamed:@"frankensteins_monster-48@2x.png"];
    
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithImage:earthIron style:UIBarButtonItemStylePlain target:self action:@selector(pushToAlternative)];
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc] initWithImage:castsIron style:UIBarButtonItemStylePlain target:self action:@selector(pushToCasts)];
    
    NSArray *rightButtons = [[NSArray alloc] initWithObjects:rightButton1, rightButton2, nil];
    self.navigationItem.rightBarButtonItems = rightButtons;
    
    //初始化一个状态指示器
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
                              initWithFrame:CGRectMake(57.0,70.0,30.0,30.0)];
    _activityIndicatorView.center = self.imageBGView.center;
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;  //设置样式
    _activityIndicatorView.hidesWhenStopped = YES;  //停止后自动隐藏
    [self.imageBGView addSubview:_activityIndicatorView];  //附着在当前试图
    [_activityIndicatorView startAnimating];
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
    
    //异步处理detailImage
    NSString *detailImgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w500%@",movie.postPath ];
    NSURL *detailURL = [NSURL URLWithString:detailImgURLString ];
    
    [self.images sd_setImageWithURL:detailURL
                   placeholderImage:nil
                            options:SDWebImageRetryFailed
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                              [_activityIndicatorView stopAnimating];
                          }];
    
    //设置属性以便创建日程
    _movieTitlestr = movie.title;
    _movieRunTime = movie.runTime;
    _movieReleaseDate = movie.release_date;
    _movieTagline = movie.tagline;
    _movieVoting = movie.voting;
}

- (IBAction)selectedTheDate:(id)sender {
    
    [self checkEventStoreAccessForCalendar];
}

#pragma mark Access Calendar申请许可的方法

// Check the authorization status of our application for Calendar
-(void)checkEventStoreAccessForCalendar
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    NSLog(@"请求许可错误");
                }
                else if (!granted)
                {
                    NSLog(@"被用户拒绝");
                }
                else
                {
                    [self accessGrantedForCalendar:eventStore];
                }
            });
        }];
    }
}

#pragma mark - 写入日程的方法

-(void)accessGrantedForCalendar:(EKEventStore *)eventStore
{
    
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    
    event.title     = [NSString stringWithFormat:@"《%@》今日上映", _movieTitlestr];  //事件标题
    
    NSString *notesStr = [NSString stringWithFormat:@"名称：%@\n长度：%@分钟\n评分：%@\n宣传：%@\n", _movieTitlestr, _movieRunTime, _movieVoting, _movieTagline];
    event.notes     = notesStr;
    event.location  = @"选一个电影院吧";
    
    //设置时间和日期
    
    NSDateFormatter* inputFormatter = [NSDateFormatter new];
    [inputFormatter setDateFormat:@"YYYY-MM-dd"];
    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    NSDate *releseDate = [inputFormatter dateFromString:_movieReleaseDate];
    NSDate *currentDate = [NSDate date];
    
    event.startDate = releseDate;
    event.endDate   = releseDate;
    event.allDay = YES;
    
    //对比现在的时间和放映时间，未来的才可以建立日程
    if ([releseDate compare:currentDate] == NSOrderedDescending) {
        
        //添加提醒
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 4]];  //4小时前提醒
        //    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];  //15分钟前提醒
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        
        NSString *messagestr = [NSString stringWithFormat:@"日程将会在创建在\n%@\n到时会有一个萌萌哒的提醒:-D", _movieReleaseDate];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"请问是否要创建该日程"
                              message:messagestr
                              delegate:self
                              cancelButtonTitle:@"好的"
                              otherButtonTitles:@"转到日历", nil];
        [alert show];
    }else{
        NSString *messagestr = [NSString stringWithFormat:@"电影早就在%@上映了\n去网上找找片源吧，亲!:-P", _movieReleaseDate];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"有意义吗"
                              message:messagestr
                              delegate:nil
                              cancelButtonTitle:@"好吧"
                              otherButtonTitles:nil];
        [alert show];
    }
}

//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDateFormatter* inputFormatter = [NSDateFormatter new];
    [inputFormatter setDateFormat:@"YYYY-MM-dd"];
    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *releseDate = [inputFormatter dateFromString:_movieReleaseDate];
    
    NSInteger interval = [releseDate timeIntervalSinceReferenceDate];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"calshow:%ld", interval]];
    NSLog(@"%@", url);
    
    if (buttonIndex == 1) {

            //跳转到日历：今天
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"calshow://"]];
            //跳转到日历：指定日期
            [[UIApplication sharedApplication] openURL:url];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
static CGRect oldframe;

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

#pragma mark - 图片点击缩放

+(void)showImage:(UIImageView *)avatarImageView{
    
    UIImage *image = avatarImageView.image;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor=[UIColor grayColor];
    backgroundView.alpha=0.4;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end

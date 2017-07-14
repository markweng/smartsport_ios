//
//  meVC.m
//  football
//
//  Created by 雨停 on 2017/6/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "meVC.h"
#import "NavigationVC.h"
#import "meCell.h"
#import "meHeadView.h"
#import "UIButton+Badge.h"
#import "myClassVC.h"
#import "myCollectVC.h"
#import "myOrderVC.h"
#import "RegistVC.h"
#import "LoginVC.h"
@interface meVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView       * tab;
@property (strong, nonatomic) UIButton          * right;
@property (strong, nonatomic) UIButton          * left;
@property (nonatomic ,strong) UILabel           * meLab;
@property (strong, nonatomic) NSMutableArray    * arr;



@end

@implementation meVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
   }
-(void)headCheakBtn:(UIButton * )sender{
    if(sender.tag==0){
        
    }else if(sender.tag ==1){
        
    }
}
-(void)setSubview{
    UIView  * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.right = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-36, 32, 20, 20)];
    self.right.badgeValue = @"0";
    self.right.tag =1;
    [self.right setBadgeMinSize:8];
    [self.right addTarget:self action:@selector(headCheakBtn:) forControlEvents:UIControlEventTouchDragInside];
    [self.right setBackgroundImage:Img(@"cat.jpeg") forState:UIControlStateNormal];
    self.right.badgeBGColor = [UIColor redColor];
    [topView addSubview:self.right];
    
    self.left = [[UIButton alloc]initWithFrame:CGRectMake(16, 32, 20, 20)];
    self.left.tag =1;
    [self.left setBackgroundImage:Img(@"cat.jpeg") forState:UIControlStateNormal];
    self.left.badgeBGColor = [UIColor redColor];
     [self.left addTarget:self action:@selector(headCheakBtn:) forControlEvents:UIControlEventTouchDragInside];
    [topView addSubview:self.left];
    
    self.meLab   = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:0 text:@"我的" fontSize:17];
    self.meLab.font = FontBold(17);
    self.meLab.frame = CGRectMake(0, 32, 150, 24);
    self.meLab.centerX = SCREEN_WIDTH/2.0;

    [topView addSubview:self.meLab];
    topView.backgroundColor = mainColor;
    [self.view addSubview:topView];
    
    NSArray * arr = @[
                      @{@"title":@"我的课程",@"detaile":@""},
                      @{@"title":@"我的收藏",@"detaile":@""},
                      @{@"title":@"我的视屏",@"detaile":@""},
                      @{@"title":@"我的球队",@"detaile":@""}

                     ];
    NSArray * arr2 = @[
                        @{@"title":@"娱乐",@"detaile":@""}
                       ];
    NSArray * arr3 = @[ @{@"title":@"我的会员",@"detaile":@""},
                        @{@"title":@"我的订单",@"detaile":@""}
                        ];
    self.arr = [NSMutableArray array];
    [self.arr addObject:arr];
    [self.arr addObject:arr2];
    [self.arr addObject:arr3];
    
    CGFloat const ViewHeight =SCREENH_HEIGHT-50-64;
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, ViewHeight) style:UITableViewStyleGrouped];
    [self.view addSubview: self.tab];
    self.tab.delegate   = self;
    self.tab.dataSource = self;
    self.tab.bounces= NO;
    //self.tab.backgroundColor =[UIColor colorWithHexString:@"#3CB963"];
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.tableHeaderView = [self setView];
    [self.tab registerClass:[meCell class] forCellReuseIdentifier: NSStringFromClass([meCell class])];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section  ==0){
        NSArray * arr = self.arr[0];
        return arr.count ;
    }else if(section==1){
        NSArray * arr = self.arr[1];
        return arr.count ;
    }
    else if(section ==2){
        NSArray * arr = self.arr[2];
        return arr.count ;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;//这里是设置tableView的第一部分的头视图高度为0.01
    }else {
        return 10;//这里设置其他部分的头视图高度为10
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;//设置尾视图高度为0.01
}



-(UIView *)setView{
    meHeadView * vic = [[NSBundle mainBundle] loadNibNamed:@"meHead" owner:nil options:nil].lastObject;
    vic.frame = CGRectMake(0, 0, SCREEN_WIDTH, 144);
    WeakSelf(self);
    vic.setInfoBlock = ^{
     LoginVC * login = [[LoginVC alloc]init];
    NavigationVC   * nav  = [[NavigationVC alloc]initWithRootViewController:login];
     [weakself presentViewController:nav animated:YES completion:nil];
    };
    return vic;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class currentClass = [meCell class];
    meCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic  =self.arr [indexPath.section][indexPath.row];
    return cell;
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       self.hidesBottomBarWhenPushed=YES;
    if(indexPath.section ==0){
        if(indexPath.row==0){
            
            myClassVC *classVC=[[myClassVC    alloc]init];
            [self.navigationController pushViewController:classVC animated:YES];
            
        }else if(indexPath.row==1){
            
            myCollectVC  *collectVC=[[  myCollectVC     alloc]init];
            [self.navigationController pushViewController:collectVC animated:YES];
            
            
        }
    }else if(indexPath.section==1){
        
        
    }else if(indexPath.section==2){
        if(indexPath.row ==0){
            
        }else{
            myOrderVC  *orderVC=[[  myOrderVC     alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
    }
     self.hidesBottomBarWhenPushed=NO;
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden =NO;
    
    
}


@end

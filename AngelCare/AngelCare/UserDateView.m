//
//  UserDateView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/10/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserDateView.h"
#import "MainClass.h"

#define UserDate_Name NSLocalizedStringFromTable(@"UserDate_Name", INFOPLIST, nil)
#define UserDate_Phone NSLocalizedStringFromTable(@"UserDate_Phone", INFOPLIST, nil)
#define UserDate_Address NSLocalizedStringFromTable(@"UserDate_Address", INFOPLIST, nil)
#define UserDate_Sex NSLocalizedStringFromTable(@"UserDate_Sex", INFOPLIST, nil)
#define UserDate_Imei NSLocalizedStringFromTable(@"UserDate_Imei", INFOPLIST, nil)
#define UserDate_NOSET NSLocalizedStringFromTable(@"UserDate_NOSET", INFOPLIST, nil)

#define UserDate_PersonInfo NSLocalizedStringFromTable(@"UserDate_PersonInfo", INFOPLIST, nil)

#define UserDate_SoSInfo NSLocalizedStringFromTable(@"UserDate_SoSInfo", INFOPLIST, nil)

#define UserDate_FamilyInfo NSLocalizedStringFromTable(@"UserDate_FamilyInfo", INFOPLIST, nil)

#define UserDate_MedInfo NSLocalizedStringFromTable(@"UserDate_MedInfo", INFOPLIST, nil)

#define UserDate_HosInfo NSLocalizedStringFromTable(@"UserDate_HosInfo", INFOPLIST, nil)
#define UserDate_SexBoy NSLocalizedStringFromTable(@"UserDate_SexBoy", INFOPLIST, nil)

#define UserDate_SexGirl NSLocalizedStringFromTable(@"UserDate_SexGirl", INFOPLIST, nil)
@implementation UserDateView
@synthesize UserImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//設定佩戴者資訊
-(void)setAccountData:(NSDictionary *)dic
{
    personDic = dic;
    sexType = [[personDic objectForKey:@"sex"] integerValue];
    NSString *imgurl = [personDic objectForKey:@"img_url"];
    
    if (imgurl.length >0) {
        
        
        [self downloadImageWithURL:[NSURL URLWithString:imgurl] completionBlock:^(BOOL succeeded, UIImage *image) {
            
            if (succeeded) {
                tempImg = image;
                [listTable reloadData];
            }else
            {
                tempImg = [UIImage imageNamed:@"mhicon"];
            }
            
        }];
        
        
//        tempImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
    }else
    {
        tempImg = [UIImage imageNamed:@"mhicon"];
    }
    
                                                                    
    NSLog(@"sex type = %d",sexType);
    [listTable reloadData];
}


//設定緊急聯絡電話與親情聯絡電話
-(void)setSoSandFamilyPhone:(NSDictionary *)dic
{
    phoneDic = dic;
    NSLog(@"phone Dic = %@",dic);
    [listTable reloadData];
}

//設定吃藥提醒
-(void)setMedRemind:(NSDictionary *)dic
{
    
    medDic = [dic objectForKey:@"Data"];
    NSLog(@"medDic dic = %@",medDic);
}

//設定回診提醒
-(void)setHosRemind:(NSDictionary *)dic
{
    hosDic = [dic objectForKey:@"Data"];
    NSLog(@"hosDic dic = %@",hosDic);
    [listTable reloadData];
}

//  設定此Ｖiew 
-(void)Set_Init:(id)sender
{
    
    MainObj = sender;
    nowEdit = 0;
    personDic = [[NSDictionary alloc] init];
    phoneDic = [[NSDictionary alloc] init];
    tempImg = [UIImage imageNamed:@"mhicon"];
    sosName1 = @"";
    sosName2 = @"";
    sosName3 = @"";
    sosPhone1 = @"";
    sosPhone2 = @"";
    sosPhone3 = @"";
    familyName1 = @"";
    familyName2 = @"";
    familyName3 = @"";
    familyPhone1 = @"";
    familyPhone2 = @"";
    familyPhone3 = @"";
    nameStr = @"";
    phoneStr = @"";
    sexType = 0;
    addrStr = @"";
    
    [nowTxt resignFirstResponder];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [listTable reloadData];
}


//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    headerView.backgroundColor = [UIColor colorWithRed:0.94 green:0.82 blue:0.25 alpha:1];
    [headerView setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
    titleLbl.backgroundColor = [UIColor clearColor];
    [titleLbl setTextColor:[UIColor whiteColor]];
    UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(290, 2.5, 25, 25)];
    [editBtn setImage:[UIImage imageNamed:@"icon_edit.png"] forState:UIControlStateNormal];
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(255, 2.5, 25, 25)];
    [saveBtn setImage:[UIImage imageNamed:@"correct.png"] forState:UIControlStateNormal];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(290, 2.5, 25, 25)];
    [cancelBtn setImage:[UIImage imageNamed:@"incorrect.png"] forState:UIControlStateNormal];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        headerView.frame = CGRectMake(0, 0, 768, 50);
        titleLbl.frame = CGRectMake(20, 0, 500, 50);
        titleLbl.font = [UIFont systemFontOfSize:20];
        editBtn.frame = CGRectMake(718, 5, 40, 40);
        saveBtn.frame = CGRectMake(568, 5, 40, 40);
        cancelBtn.frame = CGRectMake(718, 5, 40, 40);
    }
    
    switch (section) {
        case 0:
            titleLbl.text = UserDate_PersonInfo;
            if (nowEdit == 1) {
                [saveBtn addTarget:self action:@selector(UpdatePersonInfo) forControlEvents:UIControlEventTouchUpInside];
                [cancelBtn addTarget:self action:@selector(CancelEdit) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:saveBtn];
                [headerView addSubview:cancelBtn];
                
            }else
            {
            [editBtn addTarget:self action:@selector(editPerson) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:editBtn];
            }
            break;
        
        case 1:
            titleLbl.text =  UserDate_SoSInfo;
            if (nowEdit == 2) {
                [saveBtn addTarget:self action:@selector(UpdateSoSInfo) forControlEvents:UIControlEventTouchUpInside];
                [cancelBtn addTarget:self action:@selector(CancelEdit) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:saveBtn];
                [headerView addSubview:cancelBtn];
                
            }else
            {
            [editBtn addTarget:self action:@selector(editSoSPhone) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:editBtn];
            }
            break;
            
        case 2:
            titleLbl.text = UserDate_FamilyInfo;
            if (nowEdit == 3) {
                [saveBtn addTarget:self action:@selector(UpdateFailyInfo) forControlEvents:UIControlEventTouchUpInside];
                [cancelBtn addTarget:self action:@selector(CancelEdit) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:saveBtn];
                [headerView addSubview:cancelBtn];
                
            }else
            {
            [editBtn addTarget:self action:@selector(editFamilyPhone) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:editBtn];
            }
            break;
            
        case 3:
            titleLbl.text = UserDate_MedInfo;
            if (nowEdit == 4) {
                [saveBtn addTarget:self action:@selector(UpdatePersonInfo) forControlEvents:UIControlEventTouchUpInside];
                [cancelBtn addTarget:self action:@selector(CancelEdit) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:saveBtn];
                [headerView addSubview:cancelBtn];
                
            }else
            {
                [editBtn addTarget:self action:@selector(editMedRemind) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:editBtn];
            }
            
            break;
            
        case 4:
            titleLbl.text = UserDate_HosInfo;
            if (nowEdit == 5) {
                [saveBtn addTarget:self action:@selector(UpdatePersonInfo) forControlEvents:UIControlEventTouchUpInside];
                [cancelBtn addTarget:self action:@selector(CancelEdit) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:saveBtn];
                [headerView addSubview:cancelBtn];
                
            }else
            {
            [editBtn addTarget:self action:@selector(editHosRemind) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:editBtn];
            }
            break;
        
        default:
            break;
    }
    [headerView addSubview:titleLbl];
    
    return headerView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 50;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGFloat height;
    switch (indexPath.section) {
        case 0:
            height = 200.0f;
            break;

        case 2:
            height = 80.0f;
            break;
        case 1:
        case 3:
        case 4:
        default:
            height = 50.0f;
            break;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger rows;
    switch (sectionIndex) {
        case 0:
            rows = 1;//個人資訊
            break;
        
        case 1:
            rows = 3;//緊急電話
            break;
            
        case 2:
            rows = 3;//親情電話
            break;
        
        case 3:
            rows = 5;//吃藥提醒
            break;
            
        case 4:
            rows = 2;//回診提醒
    }
    
    return rows;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        
        if (nowEdit == 1) {//處於編輯狀態
            NSString *cellIdentifier = @"EditPersonInfoCell";
            EditPersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[EditPersonInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"EditPersonInfoCell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"EditPersonInfoCell" owner:self options:nil] objectAtIndex:0];
            }
            
            
            
            cell.NameLbl.text = UserDate_Name;
            
            
            cell.SexLbl.text = UserDate_Sex;
            cell.PhoneLbl.text = UserDate_Phone;
            cell.imei.text = UserDate_Imei;
            cell.AddrLbl.text = UserDate_Address;
            cell.manLbl.text = UserDate_SexBoy;
            cell.womanLbl.text = UserDate_SexGirl;
            
            
            cell.nameTxt.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"name"]];
            
            nameStr = [personDic objectForKey:@"name"];
            phoneStr = [personDic objectForKey:@"phone"];
            addrStr = [personDic objectForKey:@"address"];
            
            if (sexType == 2) {
                //女生
                [cell.womanbtn setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
                [cell.manBtn setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
                
            }else
            {
                //男生
                [cell.womanbtn setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
                [cell.manBtn setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
            }
            
            [cell.womanbtn setTag:2];
            [cell.manBtn setTag:1];
            [cell.womanbtn addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
            [cell.manBtn addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
            
            
            cell.UserImg.image = tempImg;
            
            
            cell.phoneTxt.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"phone"]];
            
            
            cell.IMEILbl.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"imei"]];
            
            
            cell.addrTxt.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"address"]];
            //鎖住地址編輯
            cell.lblAddr.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"address"]];
            
            cell.nameTxt.placeholder = NSLocalizedStringFromTable(@"UserDate_Name", INFOPLIST, nil);
            cell.addrTxt.placeholder = NSLocalizedStringFromTable(@"UserDate_Address", INFOPLIST, nil);
            cell.phoneTxt.placeholder = NSLocalizedStringFromTable(@"UserDate_Phone", INFOPLIST, nil);
            
            cell.backgroundColor = [UIColor clearColor];
            
            [cell.ImgBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.nameTxt.delegate = self;
            cell.phoneTxt.delegate = self;
            cell.addrTxt.delegate = self;
            
            cell.nameTxt.tag = 101;
            cell.phoneTxt.tag = 102;
            cell.addrTxt.tag = 103;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
        
        NSString *cellIdentifier = @"PersonInfoCell";
        PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[PersonInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonInfoCell_iPad" owner:self options:nil] objectAtIndex:0];
        }else
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonInfoCell" owner:self options:nil] objectAtIndex:0];
        }
        
        
        
        cell.NameLbl.text = UserDate_Name;
        NSString *sexStr;
        
        
        cell.SexLbl.text = UserDate_Sex;
        cell.PhoneLbl.text = UserDate_Phone;
        cell.imei.text = UserDate_Imei;
        cell.AddrLbl.text = UserDate_Address;
        
        
        
            cell.UserNameLbl.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"name"]];
            
            if ([[personDic objectForKey:@"sex"] isEqualToString:@"1"]) {
                sexStr = UserDate_SexBoy;
            }else
            {
                sexStr = UserDate_SexGirl;
            }
            cell.UserSexLbl.text = sexStr;
            
            cell.UserImg.image = tempImg;
            
            
            
            cell.UserPhone.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"phone"]];
            
            
            cell.IMEILbl.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"imei"]];
            
            cell.UserAddressLbl.text = [NSString stringWithFormat:@"%@",[personDic objectForKey:@"address"]];
            
        
        
        cell.backgroundColor = [UIColor clearColor];

        [cell.ImgBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
    }
    
    if (indexPath.section == 1)
    {
        if (nowEdit == 2) {//SOS處於編輯狀態
            
            NSString *cellIdentifier = @"EditFormat1Cell";
            EditFormat1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[EditFormat1Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"EditFormat1Cell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"EditFormat1Cell" owner:self options:nil] objectAtIndex:0];
            }
            
            cell.noLbl.text = [NSString stringWithFormat:@"%i.",indexPath.row+1];
            
            
            
            if (![phoneDic objectForKey:[NSString stringWithFormat:@"personPhone%i",indexPath.row+1]]) {
            }else
            {
                switch (indexPath.row) {
                    case 0:
                        sosName1 = [phoneDic objectForKey:[NSString stringWithFormat:@"personName%i",indexPath.row+1]];
                        sosPhone1 = [phoneDic objectForKey:[NSString stringWithFormat:@"personPhone%i",indexPath.row+1]];
                        break;
                    case 1:
                        sosName2 = [phoneDic objectForKey:[NSString stringWithFormat:@"personName%i",indexPath.row+1]];
                        sosPhone2 = [phoneDic objectForKey:[NSString stringWithFormat:@"personPhone%i",indexPath.row+1]];
                        break;
                        
                    case 2:
                        sosName3 = [phoneDic objectForKey:[NSString stringWithFormat:@"personName%i",indexPath.row+1]];
                        sosPhone3 = [phoneDic objectForKey:[NSString stringWithFormat:@"personPhone%i",indexPath.row+1]];
                        break;
                }
                
                NSString *sosName = [phoneDic objectForKey:[NSString stringWithFormat:@"personName%i",indexPath.row+1]];
                NSString *sosPhone = [phoneDic objectForKey:[NSString stringWithFormat:@"personPhone%i",indexPath.row+1]];
                
                
                cell.nameTxt.placeholder = NSLocalizedStringFromTable(@"UserDate_Name", INFOPLIST, nil);
                cell.phoneTxt.placeholder = NSLocalizedStringFromTable(@"UserDate_Phone", INFOPLIST, nil);
                
                cell.nameTxt.text = sosName;
                cell.phoneTxt.text = sosPhone;
            }
            cell.nameTxt.delegate = self;
            cell.phoneTxt.delegate = self;
            
            [cell.nameTxt setTag:[[NSString stringWithFormat:@"2%i1",indexPath.row+1] integerValue]];
            [cell.phoneTxt setTag:[[NSString stringWithFormat:@"2%i2",indexPath.row+1] integerValue]];
            
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Return" style:UIBarButtonItemStyleDone target:self action:@selector(doneSOSTxt)],
                                   nil];
            [numberToolbar sizeToFit];
            
            cell.phoneTxt.inputAccessoryView = numberToolbar;
            
            return cell;
            
            
        }
        else
        {
            NSString *cellIdentifier = @"Format1Cell";
            Format1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[Format1Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Format1Cell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Format1Cell" owner:self options:nil] objectAtIndex:0];
            }
        
            cell.noLbl.text = [NSString stringWithFormat:@"%i.",indexPath.row+1];
            
            
            
            if (![phoneDic objectForKey:[NSString stringWithFormat:@"personPhone%i",indexPath.row+1]]) {
                cell.titleLbl.text = [NSString stringWithFormat:@"%@",UserDate_NOSET];
                cell.subtitleLbl.text = @"";
            }else
            {
                
                NSString *sosName = [phoneDic objectForKey:[NSString stringWithFormat:@"personName%i",indexPath.row+1]];
                NSString *sosPhone = [phoneDic objectForKey:[NSString stringWithFormat:@"personPhone%i",indexPath.row+1]];
                
                if (sosName.length == 0) {
                    cell.titleLbl.text = [NSString stringWithFormat:@"%@",UserDate_NOSET];
                }else
                {
                    cell.titleLbl.text = [NSString stringWithFormat:@"%@",sosName];
                    
                }
                
                if (sosPhone.length == 0) {
                    cell.subtitleLbl.text = @"";
                }else
                {
                    cell.subtitleLbl.text = [NSString stringWithFormat:@"%@",sosPhone];
                }
                
            }
        
            return cell;
        }
    }
    
    if (indexPath.section == 2)
    {
        if (nowEdit == 3)//親情電話
        {
            NSString *cellIdentifier = @"EditFormat1Cell";
            EditFormat1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[EditFormat1Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"EditFormat1Cell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"EditFormat1Cell" owner:self options:nil] objectAtIndex:0];
            }
            
            cell.noLbl.text = [NSString stringWithFormat:@"%i.",indexPath.row+1];
            
            
            
            if (![phoneDic objectForKey:[NSString stringWithFormat:@"familyPhone%i",indexPath.row+1]]) {
            }else
            {
                switch (indexPath.row) {
                    case 0:
                        familyName1 = [phoneDic objectForKey:[NSString stringWithFormat:@"familyName%i",indexPath.row+1]];
                        familyPhone1 = [phoneDic objectForKey:[NSString stringWithFormat:@"familyPhone%i",indexPath.row+1]];
                        break;
                    case 1:
                        familyName2 = [phoneDic objectForKey:[NSString stringWithFormat:@"familyName%i",indexPath.row+1]];
                        familyPhone2 = [phoneDic objectForKey:[NSString stringWithFormat:@"familyPhone%i",indexPath.row+1]];
                        break;
                        
                    case 2:
                        familyName3 = [phoneDic objectForKey:[NSString stringWithFormat:@"familyName%i",indexPath.row+1]];
                        familyPhone3 = [phoneDic objectForKey:[NSString stringWithFormat:@"familyPhone%i",indexPath.row+1]];
                        break;
                }
                
                NSString *sosName = [phoneDic objectForKey:[NSString stringWithFormat:@"familyName%i",indexPath.row+1]];
                NSString *sosPhone = [phoneDic objectForKey:[NSString stringWithFormat:@"familyPhone%i",indexPath.row+1]];
                
                
                
                cell.nameTxt.text = sosName;
                cell.phoneTxt.text = sosPhone;
                cell.nameTxt.placeholder = NSLocalizedStringFromTable(@"UserDate_Name", INFOPLIST, nil);
                cell.phoneTxt.placeholder = NSLocalizedStringFromTable(@"UserDate_Phone", INFOPLIST, nil);
            }
            cell.nameTxt.delegate = self;
            cell.phoneTxt.delegate = self;
            
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleBlackTranslucent;
            numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Return" style:UIBarButtonItemStyleDone target:self action:@selector(doneFamilyTxt)],
                                   nil];
            [numberToolbar sizeToFit];
            
            cell.phoneTxt.inputAccessoryView = numberToolbar;
            
            [cell.nameTxt setTag:[[NSString stringWithFormat:@"3%i1",indexPath.row+1] integerValue]];
            [cell.phoneTxt setTag:[[NSString stringWithFormat:@"3%i2",indexPath.row+1] integerValue]];
            
            return cell;
        }else
        {
            NSString *cellIdentifier = @"Format2Cell";
            Format2Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[Format2Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Format2Cell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Format2Cell" owner:self options:nil] objectAtIndex:0];
            }
            
             
            NSLog(@"familyIconList %@",[[phoneDic objectForKey:@"familyIconList"] objectAtIndex:indexPath.row]);
                
                
            [self downloadImageWithURL:[NSURL URLWithString:[[phoneDic objectForKey:@"familyIconList"] objectAtIndex:indexPath.row]] completionBlock:^(BOOL succeeded, UIImage *image) {
                
                        if (succeeded) {
                            cell.imgFamily.image = image;
                        }else
                        {
                            cell.imgFamily.image = [UIImage imageNamed:@"icon_people"];
                        }
                        
                    }];
                
                [cell.Btn_family setTag:indexPath.row+1];
                [cell.Btn_family addTarget:self action:@selector(familyPhoto:) forControlEvents:UIControlEventTouchUpInside];

                
            cell.noLbl.text = [NSString stringWithFormat:@"%i.",indexPath.row+1];
            
            
            if (![phoneDic objectForKey:[NSString stringWithFormat:@"familyName%i",indexPath.row+1]]) {
                cell.titleLbl.text = [NSString stringWithFormat:@"%@",UserDate_NOSET];
                cell.subtitleLbl.text = @"";
            }else
            {
                NSString *familyName = [phoneDic objectForKey:[NSString stringWithFormat:@"familyName%i",indexPath.row+1]];
                NSString *familyPhone = [phoneDic objectForKey:[NSString stringWithFormat:@"familyPhone%i",indexPath.row+1]];
                
                if (familyName.length == 0) {
                    cell.titleLbl.text = [NSString stringWithFormat:@"%@",UserDate_NOSET];
                }else
                {
                    cell.titleLbl.text = [NSString stringWithFormat:@"%@",familyName];
                }
                
                if (familyPhone.length == 0) {
                    cell.subtitleLbl.text = @"";
                }else
                {
                    cell.subtitleLbl.text = [NSString stringWithFormat:@"%@",familyPhone];
                }
                
            }
            
            
            return cell;
        }
    }
    
    return NULL;
}



-(void)doneFamilyTxt{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [nowTxt resignFirstResponder];
}


-(void)doneSOSTxt{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [nowTxt resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index path section %i, row %i",indexPath.section,indexPath.row);
}


//點擊個人照片
-(IBAction)imageBtnClick:(id)sender
{
    NSLog(@"person image click");
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alert show];
        return;
    }
    //isTest End
    if ([self.delegate respondsToSelector:@selector(PersonImgClick)])
    {
        [self.delegate PersonImgClick];
    }
}


//親情照片
-(IBAction)familyPhoto:(id)sender
{
    NSLog(@"Family Photo Btn Click %i",[(UIView*)sender tag]);
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(familyImgClick:)])
    {
        [self.delegate familyImgClick:[(UIView*)sender tag]];
    }
}


-(IBAction)changeSex:(id)sender
{
    sexType = [(UIView*)sender tag];
    [listTable reloadData];
}


//編輯佩戴者資訊
-(void)editPerson
{
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alert show];
        return;
    }
    //isTestAcc End
    nowEdit = 1;
    
    [listTable reloadData];
}

//上傳配戴者資訊
-(void)UpdatePersonInfo
{
    [nowTxt resignFirstResponder];
    if ([self check1])
    {
        nowEdit = 0;
        
        NSString  *sex = [NSString stringWithFormat:@"%i",sexType];
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:nameStr,@"realName",sex,@"Sex",addrStr,@"Address",phoneStr,@"Phone", nil];
        
        //送出佩戴者資料
        if ([self.delegate respondsToSelector:@selector(SavePersonInfo:)])
        {
            [self.delegate SavePersonInfo:dic];
        }
    }else
    {
        NSLog(@"formate error");
    }
}

//上傳SOS電話
-(void)UpdateSoSInfo
{
    [self doneSOSTxt];
    
    
    if ([self check2]) {
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             sosName1,@"personName1",sosPhone1,@"personPhone1",sosName2,@"personName2",sosPhone2,@"personPhone2",sosName3,@"personName3",sosPhone3,@"personPhone3",[phoneDic objectForKey:@"familyName1"],@"familyName1",[phoneDic objectForKey:@"familyPhone1"],@"familyPhone1",[phoneDic objectForKey:@"familyName2"],@"familyName2",[phoneDic objectForKey:@"familyPhone2"],@"familyPhone2",[phoneDic objectForKey:@"familyName3"],@"familyName3",[phoneDic objectForKey:@"familyPhone3"],@"familyPhone3", nil];
        NSLog(@"dic = %@",dic);
        
        
        //送出佩戴者資料
        if ([self.delegate respondsToSelector:@selector(SaveSoSInfo:)])
        {
            [self.delegate SaveSoSInfo:dic];
        }
        
    }else
    {
        NSLog(@"formate error");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                 NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                           message:
                 NSLocalizedStringFromTable(@"Personal_MyAccount_Error3",INFOPLIST,nil)
                 delegate
                                                  : self cancelButtonTitle:
                 NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                 otherButtonTitles: nil];
        
        [alert show];
    }
}


//上傳Faily電話
-(void)UpdateFailyInfo
{
    NSLog(@"h");
    [self doneFamilyTxt];
    if ([self check3]) {
        
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [phoneDic objectForKey:@"personName1"],@"personName1",[phoneDic objectForKey:@"personPhone1"],@"personPhone1",[phoneDic objectForKey:@"personName2"],@"personName2",[phoneDic objectForKey:@"personPhone2"],@"personPhone2",[phoneDic objectForKey:@"personName3"],@"personName3",[phoneDic objectForKey:@"personPhone3"],@"personPhone3",familyName1,@"familyName1",familyPhone1,@"familyPhone1",familyName2,@"familyName2",familyPhone2,@"familyPhone2",familyName3,@"familyName3",familyPhone3,@"familyPhone3", nil];
        NSLog(@"dic = %@",dic);
        
        
        //送出佩戴者資料
        if ([self.delegate respondsToSelector:@selector(SaveSoSInfo:)])
        {
            [self.delegate SaveSoSInfo:dic];
        }
    }else
    {
        NSLog(@"formate error");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                              NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                                        message:
                              NSLocalizedStringFromTable(@"Personal_MyAccount_Error3",INFOPLIST,nil)
                              delegate
                                                               : self cancelButtonTitle:
                              NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                              otherButtonTitles: nil];
        
        [alert show];
    }
}


//取消編輯
-(void)CancelEdit
{
    nowEdit = 0;
    [self doneFamilyTxt];
    [listTable reloadData];
}

//檢查佩戴者資訊是否輸入正確
-(BOOL)check1
{
    return YES;
}

//檢查電話資訊是否輸入正確
-(BOOL)check2
{
    /*
    if (![sosPhone1 isMatchedByRegex:@"^[\\d\\+]+$"] && [sosPhone1 isEqualToString:@""])
    {
        return NO;
        
    }else if (![sosPhone2 isMatchedByRegex:@"^[\\d\\+]+$"])
    {
        return NO;
        
    }else if (![sosPhone3 isMatchedByRegex:@"^[\\d\\+]+$"])
    {
        
        return NO;
    }
    */

    
    if (sosPhone1.length >0) {
        if (![sosPhone1 isMatchedByRegex:@"^[\\d\\+]+$"] ) {
            return NO;
        }
    }else if (sosPhone2.length >0)
    {
        if (![sosPhone2 isMatchedByRegex:@"^[\\d\\+]+$"] ) {
            return NO;
        }

    }else if (sosPhone3.length >0)
    {
        if (![sosPhone3 isMatchedByRegex:@"^[\\d\\+]+$"] ) {
            return NO;
        }
    }
    
    return YES;


}


//檢查電話資訊是否輸入正確
-(BOOL)check3
{
    if (familyPhone1.length >0) {
        if (![familyPhone1 isMatchedByRegex:@"^[\\d\\+]+$"] ) {
            return NO;
        }
    }else if (familyPhone2.length >0)
    {
        if (![familyPhone2 isMatchedByRegex:@"^[\\d\\+]+$"] ) {
            return NO;
        }
        
    }else if (familyPhone3.length >0)
    {
        if (![familyPhone3 isMatchedByRegex:@"^[\\d\\+]+$"] ) {
            return NO;
        }
    }
    
    return YES;

}

//開始輸入
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    nowTxt = textField;
    
    
    if (nowEdit == 2) {
        CGRect frames = textField.frame;
        int offset = frames.origin.y + 32 - (self.frame.size.height - 230.0);//键盘高度216
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        float width = self.frame.size.width;
        float height = self.frame.size.height;
        
        NSLog(@"off set = %i",offset);
        
        CGRect rect = CGRectMake(0.0f, -100.0f,width,height);
        self.frame = rect;
        
        NSLog(@"offset < 0");
        [UIView commitAnimations];
    }
    
    
    
    if (nowEdit == 3) {
        NSLog(@"now txt = %@",[textField description]);
        
        CGRect frames = textField.frame;
        int offset = frames.origin.y + 32 - (self.frame.size.height - 230.0);//键盘高度216
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            offset = -216;
        }
        
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        float width = self.frame.size.width;
        float height = self.frame.size.height;
        
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if (iOSDeviceScreenSize.height == 568)
        {
            offset = -215;
        }
        
        /*
        if(offset > 0)
        {
            NSLog(@"offset > 0");
            CGRect rect = CGRectMake(0.0f, -offset,width,height);
            self.frame = rect;
        }
         */
        
        NSLog(@"off set = %i",offset);
        
        CGRect rect = CGRectMake(0.0f, offset,width,height);
        self.frame = rect;
        
        NSLog(@"offset < 0");
        [UIView commitAnimations];
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    NSLog(@"textFieldShouldReturn = %@",[textField description]);
    [textField resignFirstResponder];
    
    if (nowEdit == 2) {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
        self.frame = rect;
        [UIView commitAnimations];
    }
    
    
    
    if (nowEdit == 3) {
        NSLog(@"return return");
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
        self.frame = rect;
        [UIView commitAnimations];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
            
        case 101:
            nameStr = textField.text;
            break;
        
        case 102:
            phoneStr = textField.text;
            break;
            
        case 103:
            addrStr = textField.text;
            break;
            
        case 211:
            sosName1 = textField.text;
            break;
            
        case 212:
            sosPhone1 = textField.text;
            break;

        case 221:
            sosName2 = textField.text;
            break;
            
        case 222:
            sosPhone2 = textField.text;
            break;
            
        case 231:
            sosName3 = textField.text;
            break;
            
        case 232:
            sosPhone3 = textField.text;
            break;
        
        case 311:
            familyName1 = textField.text;
            break;
            
        case 312:
            familyPhone1 = textField.text;
            break;
            
        case 321:
            familyName2 = textField.text;
            break;
            
        case 322:
            familyPhone2 = textField.text;
            break;
            
        case 331:
            familyName3 = textField.text;
            break;
            
        case 332:
            familyPhone3 = textField.text;
            break;
            
    }
    
    NSLog(@"textFieldDidEndEditing %@",[textField description]);
}


//編輯緊急聯絡人電話
-(void)editSoSPhone
{
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alert show];
        return;
    }
    //isTest End
    nowEdit = 2;
    [listTable reloadData];
}


//編輯親情電話
-(void)editFamilyPhone
{
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alert show];
        return;
    }
    //isTestAcc End
    nowEdit = 3;
    [listTable reloadData];
}


//編輯吃藥提醒
-(void)editMedRemind
{
    nowEdit = 4;
    [listTable reloadData];

}

//編輯回診提醒
-(void)editHosRemind
{
    nowEdit = 5;
    [listTable reloadData];

}


//異步下載圖片
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.cachePolicy=NSURLRequestReloadIgnoringCacheData;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   
                                   NSLog(@"return image = %@",[image description]);
                                   
                                   if (image) {
                                       completionBlock(YES,image);
                                   }else
                                   {
                                       image = [UIImage imageNamed:@"icon_user.png"];
                                       completionBlock(NO,image);
                                   }
                                   
                               } else{
                                   UIImage *image = [UIImage imageNamed:@"icon_user.png"];
                                   completionBlock(NO,image);
                               }
                           }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end

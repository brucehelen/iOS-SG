//
//  MemberViewController.m
//  AngelCare
//
//  Created by macmini on 2013/12/9.
//
//

#import "MemberViewController.h"
#import "src/NMCustomLabel.h"

@interface MemberViewController ()

@end

@implementation MemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* arrayLanguages = [userDefaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [arrayLanguages objectAtIndex:0];
    
    
    
    NSString *check1 = [NSString stringWithFormat:@"zh-Hant"];
    NSString *check2 = [NSString stringWithFormat:@"zh-Hans"];
    
    if( [currentLanguage isEqualToString:check1]  )
    {
        
        [self Set_Tw];
    }
    else
    {
        if( [currentLanguage isEqualToString:check2]  )
        {
            [self Set_Cn];
        }
        else
        {
            
            [self Set_En];
        }
        
    }
	// Do any additional setup after loading the view.
    _webView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    _webView.scalesPageToFit = YES;
    
    //設定網址
    NSURL *url = [NSURL URLWithString:@"http://210.242.50.125:8000/safetywatch/PrivacyPolicy.html"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    
}

//設定為英文版本
-(void)Set_En
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        
        int totalHei = 5400;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        
        label1.text = @"<span class='bold_style'>Terms of Service & Software Agreement</span>\nmCareWatch Terms of Service Last update： April 23, 2014\n\n<span class='ital_style'>Welcome to mCareWatch.</span>\nThank you for using our products and services (“Services”). The Services are provided by mCareWatch Pty Ltd ABN: 32161052571. (located at Suite 109, 46-50 Kent Rd, Mascot NSW 2020 Australia). By using our Services, you are agreeing to these terms. Please read them carefully. Our Services are very diverse, so sometimes additional terms or product requirements (including age requirements) may apply. Additional terms will be available with the relevant Services, and those additional terms become part of your agreement with us if you use those Services.\n\n<span class='ital_style'>Using our Services</span>\nYou must follow any policies made available to you within the Services. Do not misuse our Services. For example, you must not interfere with our Services or try to access them using a method other than the interface and the instructions that we provide. You may use our Services only as permitted by law, including applicable export and re-export control laws and regulations. We may suspend or stop providing our Services to you if you do not comply with our terms or policies or if we are investigating suspected misconduct. Using our Services does not give you ownership of any intellectual property rights in our Services or the content you access. You may not use content from our Services unless you obtain permission from its owner or are otherwise permitted by law. These terms do not grant you the right to use any branding or logos used in our Services. You must not remove, obscure, or alter any legal notices displayed in or along with our Services. Services display some content that is not from mCareWatch. This content is the sole responsibility of the entity that makes it available. We may review content to determine whether it is illegal or violates our policies, and we may remove or refuse to display content that we reasonably believe violates our policies or the law. In connection with your use of the Services, we may send you service announcements, administrative messages, and other information. You may opt out of some of those communications at any time.\n\n<span class='ital_style'>mCareWatch Account</span>\nYou may need an mCareWatch Account in order to use some of our Services. You may create your own mCareWatch Account, or your mCareWatch Account may be assigned to you by an administrator, such as your employer or educational institution. If you are using an mCareWatch Account assigned to you by an administrator, additional terms may apply and your administrator may be able to access or disable your account. If you learn of any unauthorized use of your password or account, please contact mCareWatch Customer Support (tel: 02 80464860).\n\n<span class='ital_style'>Privacy and Copyright Protection</span>\nThe mCareWatch privacy policy outlines how we treat your personal data and protect your privacy when using our Services. By using our Services, you agree that mCareWatch can use such data in accordance with our privacy policies.\n\n<span class='ital_style'>Content in our Services</span>\nSome of our Services allow you to submit content. You retain ownership of any intellectual property rights that you hold in that content. In short, what belongs to you is yours. When you upload or otherwise submit content to our Services, you give mCareWatch (and those we work with) a worldwide license to use, host, store, reproduce, modify, create derivative works (such as those resulting from translations, adaptations or other changes we make so that your content works better with our Services), communicate, publish, publicly perform, publicly display and distribute such content. The rights you grant in this license are for the limited purpose of operating, promoting, improving our Services, and to develop new ones. This license continues even if you stop using our Services (for example, for a business listing you have added to mCareWatch Maps). Some Services may offer you ways to access and remove content that has been provided to that Service. Also, in some of our Services, there are terms or settings that narrow the scope of our use of the content submitted in those Services. Please ensure you have the rights to grant us this license for any content that you submit to our Services.\n\n<span class='ital_style'>About Software in our Services</span>\nWhen a Service requires or includes downloadable software, this software may update automatically on your device once a new version or feature is available. Some Services may let you adjust your automatic update settings. mCareWatch gives you a personal, worldwide, royalty-free, non-assignable and non-exclusive license to use the software provided to you by mCareWatch as part of the Services. This license is for the sole purpose of enabling you to use and enjoy the benefit of the Services as provided by mCareWatch, in the manner permitted by these terms. You may not copy, modify, distribute, sell, or lease any part of our Services or included software, nor may you reverse engineer or attempt to extract the source code of that software, unless laws prohibit those restrictions or you have our written permission. Open source software is important to us. Some software used in our Services may be offered under an open source license that we will make available to you. There may be provisions in the open source license that expressly override some of these terms.\n\n<span class='ital_style'>User Software License Agreement</span>\n\tThis user license agreement (the “Agreement”) is a legal agreement between you (either an individual or an entity) and mCareWatch Pty. Ltd. (“mCareWatch”) regarding the use of mCareWatch’s software entitled “ConnectiveCare 2.0™” (the “Software”).  Subject to the payment of service and your compliance with the terms and conditions of this Agreement, mCareWatch hereby grants you a limited, non-exclusive, personal, revocable and non-transferrable license to install and use one (1) copy of the Software, for personal use and informational (and not commercial) purposes only.\n\tThe Software is owned by mCareWatch and its partners and is protected by the intellectual property and copyright laws of Australia and certain international treaty provisions. mCareWatch owns and retains all rights, title and interest including, patents, trade-marks, copyrights, trade secrets and other intellectual property rights in and to the Software, including but not limited to, source codes, images, photographs, animation, themes, titles, characters, video, audio, music, and text embodied or contained, therein.\n\tThe software can be used to assist in remotely caring for specific clients who are wearing the watch such as tracking an individual when they press the SOS button or to monitor health related measurements (as part of advanced version where that functionality is available).\n\tAs such any data it collects is stored on the ConnectiveCare 2.0 software platform using specific privacy and security protocols to protect information. The data can be accessed by yourself based on authentication requirements and by mCareWatch in accordance with our Privacy Policy. mCareWatch reserves the right to change its Privacy Policy at its sole discretion, without specific notification other than posting an update on its website. Moreover, mCareWatch shall bear no liability for any loss, damage or expanse arising, directly or indirectly, from amendments to its privacy policy. Each time you use the software (SMW14 Apps and ConnectiveCare 2.0 Portal) you consent to the collection, transfer and storage and disclosure of information held by mCareWatch.\n\n<span class='ital_style'>Limitation of Liability of Software Use</span>\n\tYou assume the entire cost of any damage resulting from your use of the software and the information contained therein or compiled by the software. To the extent permitted by applicable law, in no event will mCareWatch be liable for any damages whatsoever, including, without limitation damages for loss of data, damage to equipment, hardware or software failure, or other pecuniary loss, arising out of the use or inability to use the software, even if such party has been advised of the possibility of such damages. mCareWatch makes no warranty or representation that the information or functions contained in the software will meet your requirements.\n\tDISCLAIMER REGARDING HEALTH & MEDICAL INFORMATION THE SOFTWARE IS NOT A SUBSTITUTE FOR, AND DOES NOT PROVIDE, MEDICAL ADVICE. THE SOFTWARE IS PROVIDED FOR PERSONAL EDUCATIONAL, INFORMATIONAL, CONVENIENCE AND ENTERTAINMENT PURPOSES ONLY AND IS NOT TO BE USED FOR THE DIRECTION OF CARE OF INDIVIDUAL PATIENTS. THE SOFTWARE IS GENERAL IN NATURE AND IS NOT INTENDED FOR ANY PARTICULAR PURPOSE, INCLUDING, IN ANY WAY, TO BE A SUBSTITUTE FOR A MEDICAL EXAM OR PROFESSIONAL MEDICAL ADVICE.\n\n<span class='ital_style'>No Warranties.</span>\n\tThe software is provided “as is” without any warranty whatsoever. You assume all risks and responsibilities associated with the selection and use of the software as an aid in remote care –giving, self-health monitoring and observations to achieving specific personal/caring goals and objectives.\n\tPLEASE NOTE: Our watch is a communication hub and not a medical diagnostic device. Our devices and services are used for observational purposes. You should always seek medical advice with your health professional concerning any questions you may have with regard to a specific medical condition. It is important not to disregard or delay seeking consultative advice because of something you have read or viewed in the software. Reliance on any information provided in the software is solely at your own risk and you assume full responsibility for the use of the information.\n\n<span class='ital_style'>Modifying and Terminating our Services</span>\nWe provide our Services using a commercially reasonable level of skill and care and we hope that you will enjoy using them. But there are certain things that we cannot promise about our Services.\n\n<span class='ital_style'>Liability for our Services</span>\nWHEN PERMITTED BY LAW, MCAREWATCH, AND MCAREWATCH’S SUPPLIERS AND DISTRIBUTORS, WILL NOT BE RESPONSIBLE FOR LOST PROFITS, REVENUES, OR DATA, FINANCIAL LOSSES OR INDIRECT, SPECIAL, CONSEQUENTIAL, EXEMPLARY, OR PUNITIVE DAMAGES. TO THE EXTENT PERMITTED BY LAW, THE TOTAL LIABILITY OF MCAREWATCH, AND ITS SUPPLIERS AND DISTRIBUTORS, FOR ANY CLAIM UNDER THESE TERMS, INCLUDING FOR ANY IMPLIED WARRANTIES, IS LIMITED TO THE AMOUNT YOU PAID US TO USE THE SERVICES (OR, IF WE CHOOSE, TO SUPPLYING YOU THE SERVICES AGAIN). IN ALL CASES, MCAREWATCH, AND ITS SUPPLIERS, DISTRIBUTORS AND RESELLERS, WILL NOT BE LIABLE FOR ANY LOSS OR DAMAGE THAT IS NOT REASONABLY FORESEEABLE.\n\n<span class='ital_style'>Business uses of our Services</span>\nIf you are using our Services on behalf of a business, that business accepts these terms. It will hold harmless and indemnify mCareWatch and its affiliates, officers, agents, resellers and employees from any claim, suit or action arising from or related to the use of the Services or violation of these terms, including any liability or expense arising from claims, losses, damages, suits, judgements, litigation costs and any legal fees.\n\n<span class='ital_style'>About these Terms</span>\nWe may modify these terms or any additional terms that apply to a Service to, for example, reflect changes to the law or changes to our Services. You should look at the terms regularly. We will post notice of modifications to these terms on this page. We will post notice of modified additional terms in the applicable Service. Changes will not apply retrospectively and will become effective no sooner than fourteen days after they are posted. However, changes addressing new functions for a Service or changes made for legal reasons will be effective immediately. If you do not agree to the modified terms for a Service, you should discontinue your use of that Service. These terms control the relationship between Google and you. They do not create any third party beneficiary rights. If you do not comply with these terms, and we do not take action immediately, this does not mean that we are giving up any rights that we may have (such as taking action in the future). If it transpires that a particular term is not enforceable, this will not affect any other terms. The state laws of NSW, Australia, will apply to any disputes arising out of or relating to these terms or the Services. All claims arising out of or relating to these terms or the Services will be litigated exclusively in the state courts of NSW, Australia, and you and mCareWatch consent to personal jurisdiction in those courts.\nFor information about how to contact mCareWatch, please visit\n<a href='http://www.mcarewatch.com.au'>www.mcarewatch.com.au</a>";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"red_style"];
        
        label1.kern = 0.0;
        label1.lineHeight = 20;
        
        [myScrollView addSubview:label1];
        
        
        NSLog(@"hei is %f",label1.frame.size.height);
        
        
        
        
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 320, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    else
    {
        int totalHei = 4035;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        
        
        label1.text = @"<span class='bold_style'>AngelCare Terms of Service</span>\nLast modified： Ort 25, 2012\n\n<span class='ital_style'>Welcome to AngelCare!</span>\nThanks for using our products and services (“Services”). The Services are provided by RFID GUIDER TECHNOLOGY CO., LTD. (AngelCare, located at 10083 8F-3, No.482, Sec.5, Zhongxiao E. Rd, Xinyi Dist. Taipei City 11083 Taiwan.\nBy using our Services, you are agreeing to these terms. Please read them carefully.\nOur Services are very diverse, so sometimes additional terms or product requirements (including age requirements) may apply. Additional terms will be available with the relevant Services, and those additional terms become part of your agreement with us if you use those Services.\n\n<span class='ital_style'>Using our Services</span>\nYou must follow any policies made available to you within the Services.\nDon’t misuse our Services. For example, don’t interfere with our Services or try to access them using a method other than the interface and the instructions that we provide. You may use our Services only as permitted by law, including applicable export and re-export control laws and regulations. We may suspend or stop providing our Services to you if you do not comply with our terms or policies or if we are investigating suspected misconduct.\nUsing our Services does not give you ownership of any intellectual property rights in our Services or the content you access. You may not use content from our Services unless you obtain permission from its owner or are otherwise permitted by law. These terms do not grant you the right to use any branding or logos used in our Services. Don’t remove, obscure, or alter any legal notices displayed in or along with our Services.\nOur Services display some content that is not AngelCare’s. This content is the sole responsibility of the entity that makes it available. We may review content to determine whether it is illegal or violates our policies, and we may remove or refuse to display content that we reasonably believe violates our policies or the law. But that does not necessarily mean that we review content, so please don’t assume that we do.\nIn connection with your use of the Services, we may send you service announcements, administrative messages, and other information. You may opt out of some of those communications.\n\n<span class='ital_style'>Your AngelCare Account</span>\nYou may need an AngelCare Account in order to use some of our Services. You may create your own AngelCare Account, or your AngelCare Account may be assigned to you by an administrator, such as your employer or educational institution. If you are using an AngelCare Account assigned to you by an administrator, different or additional terms may apply and your administrator may be able to access or disable your account.\nIf you learn of any unauthorized use of your password or account, please connect with AngelCare Service Center (+886-2-2728-1051).\n\n<span class='ital_style'>Privacy and Copyright Protection</span>\nAngelCare’s privacy policies explain how we treat your personal data and protect your privacy when you use our Services. By using our Services, you agree that AngelCare can use such data in accordance with our privacy policies.\n\n<span class='ital_style'>Your Content in our Services</span>\nSome of our Services allow you to submit content. You retain ownership of any intellectual property rights that you hold in that content. In short, what belongs to you stays yours.\nWhen you upload or otherwise submit content to our Services, you give AngelCare (and those we work with) a worldwide license to use, host, store, reproduce, modify, create derivative works (such as those resulting from translations, adaptations or other changes we make so that your content works better with our Services), communicate, publish, publicly perform, publicly display and distribute such content. The rights you grant in this license are for the limited purpose of operating, promoting, and improving our Services, and to develop new ones. This license continues even if you stop using our Services (for example, for a business listing you have added to AngelCare Maps). Some Services may offer you ways to access and remove content that has been provided to that Service. Also, in some of our Services, there are terms or settings that narrow the scope of our use of the content submitted in those Services. Make sure you have the necessary rights to grant us this license for any content that you submit to our Services.\n\n<span class='ital_style'>About Software in our Services</span>\nWhen a Service requires or includes downloadable software, this software may update automatically on your device once a new version or feature is available. Some Services may let you adjust your automatic update settings.\nAngelCare gives you a personal, worldwide, royalty-free, non-assignable and non-exclusive license to use the software provided to you by AngelCare as part of the Services. This license is for the sole purpose of enabling you to use and enjoy the benefit of the Services as provided by AngelCare, in the manner permitted by these terms. You may not copy, modify, distribute, sell, or lease any part of our Services or included software, nor may you reverse engineer or attempt to extract the source code of that software, unless laws prohibit those restrictions or you have our written permission.\nOpen source software is important to us. Some software used in our Services may be offered under an open source license that we will make available to you. There may be provisions in the open source license that expressly override some of these terms.\n\n<span class='ital_style'>Modifying and Terminating our Services</span>\nWe provide our Services using a commercially reasonable level of skill and care and we hope that you will enjoy using them. But there are certain things that we don’t promise about our Services.\n\n<span class='ital_style'>Liability for our Services</span>\nWHEN PERMITTED BY LAW, ANGELCARE, AND ANGELCARE’S SUPPLIERS AND DISTRIBUTORS, WILL NOT BE RESPONSIBLE FOR LOST PROFITS, REVENUES, OR DATA, FINANCIAL LOSSES OR INDIRECT, SPECIAL, CONSEQUENTIAL, EXEMPLARY, OR PUNITIVE DAMAGES.\nTO THE EXTENT PERMITTED BY LAW, THE TOTAL LIABILITY OF ANGELCARE, AND ITS SUPPLIERS AND DISTRIBUTORS, FOR ANY CLAIM UNDER THESE TERMS, INCLUDING FOR ANY IMPLIED WARRANTIES, IS LIMITED TO THE AMOUNT YOU PAID US TO USE THE SERVICES (OR, IF WE CHOOSE, TO SUPPLYING YOU THE SERVICES AGAIN).\nIN ALL CASES, ANGELCARE, AND ITS SUPPLIERS AND DISTRIBUTORS, WILL NOT BE LIABLE FOR ANY LOSS OR DAMAGE THAT IS NOT REASONABLY FORESEEABLE.\n\n<span class='ital_style'>Business uses of our Services</span>\nIf you are using our Services on behalf of a business, that business accepts these terms. It will hold harmless and indemnify AngelCare and its affiliates, officers, agents, and employees from any claim, suit or action arising from or related to the use of the Services or violation of these terms, including any liability or expense arising from claims, losses, damages, suits, judgments, litigation costs and attorneys’ fees.\n\n<span class='ital_style'>About these Terms</span>\nWe may modify these terms or any additional terms that apply to a Service to, for example, reflect changes to the law or changes to our Services. You should look at the terms regularly. We’ll post notice of modifications to these terms on this page. We’ll post notice of modified additional terms in the applicable Service. Changes will not apply retroactively and will become effective no sooner than fourteen days after they are posted. However, changes addressing new functions for a Service or changes made for legal reasons will be effective immediately. If you do not agree to the modified terms for a Service, you should discontinue your use of that Service.\nIf there is a conflict between these terms and the additional terms, the additional terms will control for that conflict.\nThese terms control the relationship between Google and you. They do not create any third party beneficiary rights.\nIf you do not comply with these terms, and we don’t take action right away, this doesn’t mean that we are giving up any rights that we may have (such as taking action in the future).\nIf it turns out that a particular term is not enforceable, this will not affect any other terms.\nThe laws of Taipei, Taiwan, excluding Taiwan’s conflict of laws rules, will apply to any disputes arising out of or relating to these terms or the Services. All claims arising out of or relating to these terms or the Services will be litigated exclusively in the federal or state courts of Taipei City, Taiwan, and you and AngelCare consent to personal jurisdiction in those courts.\nFor information about how to contact AngelCare, please visit us.\n";
        
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"red_style"];
        
        label1.kern = 0.1;
        label1.lineHeight = 30;
        
        [myScrollView addSubview:label1];
        
        
        NSLog(@"hei is %f",label1.frame.size.height);
        
        
        
        
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 768, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    
}

//設定為簡體版本

-(void)Set_Cn
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        
        int totalHei = 2920;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        
        label1.text = @"<span class='bold_style'>银发安全天使 AngelCare服务条款</span>\n上次修改日期： 2012年10月25日\n\n<span class='ital_style'>欢迎使用 安全天使 AngelCare！</span>\n感谢您使用我们的产品和服务 (以下共同简称「服务」)。「服务」是由 盖德科技股份有限公司RFID GUIDER TECHNOLOGY CO.,LTD. (地址为10083 台北市信义区忠孝东路五段482号8楼之3) (以下简称「AngelCare」) 提供。\n只要您使用「服务」，即表示您同意本条款，故请详阅本条款内容。\n由于「服务」种类繁多，因此某些「服务」可能会有附加条款或产品规定。附加条款将与相关「服务」一并提供；当您使用该「服务」时，该等附加条款即成为您与我们所订协议的一部分。\n\n<span class='ital_style'>使用「服务」</span>\n您必须遵守「服务」中向您提供的所有政策。\n请勿滥用「服务」。举例来说，您不应干扰「服务」运作，亦不得试图透过我们所提供的接口和操作说明以外的方法存取「服务」。您仅可于法律 (包括适用的出口及再出口管制法律和法规) 允许范围内使用「服务」。如果您未遵守我们的条款或政策，或是如果我们正在调查疑似违规行为，我们可能会暂停或终提供「服务」。\n使用「服务」并不会将「服务」或您所存取内容的任何知识产权授予您。除非相关内容的拥有者同意或法律允许，否则您一律不得使用「服务」中的内容。本条款并未授权您可使用「服务」中所采用的任何品牌标示或标志。请勿移除、遮盖或变造「服务」所显示或随附显示的任何法律声明。\n「服务」中显示的部分内容并非 AngelCare 所有，这类内容应由其提供实体承担全部责任。我们可对内容进行审查，以判断其是否违法或违反 AngelCare 政策，并可移除或拒绝显示我们合理确信违反 我们政策或法律的内容。不过，这不表示我们一定会对内容进行审查，因此请勿如此认定。\n有关您对「服务」的使用，我们会向您发送服务公告、行政管理讯息和其他信息；您可取消接收其中某些通讯内容。\n\n<span class='ital_style'>您的 AngelCare  账户</span>\n您可能需有「AngelCare账户」才能使用我们的某些「服务」。透过购买AngelCare产品后，本公司将为您指派「AngelCare  账户」。如果您使用的是管理人指派给您的「AngelCare  账户」，可能需适用不同条款或附加条款，而且您的管理人可能可以存取或停用您的账户。\n如果您发现密码或帐户遭人盗用，请按与AngelCare客服中心(02-2728-1051)联络。\n\n<span class='ital_style'>隐私权与著作权保护</span>\nAngelCare  的《隐私权政策》说明当您使用「服务」时，我们如何处理您的个人资料并保护您的隐私权。您使用「服务」，即表示您同意 AngelCare  可依据我们的隐私权政策的规定使用这类数据。\n\n<span class='ital_style'>您储存在「服务」中的内容</span>\n部分「服务」可让您提交内容；您仍保有提交内容的『知识产权』。简而言之，属于您的依旧是您的。\n当您将内容上传或以其他方式提交至「服务」，即表示您授予 AngelCare  (及我们的合作伙伴) 全球通用的授权，可使用、代管、储存、重制、修改、制作衍生作品 (例如健康报告、关心服务或变更您的内容，使其更加配合我们的「服务」)这类内容。您于本项授权授予的权利仅限用于营运、宣传与改善「服务」，以及开发新的服务。即使您停止使用「服务」，本项授权仍持续具有效力。部分「服务」可让您存取与移除先前提交至该「服务」的内容。此外，某些「服务」会有条款或设定缩限我们对提交至该类「服务」之内容的使用范围。请确认您拥有必要权利，可就您提交至「服务」的任何内容授予我们本项授权。\n如要进一步了解 AngelCare  使用与储存内容的方式，请参阅相关「服务」的隐私权政策或附加条款。如果您就「服务」提供意见或建议，我们可使用您的意见或建议，但对您不负任何义务。\n\n<span class='ital_style'>有关「服务」所含软件</span>\n如果「服务」需有或内含可下载软件，该软件可能会在提供新版或新功能时，在您的装置上自动更新。部分「服务」可以让您调整您的自动更新设定。\nAngelCare  授予您全球通用、免权利金、不得转让、非专属的个人用户许可证，让您使用 AngelCare  提供给您的、包含在「服务」中的软件。本授权仅供您以这些条款允许之方式，使用 AngelCare  提供之「服务」并享用其利益。除非您已事先取得我们的书面许可，否则您不得复制、修改、散布、销售或出租「服务」的任何部分或其中包含的软件，也不得对该软件进行逆向工程或试图撷取其源代码。\n\n<span class='ital_style'>修改与终止「服务」</span>\n我们会持续不断变更并改进「服务」。我们可能会新增或移除功能或特性，也可能会完全暂停或停止某项「服务」。\n您随时都可以停止使用「服务」，不过我们并不希望您这么做。AngelCare  也可能随时停止向您提供「服务」，或对「服务」附加或设定新的限制。\n我们认为您的数据是属于您所有，因此有必要维护您对这类数据的存取。当我们中止某项「服务」时，只要合理可行，我们都会给您合理的事先通知，让您有时间能将信息自该「服务」汇出。\n\n<span class='ital_style'>我们的担保与免责声明</span>\n我们会以商业上合理的技术与注意程度提供「服务」，希望您尽情使用。但关于「服务」，有些事情我们不予保证。\n除本条款或额外条款中明示规定者外，AngelCare  或其供货商或经销商均不对「服务」做出任何特定保证。例如，我们不会就「服务」中的内容、「服务」之特定功能及其可靠性、可用性和符合您的需求的能力，做出任何承诺。我们仅以「现状」提供「服务」。\n部分司法管辖区会规定应提供特定担保，例如对适销性、特殊用途适用性及未侵权之默示担保。凡法律准许时，我们均排除一切担保责任。\n\n<span class='ital_style'>对「服务」的责任</span>\n凡法律准许时，AngelCare  与 AngelCare  的供货商和经销商对所失利益、收入或资料、财务损失或间接、特殊、衍生性、惩戒性或处罚性损害赔偿均不负责。\n在法律准许范围内，AngelCare  与其供货商和经销商对依本条款所提出任何请求之总责任 (包括对任何默示担保之责任)，均不超过您就使用「服务」而向 AngelCare  支付的金额 (或者 AngelCare  亦可选择再向您提供该「服务」)。\n不论在任何情况下，AngelCare  与其供货商和经销商对无法合理预见之任何损失或损害均不负责。\n\n<span class='ital_style'>公司行号使用 AngelCare  服务</span>\n如果您是代表某公司使用「服务」，即表示该公司接受本条款。该公司必须就任何因使用「服务」或违反本条款而引起或相关的请求、诉讼或法律行动 (包括承担所有因请求、损失、损害、诉讼、判决、诉讼费用和律师费用而产生的任何责任或费用)，向 AngelCare  及其关系企业、主管人员、代理人和员工做出补偿，并使其不受损害（此部分声请合约需以公司名义签订方能代表公司）。\n\n<span class='ital_style'>有关本条款的说明</span>\n我们可能会修改本条款或适用于某「服务」之任何额外条款，以 (例如)反映法律之变更或「服务」之变动。您应定期查阅本条款内容。这些条款如有修订，我们会在本网页发布通知。我们会在相关「服务」中公布已修订额外条款的通知。变更不会回溯适用，并将于公布变更起十四天或更长时间后方始生效。不过，针对某项「服务」新功能的变更，或基于法律理由而为之变更，将立即生效。如果您不同意某项「服务」之修订条款，则请停止使用该「服务」。\n如果本条款与额外条款抵触时，就该抵触项目而言，应以额外条款为准。\n本条款规范 AngelCare  与您之间的关系，并不会衍生任何第三人受益权。\n如果您不遵守本条款，而我们并未立即采取行动，这并不表示我们要放弃任何原本即有的权利 (例如未来再采取行动的权利)。\n发生特定条款无法执行的情况时，并会影响任何其他条款。\n因本条款或「服务」所生或与其相关之任何争议适用中华民国法律。且因本条款或「服务」所生或与其相关之所有主张涉讼时双方合意由台湾台北地方法院为第一审管辖法院。\n如需 AngelCare  的联络信息，请造访我们的 连络网页。\n";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"red_style"];
        
        label1.kern = 0.0;
        label1.lineHeight = 20;
        
        [myScrollView addSubview:label1];
        
        
        NSLog(@"hei is %f",label1.frame.size.height);
        
        
        
        
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 320, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    else
    {
        int totalHei = 3360;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        label1.text = @"<span class='bold_style'>银发安全天使 AngelCare服务条款</span>\n上次修改日期： 2012年10月25日\n\n<span class='ital_style'>欢迎使用 安全天使 AngelCare！</span>\n感谢您使用我们的产品和服务 (以下共同简称「服务」)。「服务」是由 盖德科技股份有限公司RFID GUIDER TECHNOLOGY CO.,LTD. (地址为10083 台北市信义区忠孝东路五段482号8楼之3) (以下简称「AngelCare」) 提供。\n只要您使用「服务」，即表示您同意本条款，故请详阅本条款内容。\n由于「服务」种类繁多，因此某些「服务」可能会有附加条款或产品规定。附加条款将与相关「服务」一并提供；当您使用该「服务」时，该等附加条款即成为您与我们所订协议的一部分。\n\n<span class='ital_style'>使用「服务」</span>\n您必须遵守「服务」中向您提供的所有政策。\n请勿滥用「服务」。举例来说，您不应干扰「服务」运作，亦不得试图透过我们所提供的接口和操作说明以外的方法存取「服务」。您仅可于法律 (包括适用的出口及再出口管制法律和法规) 允许范围内使用「服务」。如果您未遵守我们的条款或政策，或是如果我们正在调查疑似违规行为，我们可能会暂停或终提供「服务」。\n使用「服务」并不会将「服务」或您所存取内容的任何知识产权授予您。除非相关内容的拥有者同意或法律允许，否则您一律不得使用「服务」中的内容。本条款并未授权您可使用「服务」中所采用的任何品牌标示或标志。请勿移除、遮盖或变造「服务」所显示或随附显示的任何法律声明。\n「服务」中显示的部分内容并非 AngelCare 所有，这类内容应由其提供实体承担全部责任。我们可对内容进行审查，以判断其是否违法或违反 AngelCare 政策，并可移除或拒绝显示我们合理确信违反 我们政策或法律的内容。不过，这不表示我们一定会对内容进行审查，因此请勿如此认定。\n有关您对「服务」的使用，我们会向您发送服务公告、行政管理讯息和其他信息；您可取消接收其中某些通讯内容。\n\n<span class='ital_style'>您的 AngelCare  账户</span>\n您可能需有「AngelCare账户」才能使用我们的某些「服务」。透过购买AngelCare产品后，本公司将为您指派「AngelCare  账户」。如果您使用的是管理人指派给您的「AngelCare  账户」，可能需适用不同条款或附加条款，而且您的管理人可能可以存取或停用您的账户。\n如果您发现密码或帐户遭人盗用，请按与AngelCare客服中心(02-2728-1051)联络。\n\n<span class='ital_style'>隐私权与著作权保护</span>\nAngelCare  的《隐私权政策》说明当您使用「服务」时，我们如何处理您的个人资料并保护您的隐私权。您使用「服务」，即表示您同意 AngelCare  可依据我们的隐私权政策的规定使用这类数据。\n\n<span class='ital_style'>您储存在「服务」中的内容</span>\n部分「服务」可让您提交内容；您仍保有提交内容的『知识产权』。简而言之，属于您的依旧是您的。\n当您将内容上传或以其他方式提交至「服务」，即表示您授予 AngelCare  (及我们的合作伙伴) 全球通用的授权，可使用、代管、储存、重制、修改、制作衍生作品 (例如健康报告、关心服务或变更您的内容，使其更加配合我们的「服务」)这类内容。您于本项授权授予的权利仅限用于营运、宣传与改善「服务」，以及开发新的服务。即使您停止使用「服务」，本项授权仍持续具有效力。部分「服务」可让您存取与移除先前提交至该「服务」的内容。此外，某些「服务」会有条款或设定缩限我们对提交至该类「服务」之内容的使用范围。请确认您拥有必要权利，可就您提交至「服务」的任何内容授予我们本项授权。\n如要进一步了解 AngelCare  使用与储存内容的方式，请参阅相关「服务」的隐私权政策或附加条款。如果您就「服务」提供意见或建议，我们可使用您的意见或建议，但对您不负任何义务。\n\n<span class='ital_style'>有关「服务」所含软件</span>\n如果「服务」需有或内含可下载软件，该软件可能会在提供新版或新功能时，在您的装置上自动更新。部分「服务」可以让您调整您的自动更新设定。\nAngelCare  授予您全球通用、免权利金、不得转让、非专属的个人用户许可证，让您使用 AngelCare  提供给您的、包含在「服务」中的软件。本授权仅供您以这些条款允许之方式，使用 AngelCare  提供之「服务」并享用其利益。除非您已事先取得我们的书面许可，否则您不得复制、修改、散布、销售或出租「服务」的任何部分或其中包含的软件，也不得对该软件进行逆向工程或试图撷取其源代码。\n\n<span class='ital_style'>修改与终止「服务」</span>\n我们会持续不断变更并改进「服务」。我们可能会新增或移除功能或特性，也可能会完全暂停或停止某项「服务」。\n您随时都可以停止使用「服务」，不过我们并不希望您这么做。AngelCare  也可能随时停止向您提供「服务」，或对「服务」附加或设定新的限制。\n我们认为您的数据是属于您所有，因此有必要维护您对这类数据的存取。当我们中止某项「服务」时，只要合理可行，我们都会给您合理的事先通知，让您有时间能将信息自该「服务」汇出。\n\n<span class='ital_style'>我们的担保与免责声明</span>\n我们会以商业上合理的技术与注意程度提供「服务」，希望您尽情使用。但关于「服务」，有些事情我们不予保证。\n除本条款或额外条款中明示规定者外，AngelCare  或其供货商或经销商均不对「服务」做出任何特定保证。例如，我们不会就「服务」中的内容、「服务」之特定功能及其可靠性、可用性和符合您的需求的能力，做出任何承诺。我们仅以「现状」提供「服务」。\n部分司法管辖区会规定应提供特定担保，例如对适销性、特殊用途适用性及未侵权之默示担保。凡法律准许时，我们均排除一切担保责任。\n\n<span class='ital_style'>对「服务」的责任</span>\n凡法律准许时，AngelCare  与 AngelCare  的供货商和经销商对所失利益、收入或资料、财务损失或间接、特殊、衍生性、惩戒性或处罚性损害赔偿均不负责。\n在法律准许范围内，AngelCare  与其供货商和经销商对依本条款所提出任何请求之总责任 (包括对任何默示担保之责任)，均不超过您就使用「服务」而向 AngelCare  支付的金额 (或者 AngelCare  亦可选择再向您提供该「服务」)。\n不论在任何情况下，AngelCare  与其供货商和经销商对无法合理预见之任何损失或损害均不负责。\n\n<span class='ital_style'>公司行号使用 AngelCare  服务</span>\n如果您是代表某公司使用「服务」，即表示该公司接受本条款。该公司必须就任何因使用「服务」或违反本条款而引起或相关的请求、诉讼或法律行动 (包括承担所有因请求、损失、损害、诉讼、判决、诉讼费用和律师费用而产生的任何责任或费用)，向 AngelCare  及其关系企业、主管人员、代理人和员工做出补偿，并使其不受损害（此部分声请合约需以公司名义签订方能代表公司）。\n\n<span class='ital_style'>有关本条款的说明</span>\n我们可能会修改本条款或适用于某「服务」之任何额外条款，以 (例如)反映法律之变更或「服务」之变动。您应定期查阅本条款内容。这些条款如有修订，我们会在本网页发布通知。我们会在相关「服务」中公布已修订额外条款的通知。变更不会回溯适用，并将于公布变更起十四天或更长时间后方始生效。不过，针对某项「服务」新功能的变更，或基于法律理由而为之变更，将立即生效。如果您不同意某项「服务」之修订条款，则请停止使用该「服务」。\n如果本条款与额外条款抵触时，就该抵触项目而言，应以额外条款为准。\n本条款规范 AngelCare  与您之间的关系，并不会衍生任何第三人受益权。\n如果您不遵守本条款，而我们并未立即采取行动，这并不表示我们要放弃任何原本即有的权利 (例如未来再采取行动的权利)。\n发生特定条款无法执行的情况时，并会影响任何其他条款。\n因本条款或「服务」所生或与其相关之任何争议适用中华民国法律。且因本条款或「服务」所生或与其相关之所有主张涉讼时双方合意由台湾台北地方法院为第一审管辖法院。\n如需 AngelCare  的联络信息，请造访我们的 连络网页。\n";
        
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"red_style"];
        
        label1.kern = 0.1;
        label1.lineHeight = 30;
        
        [myScrollView addSubview:label1];
        
        
        NSLog(@"hei is %f",label1.frame.size.height);
        
        
        
        
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 768, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    
}

//設定為繁體版本
-(void)Set_Tw
{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        
        int totalHei = 2920;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        
        label1.text = @"<span class='bold_style'>銀髮安全使 AngelCare服務條款</span>\n上次修改日期： 2012年10月25日\n\n<span class='ital_style'>歡迎使用 安全天使 AngelCare！</span>\n感謝您使用我們的產品和服務 (以下<span class='red_style'>共同</span>簡稱「服務」)。「服務」是由 蓋德科技股份有限公司RFID GUIDER TECHNOLOGY CO.,LTD. (地址為10083 台北市信義區忠孝東路五段482號8樓之3) (以下簡稱「AngelCare」) 提供。\n只要您使用「服務」，即表示您同意本條款，故請詳閱本條款內容。\n由於「服務」種類繁多，因此某些「服務」可能會有附加條款或產品規定。附加條款將與相關「服務」一併提供；當您使用該「服務」時，該等附加條款即成為您與我們所訂協議的一部分。\n\n<span class='ital_style'>使用「服務」</span>\n您必須遵守「服務」中向您提供的所有政策。\n請勿濫用「服務」。舉例來說，您不應干擾「服務」運作，亦不得試圖透過我們所提供的介面和操作說明以外的方法存取「服務」。您僅可於法律 (包括適用的出口及再出口管制法律和法規) 允許範圍內使用「服務」。如果您未遵守我們的條款或政策，或是如果我們正在調查疑似違規行為，我們可能會暫停或終提供「服務」。\n使用「服務」並不會將「服務」或您所存取內容的任何智慧財產權授予您。除非相關內容的擁有者同意或法律允許，否則您一律不得使用「服務」中的內容。本條款並未授權您可使用「服務」中所採用的任何品牌標示或標誌。請勿移除、遮蓋或變造「服務」所顯示或隨附顯示的任何法律聲明。\n「服務」中顯示的部分內容並非 AngelCare 所有，這類內容應由其提供實體承擔全部責任。我們可對內容進行審查，以判斷其是否違法或違反 AngelCare 政策，並可移除或拒絕顯示我們合理確信違反 我們政策或法律的內容。不過，這不表示我們一定會對內容進行審查，因此請勿如此認定。\n有關您對「服務」的使用，我們會向您發送服務公告、行政管理訊息和其他資訊；您可取消接收其中某些通訊內容。\n\n<span class='ital_style'>您的 AngelCare  帳戶</span>\n您可能需有「AngelCare帳戶」才能使用我們的某些「服務」。透過購買AngelCare產品後，本公司將為您指派「AngelCare  帳戶」。如果您使用的是管理人指派給您的「AngelCare  帳戶」，可能需適用不同條款或附加條款，而且您的管理人可能可以存取或停用您的帳戶。\n如果您發現密碼或帳戶遭人盜用，請按與AngelCare客服中心(02-2728-1051)聯絡。\n\n<span class='ital_style'>隱私權與著作權保護</span>\nAngelCare  的《隱私權政策》說明當您使用「服務」時，我們如何處理您的個人資料並保護您的隱私權。您使用「服務」，即表示您同意 AngelCare  可依據我們的隱私權政策的規定使用這類資料。\n\n<span class='ital_style'>您儲存在「服務」中的內容</span>\n部分「服務」可讓您提交內容；您仍保有<span class='red_style'>提交</span>內容的『智慧財產權』。簡而言之，屬於您的依舊是您的。\n當您將內容上傳或以其他方式提交至「服務」，即表示您授予 AngelCare  (及我們的合作夥伴) 全球通用的授權，可使用、代管、儲存、重製、修改、製作衍生作品 (例如健康報告、關心服務或變更您的內容，使其更加配合我們的「服務」)這類內容。您於本項授權授予的權利僅限用於營運、宣傳與改善「服務」，以及開發新的服務。即使您停止使用「服務」，本項授權仍持續具有效力。部分「服務」可讓您存取與移除先前提交至該「服務」的內容。此外，某些「服務」會有條款或設定縮限我們對提交至該類「服務」之內容的使用範圍。請確認您擁有必要權利，可就您提交至「服務」的任何內容授予我們本項授權。\n如要進一步瞭解 AngelCare  使用與儲存內容的方式，請參閱相關「服務」的隱私權政策或附加條款。如果您就「服務」提供意見或建議，我們可使用您的意見或建議，<span class='red_style'>但</span>對您不負任何義務。\n\n<span class='ital_style'>有關「服務」所含軟體</span>\n如果「服務」需有或內含可下載軟體，該軟體可能會在提供新版或新功能時，在您的裝置上自動更新。部分「服務」可以讓您調整您的自動更新設定。\nAngelCare  授予您全球通用、免權利金、不得轉讓、非專屬的個人使用授權，讓您使用 AngelCare  提供給您的、包含在「服務」中的軟體。本授權僅供您以這些條款允許之方式，使用 AngelCare  提供之「服務」並享用其利益。除非您已<span class='red_style'>事先</span>取得我們的書面許可，否則您不得複製、修改、散佈、銷售或出租「服務」的任何部分或其中包含的軟體，也不得對該軟體進行逆向工程或試圖擷取其原始程式碼。\n\n<span class='ital_style'>修改與終止「服務」</span>\n我們會持續不斷變更並改進「服務」。我們可能會新增或移除功能或特性，也可能會完全暫停或停止某項「服務」。\n您隨時都可以停止使用「服務」，不過我們並不希望您這麼做。AngelCare  也可能隨時停止向您提供「服務」，或對「服務」附加或設定新的限制。\n我們認為您的資料是屬於您所有，因此有必要維護您對這類資料的存取。當我們中止某項「服務」時，只要合理可行，我們都會給您合理的事先通知，讓您有<span class='red_style'>時間</span>能將資訊自該「服務」匯出。\n\n<span class='ital_style'>我們的擔保與免責聲明</span>\n我們會以商業上合理的技術與注意程度提供「服務」，希望您盡情使用。但關於「服務」，有些事情我們不予保證。\n除本條款或額外條款中明示規定者外，AngelCare  或其供應商或經銷商均不對「服務」做出任何特定保證。例如，我們不會就「服務」中的內容、「服務」之特定功能及其可靠性、可用性和符合您的需求的能力，做出任何承諾。我們僅以「現狀」提供「服務」。\n部分司法管轄區會規定應提供特定擔保，例如對適銷性、特殊用途適用性及未侵權之默示擔保。凡法律准許時，我們均排除一切擔保責任。\n\n<span class='ital_style'>對「服務」的責任</span>\n凡法律准許時，AngelCare  與 AngelCare  的供應商和經銷商對所失利益、收入或資料、財務損失或間接、特殊、衍生性、懲戒性或處罰性損害賠償均不負責。\n在法律准許範圍內，AngelCare  與其供應商和經銷商對依本條款所提出任何請求之總責任 (包括對任何默示擔保之責任)，均不超過您就使用「服務」而向 AngelCare  支付的金額 (或者 AngelCare  亦可選擇再向您提供該「服務」)。\n不論在任何情況下，AngelCare  與其供應商和經銷商對無法合理預見之任何損失或損害均不負責。\n\n<span class='ital_style'>公司行號使用 AngelCare  服務</span>\n如果您是代表某公司使用「服務」，即表示該公司接受本條款。該公司必須就任何因使用「服務」或違反本條款而引起或相關的請求、訴訟或法律行動 (包括承擔所有因請求、損失、損害、訴訟、判決、訴訟費用和律師費用而產生的任何責任或費用)，向 AngelCare  及其關係企業、主管人員、代理人和員工做出補償，並使其不受損害<span class='red_style'>此部分聲請合約需以公司名義簽訂方能代表公司）。</span>\n\n<span class='ital_style'>有關本條款的說明</span>\n我們可能會修改本條款或適用於某「服務」之任何額外條款，以 (例如)反映法律之變更或「服務」之變動。您應定期查閱本條款內容。這些條款如有修訂，我們會在本網頁發佈通知。我們會在相關「服務」中公布已修訂額外條款的通知。變更不會回溯適用，並將於公布變更起十四天或更長時間後方始生效。不過，針對某項「服務」新功能的變更，或基於法律理由而為之變更，將立即生效。如果您不同意某項「服務」之修訂條款，則請停止使用該「服務」。\n如果本條款與額外條款牴觸時，就該牴觸項目而言，應以額外條款為準。\n本條款規範 AngelCare  與您之間的關係，並不會衍生任何第三人受益權。\n如果您不遵守本條款，而我們並未立即採取行動，這並不表示我們要放棄任何原本即有的權利 (例如未來再採取行動的權利)。\n發生特定條款無法執行的情況時，並會影響任何其他條款。\n因本條款或「服務」所生或與其相關之任何爭議適用中華民國法律。<span class='red_style'>且因</span>本條款或「服務」所生或與其相關之所有主張<span class='red_style'>涉訟時雙方合意</span>由台灣台北地方法院為<span class='red_style'>第一審管轄法院</span>。\n如需 AngelCare  的聯絡資訊，請造訪我們的 連絡網頁。\n";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"red_style"];
        
        label1.kern = 0.0;
        label1.lineHeight = 20;
        
        [myScrollView addSubview:label1];
        
        
        NSLog(@"hei is %f",label1.frame.size.height);
        
        
        
        
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 320, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    else
    {
        int totalHei = 3360;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        
        label1.text = @"<span class='bold_style'>銀髮安全使 AngelCare服務條款</span>\n上次修改日期： 2012年10月25日\n\n<span class='ital_style'>歡迎使用 安全天使 AngelCare！</span>\n感謝您使用我們的產品和服務 (以下<span class='red_style'>共同</span>簡稱「服務」)。「服務」是由 蓋德科技股份有限公司RFID GUIDER TECHNOLOGY CO.,LTD. (地址為10083 台北市信義區忠孝東路五段482號8樓之3) (以下簡稱「AngelCare」) 提供。\n只要您使用「服務」，即表示您同意本條款，故請詳閱本條款內容。\n由於「服務」種類繁多，因此某些「服務」可能會有附加條款或產品規定。附加條款將與相關「服務」一併提供；當您使用該「服務」時，該等附加條款即成為您與我們所訂協議的一部分。\n\n<span class='ital_style'>使用「服務」</span>\n您必須遵守「服務」中向您提供的所有政策。\n請勿濫用「服務」。舉例來說，您不應干擾「服務」運作，亦不得試圖透過我們所提供的介面和操作說明以外的方法存取「服務」。您僅可於法律 (包括適用的出口及再出口管制法律和法規) 允許範圍內使用「服務」。如果您未遵守我們的條款或政策，或是如果我們正在調查疑似違規行為，我們可能會暫停或終提供「服務」。\n使用「服務」並不會將「服務」或您所存取內容的任何智慧財產權授予您。除非相關內容的擁有者同意或法律允許，否則您一律不得使用「服務」中的內容。本條款並未授權您可使用「服務」中所採用的任何品牌標示或標誌。請勿移除、遮蓋或變造「服務」所顯示或隨附顯示的任何法律聲明。\n「服務」中顯示的部分內容並非 AngelCare 所有，這類內容應由其提供實體承擔全部責任。我們可對內容進行審查，以判斷其是否違法或違反 AngelCare 政策，並可移除或拒絕顯示我們合理確信違反 我們政策或法律的內容。不過，這不表示我們一定會對內容進行審查，因此請勿如此認定。\n有關您對「服務」的使用，我們會向您發送服務公告、行政管理訊息和其他資訊；您可取消接收其中某些通訊內容。\n\n<span class='ital_style'>您的 AngelCare  帳戶</span>\n您可能需有「AngelCare帳戶」才能使用我們的某些「服務」。透過購買AngelCare產品後，本公司將為您指派「AngelCare  帳戶」。如果您使用的是管理人指派給您的「AngelCare  帳戶」，可能需適用不同條款或附加條款，而且您的管理人可能可以存取或停用您的帳戶。\n如果您發現密碼或帳戶遭人盜用，請按與AngelCare客服中心(02-2728-1051)聯絡。\n\n<span class='ital_style'>隱私權與著作權保護</span>\nAngelCare  的《隱私權政策》說明當您使用「服務」時，我們如何處理您的個人資料並保護您的隱私權。您使用「服務」，即表示您同意 AngelCare  可依據我們的隱私權政策的規定使用這類資料。\n\n<span class='ital_style'>您儲存在「服務」中的內容</span>\n部分「服務」可讓您提交內容；您仍保有<span class='red_style'>提交</span>內容的『智慧財產權』。簡而言之，屬於您的依舊是您的。\n當您將內容上傳或以其他方式提交至「服務」，即表示您授予 AngelCare  (及我們的合作夥伴) 全球通用的授權，可使用、代管、儲存、重製、修改、製作衍生作品 (例如健康報告、關心服務或變更您的內容，使其更加配合我們的「服務」)這類內容。您於本項授權授予的權利僅限用於營運、宣傳與改善「服務」，以及開發新的服務。即使您停止使用「服務」，本項授權仍持續具有效力。部分「服務」可讓您存取與移除先前提交至該「服務」的內容。此外，某些「服務」會有條款或設定縮限我們對提交至該類「服務」之內容的使用範圍。請確認您擁有必要權利，可就您提交至「服務」的任何內容授予我們本項授權。\n如要進一步瞭解 AngelCare  使用與儲存內容的方式，請參閱相關「服務」的隱私權政策或附加條款。如果您就「服務」提供意見或建議，我們可使用您的意見或建議，<span class='red_style'>但</span>對您不負任何義務。\n\n<span class='ital_style'>有關「服務」所含軟體</span>\n如果「服務」需有或內含可下載軟體，該軟體可能會在提供新版或新功能時，在您的裝置上自動更新。部分「服務」可以讓您調整您的自動更新設定。\nAngelCare  授予您全球通用、免權利金、不得轉讓、非專屬的個人使用授權，讓您使用 AngelCare  提供給您的、包含在「服務」中的軟體。本授權僅供您以這些條款允許之方式，使用 AngelCare  提供之「服務」並享用其利益。除非您已<span class='red_style'>事先</span>取得我們的書面許可，否則您不得複製、修改、散佈、銷售或出租「服務」的任何部分或其中包含的軟體，也不得對該軟體進行逆向工程或試圖擷取其原始程式碼。\n\n<span class='ital_style'>修改與終止「服務」</span>\n我們會持續不斷變更並改進「服務」。我們可能會新增或移除功能或特性，也可能會完全暫停或停止某項「服務」。\n您隨時都可以停止使用「服務」，不過我們並不希望您這麼做。AngelCare  也可能隨時停止向您提供「服務」，或對「服務」附加或設定新的限制。\n我們認為您的資料是屬於您所有，因此有必要維護您對這類資料的存取。當我們中止某項「服務」時，只要合理可行，我們都會給您合理的事先通知，讓您有<span class='red_style'>時間</span>能將資訊自該「服務」匯出。\n\n<span class='ital_style'>我們的擔保與免責聲明</span>\n我們會以商業上合理的技術與注意程度提供「服務」，希望您盡情使用。但關於「服務」，有些事情我們不予保證。\n除本條款或額外條款中明示規定者外，AngelCare  或其供應商或經銷商均不對「服務」做出任何特定保證。例如，我們不會就「服務」中的內容、「服務」之特定功能及其可靠性、可用性和符合您的需求的能力，做出任何承諾。我們僅以「現狀」提供「服務」。\n部分司法管轄區會規定應提供特定擔保，例如對適銷性、特殊用途適用性及未侵權之默示擔保。凡法律准許時，我們均排除一切擔保責任。\n\n<span class='ital_style'>對「服務」的責任</span>\n凡法律准許時，AngelCare  與 AngelCare  的供應商和經銷商對所失利益、收入或資料、財務損失或間接、特殊、衍生性、懲戒性或處罰性損害賠償均不負責。\n在法律准許範圍內，AngelCare  與其供應商和經銷商對依本條款所提出任何請求之總責任 (包括對任何默示擔保之責任)，均不超過您就使用「服務」而向 AngelCare  支付的金額 (或者 AngelCare  亦可選擇再向您提供該「服務」)。\n不論在任何情況下，AngelCare  與其供應商和經銷商對無法合理預見之任何損失或損害均不負責。\n\n<span class='ital_style'>公司行號使用 AngelCare  服務</span>\n如果您是代表某公司使用「服務」，即表示該公司接受本條款。該公司必須就任何因使用「服務」或違反本條款而引起或相關的請求、訴訟或法律行動 (包括承擔所有因請求、損失、損害、訴訟、判決、訴訟費用和律師費用而產生的任何責任或費用)，向 AngelCare  及其關係企業、主管人員、代理人和員工做出補償，並使其不受損害<span class='red_style'>此部分聲請合約需以公司名義簽訂方能代表公司）。</span>\n\n<span class='ital_style'>有關本條款的說明</span>\n我們可能會修改本條款或適用於某「服務」之任何額外條款，以 (例如)反映法律之變更或「服務」之變動。您應定期查閱本條款內容。這些條款如有修訂，我們會在本網頁發佈通知。我們會在相關「服務」中公布已修訂額外條款的通知。變更不會回溯適用，並將於公布變更起十四天或更長時間後方始生效。不過，針對某項「服務」新功能的變更，或基於法律理由而為之變更，將立即生效。如果您不同意某項「服務」之修訂條款，則請停止使用該「服務」。\n如果本條款與額外條款牴觸時，就該牴觸項目而言，應以額外條款為準。\n本條款規範 AngelCare  與您之間的關係，並不會衍生任何第三人受益權。\n如果您不遵守本條款，而我們並未立即採取行動，這並不表示我們要放棄任何原本即有的權利 (例如未來再採取行動的權利)。\n發生特定條款無法執行的情況時，並會影響任何其他條款。\n因本條款或「服務」所生或與其相關之任何爭議適用中華民國法律。<span class='red_style'>且因</span>本條款或「服務」所生或與其相關之所有主張<span class='red_style'>涉訟時雙方合意</span>由台灣台北地方法院為<span class='red_style'>第一審管轄法院</span>。\n如需 AngelCare  的聯絡資訊，請造訪我們的 連絡網頁。\n";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"red_style"];
        
        label1.kern = 0.1;
        label1.lineHeight = 30;
        
        [myScrollView addSubview:label1];
        
        
        NSLog(@"hei is %f",label1.frame.size.height);
        
        
        
        
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 768, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    
    
}



-(IBAction)cancel:(id)sender
{
    //ios7 modify
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

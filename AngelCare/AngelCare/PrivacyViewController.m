//
//  PrivacyViewController.m
//  AngelCare
//
//  Created by macmini on 2013/12/9.
//
//

#import "PrivacyViewController.h"
#import "src/NMCustomLabel.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

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
-(IBAction)cancel:(id)sender
{
    //ios7 modify
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissModalViewControllerAnimated:YES];
}


//設定為英文版本
-(void)Set_En
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        
        int totalHei = 3845;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        label1.text =  @"<span class='ital_style'>Privacy Policy</span>\n\tYour privacy is important to mCareWatch. Our Privacy Policy covers how we collect, use, disclose, transfer, and store your information. Please take a moment to familiarize yourself with our privacy practices and let us know if you have any questions.\n\n<span class='ital_style'>Collection and Use of Personal Information</span>\n\tPersonal information is data that can be used to uniquely identify or contact a single person. You may be asked to provide your personal information anytime you are in contact with mCareWatch or mCareWatch affiliated company. mCareWatch and its affiliates may share this personal information with each other and use it consistent with this Privacy Policy. They may also combine it with other information to provide and improve our products, services, content, and promotion. Here are some examples of the types of personal information mCareWatch may collect and how we may use it.\n\n<span class='ital_style'>What personal information we collect</span>\n\tWhen you create an mCareWatch ID, register your products, apply for Location, Tracking and Measurement, or participate in an online survey, we may collect a variety of information, including your name, mailing address and specific health parameters such as Blood Glucose, Blood Pressure, Weight, Blood Oximeter information.\n\n<span class='ital_style'>How we use your personal information</span>\n\tThe personal information we collect allows us to keep you posted on mCareWatch’s latest product news, software updates, and upcoming events. It also helps to improve our services, content, and other promotional activity. If you do not want to be on our mailing list, you can opt out anytime by updating your preferences. We also use personal information to help develop, deliver, and improve our products, services, content, and promotional activity. From time to time, we may use your personal information to send important notices, such as communications about purchases and changes to our terms, conditions, and policies. Because this information is important to your engagement with mCareWatch, you may not opt out of receiving this communication. We may also use personal information for internal purposes such as auditing, data analysis, and research to improve mCareWatch’s products, services, and customer communications.\n\n<span class='ital_style'>Collection and Use of Non-Personal Information</span>\n\tWe also collect non-personal information − data that does not permit direct association with any specific individual. We may collect, use, transfer, and disclose non-personal information for any purpose. The following are some examples of non-personal information that we collect and how it may be used: information such as occupation, language, postcode, state, unique device identifier, location, and the time zone where mCareWatch product is being used. We may also collect information regarding customer activities on our website and from our other products and services. This information is aggregated and used to help us provide more useful information to our customers and to understand which parts of our website, products, and services are most popular. Aggregated data is considered non-personal information for the purposes of this Privacy Policy.\n\n<span class='ital_style'>Disclosure to Third Parties</span>\n\tAt times mCareWatch may make certain personal information available to strategic partners that work with mCareWatch to provide products and services, or that assist mCareWatch market to their customers. For example, when you purchase and activate your device, you authorize mCareWatch and its carrier to exchange the information you provide during the activation process to carry out service. If you are approved for service, your account will be governed by mCareWatch and its carrier’s respective privacy policies. Personal information will only be shared by mCareWatch to provide or improve our products, services and promotional activity; it will not be shared with third parties for their marketing purposes.\n\n<span class='ital_style'>Service Providers</span>\n\tmCareWatch shares personal information with companies who provide services such as information processing, extending credit, fulfilling customer orders, delivering products to you, managing and enhancing customer data, providing customer service, assessing your interest in our products and services, and conducting customer research or satisfaction surveys. These companies are obligated to protect your information and may be located wherever mCareWatch operates.\n\n<span class='ital_style'>Others</span>\n\tIt may be necessary − by law, legal process, litigation, and/or requests from public and governmental authorities within or outside your country of residence − for mCareWatch to disclose your personal information. We may also disclose information about you if we determine that for purposes of national security, law enforcement, or other issues of public importance, disclosure is necessary or appropriate. We may also disclose information about you if we determine that disclosure is reasonably necessary to enforce our terms and conditions or protect our operations or users. Additionally, in the event of a reorganization, merger, or sale we may transfer any and all personal information we collect to the relevant third party.\n\n<span class='ital_style'>Protection of Personal Information</span>\n\tmCareWatch takes precautions — including administrative, technical, and physical measures — to safeguard your personal information against loss, theft, and misuse, as well as against unauthorized access, disclosure, alteration, and destruction. mCareWatch online services such as the mCareWatch website use Secure Sockets Layer (SSL) encryption on all web pages where personal information is collected. To make purchases from these services, you must use an SSL-enabled browser such as Safari, Firefox, or Internet Explorer. Doing so protects the confidentiality of your personal information when transmitted online.\n\n<span class='ital_style'>Integrity and Retention of Personal Information</span>\n\tmCareWatch makes it easy for you to keep your personal information accurate, complete, and up to date. We will retain your personal information for the period necessary to fulfill the purposes outlined in this Privacy Policy unless a longer retention period is required or permitted by law.\n\n<span class='ital_style'>Access to Personal Information</span>\n\tYou can help ensure that your contact information and preferences are accurate, complete, and up to date by logging in to your account at https://www.mcarewatch.com.au For other personal information, we make good faith effort to provide you with access so you can request that we correct the data if it is inaccurate or delete the data if mCareWatch is not required to retain it by law or for legitimate business purposes. We may decline to process requests that are unreasonably repetitive, require disproportionate technical effort, jeopardize the privacy of others, are extremely impractical, or for which access is not otherwise required by local law. Access, correction, or deletion requests can be made through the regional Privacy Contact Form.\n\n<span class='ital_style'>Location-Based Services</span>\n\tTo provide location-based services on mCareWatch products, mCareWatch and our partners and licensees may collect, use, and share precise location data, including the real-time geographic location of your mCareWatch device. This location data is collected anonymously in a form that does not personally identify you and is used by mCareWatch and our partners and licensees to provide and improve location-based products and services. For example, we may share geographic location with application providers when you opt in to their location services. Some location-based services offered by mCareWatch, such as the “Find My device” feature, require your personal information for the feature to work.\n\n<span class='ital_style'>Third-Party Sites and Services</span>\n\tmCareWatch mobile APP, products, applications, and services may contain links to third-party websites, products, and services. Our products and services may also use or offer products or services from third parties − for example, a third-party mobile app. Information collected by third parties, which may include such things as location data or contact details, is governed by their privacy practices. We encourage you to read the privacy practices of these third parties.\n\n<span class='ital_style'>Our Companywide Commitment to Your Privacy</span>\n\tTo make sure your personal information is secure, we communicate our privacy and security guidelines to mCareWatch employees and strictly enforce privacy safeguards within the company.\n\n<span class='ital_style'>Privacy Questions</span>\n\tIf you have any questions or concerns about mCareWatch’s Privacy Policy or data processing, please contact us. mCareWatch may update its Privacy Policy from time to time. When we change the policy, a notice will be posted on our website along with the updated Privacy Policy.\n";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        label1.kern = 0.0;
        label1.lineHeight = 20;
        [myScrollView addSubview:label1];
        
        /*
         
         NMCustomLabel *label2 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(30, 125, myScrollView.frame.size.width-60, 230)];
         label2.text = @"You think water moves fast? You should see ice. It moves like it has a mind. <span class='bold_style'>Like it knows it killed the world once and got a taste for murder.</span> After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. <span class='ital_style'>Nature is lethal but it doesn't hold a candle to man.</span>";
         [label2 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:60/255.0 green:87/255.0 blue:186/255.0 alpha:1.0]]];
         [label2 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Georgia-Bold" size:16] color:[UIColor colorWithRed:98/255.0 green:186/255.0 blue:60/255.0 alpha:1.0]] forKey:@"bold_style"];
         [label2 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Verdana-Italic" size:15] color:[UIColor colorWithRed:60/255.0 green:87/255.0 blue:186/255.0 alpha:1.0]] forKey:@"ital_style"];
         label2.kern = 0.6;
         label2.lineHeight = 16;
         [myScrollView addSubview:label2];
         
         NMCustomLabel *label3 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(30, 350, myScrollView.frame.size.width-60, 50)];
         label3.text = @"This is a picture of me: <span class='fez'>         </span>  – what do you think?";
         [label3 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Georgia" size:14] color:[UIColor colorWithRed:98/255.0 green:227/255.0 blue:104/255.0 alpha:1]]];
         [label3 setStyle:[NMCustomLabelStyle styleWithImage:[UIImage imageNamed:@"fez.png"] verticalOffset:-8] forKey:@"fez"];
         label3.lineHeight = 25;
         [myScrollView addSubview:label3];
         
         
         */
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 320, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    else
    {
        int totalHei = 4170;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        
        label1.text = @"<span class='ital_style'>Privacy Policy</span>\nYour privacy is important to AngelCare. So we’ve developed a Privacy Policy that covers how we collect, use, disclose, transfer, and store your information. Please take a moment to familiarize yourself with our privacy practices and let us know if you have any questions\n\n\n<span class='ital_style'>Collection and Use of Personal Information</span>\nPersonal information is data that can be used to uniquely identify or contact a single person.\nPersonal information is data that can be used to uniquely identify or contact a single person.\nYou may be asked to provide your personal information anytime you are in contact with AngelCare or an AngelCare affiliated company. AngelCare and its affiliates may share this personal information with each other and use it consistent with this Privacy Policy. They may also combine it with other information to provide and improve our products, services, content, and advertising.\nHere are some examples of the types of personal information AngelCare may collect and how we may use it.\n\n\n<span class='ital_style'>What personal information we collect</span>\n\tWhen you create an AngelCare ID, register your products, apply for Location, Tracking and Measurement, or participate in an online survey, we may collect a variety of information, including your name, mailing address, Blood Glucose, Blood Pressure, Weight, Blood Oximeter information.\n\n\n<span class='ital_style'>How we use your personal information</span>\n\tThe personal information we collect allows us to keep you posted on AngelCare’s latest product announcements, software updates, and upcoming events. It also helps us to improve our services, content, and advertising. If you don’t want to be on our mailing list, you can opt out anytime by updating your preferences.\n\tWe also use personal information to help us develop, deliver, and improve our products, services, content, and advertising.\n\tFrom time to time, we may use your personal information to send important notices, such as communications about purchases and changes to our terms, conditions, and policies. Because this information is important to your interaction with AngelCare, you may not opt out of receiving these communications.\nWe may also use personal information for internal purposes such as auditing, data analysis, and research to improve AngelCare’s products, services, and customer communications.\n\n\n<span class='ital_style'>Collection and Use of Non-Personal Information</span>\n\tWe also collect non-personal information − data in a form that does not permit direct association with any specific individual. We may collect, use, transfer, and disclose non-personal information for any purpose. The following are some examples of non-personal information that we collect and how we may use it:\nWe may collect information such as occupation, language, zip code, area code, unique device identifier, location, and the time zone where an AngelCare product is used so that we can better understand customer behavior and improve our products, services, and advertising.\n\tWe also may collect information regarding customer activities on our website and from our other products and services. This information is aggregated and used to help us provide more useful information to our customers and to understand which parts of our website, products, and services are of most interest. Aggregated data is considered non-personal information for the purposes of this Privacy Policy.\n\n\n<span class='ital_style'>Disclosure to Third Parties</span>\n\tAt times AngelCare may make certain personal information available to strategic partners that work with AngelCare to provide products and services, or that help AngelCare market to customers. For example, when you purchase and activate your device, you authorize AngelCare and its carrier to exchange the information you provide during the activation process to carry out service. If you are approved for service, your account will be governed by AngelCare and its carrier’s respective privacy policies. Personal information will only be shared by AngelCare to provide or improve our products, services and advertising; it will not be shared with third parties for their marketing purposes.\n\n\n<span class='ital_style'>Service Providers</span>\nAngelCare shares personal information with companies who provide services such as information processing, extending credit, fulfilling customer orders, delivering products to you, managing and enhancing customer data, providing customer service, assessing your interest in our products and services, and conducting customer research or satisfaction surveys. These companies are obligated to protect your information and may be located wherever AngelCare operates.\n\n\n<span class='ital_style'>Others</span>\nIt may be necessary − by law, legal process, litigation, and/or requests from public and governmental authorities within or outside your country of residence − for AngelCare to disclose your personal information. We may also disclose information about you if we determine that for purposes of national security, law enforcement, or other issues of public importance, disclosure is necessary or appropriate.\nWe may also disclose information about you if we determine that disclosure is reasonably necessary to enforce our terms and conditions or protect our operations or users. Additionally, in the event of a reorganization, merger, or sale we may transfer any and all personal information we collect to the relevant third party.\n\n\n<span class='ital_style'>Protection of Personal Information</span>\nAngelCare takes precautions — including administrative, technical, and physical measures — to safeguard your personal information against loss, theft, and misuse, as well as against unauthorized access, disclosure, alteration, and destruction.\nAngelCare online services such as the AngelCare Website use Secure Sockets Layer (SSL) encryption on all web pages where personal information is collected. To make purchases from these services, you must use an SSL-enabled browser such as Safari, Firefox, or Internet Explorer. Doing so protects the confidentiality of your personal information while it’s transmitted over the Internet.\n\n\n<span class='ital_style'>Integrity and Retention of Personal Information</span>\nAngelCare makes it easy for you to keep your personal information accurate, complete, and up to date. We will retain your personal information for the period necessary to fulfill the purposes outlined in this Privacy Policy unless a longer retention period is required or permitted by law.\n\n\n<span class='ital_style'>Access to Personal Information</span>\nYou can help ensure that your contact information and preferences are accurate, complete, and up to date by logging in to your account at https://www.guidercare.com/. For other personal information, we make good faith efforts to provide you with access so you can request that we correct the data if it is inaccurate or delete the data if AngelCare is not required to retain it by law or for legitimate business purposes. We may decline to process requests that are unreasonably repetitive, require disproportionate technical effort, jeopardize the privacy of others, are extremely impractical, or for which access is not otherwise required by local law. Access, correction, or deletion requests can be made through the regional Privacy Contact Form.\n\n\n<span class='ital_style'>Location-Based Services</span>\nTo provide location-based services on AngelCare products, AngelCare and our partners and licensees may collect, use, and share precise location data, including the real-time geographic location of your AngelCare computer or device. This location data is collected anonymously in a form that does not personally identify you and is used by AngelCare and our partners and licensees to provide and improve location-based products and services. For example, we may share geographic location with application providers when you opt in to their location services.\nSome location-based services offered by AngelCare, such as the “Find My device” feature, require your personal information for the feature to work.\n\n\n<span class='ital_style'>Third-Party Sites and Services</span>\nngelCare APP, products, applications, and services may contain links to third-party websites, products, and services. Our products and services may also use or offer products or services from third parties − for example, a third-party app. Information collected by third parties, which may include such things as location data or contact details, is governed by their privacy practices. We encourage you to learn about the privacy practices of those third parties.\n\n\n<span class='ital_style'>Our Companywide Commitment to Your Privacy</span>\nTo make sure your personal information is secure, we communicate our privacy and security guidelines to AngelCare employees and strictly enforce privacy safeguards within the company.\n\n\n<span class='ital_style'>Privacy Questions</span>\nIf you have any questions or concerns about AngelCare’s Privacy Policy or data processing, please contact us.\nAngelCare may update its Privacy Policy from time to time. When we change the policy in a material way, a notice will be posted on our website along with the updated Privacy Policy.\n";
        
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        label1.kern = 0.1;
        label1.lineHeight = 30;
        
        [myScrollView addSubview:label1];
        
        
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
        
        int totalHei = 2625;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        label1.text = @"<span class='ital_style'>隐私权政策</span>\n盖德科技股份有限公司 (以下简称AngelCare公司) 非常重视你的隐私权。所以我们制定了一项隐私权政策，载明我们如何收集、使用、揭露、移转及储存你的数据。请花一些时间熟读我们的隐私权作法，如你有任何疑问，亦请传达给我们。\n\n<span class='ital_style'>个人资料的收集与使用</span>\n个人资料，即是可用以辨识或联络特定个人的资料。\n在你与 AngelCare 公司或 AngelCare 公司的关系企业接触时，即可能被要求提供个人资料。AngelCare 公司与其关系企业可能相互共享本项个人资料，其使用将遵守本隐私权政策。AngelCare 公司与其关系企业亦可能将个人资料与其他数据合并，用以提供并改进我们的产品、服务、内容及广告。\n有关 AngelCare 公司可能收集的个人资料类型，以及可能如何使用这类个人资料，举例说明如下：\n\n<span class='ital_style'>我们收集什么样的个人资料</span>\n\t	在你使用 AngelCare 公司产品记录您的移动位置、量测数据时，AngelCare 公司即可能收集你所提供数据，如：地址、血糖、血压、体重、血氧、使用率，但不会额外询问您的个人辨识数据。\n\n<span class='ital_style'>我们如何使用你的个人资料</span>\n\t我们所收集的量测资料，在您取得特殊方案服务授权下，使我们得以通知你有关 AngelCare 公司提供给您参考建议及广告信息。亦可用以协助我们改进我们的服务及内容。\n\t我们亦可能不时使用你的个人资料传送重要通知，诸如有关购买产品或修改我们条款或政策之通知。由于本项通知讯息对你与 AngelCare 公司之互动关系十分重要，所以你无法退出不接收本项通知。\n\t我们亦可能为内部目的使用量测及定位数据，例如：稽核、资料分析及研究等，以改进 AngelCare 公司之产品、服务及客户沟通。\n\n<span class='ital_style'>非个人资料的收集与使用</span>\n\t我们亦收集非个人资料，非个人资料即指无法直接用于相关任何特定个人之数据。我们得为任何目的收集、使用、移转及揭露非个人资料。有关我们收集的非个人资料以及可能的使用方式，举例说明如下：\n我们可能收集的数据诸如：装置个别识别标记、地点、时间，使我们得以更了解客户行为，并改进我们的产品、服务及广告。\n\t本项数据会被彚总及用以协助我们提供更有用的数据给客户，并了解我们那些部分的网站、产品及服务最具重要性。在本隐私权政策中，彚总的资料被认作非个人资料。\n若我们合并非个人资料与个人资料，则合并数据在合并之情形下，均被认作个人资料。\n\n<span class='ital_style'>揭露予第三人</span>\n\tAngelCare 公司有时可能提供特定个人资料，予配合 AngelCare 公司提供产品与服务或协助 AngelCare 公司向客户营销的策略性合作厂商。例如，在你购买并启动你的AngelCare手机手表时，你即授权 AngelCare 公司与其电信公司交换你在启动过程中所提供的数据，以执行服务。若你获许得到服务，你的账户处理即依据 AngelCare 公司与其电信公司各自的隐私权政策。AngelCare 公司仅会分享个人资料以提供或改进我们的产品、服务及广告，而不会分享予第三人供其用于营销目的。\n\n<span class='ital_style'>服务供货商</span>\nAngelCare 公司仅与提供下列服务的公司分享个人资料，诸如：数据处理、展延信用、完成客户订单、交付产品予你、管理及提升客户数据、提供客户服务、评估你对我们产品与服务的兴趣、进行客户研究或满意度调查。该等公司有义务保护你的数据，其可能位于 AngelCare 公司营运的任何地方。\n\n<span class='ital_style'>其他人</span>\n在有些情形下，无论是在你居住所在国之内或之外，依据法律、法律程序、诉讼、及/或公家机关或政府机构的要求，AngelCare 公司可能必须揭露你的个人资料。若我们认为基于国家安全、法律执行或其他重要公共议题之目的揭露你的数据系属必要或适当，则我们亦可能揭露之。\n若为执行我们的条款或保护我们的营运或使用者，而令我们认为揭露你的数据系属合理必要者，则我们亦可能揭露之。此外，若发生公司重整、合并或出售情事，我们亦可能移转任何及全部我们所收集的个人资料予相关第三人。\n\n<span class='ital_style'>个人资料的保护</span>\nAngelCare 公司采取预防措施保护你的个人资料，包括行政上、技术上及实际上的措施，使你的个人资料免于损失、遭窃或滥用，亦免于遭受未经授权之擅自存取、揭露、变更或损毁。\nAngelCare 公司的在线服务，均使用「安全套接层」(Secure Sockets Layer；SSL) 加密在所有收集个人资料的网页。若欲从上述服务购买产品，你必须使用可启动 SSL 的浏览器，诸如 Safari、Firefox、或 Internet Explorer。当你的个人资料在因特网上传输时，上述措施保护你个人资料的机密性。\n\n<span class='ital_style'>个人资料的完整与保留</span>\nAngelCare 公司让你轻松维持正确、完整且最新的个人资料。我们保留你个人资料的期限，以完成本隐私权政策所载目的所必要的期间为准，但若法律要求或许可更长的期间，则不在此限。\n\n<span class='ital_style'>个人资料的存取</span>\n只要在 购买时填写您的账户，透过审查后，将会核发您专属帐户数据。关于其他个人资料，我们竭尽诚挚努力提供你存取路径，所以若数据不正确，你可要求我们改正，或倘依法或为正当商业目的 AngelCare 公司无须继续保留数据，你亦可要求我们将之删除。惟若你提出的要求不合理的反复、需要不成比例的技术上努力、危害他人隐私、极度不切实际、或该要求之存取依当地法律并非规定必要者，则我们亦得拒绝处理你的要求。若有存取、改正或删除的要求，请向AngelCare公司提出申请。\n\n<span class='ital_style'>位置服务</span>\n为于 AngelCare 公司产品上提供以位置为基础的服务，AngelCare 公司与其合作厂商及被授权人得收集、使用及分享精确的地点数据，包括你的 AngelCare 计算机或装置的实时地理位置。本项数据的收集是以无法辨识你个人身分的匿名方式为之，且数据是由 AngelCare 公司与其合作厂商及被授权人使用于提供及改进以位置为基础的产品与服务。例如，若你选择进入软件供货商的位置服务，则我们可能与该软件供货商分享地理位置的数据。\nAngelCare 公司提供的某些以位置为基础的服务，例如「寻找我的 iPhone」的功能，必须要有你的个人资料，功能始能执行。\n\n<span class='ital_style'>第三人网站与服务</span>\nAngelCare 公司的网站、产品、应用软件及服务可能含有链接至第三人网站、产品或服务的链接。我们产品与服务亦可能使用或提供第三人产品或服务。第三人所收集的数据，可能包括诸如位置数据或详细联络数据等的数据，均依据该第三人的隐私权常规为准。我们鼓励你了解这些第三人的隐私权实施方式。\n\n<span class='ital_style'>我们全体对保护你隐私权的承诺</span>\n为确保你的个人资料安全，我们传递我们的隐私权与安全准则予 AngelCare 公司员工，并在公司内严格执行隐私权防护措施。\n\n<span class='ital_style'>隐私权问题</span>\n若你对 AngelCare 公司隐私权政策或数据处理有问题或疑虑，请联络我们。\nAngelCare 公司得不时更新其隐私权政策。我们对本政策进行重大修改时，将在我们网站上张贴公告，并附上更新后的隐私权政策。\n";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        label1.kern = 0.0;
        label1.lineHeight = 20;
        [myScrollView addSubview:label1];
        
        /*
         
         NMCustomLabel *label2 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(30, 125, myScrollView.frame.size.width-60, 230)];
         label2.text = @"You think water moves fast? You should see ice. It moves like it has a mind. <span class='bold_style'>Like it knows it killed the world once and got a taste for murder.</span> After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. <span class='ital_style'>Nature is lethal but it doesn't hold a candle to man.</span>";
         [label2 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:60/255.0 green:87/255.0 blue:186/255.0 alpha:1.0]]];
         [label2 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Georgia-Bold" size:16] color:[UIColor colorWithRed:98/255.0 green:186/255.0 blue:60/255.0 alpha:1.0]] forKey:@"bold_style"];
         [label2 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Verdana-Italic" size:15] color:[UIColor colorWithRed:60/255.0 green:87/255.0 blue:186/255.0 alpha:1.0]] forKey:@"ital_style"];
         label2.kern = 0.6;
         label2.lineHeight = 16;
         [myScrollView addSubview:label2];
         
         NMCustomLabel *label3 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(30, 350, myScrollView.frame.size.width-60, 50)];
         label3.text = @"This is a picture of me: <span class='fez'>         </span>  – what do you think?";
         [label3 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Georgia" size:14] color:[UIColor colorWithRed:98/255.0 green:227/255.0 blue:104/255.0 alpha:1]]];
         [label3 setStyle:[NMCustomLabelStyle styleWithImage:[UIImage imageNamed:@"fez.png"] verticalOffset:-8] forKey:@"fez"];
         label3.lineHeight = 25;
         [myScrollView addSubview:label3];
         
         
         */
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 320, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    else
    {
        int totalHei = 3080;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        label1.text = @"<span class='ital_style'>隐私权政策</span>\n盖德科技股份有限公司 (以下简称AngelCare公司) 非常重视你的隐私权。所以我们制定了一项隐私权政策，载明我们如何收集、使用、揭露、移转及储存你的数据。请花一些时间熟读我们的隐私权作法，如你有任何疑问，亦请传达给我们。\n\n<span class='ital_style'>个人资料的收集与使用</span>\n个人资料，即是可用以辨识或联络特定个人的资料。\n在你与 AngelCare 公司或 AngelCare 公司的关系企业接触时，即可能被要求提供个人资料。AngelCare 公司与其关系企业可能相互共享本项个人资料，其使用将遵守本隐私权政策。AngelCare 公司与其关系企业亦可能将个人资料与其他数据合并，用以提供并改进我们的产品、服务、内容及广告。\n有关 AngelCare 公司可能收集的个人资料类型，以及可能如何使用这类个人资料，举例说明如下：\n\n<span class='ital_style'>我们收集什么样的个人资料</span>\n\t	在你使用 AngelCare 公司产品记录您的移动位置、量测数据时，AngelCare 公司即可能收集你所提供数据，如：地址、血糖、血压、体重、血氧、使用率，但不会额外询问您的个人辨识数据。\n\n<span class='ital_style'>我们如何使用你的个人资料</span>\n\t我们所收集的量测资料，在您取得特殊方案服务授权下，使我们得以通知你有关 AngelCare 公司提供给您参考建议及广告信息。亦可用以协助我们改进我们的服务及内容。\n\t我们亦可能不时使用你的个人资料传送重要通知，诸如有关购买产品或修改我们条款或政策之通知。由于本项通知讯息对你与 AngelCare 公司之互动关系十分重要，所以你无法退出不接收本项通知。\n\t我们亦可能为内部目的使用量测及定位数据，例如：稽核、资料分析及研究等，以改进 AngelCare 公司之产品、服务及客户沟通。\n\n<span class='ital_style'>非个人资料的收集与使用</span>\n\t我们亦收集非个人资料，非个人资料即指无法直接用于相关任何特定个人之数据。我们得为任何目的收集、使用、移转及揭露非个人资料。有关我们收集的非个人资料以及可能的使用方式，举例说明如下：\n我们可能收集的数据诸如：装置个别识别标记、地点、时间，使我们得以更了解客户行为，并改进我们的产品、服务及广告。\n\t本项数据会被彚总及用以协助我们提供更有用的数据给客户，并了解我们那些部分的网站、产品及服务最具重要性。在本隐私权政策中，彚总的资料被认作非个人资料。\n若我们合并非个人资料与个人资料，则合并数据在合并之情形下，均被认作个人资料。\n\n<span class='ital_style'>揭露予第三人</span>\n\tAngelCare 公司有时可能提供特定个人资料，予配合 AngelCare 公司提供产品与服务或协助 AngelCare 公司向客户营销的策略性合作厂商。例如，在你购买并启动你的AngelCare手机手表时，你即授权 AngelCare 公司与其电信公司交换你在启动过程中所提供的数据，以执行服务。若你获许得到服务，你的账户处理即依据 AngelCare 公司与其电信公司各自的隐私权政策。AngelCare 公司仅会分享个人资料以提供或改进我们的产品、服务及广告，而不会分享予第三人供其用于营销目的。\n\n<span class='ital_style'>服务供货商</span>\nAngelCare 公司仅与提供下列服务的公司分享个人资料，诸如：数据处理、展延信用、完成客户订单、交付产品予你、管理及提升客户数据、提供客户服务、评估你对我们产品与服务的兴趣、进行客户研究或满意度调查。该等公司有义务保护你的数据，其可能位于 AngelCare 公司营运的任何地方。\n\n<span class='ital_style'>其他人</span>\n在有些情形下，无论是在你居住所在国之内或之外，依据法律、法律程序、诉讼、及/或公家机关或政府机构的要求，AngelCare 公司可能必须揭露你的个人资料。若我们认为基于国家安全、法律执行或其他重要公共议题之目的揭露你的数据系属必要或适当，则我们亦可能揭露之。\n若为执行我们的条款或保护我们的营运或使用者，而令我们认为揭露你的数据系属合理必要者，则我们亦可能揭露之。此外，若发生公司重整、合并或出售情事，我们亦可能移转任何及全部我们所收集的个人资料予相关第三人。\n\n<span class='ital_style'>个人资料的保护</span>\nAngelCare 公司采取预防措施保护你的个人资料，包括行政上、技术上及实际上的措施，使你的个人资料免于损失、遭窃或滥用，亦免于遭受未经授权之擅自存取、揭露、变更或损毁。\nAngelCare 公司的在线服务，均使用「安全套接层」(Secure Sockets Layer；SSL) 加密在所有收集个人资料的网页。若欲从上述服务购买产品，你必须使用可启动 SSL 的浏览器，诸如 Safari、Firefox、或 Internet Explorer。当你的个人资料在因特网上传输时，上述措施保护你个人资料的机密性。\n\n<span class='ital_style'>个人资料的完整与保留</span>\nAngelCare 公司让你轻松维持正确、完整且最新的个人资料。我们保留你个人资料的期限，以完成本隐私权政策所载目的所必要的期间为准，但若法律要求或许可更长的期间，则不在此限。\n\n<span class='ital_style'>个人资料的存取</span>\n只要在 购买时填写您的账户，透过审查后，将会核发您专属帐户数据。关于其他个人资料，我们竭尽诚挚努力提供你存取路径，所以若数据不正确，你可要求我们改正，或倘依法或为正当商业目的 AngelCare 公司无须继续保留数据，你亦可要求我们将之删除。惟若你提出的要求不合理的反复、需要不成比例的技术上努力、危害他人隐私、极度不切实际、或该要求之存取依当地法律并非规定必要者，则我们亦得拒绝处理你的要求。若有存取、改正或删除的要求，请向AngelCare公司提出申请。\n\n<span class='ital_style'>位置服务</span>\n为于 AngelCare 公司产品上提供以位置为基础的服务，AngelCare 公司与其合作厂商及被授权人得收集、使用及分享精确的地点数据，包括你的 AngelCare 计算机或装置的实时地理位置。本项数据的收集是以无法辨识你个人身分的匿名方式为之，且数据是由 AngelCare 公司与其合作厂商及被授权人使用于提供及改进以位置为基础的产品与服务。例如，若你选择进入软件供货商的位置服务，则我们可能与该软件供货商分享地理位置的数据。\nAngelCare 公司提供的某些以位置为基础的服务，例如「寻找我的 iPhone」的功能，必须要有你的个人资料，功能始能执行。\n\n<span class='ital_style'>第三人网站与服务</span>\nAngelCare 公司的网站、产品、应用软件及服务可能含有链接至第三人网站、产品或服务的链接。我们产品与服务亦可能使用或提供第三人产品或服务。第三人所收集的数据，可能包括诸如位置数据或详细联络数据等的数据，均依据该第三人的隐私权常规为准。我们鼓励你了解这些第三人的隐私权实施方式。\n\n<span class='ital_style'>我们全体对保护你隐私权的承诺</span>\n为确保你的个人资料安全，我们传递我们的隐私权与安全准则予 AngelCare 公司员工，并在公司内严格执行隐私权防护措施。\n\n<span class='ital_style'>隐私权问题</span>\n若你对 AngelCare 公司隐私权政策或数据处理有问题或疑虑，请联络我们。\nAngelCare 公司得不时更新其隐私权政策。我们对本政策进行重大修改时，将在我们网站上张贴公告，并附上更新后的隐私权政策。\n";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        label1.kern = 0.1;
        label1.lineHeight = 30;
        
        [myScrollView addSubview:label1];
        
        /*
         
         NMCustomLabel *label2 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(30, 125, myScrollView.frame.size.width-60, 230)];
         label2.text = @"You think water moves fast? You should see ice. It moves like it has a mind. <span class='bold_style'>Like it knows it killed the world once and got a taste for murder.</span> After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. <span class='ital_style'>Nature is lethal but it doesn't hold a candle to man.</span>";
         [label2 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:60/255.0 green:87/255.0 blue:186/255.0 alpha:1.0]]];
         [label2 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Georgia-Bold" size:16] color:[UIColor colorWithRed:98/255.0 green:186/255.0 blue:60/255.0 alpha:1.0]] forKey:@"bold_style"];
         [label2 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Verdana-Italic" size:15] color:[UIColor colorWithRed:60/255.0 green:87/255.0 blue:186/255.0 alpha:1.0]] forKey:@"ital_style"];
         label2.kern = 0.6;
         label2.lineHeight = 16;
         [myScrollView addSubview:label2];
         
         NMCustomLabel *label3 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(30, 350, myScrollView.frame.size.width-60, 50)];
         label3.text = @"This is a picture of me: <span class='fez'>         </span>  – what do you think?";
         [label3 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Georgia" size:14] color:[UIColor colorWithRed:98/255.0 green:227/255.0 blue:104/255.0 alpha:1]]];
         [label3 setStyle:[NMCustomLabelStyle styleWithImage:[UIImage imageNamed:@"fez.png"] verticalOffset:-8] forKey:@"fez"];
         label3.lineHeight = 25;
         [myScrollView addSubview:label3];
         
         
         */
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 768, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    
}

-(void)Set_Tw
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        
        int totalHei = 2625;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        label1.text = @"<span class='ital_style'>隱私權政策</span>\n蓋德科技股份有限公司 (以下簡稱AngelCare公司) 非常重視你的隱私權。所以我們制定了一項隱私權政策，載明我們如何收集、使用、揭露、移轉及儲存你的資料。請花一些時間熟讀我們的隱私權作法，如你有任何疑問，亦請傳達給我們。\n\n<span class='ital_style'>個人資料的收集與使用</span>\n個人資料，即是可用以辨識或聯絡特定個人的資料。\n在你與 AngelCare 公司或 AngelCare 公司的關係企業接觸時，即可能被要求提供個人資料。AngelCare 公司與其關係企業可能相互共享本項個人資料，其使用將遵守本隱私權政策。AngelCare 公司與其關係企業亦可能將個人資料與其他資料合併，用以提供並改進我們的產品、服務、內容及廣告。\n有關 AngelCare 公司可能收集的個人資料類型，以及可能如何使用這類個人資料，舉例說明如下：\n\n<span class='ital_style'>我們收集什麼樣的個人資料</span>\n\t在你使用 AngelCare 公司產品記錄您的移動位置、量測資料時，AngelCare 公司即可能收集你所提供資料，如：地址、血糖、血壓、體重、血氧、使用率，但不會額外詢問您的個人辨識資料。\n\n<span class='ital_style'>我們如何使用你的個人資料</span>\n\t我們所收集的量測資料，在您取得特殊方案服務授權下，使我們得以通知你有關 AngelCare 公司提供給您參考建議及廣告資訊。亦可用以協助我們改進我們的服務及內容。\n\t我們亦可能不時使用你的個人資料傳送重要通知，諸如有關購買產品或修改我們條款或政策之通知。由於本項通知訊息對你與 AngelCare 公司之互動關係十分重要，所以你無法退出不接收本項通知。\n\t我們亦可能為內部目的使用量測及定位資料，例如：稽核、資料分析及研究等，以改進 AngelCare 公司之產品、服務及客戶溝通。\n\n<span class='ital_style'>非個人資料的收集與使用</span>\n\t我們亦收集非個人資料，非個人資料即指無法直接用於相關任何特定個人之資料。我們得為任何目的收集、使用、移轉及揭露非個人資料。有關我們收集的非個人資料以及可能的使用方式，舉例說明如下：\n我們可能收集的資料諸如：裝置個別識別標記、地點、時間，使我們得以更了解客戶行為，並改進我們的產品、服務及廣告。\n\t本項資料會被彚總及用以協助我們提供更有用的資料給客戶，並了解我們那些部分的網站、產品及服務最具重要性。在本隱私權政策中，彚總的資料被認作非個人資料。\n若我們合併非個人資料與個人資料，則合併資料在合併之情形下，均被認作個人資料。\n\n<span class='ital_style'>揭露予第三人</span>\n\tAngelCare 公司有時可能提供特定個人資料，予配合 AngelCare 公司提供產品與服務或協助 AngelCare 公司向客戶行銷的策略性合作廠商。例如，在你購買並啟動你的AngelCare手機手錶時，你即授權 AngelCare 公司與其電信公司交換你在啟動過程中所提供的資料，以執行服務。若你獲許得到服務，你的帳戶處理即依據 AngelCare 公司與其電信公司各自的隱私權政策。AngelCare 公司僅會分享個人資料以提供或改進我們的產品、服務及廣告，而不會分享予第三人供其用於行銷目的。\n\n<span class='ital_style'>服務供應商</span>\nAngelCare 公司僅與提供下列服務的公司分享個人資料，諸如：資料處理、展延信用、完成客戶訂單、交付產品予你、管理及提升客戶資料、提供客戶服務、評估你對我們產品與服務的興趣、進行客戶研究或滿意度調查。該等公司有義務保護你的資料，其可能位於 AngelCare 公司營運的任何地方。\n\n<span class='ital_style'>其他人</span>\n在有些情形下，無論是在你居住所在國之內或之外，依據法律、法律程序、訴訟、及/或公家機關或政府機構的要求，AngelCare 公司可能必須揭露你的個人資料。若我們認為基於國家安全、法律執行或其他重要公共議題之目的揭露你的資料係屬必要或適當，則我們亦可能揭露之。\n若為執行我們的條款或保護我們的營運或使用者，而令我們認為揭露你的資料係屬合理必要者，則我們亦可能揭露之。此外，若發生公司重整、合併或出售情事，我們亦可能移轉任何及全部我們所收集的個人資料予相關第三人。\n\n<span class='ital_style'>個人資料的保護</span>\nAngelCare 公司採取預防措施保護你的個人資料，包括行政上、技術上及實際上的措施，使你的個人資料免於損失、遭竊或濫用，亦免於遭受未經授權之擅自存取、揭露、變更或損毀。\nAngelCare 公司的線上服務，均使用「安全套接層」(Secure Sockets Layer；SSL) 加密在所有收集個人資料的網頁。若欲從上述服務購買產品，你必須使用可啟動 SSL 的瀏覽器，諸如 Safari、Firefox、或 Internet Explorer。當你的個人資料在網際網路上傳輸時，上述措施保護你個人資料的機密性。\n\n<span class='ital_style'>個人資料的完整與保留</span>\nAngelCare 公司讓你輕鬆維持正確、完整且最新的個人資料。我們保留你個人資料的期限，以完成本隱私權政策所載目的所必要的期間為準，但若法律要求或許可更長的期間，則不在此限。\n\n<span class='ital_style'>個人資料的存取</span>\n你只要在 購買時填寫您的帳戶，透過審查後，將會核發您專屬帳戶資料。關於其他個人資料，我們竭盡誠摯努力提供你存取路徑，所以若資料不正確，你可要求我們改正，或倘依法或為正當商業目的 AngelCare 公司無須繼續保留資料，你亦可要求我們將之刪除。惟若你提出的要求不合理的反覆、需要不成比例的技術上努力、危害他人隱私、極度不切實際、或該要求之存取依當地法律並非規定必要者，則我們亦得拒絕處理你的要求。若有存取、改正或刪除的要求，請向AngelCare公司提出申請。\n\n<span class='ital_style'>位置服務</span>\n為於 AngelCare 公司產品上提供以位置為基礎的服務，AngelCare 公司與其合作廠商及被授權人得收集、使用及分享精確的地點資料，包括你的 AngelCare 電腦或裝置的即時地理位置。本項資料的收集是以無法辨識你個人身分的匿名方式為之，且資料是由 AngelCare 公司與其合作廠商及被授權人使用於提供及改進以位置為基礎的產品與服務。例如，若你選擇進入軟體供應商的位置服務，則我們可能與該軟體供應商分享地理位置的資料。\nAngelCare 公司提供的某些以位置為基礎的服務，例如「尋找我的 iPhone」的功能，必須要有你的個人資料，功能始能執行。\n\n<span class='ital_style'>第三人網站與服務</span>\nAngelCare 公司的網站、產品、應用軟體及服務可能含有連結至第三人網站、產品或服務的連結。我們產品與服務亦可能使用或提供第三人產品或服務。第三人所收集的資料，可能包括諸如位置資料或詳細聯絡資料等的資料，均依據該第三人的隱私權常規為準。我們鼓勵你了解這些第三人的隱私權實施方式。\n\n<span class='ital_style'>我們全體對保護你隱私權的承諾</span>\n為確保你的個人資料安全，我們傳遞我們的隱私權與安全準則予 AngelCare 公司員工，並在公司內嚴格執行隱私權防護措施。\n\n<span class='ital_style'>隱私權問題</span>\n若你對 AngelCare 公司隱私權政策或資料處理有問題或疑慮，請聯絡我們。\nAngelCare 公司得不時更新其隱私權政策。我們對本政策進行重大修改時，將在我們網站上張貼公告，並附上更新後的隱私權政策。\n";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        label1.kern = 0.0;
        label1.lineHeight = 20;
        [myScrollView addSubview:label1];
        
        /*
         
         NMCustomLabel *label2 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(30, 125, myScrollView.frame.size.width-60, 230)];
         label2.text = @"You think water moves fast? You should see ice. It moves like it has a mind. <span class='bold_style'>Like it knows it killed the world once and got a taste for murder.</span> After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. <span class='ital_style'>Nature is lethal but it doesn't hold a candle to man.</span>";
         [label2 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12] color:[UIColor colorWithRed:60/255.0 green:87/255.0 blue:186/255.0 alpha:1.0]]];
         [label2 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Georgia-Bold" size:16] color:[UIColor colorWithRed:98/255.0 green:186/255.0 blue:60/255.0 alpha:1.0]] forKey:@"bold_style"];
         [label2 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Verdana-Italic" size:15] color:[UIColor colorWithRed:60/255.0 green:87/255.0 blue:186/255.0 alpha:1.0]] forKey:@"ital_style"];
         label2.kern = 0.6;
         label2.lineHeight = 16;
         [myScrollView addSubview:label2];
         
         NMCustomLabel *label3 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(30, 350, myScrollView.frame.size.width-60, 50)];
         label3.text = @"This is a picture of me: <span class='fez'>         </span>  – what do you think?";
         [label3 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"Georgia" size:14] color:[UIColor colorWithRed:98/255.0 green:227/255.0 blue:104/255.0 alpha:1]]];
         [label3 setStyle:[NMCustomLabelStyle styleWithImage:[UIImage imageNamed:@"fez.png"] verticalOffset:-8] forKey:@"fez"];
         label3.lineHeight = 25;
         [myScrollView addSubview:label3];
         
         
         */
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 320, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    else
    {
        int totalHei = 3080;
        
        NMCustomLabel *label1 = [[NMCustomLabel alloc] initWithFrame:CGRectMake(5, 15, myScrollView.frame.size.width-10, totalHei)];
        
        label1.text = @"<span class='ital_style'>隱私權政策</span>\n蓋德科技股份有限公司 (以下簡稱AngelCare公司) 非常重視你的隱私權。所以我們制定了一項隱私權政策，載明我們如何收集、使用、揭露、移轉及儲存你的資料。請花一些時間熟讀我們的隱私權作法，如你有任何疑問，亦請傳達給我們。\n\n<span class='ital_style'>個人資料的收集與使用</span>\n個人資料，即是可用以辨識或聯絡特定個人的資料。\n在你與 AngelCare 公司或 AngelCare 公司的關係企業接觸時，即可能被要求提供個人資料。AngelCare 公司與其關係企業可能相互共享本項個人資料，其使用將遵守本隱私權政策。AngelCare 公司與其關係企業亦可能將個人資料與其他資料合併，用以提供並改進我們的產品、服務、內容及廣告。\n有關 AngelCare 公司可能收集的個人資料類型，以及可能如何使用這類個人資料，舉例說明如下：\n\n<span class='ital_style'>我們收集什麼樣的個人資料</span>\n\t在你使用 AngelCare 公司產品記錄您的移動位置、量測資料時，AngelCare 公司即可能收集你所提供資料，如：地址、血糖、血壓、體重、血氧、使用率，但不會額外詢問您的個人辨識資料。\n\n<span class='ital_style'>我們如何使用你的個人資料</span>\n\t我們所收集的量測資料，在您取得特殊方案服務授權下，使我們得以通知你有關 AngelCare 公司提供給您參考建議及廣告資訊。亦可用以協助我們改進我們的服務及內容。\n\t我們亦可能不時使用你的個人資料傳送重要通知，諸如有關購買產品或修改我們條款或政策之通知。由於本項通知訊息對你與 AngelCare 公司之互動關係十分重要，所以你無法退出不接收本項通知。\n\t我們亦可能為內部目的使用量測及定位資料，例如：稽核、資料分析及研究等，以改進 AngelCare 公司之產品、服務及客戶溝通。\n\n<span class='ital_style'>非個人資料的收集與使用</span>\n\t我們亦收集非個人資料，非個人資料即指無法直接用於相關任何特定個人之資料。我們得為任何目的收集、使用、移轉及揭露非個人資料。有關我們收集的非個人資料以及可能的使用方式，舉例說明如下：\n我們可能收集的資料諸如：裝置個別識別標記、地點、時間，使我們得以更了解客戶行為，並改進我們的產品、服務及廣告。\n\t本項資料會被彚總及用以協助我們提供更有用的資料給客戶，並了解我們那些部分的網站、產品及服務最具重要性。在本隱私權政策中，彚總的資料被認作非個人資料。\n若我們合併非個人資料與個人資料，則合併資料在合併之情形下，均被認作個人資料。\n\n<span class='ital_style'>揭露予第三人</span>\n\tAngelCare 公司有時可能提供特定個人資料，予配合 AngelCare 公司提供產品與服務或協助 AngelCare 公司向客戶行銷的策略性合作廠商。例如，在你購買並啟動你的AngelCare手機手錶時，你即授權 AngelCare 公司與其電信公司交換你在啟動過程中所提供的資料，以執行服務。若你獲許得到服務，你的帳戶處理即依據 AngelCare 公司與其電信公司各自的隱私權政策。AngelCare 公司僅會分享個人資料以提供或改進我們的產品、服務及廣告，而不會分享予第三人供其用於行銷目的。\n\n<span class='ital_style'>服務供應商</span>\nAngelCare 公司僅與提供下列服務的公司分享個人資料，諸如：資料處理、展延信用、完成客戶訂單、交付產品予你、管理及提升客戶資料、提供客戶服務、評估你對我們產品與服務的興趣、進行客戶研究或滿意度調查。該等公司有義務保護你的資料，其可能位於 AngelCare 公司營運的任何地方。\n\n<span class='ital_style'>其他人</span>\n在有些情形下，無論是在你居住所在國之內或之外，依據法律、法律程序、訴訟、及/或公家機關或政府機構的要求，AngelCare 公司可能必須揭露你的個人資料。若我們認為基於國家安全、法律執行或其他重要公共議題之目的揭露你的資料係屬必要或適當，則我們亦可能揭露之。\n若為執行我們的條款或保護我們的營運或使用者，而令我們認為揭露你的資料係屬合理必要者，則我們亦可能揭露之。此外，若發生公司重整、合併或出售情事，我們亦可能移轉任何及全部我們所收集的個人資料予相關第三人。\n\n<span class='ital_style'>個人資料的保護</span>\nAngelCare 公司採取預防措施保護你的個人資料，包括行政上、技術上及實際上的措施，使你的個人資料免於損失、遭竊或濫用，亦免於遭受未經授權之擅自存取、揭露、變更或損毀。\nAngelCare 公司的線上服務，均使用「安全套接層」(Secure Sockets Layer；SSL) 加密在所有收集個人資料的網頁。若欲從上述服務購買產品，你必須使用可啟動 SSL 的瀏覽器，諸如 Safari、Firefox、或 Internet Explorer。當你的個人資料在網際網路上傳輸時，上述措施保護你個人資料的機密性。\n\n<span class='ital_style'>個人資料的完整與保留</span>\nAngelCare 公司讓你輕鬆維持正確、完整且最新的個人資料。我們保留你個人資料的期限，以完成本隱私權政策所載目的所必要的期間為準，但若法律要求或許可更長的期間，則不在此限。\n\n<span class='ital_style'>個人資料的存取</span>\n你只要在 購買時填寫您的帳戶，透過審查後，將會核發您專屬帳戶資料。關於其他個人資料，我們竭盡誠摯努力提供你存取路徑，所以若資料不正確，你可要求我們改正，或倘依法或為正當商業目的 AngelCare 公司無須繼續保留資料，你亦可要求我們將之刪除。惟若你提出的要求不合理的反覆、需要不成比例的技術上努力、危害他人隱私、極度不切實際、或該要求之存取依當地法律並非規定必要者，則我們亦得拒絕處理你的要求。若有存取、改正或刪除的要求，請向AngelCare公司提出申請。\n\n<span class='ital_style'>位置服務</span>\n為於 AngelCare 公司產品上提供以位置為基礎的服務，AngelCare 公司與其合作廠商及被授權人得收集、使用及分享精確的地點資料，包括你的 AngelCare 電腦或裝置的即時地理位置。本項資料的收集是以無法辨識你個人身分的匿名方式為之，且資料是由 AngelCare 公司與其合作廠商及被授權人使用於提供及改進以位置為基礎的產品與服務。例如，若你選擇進入軟體供應商的位置服務，則我們可能與該軟體供應商分享地理位置的資料。\nAngelCare 公司提供的某些以位置為基礎的服務，例如「尋找我的 iPhone」的功能，必須要有你的個人資料，功能始能執行。\n\n<span class='ital_style'>第三人網站與服務</span>\nAngelCare 公司的網站、產品、應用軟體及服務可能含有連結至第三人網站、產品或服務的連結。我們產品與服務亦可能使用或提供第三人產品或服務。第三人所收集的資料，可能包括諸如位置資料或詳細聯絡資料等的資料，均依據該第三人的隱私權常規為準。我們鼓勵你了解這些第三人的隱私權實施方式。\n\n<span class='ital_style'>我們全體對保護你隱私權的承諾</span>\n為確保你的個人資料安全，我們傳遞我們的隱私權與安全準則予 AngelCare 公司員工，並在公司內嚴格執行隱私權防護措施。\n\n<span class='ital_style'>隱私權問題</span>\n若你對 AngelCare 公司隱私權政策或資料處理有問題或疑慮，請聯絡我們。\nAngelCare 公司得不時更新其隱私權政策。我們對本政策進行重大修改時，將在我們網站上張貼公告，並附上更新後的隱私權政策。\n";
        
        [label1 setDefaultStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue" size:20] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]]];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"bold_style"];
        
        [label1 setStyle:[NMCustomLabelStyle styleWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] color:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]] forKey:@"ital_style"];
        
        label1.kern = 0.1;
        label1.lineHeight = 30;
        
        [myScrollView addSubview:label1];
        
        
        
        CGRect  NewRect2;
        NewRect2 = CGRectMake(0, 0, 768, totalHei );
        myScrollView.contentSize  =  NewRect2.size;
    }
    
}

/*
-(void)awakeFromNib
{
    
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
    
}
*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

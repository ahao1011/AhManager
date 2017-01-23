AhNetmanager基于AFN封装的网络处理层
===
## 目录
* [什么是cocoapods](#what_cocoa)
* [cocoapods共公库制作](#make_coca)
* [AhNetManager介绍](#intro_ahnet)
	* [为什么做AhNetManager](#dowhat_ahnet)
	* [AhNetManager安装](#install_ahnet) 
* [AhNetmanager操作示例](#examples_ahnet)
	* [配置初始化](#set_ahnet)
	* [post示例](#post_ahnet)
	* [上传图片示例](#postimg_ahnet)  
* [待开发功能](#undo_ahnet)
	
	
---

# <a id="what_cocoa"></a> 什么是cocoapods

###CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It has over 27 thousand libraries and is used in over 1.6 million apps. CocoaPods can help you scale your projects elegantly

####cocaopods是一个针对Swift和Objective开发的依赖管理工具,目前它拥有超过2.7万个库和160万个应用程序,cocoapods可以帮助你更方便,便捷的扩展你的项目.
cocoapods源码是在github上进行管理的,就像java语言的maven,nodejs的npm一样,当前cocaopods已经成为iOS开发的依赖管理工具标准,cocoapods的出现一方面为我们项目省去了项目引入或者更新第三方库时在环境部署上的时间,另一方面也为模块化提供了实现途径.

# <a id="make_coca"></a> cocoapods共公库制作

 自行百度吧,自己动手丰衣足食,有时间时自己也会把发布AhNetManager期间遇到的坑贴出来,请 
<a id="http://weibo.com/u/6042582447?topnav=1&wvr=6&topsug=1&is_hot=1">关注我的微博</a>
 
# <a id="intro_ahnet"></a> AhNetManager介绍
## <a id="dowhat_ahnet"></a> 为什么做AhNetManager

 AhNetManager是一款基于AFN封装的网络处理层,支持cocoapods,封装的目的是因为公司要做模块化开发,将AFN封装后使用cocoapods制作成共有库,为公司的所有项目提供网络处理功能, AhNetManager让初中级开发工程师只关注业务逻辑功能的实现.
## <a id="install_ahnet"></a> AhNetManager安装
###使用cocoapods安装
```ruby
	pod 'AhNetManager', '~> 0.2.0'
```
###手动安装
 导入NETManager文件夹以及所含文件到自己的项目中
# <a id="examples_ahnet"></a> AhNetmanager操作示例
## <a id="set_ahnet"></a> 配置初始化
在AppDelegate.m的didFinishLaunchingWithOptions方法中进行网络的初始化配置,这些配置需要在你进行网络请求前设好好,且只需要设置一次.

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    //  网络初始化
    
    [SystemSet defaultSet].HOST = @"你项目的url的公共头";
    [SystemSet defaultSet].SUFFIX = @"你项目的url的公共尾";
    // 可以不设置,那所有的status都会在回调句柄中返回
    [SystemSet defaultSet].SucStatus = @"服务器自定义的正常状态码";
    
    return YES;
}
``` 
## <a id="post_ahnet"></a> post示例

get请求不在示例了.很简单

```objc
- (IBAction)btn1:(id)sender {
    
 //  post请求示例  具体请参看Demo 
 //  注意 Hea004 是AhRequest的子类,如果你只是一个项目的话,你可以在AhRequest类中根据自己产品的业务逻辑书写请求模型,
 //  若是和我们一样,多个项目使用该网络处理层,我们需要把网络处理层和业务逻辑拆分开,我建议创建一AhRequest的子类,在该子类里边实现相关的业务逻辑
    Hea004 *request = [[Hea004 alloc]init];
    request.username = @"17011111111";
    request.userpwd = @"200820E3227815ED1756A6B531E7E0D2";
    [NetManager POST:Health004 parameters:request progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
    } success:^(id responseObject, NSString *status) {
        
        //  登录成功
        NSLog(@"登录成功");
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
``` 
## <a id="postimg_ahnet"></a> 上传图片示例

```objc
- (IBAction)btn2:(id)sender {
    
    Bre011 *request = [[Bre011 alloc]init];
    request.action = @"addImg";
    UIImage *img = [UIImage imageNamed:@"test.png"];
    [NetManager POST:Breach011 parameters:request image:img progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        NSLog(@"图片上传%zd==总共%zd",bytesRead,totalBytesRead);
        
    } success:^(id responseObject,NSString*status) {
        
        Bre011Res *result = (Bre011Res *)responseObject;
        Bre011ResItem *item = result.data.firstObject;
        NSLog(@"图片所在服务器路径:%@",item.picurl);
        
    } failure:^(NSError *error) {
        
        
        
    }];
}
```
# <a id="undo_ahnet"></a> 待开发功能
####  因为我们现在没有视频类或者OA类的项目,诸如上传文件,下载视频等功能也就没有去实现,以后有时间了会完善起来.

就写到这里吧,我语文是体育老师教的,语言不当之处还望海涵,各位大咖不必纠结于以下几个问题:

1. 我本来就用了AFN了,你干嘛还要对AFN封装一层, 而且功能还这么少.
2. 你这个为嘛不封装底层的呢?



##### 我向强调的是,这是一个工具类,工具类是拿来用的,我们坚持的是在最短的时间内设计出最好用,最便捷的工具来,设计它的出发点是让我们多个项目利用cocoapods功能做到网络处理层统一管理.

######针对第一个问题, 我相信你的项目也是对AFN进行了封装,目的何在呢?个人认为这样就避免了每一个控制器中都有AFN的身影,将AFN与我们的项目分割开来,想想AFN2.0 迁移到AFN3.0, 每一个控制器中都要改的话,那是多么的酸爽.
######我不知道你的项目有没有经历从ASI转移到AFN的时期,如果不封装,呵呵 想想都觉得忧伤.

######针对第二个问题,我觉得AFN真的已经做得很好了,这么好的轮子,干嘛不能借鉴鲁迅先生的拿来主义呢,如果封装底层,功能且不论能不能与AFN比肩,时间成本就要多很多出去,留出这些时间,我可以去学习一些更需要我去学习的,比如RN  比如MUI 比如PMP



 

 
 



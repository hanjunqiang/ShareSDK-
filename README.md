# ShareSDK-
首先要集成第三方ShareSDK，然后拖入工具类即可。
![sdf](https://github.com/hanjunqiang/ShareSDK-/blob/master/ShareSDK%E5%88%86%E4%BA%AB%E5%B0%81%E8%A3%85/%E8%87%AA%E5%AE%9A%E4%B9%89%E5%88%86%E4%BA%AB%E7%95%8C%E9%9D%A2.PNG)
```


#####注：首先要shareSDK官网去配置基本的环境，
//  使用方法：
//  KDShareTool *shareTool = [[KDShareTool alloc] init];
//  //图片传nil,默认是口袋广播图片，否则传图片（放数组中）
//  [shareTool shareMethodTitle:self.model.title content:self.model.intro url:self.url images:nil];


---
###以下为具体实现，可以不看，上面就够了。

  //1)检查微信是否已被用户安装
  if ([WXApi isWXAppInstalled]) {
        //操作
  }
 //2)检测QQ是否安装
  if ([TencentOAuth iphoneQQInstalled]) {
        //操作
  }
    //3)
/**
* 设置分享参数
*
* @param text   文本
* @param images  图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
* @param url   网页路径/应用路径
* @param title  标题
* @param type   分享类型
*/
    NSMutableDictionary *canshuDic = [NSMutableDictionary dictionary];
    [canshuDic SSDKSetupShareParamsByText:kcontent2
                    images:kImages.isNotNullStr?kImages:morenImage
                      url:kurl
                     title:ktitle2
                     type:SSDKContentTypeAuto];
    //4)
/**
* 分享内容
*
* @param platformType       平台类型（点击进入可查看）
* @param parameters        分享参数
* @param stateChangeHandler    状态变更回调处理
*/
  [ShareSDK share:type
    parameters:self.messageParam
  onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
    switch (state) {
      case SSDKResponseStateSuccess:
      {
        NSLog(@"分享成功！");
        break;
      }
      case SSDKResponseStateFail:
      {
          NSLog(@"分享失败！");
        break;
      }
      case SSDKResponseStateCancel:
      {
        NSLog(@"分享取消！");
        break;
      }
      default:
        break;
    }
  }];
}
```

//
//  SFColorDefines.h
//  SeeFM
//
//  Created by CBCT_MBP on 2019/4/2.
//  Copyright © 2019年 CBCT_MBP. All rights reserved.
//

#ifndef SFColorDefines_h
#define SFColorDefines_h

#define SFhexColor(colorV)              [UIColor hexStringToColor:(colorV)]
#define SFhexColorAlpha(colorV,a)       [UIColor colorWithHexColorString:(colorV) alpha:a]
#define kCommonRedColor                 SFhexColor(@"fc426e")

///RGB颜色
#define SFRGBA(r,g,b,a)                 [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
///随机颜色
#define kRandColor                      SFRGBA(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255),1)

#define SFhexColor(colorV)              [UIColor hexStringToColor:(colorV)]
#define SFhexColorAlpha(colorV,a)       [UIColor colorWithHexColorString:(colorV) alpha:a]
#define kCommonRedColor                 SFhexColor(@"fc426e")
#define kBlackColor                     [UIColor blackColor]
#define kDarkGrayColor                  [UIColor darkGrayColor]
#define kLightGrayColor                 [UIColor lightGrayColor]
#define kWhiteColor                     [UIColor whiteColor]
#define kGrayColor                      [UIColor grayColor]
#define kRedColor                       [UIColor redColor]
#define kGreenColor                     [UIColor greenColor]
#define kBlueColor                      [UIColor blueColor]
#define kCyanColor                      [UIColor cyanColor]
#define kYellowColor                    [UIColor yellowColor]
#define kMagentaColor                   [UIColor magentaColor]
#define kOrangeColor                    [UIColor orangeColor]
#define kPurpleColor                    [UIColor purpleColor]
#define kClearColor                     [UIColor clearColor]
#define kGoldenColor                    SFhexColor(@"FFC771")

#define kColorc9                        SFhexColor(@"c9c9c9")
#define kColor19                        SFhexColor(@"191919")
#define kColorF1                        SFhexColor(@"f1f1f1")
#define kColorF8                        SFhexColor(@"f8f8f8")
#define kColorFE                        SFhexColor(@"f8f8fe")
#define kColor33                        SFhexColor(@"333333")
#define kColor66                        SFhexColor(@"666666")
#define kColor99                        SFhexColor(@"999999")
#define kColor88                        SFhexColor(@"888888")
#define kColor8c                        SFhexColor(@"8c8c8c")
#define kColorCC                        kColorAA
#define kColorDC                        SFhexColor(@"DCDCDC")

#define kColorDD                        SFhexColor(@"DDDDDD")

#define kColorEB                        SFhexColor(@"EBEBEB")
#define kColorF2                        SFhexColor(@"f2f2f2")

#define kMainRedColor                   SFhexColor(@"CC3232")
#define kCellSeperatorColor             SFhexColorAlpha(@"ffffff", 0.1)
#define kLiveNickNameColor              SFhexColor(@"aaaaaa")
#define kLiveSystemColor                SFhexColor(@"d8d8d8")
#define kLifeStyleHighlightColor        SFhexColor(@"44cde1")


#define kMineBlackTxtColor              kColorAA
#define kMineLightTxtColor              kColorAA

//new add
#define kColor3e                        SFhexColor(@"3e3e3e")
#define kColor32                        SFhexColor(@"323232")
#define kColor55                        SFhexColor(@"555555")
#define kColor22                        SFhexColor(@"222222")
#define kColor28                        SFhexColor(@"282828")
#define kColor3d                        SFhexColor(@"3d3d3d")
#define kColor37                        SFhexColor(@"373737")
#define kColorAA                        SFhexColor(@"aaaaaa")
#define kColorD8                        SFhexColor(@"d8d8d8")
#define kColor21                        SFhexColor(@"212121")
#define kColor97                        SFhexColor(@"979797")
#define kColor13                        SFhexColor(@"131313")
#define kColor3c                        SFhexColor(@"3c3c3c")
#define kMainOrangeColor                SFhexColor(@"FCCC64")
#define kMainBlueColor                  SFhexColor(@"3da3fd")
#define kTopicYellowColor               SFhexColor(@"ffc316")

/** 首页顶部滚动标签选中颜色 */
#define kHomeTopTagViewSelectedColor    SFhexColor(@"ff0944")



#endif /* SFColorDefines_h */

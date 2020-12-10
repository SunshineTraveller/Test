//
//  RuntimeTest.h
//  test
//
//  Created by CBCT_MBP on 2020/3/3.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

// cannot declare variable inside @interface or @protocol,so you can declare them in below.
static CGFloat sd = 2.3;
static UILabel *als = nil;
static NSMutableArray *arr = nil;
static NSArray *sff;


/*
 成员变量默认是 @protected 的，所以外界在调用 RuntimeTestInstance->_someLabel 的时候会提示错误，需要改成 @public 公共类型才外界可以访问，否则只能用于类里使用
 */
@interface RuntimeTest : NSObject {
    
    /*
     1.如果声明了属性 a，且没有使用 @systhesize ，则编译器会自动帮我们生成 _a 成员变量，若自己声明了 _a,编译器就会用你声明的 _a，若此时你声明的成员变量不是_a而是a，则编译器还是会生成一个_a，你自己生成的成员变量a和_a没关系，和属性a也没关系,属性用.a调用，成员变量a用 ->a 调用
     2.如果声明了属性 a,使用了 @systhesize a, 但并没有指定使用的成员变量（@systhesize a = _a），则编译器会使用a作为属性的成员变量（你若声明了a成员变量就用你的），你自己声明的_a成员变量和a没关系
     3.如果声明了一个属性a，使用 @systhesize a = _a,此时就使用指定的成员变量作为属性了  即 _a 和 a 一样
     
     
     1 对应本类里的 p1
     2 对应本类里的 p2, _p2则和属性没关系
     3 对应本类里的 p3
     */
    
    NSString *_p1;
    NSString *p2;
    NSString *_p2;
    NSString *_p3;
    @public
    UILabel *_someLabel;    // 成员变量不允许用 static 修饰，static 可以用来修饰全局变量，局部变量，函数
    SEL aSelector;
    IMP aImplementation;
    Method aMethod;
    
    
    
    
}

@property(nonatomic,strong) UILabel *aLabel;          //
@property(nonatomic,assign) CGFloat num;

@property(nonatomic,copy) NSString *p1;
@property(nonatomic,copy) NSString *p2;
@property(nonatomic,copy) NSString *p3;       

/*
 
 
                           nil
                            ^
                            |
                            |
      instance              |
    of Root class  ·····> Roolclass  ········>   Rootclasss
                            ^                       ^
                            |                       |
       instance             |                       |
    of Superclass ·····> Superclass  ········>   Superclass
                            ^                       ^
                            |                       |
                            |                       |
 实例对象A的isa指针 ······> Subclass(Aclass) ······> SubClass(meta)
 
    struct objc_objcet 结构体它的 isa 指针指向类对象
    类对象的 isa 指针指向元类
    super_class 指针指向了父类的类对象
    元类的 super_class 指针指向了父类的元类
    
    总结：
    首先实例对象是一个结构体，这个结构体只有一个成员变量isa,它指向构造它的那个类对象，这个类对象中存储了一切实例对象需要的信息，包括实例变量、实例方法等，而类对象是通过元类创建的，元类中保存了类变量和类方法
    
 
    实例对象
    struct objc_object {
       Class isa;  指向构造该对象的类
    }
 
    类
    struct objc_class {
        Class isa;                              指向该类的元类
        Class super_class;                      指向该类的父类
        const char *name;                       类名
        long version;                           版本
        long info;
        long instanceSize;
        struct objc_ivar_list *ivars;           成员变量
        struct objc_method_list **methodLists;  方法列表
        struct objc_cache *cache;               缓存
        struct objc_protocol_list *protocols;   协议
    }
 
    // 方法列表
    struct objc_method_list {
        struct objc_method_list *obsolete;
        int method_count;
        int space;
        struct objc_method method_list[1]
    }
 
    // 方法
    struct objc_method {
        SEL method_name;
        char *method_types;
        IMP method_imp;
    }
 
    SEL
    IMP
    
 
    // 消息转发
   转发分为3阶段：动态方法解析、备用接受者、完整消息转发
  
   1.动态方法解析：简单讲就是当找不到某个方法时，系统会调用 resolveInstanceMethod: 或者 resolveClassMethod: ，看你是否提供了一个函数实现并返回YES，如果有，系统就会执行你的函数实现，转发结束，没有则会进入下一步
  +(BOOL)resolveInstanceMethod:(SEL)sel {
     if(sel == @selector(找不到的sel:)) {
         class_addMethod([self class],sel,(IMP)aMethod,"v@:");
         return YES;
     }
     return [super resolveInstanceMethod:sel];
  }
  void aMethod(id obj,SEL _cmd) {...};
  
  +(BOOL)resolveClassMethod:(SEL)sel {
     ...
  }
  
   2.备用接受者：简单讲计时，执行1后都返回NO，这时系统就会判断对象是否实现了 forwardingTargetForSelector,顾名思义就是转发方法的对象,如果返回了一个实现了 aSelector 方法的对象，就会调用那个对象对应的方法，消息转发结束；若没返回或返回nil,则进行第三步，完整的消息转发
 -(id)forwardingTargetForSelector:(SEL)aSelector {
     if(aSelector == @selector(someSel)) {
         return [[aNewTarget alloc] init];
     }
     return [super forwardingTargetForSelector:aSelector];
  }
 
   3.完整的消息转发
    首先系统会通过 methodSignatureForSelector 向你请求一个方法签名,如果返回了nil,则Runtime会发出 doesNotRecoginzeSelector: 消息，程序崩溃。如果返回了一个方法签名，Runtime 会创建一个 NSInvocation 对象
    并发送 forwardInvocation: 消息给目标对象
    
  
  */
 
 


-(void)aFakeMethod;
-(void)aTrueMethod;


@end

NS_ASSUME_NONNULL_END

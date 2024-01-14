//
//  dylib_dobby_hook.m
//  dylib_dobby_hook
//
//  Created by artemis on 2024/1/14.
//

#import "dylib_dobby_hook.h"
#import "dobby.h"
#import <mach-o/dyld.h>
#import <Cocoa/Cocoa.h>

@implementation dylib_dobby_hook


// INIT TEST START
int sum(int a, int b) {
    return a+b;
}
//函数指针用于保存被替换函数的地址
static int (*sum_p)(int a, int b);

//新函数
int mySum(int a,int b){
    return a - b;
}
void init(){
    
    NSLog(@"before %d", sum(1, 2));
    NSLog(@"%s", DobbyGetVersion());
    DobbyHook(sum, mySum, (void *)&sum_p);
    NSLog(@"after %d", sum(1, 2));
    NSLog(@"origin %d", sum_p(1, 2));
    
}
// INIT TEST END



int (*_0x100050480Ori)();




#if defined(__arm64__) || defined(__aarch64__)

void AirBuddy() {
    
}

#elif defined(__x86_64__)

int _0x100050480New() {
    // register int r13 asm("r13"); //读取寄存器的值
    NSLog(@"==== _0x100050480New called");
    __asm
    {   //内联汇编直接修改寄存器的值
        mov byte ptr[r13+99h], 0
    }
    NSLog(@"==== _0x100050480New call end");
    return _0x100050480Ori();
}

void AirBuddy() {
    NSLog(@"The current app running environment is __x86_64__");
    intptr_t _0x100050480 = _dyld_get_image_vmaddr_slide(0) + 0x100050480;
    DobbyHook(_0x100050480, _0x100050480New, (void *)&_0x100050480Ori);
}
#endif

+ (void) load {
    
    
    init();
    
    NSString *appName = [[NSBundle mainBundle] bundleIdentifier];
    const char *myAppBundleName = [appName UTF8String];
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"确认执行破解操作吗？"];
    [alert addButtonWithTitle:@"确认"];
    [alert addButtonWithTitle:@"取消"];
    NSInteger response = [alert runModal];
    
    if (response == NSAlertFirstButtonReturn) {
        // 用户选择了确认按钮
        AirBuddy();
    } else {
        // 用户选择了取消按钮
        return;
    }
    
    
}
@end

//
//  common_ret.h
//  dylib_dobby_hook
//
//  Created by 马治武 on 2024/4/9.
//

#ifndef common_ret_h
#define common_ret_h
#include <sys/types.h>
#include <stdio.h>

int ret2 (void);
int ret1 (void);
int ret0 (void);
void ret(void);

// ptrace hook 相关
// ptrace 函数指针
typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
int my_ptrace(int _request, pid_t _pid, caddr_t _addr, int _data);
extern ptrace_ptr_t orig_ptrace;

// TODO
// 1. hook SecCode
// 2, hook nop
// 3. hook svc80
// 4. dlopen/dlclose/sysctl....

// 声明全局的邮件地址
extern char *global_email_address;


#endif /* common_ret_h */

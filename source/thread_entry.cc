#include "thrdpool.h"
#include <stdio.h>
#include <unistd.h> //for sleep

void my_routine(void *context) // 我们要执行的函数
{
    printf("task-%llu started.\n", reinterpret_cast<unsigned long long>(context));
    sleep(1);
}

void my_pending(const struct thrdpool_task *task) // 线程池销毁后，没执行的任务会到这里
{
    printf("pending task-%llu.\n", reinterpret_cast<unsigned long long>(task->context));
}


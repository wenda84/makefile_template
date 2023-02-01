#include "thrdpool.h"
#include "thread_entry.h"
#include <stdio.h>

int main()
{
    thrdpool_t *thrd_pool = thrdpool_create(3, 1024); // 创建
    struct thrdpool_task task;
    unsigned long long i;
    
    for (i = 0; i < 10; i++)
    {
        task.routine = &my_routine;
        task.context = reinterpret_cast<void *>(i);
        thrdpool_schedule(&task, thrd_pool); // 调用
    }

    printf("press any key to exit;\n");
    getchar();                                // 卡住主线程，按回车继续
    thrdpool_destroy(&my_pending, thrd_pool); // 结束
    return 0;
}

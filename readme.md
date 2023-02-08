## 说明
一个常用的makefile示例，涵盖了中小工程大部分需求，如多个代码路径、多个头文件路径、多个动态库链接路径等等。  
## 示例目录结构
默认目录结构如下，也支持通过修改makefile配置来自定义目录结构.

```c
.
├── 3rd
│   └── thrdpool
│       ├── list.h
│       └── thrdpool.h
├── include
│   └── thread_entry.h
├── libs
│   └── libthrdpool.so
├── source
│   └── thread_entry.cc
├── main.cc
├── makefile
└── readme.md
```

## 参考
《跟我一起写 Makefile》  
[通过实例学Makefile](https://zhuanlan.zhihu.com/p/317716664)  

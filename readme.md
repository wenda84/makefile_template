## 说明
一个常用的makefile示例，涵盖了中小工程大部分需求，如多个代码路径、多个头文件路径、多个动态库链接路径等等。  
不 需 要 懂 makefile任何语法，开箱即用，支持自定义配置。

## 配置项
常用的基础配置项都提取到Makefile头部了，按需修改即可。  
```
# 使用的编译器
CC := g++
# 待编译的源文件后缀名，只支持一种
SUFFIX := cc

# 配置生成的程序名
PROG := runMain

# 配置源码目录，支持多个
SOURCE_DIR := .
SOURCE_DIR += source

#配置头文件目录，支持多个
INCLUDE_DIR := .
INCLUDE_DIR += include
INCLUDE_DIR += 3rd/thrdpool
```

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

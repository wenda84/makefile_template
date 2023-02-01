########################################## 基础配置 begin ##########################################
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

#配置编译时需要链接的动态库，支持多个
LIBS := pthread
LIBS += thrdpool

#配置编译时需要链接的动态库路径，支持多个
LIB_PATH_COMP := ./libs
LIB_PATH_COMP += .

#配置运行时存放动态库路径，支持多个
LIB_PATH_RUN := ./libs
LIB_PATH_RUN += .

#make install的输出路径
OUT_PUT_DIR := output

#配置使用的语言标准，如C++11
STD := c++11

#配置其他编译参数
FLAGS := -g
FLAGS += -O2
FLAGS += -Wall
########################################## 基础配置 end ##########################################

########################################## 内部变量  ##########################################
OBJDIR := .objs
DEPDIR := .deps

########################################## 开始处理  ##########################################

# 添加所有源代码
SRCS_TEMP := $(foreach dir, $(SOURCE_DIR), $(wildcard $(dir)/*.$(SUFFIX))) 
# 去掉代码路径中的./ 可以减少很多兼容问题
SRCS := $(subst ./,,$(SRCS_TEMP))

OBJS := $(SRCS:%.$(SUFFIX)=$(OBJDIR)/%.o)
DEPS := $(SRCS:%.$(SUFFIX)=$(DEPDIR)/%.d)

ALL_INCLUDE := $(addprefix -I, $(INCLUDE_DIR))
ALL_LIBS := $(addprefix -l, $(LIBS))
ALL_LIB_PATH_COMP :=  $(addprefix -L, $(LIB_PATH_COMP))
empty=
space=$(empty) $(empty)
COMMA=,
ALLLIB_PATH_RUN := $(subst $(space),$(COMMA),-Wl,$(addprefix -rpath=, $(LIB_PATH_RUN)))

STD_IMPL = -std=$(STD)

ALL_FLAGS = $(ALL_INCLUDE) $(STD_IMPL) $(FLAGS) $(ALL_LIB_PATH_COMP) $(ALL_LIBS) $(ALLLIB_PATH_RUN)

default:$(PROG)

$(PROG) : $(OBJS)
	@ echo "building app: $@"
	@$(CC) -o $@ $^ $(ALL_FLAGS)  

$(OBJDIR)/%.o: %.$(SUFFIX)
# 如果对象目录不存在，创建该目录
	@test -d $(@D) || mkdir -p $(@D)
	@echo "compiling: $<"
	@$(CC) $(ALL_FLAGS) -o $@ -c $<

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(MAKECMDGOALS),help)
-include $(DEPS)
endif
endif

$(DEPDIR)/%.d: %.$(SUFFIX)
#	@echo "make depend: $@ by $<"
	
# 如果依赖目录不存在，创建该目录   
	@test -d $(@D) || mkdir -p $(@D)
	@set -e; rm -f $@; \
	$(CC) $(ALL_INCLUDE) -MM $< -MT "$*.o" | sed -E 's,($*).o[: ]*,$(OBJDIR)/\1.o $@: ,g' > $@

help:
	@echo "supported commands:" 
	@echo "  make"
	@echo "  make install"
	@echo "  make clean"
	@echo "  make help"

clean:
	rm -rf ./$(PROG)  ./$(OBJDIR) ./$(DEPDIR) ./$(OUT_PUT_DIR)

install:
	@if [ ! -d $(OUT_PUT_DIR) ] ; then mkdir -p $(OUT_PUT_DIR); fi

# 拷贝动态库	
	@cp -r $(filter-out .,$(LIB_PATH_RUN))  $(OUT_PUT_DIR)
	@if [ -e $(filter .,$(LIB_PATH_RUN))/*.so ]; then cp -f $(filter .,$(LIB_PATH_RUN))/*.so $(OUT_PUT_DIR); fi
	
	@cp -f $(PROG) $(OUT_PUT_DIR)

.PHONY : default clean install help

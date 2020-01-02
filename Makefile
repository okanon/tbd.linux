SHELL = /bin/sh
C := clang

WARNINGFLAGS := -Wshadow -Wwrite-strings -Wunused-parameter -Wno-attributes
DEFAULTFLAGS := -std=gnu11 -I. -Iinclude/ $(WARNINGFLAGS)
CFLAGS := $(DEFAULTFLAGS) -Ofast -funroll-loops
COMPILE_COMMANDS_FLAGS := -I.vscode/ -Wno-unused-parameter -Wno-sign-conversion $(CFLAGS)

SRCS := $(shell find src -name "*.c")
TARGET := bin/tbd

EXTRADEBUGFLAGS := -fsanitize=address -fno-omit-frame-pointer
DEBUGFLAGS := $(DEFAULTFLAGS) -g $(EXTRADEBUGFLAGS)

.DEFAULT_GOAL := all

clean:
	@$(RM) -rf bin

target-dir:
	@mkdir -p $(dir $(TARGET))

all: target-dir
	@$(C) $(CFLAGS) $(SRCS) -o $(TARGET)

debug: target-dir
	@$(C) $(DEBUGFLAGS) $(SRCS) -o $(TARGET)

install: all
	@sudo mv $(TARGET) /usr/bin

uninstall:
	@sudo rm /usr/$(TARGET)

cc_internal:
	@$(C) $(COMPILE_COMMANDS_FLAGS) $(SRCS)

compile_commands:
	@bear make cc_internal


cmake_minimum_required(VERSION 3.10)

set(CMAKE_C_COMPILER clang)
project(tbd C)

set(CMAKE_C_FLAGS "-std=gnu11 -Wshadow -Wwrite-strings")
set(CMAKE_C_FLAGS_DEBUG "-g3 -Og -pg -fsanitize=address -fno-omit-frame-pointer")
set(CMAKE_C_FLAGS_RELEASE "-Ofast -DNDEBUG -funroll-loops")


if (CMAKE_C_COMPILER_ID MATCHES "GNU")
   if (CMAKE_C_COMPILER_VERSION VERSION_LESS 8.0)
      message(FATAL_ERROR "GCC>=8.0 required. In case you are on Linux upgrade.")
   endif ()
   message(WARNING "Building with GCC may cause unexpected bugs at build. Recommend using Clang for the build.")
   set(CMAKE_C_FLAGS "-O1 ${CMAKE_C_FLAGS} -Wno-unused-parameter -Wno-attributes -Wno-nonnull")
elseif (CMAKE_C_COMPILER_ID MATCHES "Clang")
   if (CMAKE_C_COMPILER_VERSION VERSION_LESS 4.0)
      message(FATAL_ERROR "Clang>=4.0 required. In case you are on Linux upgrade.")
   endif ()
   set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wunused-parameter -Wno-attributes -Wno-nonnull")
endif ()

file(GLOB SRC src/*.c)

include_directories(include/)
add_executable(tbd ${SRC})

install(TARGETS tbd RUNTIME DESTINATION bin)

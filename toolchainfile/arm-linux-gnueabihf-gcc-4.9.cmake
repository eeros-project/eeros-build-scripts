set(CMAKE_SYSTEM_NAME Linux)

set(TOOLCHAIN_PREFIX arm-linux-gnueabihf)
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}-gcc-4.9)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}-g++-4.9)

set(CMAKE_FIND_ROOT_PATH /usr/${TOOLCHAIN_PREFIX})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Workaround to fix issue:
# CMake Error: TRY_RUN() invoked in cross-compiling mode, please set the
# following cache variables appropriately: THREADS_PTHREAD_ARG (advanced)
# see: https://gitlab.kitware.com/cmake/cmake/issues/16920
set(THREADS_PTHREAD_ARG "2" CACHE STRING "Forcibly set by arm-linux-gnueabihf-gcc-4.9.cmake." FORCE)


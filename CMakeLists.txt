cmake_minimum_required(VERSION 3.13)

set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

project(myproject)

set(PROJECT_VERSION 0.0.1)
set(CMAKE_VERBOSE_MAKEFILE ON)

enable_testing()

add_executable(hello
	main.c
)

install(TARGETS hello
	EXPORT hello.exe
)

add_test(NAME test_hello COMMAND hello.exe)

add_custom_target(package
   COMMAND ${CMAKE_COMMAND} -E tar "cfv" "${CMAKE_CURRENT_BINARY_DIR}/hello-0.0.1.zip" --format=zip "hello-0.0.1"
   WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/dest"
)

add_custom_target(upload
   COMMAND jf rt upload --flat hello-0.0.1.zip mygenericrepo-local
)

add_custom_target(publish
   COMMAND jf rt build-clean
   COMMAND jf rt build-add-git
   COMMAND jf rt build-collect-env $ENV{JOB_NAME} $ENV{BUILD_NUMBER}
   COMMAND jf rt build-publish $ENV{JOB_NAME} $ENV{BUILD_NUMBER}
)

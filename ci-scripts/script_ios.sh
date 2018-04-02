#!/bin/bash

set -euf -o pipefail

export ROS2_IOS_VERSION="10-3"
export XCODE_XCCONFIG_FILE=$HOME/ros2_ios_ws/src/ruslo/polly/scripts/NoCodeSign.xcconfig

mkdir -p ~/ros2_ios_ws/src
cd ~/ros2_ios_ws
vcs import ~/ros2_ios_ws/src < $TRAVIS_BUILD_DIR/ros2_objc_ios.repos
touch ~/ros2_ios_ws/src/ros2/rosidl/python_cmake_module/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/rosidl/rosidl_generator_py/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ruslo/polly/examples/01-executable/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ruslo/polly/examples/02-library/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ruslo/polly/examples/03-shared-link/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/rcl_interfaces/test_msgs/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/common_interfaces/shape_msgs/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/common_interfaces/stereo_msgs/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/common_interfaces/trajectory_msgs/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/common_interfaces/visualization_msgs/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/rosidl/python_cmake_module/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/rosidl/rosidl_generator_py/AMENT_IGNORE
cd ~/ros2_ios_ws/src/ros2/rosidl_typesupport
patch -p1 < ../../ros2_objc/ros2_objc/rosidl_typesupport_ros2_ios.patch
cd ~/ros2_ios_ws
src/ament/ament_tools/scripts/ament.py build \
    --use-xcode \
    --symlink-install \
    --isolated \
    --cmake-args \
        -DCMAKE_BUILD_TYPE=Release \
        -DTHIRDPARTY=ON \
        -DCOMPILE_EXAMPLES=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_TOOLCHAIN_FILE=$HOME/ros2_ios_ws/src/ruslo/polly/ios-nocodesign-${ROS2_IOS_VERSION}.cmake \
        -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
    -- \
    --make-flags \
        -quiet \
        -sdk iphoneos | tee /tmp/ament_build.log | xcpretty
tail /tmp/ament_build.log

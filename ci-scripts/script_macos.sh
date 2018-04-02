#!/bin/bash

set -euf -o pipefail

mkdir -p ~/ros2_objc_ws/src
cd ~/ros2_objc_ws
vcs import ~/ros2_objc_ws/src < $TRAVIS_BUILD_DIR/ros2_objc_macos.repos
touch ~/ros2_objc_ws/src/ros2/rcl_interfaces/test_msgs/AMENT_IGNORE
touch ~/ros2_objc_ws/src/ros2/common_interfaces/shape_msgs/AMENT_IGNORE
touch ~/ros2_objc_ws/src/ros2/common_interfaces/stereo_msgs/AMENT_IGNORE
touch ~/ros2_objc_ws/src/ros2/common_interfaces/trajectory_msgs/AMENT_IGNORE
touch ~/ros2_objc_ws/src/ros2/common_interfaces/visualization_msgs/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/rosidl/python_cmake_module/AMENT_IGNORE
touch ~/ros2_ios_ws/src/ros2/rosidl/rosidl_generator_py/AMENT_IGNORE
cd ~/ros2_objc_ws/src/ros2/rosidl_typesupport
patch -p1 < ../../ros2_objc/ros2_objc/rosidl_typesupport_ros2_ios.patch
cd ~/ros2_objc_ws
src/ament/ament_tools/scripts/ament.py build \
    --use-xcode \
    --symlink-install \
    --isolated \
    --cmake-args \
        -DCMAKE_BUILD_TYPE=Release \
    --  | tee /tmp/ament_build.log | xcpretty
tail /tmp/ament_build.log

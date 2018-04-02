#!/bin/bash

set -euf -o pipefail

set -xv

mkdir -p ~/ros2_objc_ws/src
cd ~/ros2_objc_ws
docker run \
    -v $PWD/ci-scripts/ci-scripts \
    -v $HOME/ros2_objc_ws:/ros2_objc_ws \
    -v $TRAVIS_BUILD_DIR/ros2_objc_macos.repos:/ros2_objc_macos.repos \
    -u $(id -u $USER) \
    -w /ros2_objc_ws \
    -e CC=clang \
    -e CXX=clang++ \
    --rm \
    esteve/ros2-ubuntu-xenial-travisci:objc \
    sh -c "\
        vcs import /ros2_objc_ws/src < /ros2_objc_macos.repos
        "
touch ~/ros2_objc_ws/src/ros2/rcl_interfaces/test_msgs/AMENT_IGNORE
touch ~/ros2_objc_ws/src/ros2/common_interfaces/shape_msgs/AMENT_IGNORE
touch ~/ros2_objc_ws/src/ros2/common_interfaces/stereo_msgs/AMENT_IGNORE
touch ~/ros2_objc_ws/src/ros2/common_interfaces/trajectory_msgs/AMENT_IGNORE
touch ~/ros2_objc_ws/src/ros2/common_interfaces/visualization_msgs/AMENT_IGNORE
cd ~/ros2_objc_ws/src/ros2/rosidl_typesupport
patch -p1 < ../../ros2_objc/ros2_objc/rosidl_typesupport_ros2_objc.patch
cd ~/ros2_objc_ws
docker run \
    -v $PWD/ci-scripts/ci-scripts \
    -v $HOME/ros2_objc_ws:/ros2_objc_ws \
    -v $TRAVIS_BUILD_DIR/ros2_objc_macos.repos:/ros2_objc_macos.repos \
    -u $(id -u $USER) \
    -w /ros2_objc_ws \
    -e CC=clang \
    -e CXX=clang++ \
    --rm \
    esteve/ros2-ubuntu-xenial-travisci:objc \
    sh -c "\
        src/ament/ament_tools/scripts/ament.py build \
            --symlink-install \
            --isolated \
            --cmake-args \
            -DCMAKE_BUILD_TYPE=Release \
        "

#!/bin/bash

script="$(readlink -f $0)"
script_dir="$(dirname $script)"

. "$script_dir/config.sh.in"

MAKE="make -j$(nproc)"

if [ "$rm_build_install_dir" = true ]; then
  rm -rf "$build_dir" "$install_dir"
fi

# build sourceDir buildDir cmakeFlags
function build ()
{
  local source_dir="$1"
  local build_dir="$2"
  shift 2
  local flags="$@"

  mkdir -p "$build_dir"
  pushd "$build_dir"

  cmake -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        $flags \
        "$source_dir"

  $MAKE
  $MAKE install
  popd
}


if [ "$use_ros" = true ] || [ "$use_ros2" = true ]; then
  . "$ros_setup_script"
fi


if [ "$use_can" = true ]; then
  build "$canopen_source_dir" "$canopen_build_dir"
fi


build "$eeros_source_dir" "$eeros_build_dir" "-DUSE_ROS=$use_ros" "-DUSE_ROS2=$use_ros2" "-DUSE_CAN=$use_can"


if [ "$use_comedi" = true ]; then
  build "$comedi_eeros_source_dir" "$comedi_eeros_build_dir" -DREQUIRED_EEROS_VERSION="$eeros_required_version"
fi


if [ "$use_simulator" = true ]; then
  build "$sim_eeros_source_dir" "$sim_eeros_build_dir" -DREQUIRED_EEROS_VERSION="$eeros_required_version"
fi


if [ "$use_ros" = true ] || [ "$use_ros2" = true ]; then
  build "$ros_eeros_source_dir" "$ros_eeros_build_dir" -DREQUIRED_EEROS_VERSION="$eeros_required_version"
fi



#!/bin/bash

script="$(readlink -f $0)"
script_dir="$(dirname $script)"

. "$script_dir/config.sh.in"



if [ "$rm_build_install_dir" = true ]; then
  rm -rf "$build_dir" "$install_dir"
fi


mkdir -p "$eeros_build_dir"
pushd "$eeros_build_dir"
cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
      -DCMAKE_INSTALL_PREFIX="$install_dir" \
      -DCMAKE_BUILD_TYPE=Release \
      "$eeros_source_dir"
make
make install
popd


if [ "$use_flink" = true ]; then
  mkdir -p "$flinklib_build_dir"
  pushd "$flinklib_build_dir"
  cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
        -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        "$flinklib_source_dir"
  make
  make install
  popd
fi


if [ "$use_flink" = true ]; then
  mkdir -p "$flink_eeros_build_dir"
  pushd "$flink_eeros_build_dir"
  cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
        -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        -DREQUIRED_EEROS_VERSION="$eeros_required_version" \
        "$flink_eeros_source_dir"
  make
  make install
  popd
fi


if [ "$use_bbblue" = true ]; then
  mkdir -p "$bbblue_eeros_build_dir"
  pushd "$bbblue_eeros_build_dir"
  cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
        -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        -DREQUIRED_EEROS_VERSION="$eeros_required_version" \
        "$bbblue_eeros_source_dir"
  make
  make install
  popd
fi


if [ "$use_comedi" = true ]; then
  mkdir -p "$comedi_eeros_build_dir"
  pushd "$comedi_eeros_build_dir"
  cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
        -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        -DREQUIRED_EEROS_VERSION="$eeros_required_version" \
        "$comedi_eeros_source_dir"
  make
  make install
  popd
fi


if [ "$use_simulator" = true ]; then
  mkdir -p "$sim_eeros_build_dir"
  pushd "$sim_eeros_build_dir"
  cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
        -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        -DREQUIRED_EEROS_VERSION="$eeros_required_version" \
        "$sim_eeros_source_dir"
  make
  make install
  popd
fi


if [ "$use_ros" = true ]; then
  mkdir -p "$ros_eeros_build_dir"
  pushd "$ros_eeros_build_dir"
  cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
        -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        -DREQUIRED_EEROS_VERSION="$eeros_required_version" \
        "$ros_eeros_source_dir"
  make
  make install
  popd
fi


if [ "$use_custom_application" = true ]; then
  mkdir -p "$custom_application_build_dir"
  pushd "$custom_application_build_dir"
  cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
        -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        -DUSE_SIM="$use_simulator" \
        -DUSE_FLINK="$use_flink" \
        -DUSE_COMEDI="$use_comedi" \
        -DUSE_ROS="$use_ros" \
        -DREQUIRED_EEROS_VERSION="$eeros_required_version" \
        -DREQUIRED_SIM_EEROS_VERSION="$sim_eeros_required_version" \
        -DREQUIRED_FLINKLIB_VERSION="$flinklib_required_version" \
        -DREQUIRED_FLINK_EEROS_VERSION="$flink_eeros_required_version" \
        -DREQUIRED_COMEDI_EEROS_VERSION="$comedi_eeros_required_version" \
        -DREQUIRED_ROS_EEROS_VERSION="$ros_eeros_required_version" \
        "$custom_application_source_dir"
  make
  popd
fi


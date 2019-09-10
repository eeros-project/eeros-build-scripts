#!/bin/bash

script="$(readlink -f $0)"
script_dir="$(dirname $script)"

. "$script_dir/config.sh.in"


rm -rf "$build_dir" "$install_dir"

mkdir -p $eeros_build_dir
pushd $eeros_build_dir
cmake -DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
      -DCMAKE_INSTALL_PREFIX=$install_dir \
      -DCMAKE_BUILD_TYPE=Release \
      $eeros_source_dir
make
make install
popd


if [ ! -z ${flink_source_dir+x} ]; then
  mkdir -p $flink_build_dir
  pushd $flink_build_dir
  cmake -DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
        -DCMAKE_INSTALL_PREFIX=$install_dir \
        -DCMAKE_BUILD_TYPE=Release \
        $flink_source_dir
  make
  make install
  popd
fi


if [ ! -z ${flink_eeros_source_dir+x} ]; then
  mkdir -p $flink_eeros_build_dir
  pushd $flink_eeros_build_dir
  cmake -DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
        -DCMAKE_INSTALL_PREFIX=$install_dir \
        -DCMAKE_BUILD_TYPE=Release \
        -DREQUIRED_EEROS_VERSION=$eeros_required_version \
        $flink_eeros_source_dir
  make
  make install
  popd
fi


if [ ! -z ${comedi_eeros_source_dir+x} ]; then
  mkdir -p $comedi_eeros_build_dir
  pushd $comedi_eeros_build_dir
  cmake -DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
        -DCMAKE_INSTALL_PREFIX=$install_dir \
        -DCMAKE_BUILD_TYPE=Release \
        $comedi_eeros_source_dir
  make
  make install
  popd
fi


if [ ! -z ${sim_eeros_source_dir+x} ]; then
  mkdir -p $sim_eeros_build_dir
  pushd $sim_eeros_build_dir
  cmake -DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
        -DCMAKE_INSTALL_PREFIX=$install_dir \
        -DCMAKE_BUILD_TYPE=Release \
        -DREQUIRED_EEROS_VERSION=$eeros_required_version \
        $sim_eeros_source_dir
  make
  make install
  popd
fi


if [ ! -z ${ros_eeros_source_dir+x} ]; then
  mkdir -p $ros_eeros_build_dir
  pushd $ros_eeros_build_dir
  cmake -DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
        -DCMAKE_INSTALL_PREFIX=$install_dir \
        -DCMAKE_BUILD_TYPE=Release \
        $ros_eeros_source_dir
  make
  make install
  popd
fi

if [ ! -z ${application_source_dir+x} ]; then
  mkdir -p $application_build_dir
  pushd $application_build_dir
  cmake -DCMAKE_TOOLCHAIN_FILE=$toolchain_file \
        -DCMAKE_INSTALL_PREFIX=$install_dir \
        -DCMAKE_BUILD_TYPE=Release \
        $application_source_dir
  make
  popd
fi


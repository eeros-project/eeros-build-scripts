#!/bin/bash

script="$(readlink -f $0)"
script_dir="$(dirname $script)"

. "$script_dir/config.sh.in"

if [ ! -d "$eeros_source_dir" ]; then
  git clone "$eeros_git_remote_address" -o upstream "$eeros_source_dir"
  pushd "$eeros_source_dir"
  git checkout "$eeros_git_version"
  popd
fi

if [ "$use_flink" = true ]; then
  if [ ! -d "$flinklib_source_dir" ]; then
    git clone "$flinklib_git_remote_address" -o upstream --recursive  "$flinklib_source_dir"
    pushd "$flinklib_source_dir"
    git checkout "$flinklib_git_version"
    popd
  fi
fi

if [ "$use_flink" = true ]; then
  if [ ! -d "$flink_eeros_source_dir" ]; then
    git clone "$flink_eeros_git_remote_address" -o upstream "$flink_eeros_source_dir"
    pushd "$flink_eeros_source_dir"
    git checkout "$flink_eeros_git_version"
    popd
  fi
fi

if [ "$use_bbblue" = true ]; then
  if [ ! -d "$librobotcontrol_source_dir" ]; then
    git clone "$librobotcontrol_git_remote_address" -o upstream "$librobotcontrol_source_dir"
    pushd "$librobotcontrol_source_dir"
    git checkout "librobotcontrol_git_version"
    popd
  fi
fi

if [ "$use_bbblue" = true ]; then
  if [ ! -d "$bbblue_eeros_source_dir" ]; then
    git clone "$bbblue_eeros_git_remote_address" -o upstream "$bbblue_eeros_source_dir"
    pushd "$bbblue_eeros_source_dir"
    git checkout "$bbblue_eeros_git_version"
    popd
  fi
fi

if [ "$use_comedi" = true ]; then
  if [ ! -d "$comedi_eeros_source_dir" ]; then
    git clone "$comedi_eeros_git_remote_address" -o upstream "$comedi_eeros_source_dir"
    pushd "$comedi_eeros_source_dir"
    git checkout "$comedi_eeros_git_version"
    popd
  fi
fi

if [ "$use_simulator" = true ]; then
  if [ ! -d "$sim_eeros_source_dir" ]; then
    git clone "$sim_eeros_git_remote_address" -o upstream "$sim_eeros_source_dir"
    pushd "$sim_eeros_source_dir"
    git checkout "$sim_eeros_git_version"
    popd
  fi
fi

if [ "$use_ros" = true ]; then
  if [ ! -d "$ros_eeros_source_dir" ]; then
    git clone "$ros_eeros_git_remote_address" -o upstream "$ros_eeros_source_dir"
    pushd "$ros_eeros_source_dir"
    git checkout "$ros_eeros_git_version"
    popd
  fi
fi

if [ "$use_custom_application" = true ]; then
  if [ ! -d "$custom_application_source_dir" ]; then
    git clone "$custom_application_git_remote_address" -o upstream "$custom_application_source_dir"
    pushd "$custom_application_source_dir"
    git checkout "$custom_application_git_version"
    popd
  fi
fi


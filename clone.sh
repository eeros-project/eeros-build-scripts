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



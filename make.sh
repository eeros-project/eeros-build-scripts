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
  cmake -DCMAKE_TOOLCHAIN_FILE="$toolchain_file" \
        -DCMAKE_INSTALL_PREFIX="$install_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        $flags \
        "$source_dir"
  $MAKE
  $MAKE install
  popd
}

build "$eeros_source_dir" "$eeros_build_dir" "-DUSE_ROS=$use_ros -DUSE_CAN=$use_can"

if [ "$use_flink" = true ]; then
  build "$flinklib_source_dir" "$flinklib_build_dir"
  build "$flink_eeros_source_dir" "$flink_eeros_build_dir" -DREQUIRED_EEROS_VERSION="$eeros_required_version"
fi

if [ "$use_bbblue" = true ]; then
  build "$bbblue_eeros_source_dir" "bbblue_eeros_build_dir" -DADDITIONAL_INCLUDE_DIRS="$librobotcontrol_source_dir/libraries/" \
                                                            -DADDITIONAL_LINK_DIRS="$librobotcontrol_source_dir/libraries/" \
                                                            -DREQUIRED_EEROS_VERSION="$eeros_required_version"
fi


if [ "$use_comedi" = true ]; then
  build "$comedi_eeros_source_dir" "$comedi_eeros_build_dir" -DREQUIRED_EEROS_VERSION="$eeros_required_version"
fi


if [ "$use_simulator" = true ]; then
  build "$sim_eeros_source_dir" "$sim_eeros_build_dir" -DREQUIRED_EEROS_VERSION="$eeros_required_version"
fi


if [ "$use_ros" = true ]; then
  build "$ros_eeros_source_dir" "$ros_eeros_build_dir" -DREQUIRED_EEROS_VERSION="$eeros_required_version"
fi


if [ "$use_can" = true ]; then
  build "$canopenlib_source_dir" "$canopenlib_build_dir"
fi


if [ "$use_custom_application" = true ]; then
  build "$custom_application_source_dir" "$custom_application_build_dir" -DUSE_SIM="$use_simulator" \
                                                                         -DUSE_FLINK="$use_flink" \
                                                                         -DUSE_BBBLUE="$use_bbblue" \
                                                                         -DUSE_COMEDI="$use_comedi" \
                                                                         -DUSE_ROS="$use_ros" \
                                                                         -DUSE_CAN="$use_can" \
                                                                         -DREQUIRED_EEROS_VERSION="$eeros_required_version" \
                                                                         -DREQUIRED_SIM_EEROS_VERSION="$sim_eeros_required_version" \
                                                                         -DREQUIRED_FLINKLIB_VERSION="$flinklib_required_version" \
                                                                         -DREQUIRED_FLINK_EEROS_VERSION="$flink_eeros_required_version" \
                                                                         -DREQUIRED_BBBLUE_EEROS_VERSION="$bbblue_eeros_required_version" \
                                                                         -DREQUIRED_COMEDI_EEROS_VERSION="$comedi_eeros_required_version" \
                                                                         -DREQUIRED_ROS_EEROS_VERSION="$ros_eeros_required_version"
fi

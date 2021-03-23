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


if [ "$use_cross_compilation_environment" = true ]; then
  unset LD_LIBRARY_PATH
  . "$environment_setup_script"
  install_dir="$SDKTARGETSYSROOT/$sdk_install_dir"
  echo "Due to cross compilation environment, install_dir is set to: $install_dir"
fi


if [ "$use_ros" = true ]; then
  . "$ros_setup_script"
fi


# workaround to correctly setup environment when both of them are used
if [ "$use_cross_compilation_environment" = true -a "$use_ros_setup_script" = true ]; then
  unset LD_LIBRARY_PATH
  . "$environment_setup_script"
fi


if [ "$use_custom_application" = true ]; then
  build "$custom_application_source_dir" "$custom_application_build_dir" -DREQUIRED_EEROS_VERSION="$eeros_required_version" \
                                                                         -DREQUIRED_SIM_EEROS_VERSION="$sim_eeros_required_version" \
                                                                         -DREQUIRED_FLINKLIB_VERSION="$flinklib_required_version" \
                                                                         -DREQUIRED_FLINK_EEROS_VERSION="$flink_eeros_required_version" \
                                                                         -DREQUIRED_BBBLUE_EEROS_VERSION="$bbblue_eeros_required_version" \
                                                                         -DREQUIRED_COMEDI_EEROS_VERSION="$comedi_eeros_required_version" \
                                                                         -DREQUIRED_ROS_EEROS_VERSION="$ros_eeros_required_version"
fi

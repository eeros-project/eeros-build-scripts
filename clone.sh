#!/bin/bash

script="$(readlink -f $0)"
script_dir="$(dirname $script)"

. "$script_dir/config.sh.in"

if [ ! -d "$eeros_source_dir" ]; then
	git clone https://github.com/eeros-project/eeros-framework.git -o upstream "$eeros_source_dir"
	pushd "$eeros_source_dir"
	git checkout master
	popd
fi

if [ ! -z ${flink_source_dir+x} ]; then
	if [ ! -d "$flink_source_dir" ]; then
		git clone https://github.com/flink-project/flinklib.git -o upstream --recursive "$flink_source_dir"
	fi
fi

if [ ! -z ${flink_eeros_source_dir+y} ]; then
	if [ ! -d "$flink_eeros_source_dir" ]; then
		git clone https://github.com/eeros-project/flink-eeros.git -o upstream "$flink_eeros_source_dir"
	fi
fi

if [ ! -z ${comedi_eeros_source_dir+x} ]; then
	if [ ! -d "$comedi_eeros_source_dir" ]; then
		git clone https://github.com/eeros-project/comedi-eeros.git -o upstream "$comedi_eeros_source_dir"
	fi
fi

if [ ! -z ${sim_eeros_source_dir+x} ]; then
	if [ ! -d "$sim_eeros_source_dir" ]; then
		git clone https://github.com/eeros-project/sim-eeros.git -o upstream "$sim_eeros_source_dir"
	fi
fi

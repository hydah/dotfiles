#!/bin/sh
PREFIX=/tmp/hy_qemu-i386
path_red=$PWD
FILE=/home/vhome/heyu/unitrans/unitrans-0.6/target-i386/ind-prof.c
FILE1=/home/vhome/heyu/unitrans/unitrans-0.6/target-i386/translate.c
UNITRANS_DIR="/home/vhome/heyu/unitrans/unitrans-0.6"
LOG=$path_red/hy_run-$$.log
TIME="/usr/bin/time -f %e --append -o $LOG"

function build
{
	cd $UNITRANS_DIR
	chg_pc
	make &> /dev/null
	restore_pc
	if [ $? != 0 ]; then
		echo build err
		exit
	fi
	cp ./i386-linux-user/qemu-i386 $PREFIX -a
	cd -
}

# for other benchmark, assign "(uint32_t)env->code_ptr" to "key" for mutipath
# but the "key" must be set "cur_tb->pc" here so that i can get a constant source inst address
function chg_pc
{
	sed -i "s/\(key = (uint32_t)env->code_ptr;\)/\/\/\1/" $FILE1
	sed -i "s/\/\/\(key = cur_tb->pc;\)/\1/" $FILE1
}

# restore the pc for other "normal" benchmark
function restore_pc
{
	sed -i "s/\/\/\(key = (uint32_t)env->code_ptr;\)/\1/" $FILE1
	sed -i "s/\(key = cur_tb->pc;\)/\/\/\1/" $FILE1
}


function rebuild
{
	path=$PWD
	addr=`grep "prof_stat:" hy_*.err1 | sort -k4,4nr -k3,3n | head -1 | awk '{print $2}'`
	echo "the address of which instruct that excutes the most times is $addr"
	addr=${addr:=0x0}
	sed -i "s/0x[a-z0-9][a-z0-9]*$/$addr/" $FILE 
	echo "rebuild for $path"
	build
}

function run_spec
{
	echo "first build"
	build

	echo "*****run gcc*****" >> $LOG
	cd 176.gcc
	echo "run to get hy_scilab.err1"
	$TIME $PREFIX ./cc1_base.gcc44 scilab.i -o hy_scilab.s 1>hy_scilab.out 2>hy_scilab.err1
	#grep "prof_stat:" hy_scilab.err > /tmp/prof_stat.log
	#sort -o /tmp/prof_stat_new.log -k4,4nr -k3,3n /tmp/prof_stat.log
	#addr=`head -1 /tmp/prof_stat_new.log | awk '{print $2}'`
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\123/' $FILE
	rebuild
	echo "run to get cc1_base.ind.st.log"
	$TIME $PREFIX ./cc1_base.gcc44 scilab.i -o hy_scilab.s 1>hy_scilab.out 2>hy_scilab.err1
	mv /tmp/ind_profile.log ~/cc1_base.ind.st.log
	cd ..

	echo "*****run crafty*****" >> $LOG
	cd 186.crafty
#$PREFIX -prof ./crafty_base.gcc44 <crafty.in 1>crafty.out 2>crafty.err
	echo "run to get hy_crafty.err1"
	$TASKSET $TIME $PREFIX ./crafty_base.gcc44 <crafty.in 1>hy_crafty.out 2>hy_crafty.err1
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\1997/' $FILE
	rebuild
	echo "run to get crafty.ind.st.log"
	$TIME $PREFIX ./crafty_base.gcc44 <crafty.in 1>hy_crafty.out 2>hy_crafty.err1
	mv /tmp/ind_profile.log ~/crafty.ind.st.log
	cd ..

	echo "*****run eon*****" >> $LOG
	cd 252.eon
#$PREFIX -prof ./eon_base.gcc44 chair.control.kajiya chair.camera chair.surfaces chair.kajiya.ppm ppm pixels_out.kajiya 1>kajiya_log.out 2>kajiya_log.err
	$TASKSET $TIME $PREFIX ./eon_base.gcc44 chair.control.kajiya chair.camera chair.surfaces chair.kajiya.ppm ppm pixels_out.kajiya 1>kajiya_log.out 2>hy_kajiya_log.err1
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\1997/' $FILE
	rebuild
	$TIME $PREFIX ./eon_base.gcc44 chair.control.kajiya chair.camera chair.surfaces chair.kajiya.ppm ppm pixels_out.kajiya 1>kajiya_log.out 2>hy_kajiya_log.err1
	mv /tmp/ind_profile.log ~/eon_base.ind.st.log
	cd ..

	echo "*****run perlbmk*****" >> $LOG
	cd 253.perlbmk
#$PREFIX -prof ./perlbmk_base.gcc44 -I./lib splitmail.pl 850 5 19 18 1500 1>850.5.19.18.1500.out 2>850.5.19.18.1500.err
	$TASKSET $TIME $PREFIX ./perlbmk_base.gcc44 -I./lib splitmail.pl 850 5 19 18 1500 1>850.5.19.18.1500.out 2>hy_850.5.19.18.1500.err1
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\153/' $FILE
	rebuild
	$TIME $PREFIX ./perlbmk_base.gcc44 -I./lib splitmail.pl 850 5 19 18 1500 1>850.5.19.18.1500.out 2>hy_850.5.19.18.1500.err1
	mv /tmp/ind_profile.log ~/perlbmk.ind.st.log
	cd ..

	echo "*****run gap*****" >> $LOG
	cd 254.gap
#$PREFIX -prof ./gap_base.gcc44 -l ./ -q -m 192M < ref.in 1>ref.out 2>gap-ref.err
	$TASKSET $TIME $PREFIX ./gap_base.gcc44 -l ./ -q -m 192M < ref.in 1>ref.out 2>hy_gap-ref.err1
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\123/' $FILE
	rebuild
	$TIME $PREFIX ./gap_base.gcc44 -l ./ -q -m 192M < ref.in 1>ref.out 2>hy_gap-ref.err1
	mv /tmp/ind_profile.log ~/gap-ref.ind.st.log
	cd ..

	echo "*****run perlbench*****" >> $LOG
	cd 400.perlbench
#$PREFIX -prof  ./perlbench_base.gcc44 -I./lib splitmail.pl 1600 12 26 16 4500 1>splitmail.1600.12.26.16.4500.out 2>splitmail.1600.12.26.16.4500.err
	$TASKSET $TIME $PREFIX  ./perlbench_base.gcc44 -I./lib splitmail.pl 1600 12 26 16 4500 1>splitmail.1600.12.26.16.4500.out 2>hy_splitmail.1600.12.26.16.4500.err1
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\1997/' $FILE
	rebuild
	$TIME $PREFIX  ./perlbench_base.gcc44 -I./lib splitmail.pl 1600 12 26 16 4500 1>splitmail.1600.12.26.16.4500.out 2>hy_splitmail.1600.12.26.16.4500.err1
	mv /tmp/ind_profile.log ~/perlbench.ind.st.log
	cd ..

	echo "*****run gcc06*****" >> $LOG
	cd 403.gcc
#$PREFIX -prof ./gcc_base.gcc44 scilab.i -o scilab.s 1>scilab.out 2>scilab.err
	$TASKSET $TIME $PREFIX ./gcc_base.gcc44 scilab.i -o scilab.s 1>scilab.out 2>hy_scilab.err1
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\123/' $FILE
	rebuild
	$TIME $PREFIX ./gcc_base.gcc44 scilab.i -o scilab.s 1>scilab.out 2>hy_scilab.err1
	mv /tmp/ind_profile.log ~/gcc_base.ind.st.log
	cd ..

	echo "*****run sjeng*****" >> $LOG
	cd 458.sjeng
#$PREFIX -prof ./sjeng_base.gcc44 train.txt 1>train.out 2>sjeng-train.err
	$TASKSET $TIME $PREFIX ./sjeng_base.gcc44 train.txt 1>train.out 2>hy_sjeng-train.err1
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\153/' $FILE
	rebuild
	$TIME $PREFIX ./sjeng_base.gcc44 train.txt 1>train.out 2>hy_sjeng-train.err1
	mv /tmp/ind_profile.log ~/sjeng_base.ind.st.log
	cd ..

	echo "*****run richard*****" >> $LOG
	cd richard
#$PREFIX -prof ./bench100 1>richard.out 2>richard.err
	$TASKSET $TIME $PREFIX ./bench100 1>richard.out 2>hy_richard.err1
	sed 's/\(node->tgt_dyn_count % \)[0-9][0-9]*/\153/' $FILE
	rebuild
	$TIME $PREFIX ./bench100 1>richard.out 2>hy_richard.err1
	mv /tmp/ind_profile.log ~/bench100.ind.st.log
	cd ..
}

run_spec
exit 0

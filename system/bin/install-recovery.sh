#!/system/bin/sh
  echo 1 > /sys/module/sec/parameters/recovery_done
if ! applypatch -c EMMC:/dev/block/platform/mtk-msdc.0/11230000.msdc0/by-name/recovery:11177984:3d102dd0d329b5ff3089566285fc7a001a4473fb; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/mtk-msdc.0/11230000.msdc0/by-name/boot:9238528:a449b55fd0d01da012560030c4d671906e2cc4b6 EMMC:/dev/block/platform/mtk-msdc.0/11230000.msdc0/by-name/recovery 3d102dd0d329b5ff3089566285fc7a001a4473fb 11177984 a449b55fd0d01da012560030c4d671906e2cc4b6:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
  if applypatch -c EMMC:/dev/block/platform/mtk-msdc.0/11230000.msdc0/by-name/recovery:11177984:3d102dd0d329b5ff3089566285fc7a001a4473fb; then
        echo 0 > /sys/module/sec/parameters/recovery_done
        log -t recovery "Install new recovery image completed"
        
  if applysig /system/etc/recovery.sig recovery; then
    sync
    log -t recovery "Apply recovery image signature completed"
  else
    log -t recovery "Apply recovery image signature fail!!"
  fi
  
  else
        echo 2 > /sys/module/sec/parameters/recovery_done
        log -t recovery "Install new recovery image not completed"
  fi
else
  echo 0 > /sys/module/sec/parameters/recovery_done
  log -t recovery "Recovery image already installed"
fi

alias qtcreator="~/Qt/Tools/QtCreator/bin/qtcreator"

alias qgc="~/.local/bin/QGroundControl.AppImage"
alias sim_jmav="pushd .; cd ~/work/px4/px4-firmware; make px4_sitl jmavsim; popd"
alias sim_jmav_no_gui="pushd .; cd ~/work/px4/px4-firmware; HEADLESS=1 make px4_sitl jmavsim; popd"
alias sim_gazebo="pushd .; cd ~/work/px4/px4-firmware; make px4_sitl gazebo; popd"
alias sim_atak="pushd .; cd ~/work/px4/px4-firmware; make px4_sitl gazebo_typhoon_h480; popd"

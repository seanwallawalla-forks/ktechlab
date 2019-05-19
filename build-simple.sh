#!/bin/sh
set -e
set -x



#SCRIPTDIR=$(dirname $(readlink -f "$0"))

case "$(uname -s)" in

   Darwin)
     echo 'Mac OS X'
     readlinkf(){ perl -MCwd -e 'print Cwd::abs_path shift' "$1";}
     SCRIPTDIR=$(dirname $(readlinkf "$0"))
     ;;

   # taken from: https://en.wikipedia.org/wiki/Uname
   Linux|*BSD)
     echo 'Linux'
     SCRIPTDIR=$(dirname $(readlink -f "$0"))
     ;;

   CYGWIN*|MINGW32*|MSYS*)
     echo 'MS Windows'
     SCRIPTDIR=$(dirname $(readlink -f "$0")) # untested
     ;;

   # Add here more strings to compare
   #

   *)
     echo 'other OS, please notify the developers'
     SCRIPTDIR=$(dirname $(readlink -f "$0")) # untested
     ;;
esac

LOGFILE="$SCRIPTDIR/build-simple.log"

log_cmd() {
    "$@" 2>&1  | tee -a "$LOGFILE"
}

log_cmd echo "== starting build at $( date ) == "

(
    mkdir -p "$SCRIPTDIR/build-simple/"
    cd "$SCRIPTDIR/build-simple/"

    if [ -f "$SCRIPTDIR/build-simple/CMakeCache.txt" ] ; then
        echo "buildsystem generated, using it"
    else
        echo "buildsystem being generated"

        log_cmd cmake -DCMAKE_INSTALL_PREFIX="$SCRIPTDIR/inst-simple/" "$SCRIPTDIR"
    fi

#     # bug in buildsystem: generated header files are not always built; work it around
# 
#     UI_HEADERS_TO_GENERATE="
#         ./src/gui/ui_contexthelpwidget.h
#         ./src/gui/ui_generaloptionswidget.h
#         ./src/gui/ui_linkeroptionswidget.h
#         ./src/gui/ui_processingoptionswidget.h
#         ./src/gui/ui_programmerwidget.h
#         ./src/gui/ui_gpasmsettingswidget.h
#         ./src/gui/ui_newprojectwidget.h
#         ./src/gui/ui_newfilewidget.h
#         ./src/gui/ui_outputmethodwidget.h
#         ./src/gui/ui_scopescreenwidget.h
#         ./src/gui/ui_createsubprojectwidget.h
#         ./src/gui/ui_asmformattingwidget.h
#         ./src/gui/ui_oscilloscopewidget.h
#         ./src/gui/ui_microsettingswidget.h
#         ./src/gui/ui_newpinmappingwidget.h
#         ./src/gui/ui_logicwidget.h
#         ./src/gui/ui_sdccoptionswidget.h
#         ./src/gui/ui_picprogrammerconfigwidget.h
#         ./src/gui/ui_gplinksettingswidget.h
#         "
#     for HEADER in $UI_HEADERS_TO_GENERATE ; do
#         make -f src/gui/CMakeFiles/gui.dir/build.make "$HEADER"
#     done
# 
#     # work around the bug: core directory has to be built first
#     # ./src/core/ktlconfig.h
#     log_cmd make -C "$SCRIPTDIR/build-simple/src/core"

    log_cmd make install -j2
)

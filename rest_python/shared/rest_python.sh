#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="rest_python"
QPKG_ROOT=`/sbin/getcfg $QPKG_NAME Install_Path -f ${CONF}`
APACHE_ROOT=`/sbin/getcfg SHARE_DEF defWeb -d Qweb -f /etc/config/def_share.info`
export QNAP_QPKG=$QPKG_NAME

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    : ADD START ACTIONS HERE
    $CONTAINER_ROOT/bin/system-docker-compose -f $QPKG_PATH/src/docker-compose.yml up -d
    ;;

  stop)
    : ADD STOP ACTIONS HERE
    $CONTAINER_ROOT/bin/system-docker-compose -f $QPKG_PATH/src/docker-compose.yml stop
    ;;

  restart)
    $0 stop
    $0 start
    ;;
  remove)
    ;;

  *)
    echo "Usage: $0 {start|stop|restart|remove}"
    exit 1
esac

exit 0

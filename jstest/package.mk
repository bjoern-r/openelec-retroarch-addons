################################################################################
#      Copyright (C) 2014 Bjoern
#
#  THIS is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  THIS is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="jstest"
PKG_VERSION="1.47"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="http://sourceforge.net/projects/linuxconsole/files/linuxconsoletools-1.4.7.tar.bz2/download"
PKG_DEPENDS_TARGET=""
PKG_BUILD_DEPENDS_TARGET="toolchain" 
PKG_PRIORITY="optional"
PKG_SECTION="debug/tools"
PKG_SHORTDESC="jstest: Simple tool for JS debugging."
PKG_LONGDESC=""

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_AUTORECONF="no"

PKG_MAINTAINER="unofficial.addon.pro"

unpack(){
  test -f $SOURCES/$PKG_NAME/download && mv $SOURCES/$PKG_NAME/download $SOURCES/$PKG_NAME/linuxconsoletools-1.4.7.tar.bz2
  tar xjf $SOURCES/$PKG_NAME/linuxconsoletools-1.4.7.tar.bz2 -C $BUILD
  mv $BUILD/linuxconsoletools-1.4.7 $BUILD/jstest-$PKG_VERSION
}

make_target(){
  #pushd utils
  make -C utils jstest
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/utils/jstest $ADDON_BUILD/$PKG_ADDON_ID/bin
  #cp -P $PKG_BUILD/.$TARGET_NAME/evtest-capture $ADDON_BUILD/$PKG_ADDON_ID/bin
}

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="jstest"
PKG_VERSION="1.47"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
#PKG_URL="http://cgit.freedesktop.org/evtest/snapshot/$PKG_NAME-$PKG_VERSION.tar.bz2"
##http://downloads.sourceforge.net/project/p7zip/p7zip/${PKG_VERSION}/p7zip_${PKG_VERSION}_src_all.tar.bz2
PKG_URL="http://sourceforge.net/projects/linuxconsole/files/linuxconsoletools-1.4.7.tar.bz2/download"
#PKG_URL="$SOURCEFORGE_SRC/liuxconsole$PKG_VERSION/linuxconsole-$PKG_VERSION.tar.bz2"
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

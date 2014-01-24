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

PKG_NAME="retroarch"
PKG_VERSION="0.9.9"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libretro.github.com/"
PKG_URL="https://github.com/libretro/RetroArch/archive/v$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="RetroArch-0.9.9"
PKG_DEPENDS="bcm2835-driver"
PKG_BUILD_DEPENDS_TARGET="toolchain bcm2835-driver"
PKG_PRIORITY="optional"
PKG_SECTION="addon"
PKG_SHORTDESC="retroarch: Reference frontend for the libretro API."
PKG_LONGDESC="RetroArch is the reference frontend for the libretro API."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_AUTORECONF="no"

BCM2835_INCLUDES="-I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ \
                  -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"

PKG_BUILD_DEPENDS_TARGET="$PKG_BUILD_DEPENDS_TARGET $OPENGLES"
PKG_DEPENDS="$PKG_DEPENDS $OPENGLES"

export CFLAGS="$CFLAGS $BCM2835_INCLUDES"
export CXXFLAGS="$CXXFLAGS $BCM2835_INCLUDES"


off_pre_unpack() {
  cp $SOURCES/retroarch/v0.9.9.tar.gz $SOURCES/retroarch/retroarch-0.9.9.tar.gz
}

unpack() {
  tar xzf $SOURCES/retroarch/v0.9.9.tar.gz -C $BUILD
}

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

configure_target() {
  ./configure --disable-x11 --disable-oss --disable-pulse --disable-sdl --enable-neon --prefix=/usr --enable-alsa
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/retroarch $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/.$TARGET_NAME/retroarch-zip $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/.$TARGET_NAME/tools/retroarch-joyconfig $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/.$TARGET_NAME/tools/retrolaunch/retrolaunch $ADDON_BUILD/$PKG_ADDON_ID/bin/
  #cp $(get_build_dir dtach)/.$TARGET_NAME/dtach $ADDON_BUILD/$PKG_ADDON_ID/bin
  #mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  #cp $PKG_BUILD/lib/out/libmakemkv.so.[0-9] $ADDON_BUILD/$PKG_ADDON_ID/lib
  #cp $LIB_PREFIX/lib/libxmlrpc_util.so.[0-9] $ADDON_BUILD/$PKG_ADDON_ID/lib
}

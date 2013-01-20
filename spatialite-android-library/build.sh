#!/bin/bash -e

help() {
  echo
  if [ $# -eq 1 ]; then
    echo "Error: $1"
    echo
  fi
  
  echo "Usage: build.sh [options]"
  echo
  echo "Options:"
  echo "  --no-download :  Do not download packages"
}

#
# Process options
#
NO_DOWNLOAD=0
MAKE_JOBS=""

for arg in "$@"
do
  case "$arg" in
    "--no-download")
      NO_DOWNLOAD=1
      ;;
    -j*)
      MAKE_JOBS=$arg
      ;;
    "-h"|"--help")
      help
      exit 0
      ;;
    *)
      help "Invalid argument: $1"
      exit 1
      ;;
  esac
done

#
# Set env
#
export NDK_BASE=/opt/android-ndk-r8d
export STANDALONE_BASE=/tmp/standalone-toolchain-arm

# Create the standalone toolchain
$NDK_BASE/build/tools/make-standalone-toolchain.sh --toolchain=arm-linux-androideabi-4.6 --platform=android-14 --install-dir=$STANDALONE_BASE

export PATH=$STANDALONE_BASE/bin:$PATH
export STRIP=arm-linux-androideabi-strip
export CC=arm-linux-androideabi-gcc
export LD=arm-linux-androideabi-ld
export AR=arm-linux-androideabi-ar
export RANLIB=arm-linux-androideabi-ranlib
export OBJDUMP=arm-linux-androideabi-objdump
export CXX=arm-linux-androideabi-g++
export CPP=arm-linux-androideabi-cpp

export CFLAGS="-ffunction-sections -funwind-tables -fstack-protector -no-canonical-prefixes -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID -Wa,--noexecstack"
export CXXFLAGS="-ffunction-sections -funwind-tables -no-canonical-prefixes -fstack-protector -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300 -DANDROID -Wa,--noexecstack -frtti -fexceptions"

cd jni

#
# Download the required packages
#
if [ $NO_DOWNLOAD -eq 0 ]; then
   wget -nv http://download.osgeo.org/proj/proj-4.8.0.tar.gz 

   wget -nv http://download.osgeo.org/geos/geos-3.3.6.tar.bz2 

   wget -nv http://www.sqlite.org/sqlite-amalgamation-3071500.zip

   wget -nv http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-4.0.0.tar.gz
fi

#
# Uncompress packages
#
tar -xvzf proj-4.8.0.tar.gz 
tar -xvjf geos-3.3.6.tar.bz2 
unzip -o sqlite-amalgamation-3071500.zip 
tar -xvzf libspatialite-4.0.0.tar.gz 

#
# Configure and Build PROJ.4
#
cd proj-4.8.0/ 
cp ../patches/config.guess .
cp ../patches/config.sub .
./configure --build=x86_64-pc-linux-gnu --host=arm-linux-androideabi --with-jni=no --enable-shared=no
#make $MAKE_JOBS
cd ..

#
# Configure and Build GEOS
#
cd geos-3.3.6
cp ../patches/config.guess .
cp ../patches/config.sub .
./configure --build=x86_64-pc-linux-gnu --host=arm-linux-androideabi --enable-shared=no
#make $MAKE_JOBS
cd ..

#
# Configure and Build Sqlite
#
cd sqlite-amalgamation-3071500
#make
cd ..

cd libspatialite-4.0.0/ 
cp ../patches/config.guess .
cp ../patches/config.sub .
#./configure --build=x86_64-pc-linux-gnu --host=arm-linux-androideabi --enable-shared=no --enable-freexl=no --enable-iconv=no
./configure --build=x86_64-pc-linux-gnu --host=arm-linux-eabi
cd ..

#!/bin/sh

top_dir=$(cd "$(dirname "$0")" > /dev/null 2>&1 && pwd)

cd $top_dir

if [ -e "config.bashrc" ]; then
  . ./config.bashrc
fi

build_dir="_build"

usage()
{
  echo "usage : $0 target1 target2 ..."
cat - << EOS

  target:
     config/configure       run cmake
     build
     test
     install
     package
     upload
     publish
EOS

}

help()
{
  usage
}

all()
{
  build
}

configure()
{
  echo build_dir is ${build_dir}
  rm -rf ${build_dir}
  mkdir -p ${build_dir}
  cd ${build_dir}
  cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="" ..
  cd ${top_dir}
}

config()
{
  configure
}

build()
{
  cmake --build ${build_dir} -- all
}

test()
{
  cmake --build ${build_dir} -- test
}

install()
{
  rm -rf ${top_dir}/dest
  cmake --build ${build_dir} -- \
    install DESTDIR=${top_dir}/${build_dir}/dest/hello-0.0.1/usr
}

package()
{
  cmake --build ${build_dir} -- package
}

upload()
{
  cmake --build ${build_dir} -- upload
}

publish()
{
  if [ -z "${JOB_NAME}" ]; then
    export JOB_NAME="Manual"
  fi

  if [ -z "${BUILD_NUMBER}" ]; then
    export BUILD_NUMBER=1
  fi

  cmake --build ${build_dir} -- publish
}

clean()
{
  echo clean
}

_default()
{
  cmake --build ${build_dir} $1
}

if [ $# -eq 0 ]; then
  usage
  exit 1
fi

args=""

while [ $# -ne 0 ]; do
  case "$1" in
    h)
      usage
      ;;
    *)
      args="$args $1"
      ;;
  esac

  shift
done

for target in $args ; do
  LANG=C type $target | grep 'function' > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    $target
  else
    _default $target
  fi
done




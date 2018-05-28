#!/bin/sh

# check existance of lti-config
if ! which lti-config 2>/dev/null 1> /dev/null; then
    echo "lti-config not found in PATH"
fi

mkdir -p linux
cp Makefile linux

# apply source code fixes
files='main.cpp' # list your files here (space-separated)

# don't read this, don't touch this, it works ;)
for file in $files; do
    cmd='s/gtk\.h/gtk\/gtk\.h/'
    echo applying $cmd to $file and write to linux/$file
    sed "$cmd" $file > linux/$file

    cmd='s/ltiViewer\.h/ltiViewer2D\.h/'
    echo applying $cmd to $file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/ltiBMPFunctor\.h/ltiIOImage\.h/'
    echo applying $cmd to $file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/ltiSplitImg\.h/ltiSplitImageToHSI\.h/'
    echo applying $cmd to $file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/ltiGtkServer\.h/ltiGuiServer\.h/'
    echo applying $cmd to $file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/ltiImage\.h/ltiChannel8\.h/'
    echo applying $cmd to $file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='/#include\ \"ltiChannel8\.h\"/a#include\ \"ltiChannel32\.h\"'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/ltiRealFFT\.h/ltiFFT\.h/'
    echo applying $cmd to $file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/ltiRealInvFFT\.h/ltiIFFT\.h/'
    echo applying $cmd to $file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='/gtkServer\ server;/d' #\n\s*server\.start\(\);/d'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='/server\.start();/d'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/loadBMP/ioImage/'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/viewer/viewer2D/'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/resize\((.*)false,\s*true\);/resize\(\1lti::Init\);/'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i -E linux/$file

    cmd='s/getIntensity\((.*)\)/extractIntensity\(\1\)/'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i -E linux/$file

    cmd='s/realFFT/fft/'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i linux/$file

    cmd='s/realInvFFT/ifft/'
    echo applying $cmd to linux/$file and write to linux/$file
    sed "$cmd" -i linux/$file
done
	
cd linux
make
rm *.o
cd ..

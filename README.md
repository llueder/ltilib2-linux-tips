# ltilib2 linux tips
Installation and usage information for ltilib2 (based on my experience at HAW Hamburg).

ltilib2 is a C++ image processing library used in the *Robot Vision* class at HAW Hamburg.
I could use ltilib on arch linux only with changes to the library itself and the given code of the exercises.

Should you spot an error or have any suggestions, feel free to contact me or open an issue/PR.

## Prerequisites
* packages to build applications (gcc, base-devel, make...)
* f2c (fortran stuff, available in the AUR
* subversion

## Installation
```
svn checkout https://svn.code.sf.net/p/ltilib/code/trunk/ltilib-2
cd ltilib-2/linux/
make -f Makefile.svn
./configure
patch ../misc/lamath/clapack.h <path-to-patch_ltilib_1.diff>
patch ../src/system/ltiSemaphore.h <path-to-patch_ltilib_2.diff>
make
#(sudo make install)
```

## Usage with RobotVision projects (based on [1] and extended)
* some changes in the code have to be made
  * "gtk.h" => "<gtk/gtk.h>
  * "ltiViewer.h" => <ltiViewer2D.h> 
  * "ltiBMPFunctor.h" => <ltiIOImage.h> 
  * "ltiSplitImg.h" => <ltiSplitImageToHSI.h> 
  * "ltiGtkServer.h" => <ltiGuiServer.h> 
  * "ltiImage" => <ltiChannel8.h> (for channel32 also include ltiChannel32.h)
  * "ltiRealFFT.h" => <ltiFFT.h>
  * "ltiRealInvFFT.h" => <ltiIFFT.h>
  * remove `gtkServer server` and `server.start()`
  * loadBMP => ioImage
  * Viewer => Viewer2D ändern
  * `resize(rowSize,columnSize,0,false,true)` => `resize(rowSize,columnSize,0, lti::Init)`
  * `splitter.getIntensity(imt,src)` => `extractIntensity(img,src)`
  * `realFFT` => `fft`
  * `realInvFFT` => `ifft`
* an easy way to compile the project is to use ltilib's example makefile (examples/template/Makefile)
  * I changed the `LTIBASE` variable to the installation directory
  * I changed the `LTICMD` variable to lti-config
  * I changed the `LINKDIR` variable to `-L$(LTIBASE)/lib`
  * my modified version can be found in this repository
* to automate the changes, I wrote the script makeLinux.sh (which can be found in this repository). It
  * creates a subfolder 'linux'
  * performs the necessary changes to all specified files and writes the modified versions into the 'linux' folder
  * builds the project
  * is not a particularly beautiful peace of code.
* Now you've got your binary at linux/linux :)


[1] Janus, John: Installation und Nutzung der LTILib2 unter GNU/Linux für Robotvision, 11.04.2013. Verfügbar in der RobotVision-Freigabe von Prof. Dr. Andreas Meisel (Stand 09.05.2018).

# Changelog
 * **18-05-09** Initial version
 * **19-09-29** Perform modification of ltilib file as patch. Changed formulations and formatting. Publication on github.com/llueder/lti2-linux-tips. Second patch for semaphore limit. v1.

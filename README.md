# ltilib2-linux-tips
Installation and usage information for ltilib2 (based on my experience at HAW Hamburg)

# About this document
In a course at HAW (Robot Vision), I needed to install the ltilib. Here are the steps I needed to get things to work on arch linux. Changes might be necessary for other distributions.

Should you spot an error or have any suggestions, feel free to contact me or open an issue.

# Prerequisites
* packages to build applications (gcc, base-devel, make...)
* f2c (fortran stuff, available in the AUR
* subversion

# Installation
* svn checkout https://svn.code.sf.net/p/ltilib/code/trunk/ltilib-2
* cd ltilib-2/linux/
* make -f Makefile.svn
* ./configure
* add `#define VOID void` to misc/lamath/clapack.h
* make
* (sudo make install)

# Usage with RobotVision projects (based on [1])
* some changes in the code have to be made
  * "gtk.h" => "<gtk/gtk.h>
  * "ltiViewer.h" => <ltiViewer2D.h> 
  * "ltiBMPFunctor.h" => <ltiIOImage.h> 
  * "ltiSplitImg.h" => <ltiSplitImageToHSI.h> 
  * "ltiGtkServer.h" => <ltiGuiServer.h> 
  * "ltiImage" => <ltiChannel8.h> (for channel32 also include ltiChannel32.h)
  * remove `gtkServer server` and `server.start()`
  * loadBMP => ioImage
  * Viewer => Viewer2D ändern
  * `resize(rowSize,columnSize,0,false,true)` => `resize(rowSize,columnSize,0, lti::Init)`
  * `splitter.getIntensity(imt,src)` => `extractIntensity(img,src)`
* an easy way to compile the project is to use ltilib's example makefile (examples/template/Makefile)
  * I changed the `LTIBASE` variable to the installation directory
  * I changed the `LTICMD` variable to lti-config
  * I changed the `LINKDIR` variable to `-L$(LTIBASE)/lib`
  * my modified version can be found in this repository
* to automate the changes, I wrote the script makeLinux.sh (which can be found in this repository). It
  * creates a subfolder 'linux'
  * performs the necessary changes to all specified files and writes the modified versions into the 'linux' folder
  * builds the project.
* Now you've got your binary at linux/linux :)


[1] Janus, John: Installation und Nutzung der LTILib2 unter GNU/Linux für Robotvision, 11.04.2013. Verfügbar in der RobotVision-Freigabe von Prof. Dr. Andreas Meisel (Stand 09.05.2018).

# Changelog
 * **18-05-09** Initial version

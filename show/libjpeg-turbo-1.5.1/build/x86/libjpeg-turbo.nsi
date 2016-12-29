!include x64.nsh
Name "libjpeg-turbo SDK for Visual C++"
OutFile "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}libjpeg-turbo-1.5.1-vc.exe"
InstallDir c:\libjpeg-turbo

SetCompressor bzip2

Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

Section "libjpeg-turbo SDK for Visual C++ (required)"
!ifdef WIN64
	${If} ${RunningX64}
	${DisableX64FSRedirection}
	${Endif}
!endif
	SectionIn RO
!ifdef GCC
	IfFileExists $SYSDIR/libturbojpeg.dll exists 0
!else
	IfFileExists $SYSDIR/turbojpeg.dll exists 0
!endif
	goto notexists
	exists:
!ifdef GCC
	MessageBox MB_OK "An existing version of the libjpeg-turbo SDK for Visual C++ is already installed.  Please uninstall it first."
!else
	MessageBox MB_OK "An existing version of the libjpeg-turbo SDK for Visual C++ or the TurboJPEG SDK is already installed.  Please uninstall it first."
!endif
	quit

	notexists:
	SetOutPath $SYSDIR
!ifdef GCC
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\libturbojpeg.dll"
!else
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}turbojpeg.dll"
!endif
	SetOutPath $INSTDIR\bin
!ifdef GCC
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\libturbojpeg.dll"
!else
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}turbojpeg.dll"
!endif
!ifdef GCC
	File "/oname=libjpeg-8.dll" "F:/demo/libjpeg-turbo-1.5.1/build/x86\sharedlib\libjpeg-*.dll"
!else
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\sharedlib\${BUILDDIR}jpeg8.dll"
!endif
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\sharedlib\${BUILDDIR}cjpeg.exe"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\sharedlib\${BUILDDIR}djpeg.exe"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\sharedlib\${BUILDDIR}jpegtran.exe"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}tjbench.exe"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}rdjpgcom.exe"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}wrjpgcom.exe"
	SetOutPath $INSTDIR\lib
!ifdef GCC
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\libturbojpeg.dll.a"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\libturbojpeg.a"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\sharedlib\libjpeg.dll.a"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\libjpeg.a"
!else
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}turbojpeg.lib"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}turbojpeg-static.lib"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\sharedlib\${BUILDDIR}jpeg.lib"
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\${BUILDDIR}jpeg-static.lib"
!endif
!ifdef JAVA
	SetOutPath $INSTDIR\classes
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\java\${BUILDDIR}turbojpeg.jar"
!endif
	SetOutPath $INSTDIR\include
	File "F:/demo/libjpeg-turbo-1.5.1/build/x86\jconfig.h"
	File "F:/demo/libjpeg-turbo-1.5.1\jerror.h"
	File "F:/demo/libjpeg-turbo-1.5.1\jmorecfg.h"
	File "F:/demo/libjpeg-turbo-1.5.1\jpeglib.h"
	File "F:/demo/libjpeg-turbo-1.5.1\turbojpeg.h"
	SetOutPath $INSTDIR\doc
	File "F:/demo/libjpeg-turbo-1.5.1\README.ijg"
	File "F:/demo/libjpeg-turbo-1.5.1\README.md"
	File "F:/demo/libjpeg-turbo-1.5.1\LICENSE.md"
	File "F:/demo/libjpeg-turbo-1.5.1\example.c"
	File "F:/demo/libjpeg-turbo-1.5.1\libjpeg.txt"
	File "F:/demo/libjpeg-turbo-1.5.1\structure.txt"
	File "F:/demo/libjpeg-turbo-1.5.1\usage.txt"
	File "F:/demo/libjpeg-turbo-1.5.1\wizard.txt"

	WriteRegStr HKLM "SOFTWARE\libjpeg-turbo 1.5.1" "Install_Dir" "$INSTDIR"

	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\libjpeg-turbo 1.5.1" "DisplayName" "libjpeg-turbo SDK v1.5.1 for Visual C++"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\libjpeg-turbo 1.5.1" "UninstallString" '"$INSTDIR\uninstall_1.5.1.exe"'
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\libjpeg-turbo 1.5.1" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\libjpeg-turbo 1.5.1" "NoRepair" 1
	WriteUninstaller "uninstall_1.5.1.exe"
SectionEnd

Section "Uninstall"
!ifdef WIN64
	${If} ${RunningX64}
	${DisableX64FSRedirection}
	${Endif}
!endif

	SetShellVarContext all

	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\libjpeg-turbo 1.5.1"
	DeleteRegKey HKLM "SOFTWARE\libjpeg-turbo 1.5.1"

!ifdef GCC
	Delete $INSTDIR\bin\libjpeg-8.dll
	Delete $INSTDIR\bin\libturbojpeg.dll
	Delete $SYSDIR\libturbojpeg.dll
	Delete $INSTDIR\lib\libturbojpeg.dll.a"
	Delete $INSTDIR\lib\libturbojpeg.a"
	Delete $INSTDIR\lib\libjpeg.dll.a"
	Delete $INSTDIR\lib\libjpeg.a"
!else
	Delete $INSTDIR\bin\jpeg8.dll
	Delete $INSTDIR\bin\turbojpeg.dll
	Delete $SYSDIR\turbojpeg.dll
	Delete $INSTDIR\lib\jpeg.lib
	Delete $INSTDIR\lib\jpeg-static.lib
	Delete $INSTDIR\lib\turbojpeg.lib
	Delete $INSTDIR\lib\turbojpeg-static.lib
!endif
!ifdef JAVA
	Delete $INSTDIR\classes\turbojpeg.jar
!endif
	Delete $INSTDIR\bin\cjpeg.exe
	Delete $INSTDIR\bin\djpeg.exe
	Delete $INSTDIR\bin\jpegtran.exe
	Delete $INSTDIR\bin\tjbench.exe
	Delete $INSTDIR\bin\rdjpgcom.exe
	Delete $INSTDIR\bin\wrjpgcom.exe
	Delete $INSTDIR\include\jconfig.h"
	Delete $INSTDIR\include\jerror.h"
	Delete $INSTDIR\include\jmorecfg.h"
	Delete $INSTDIR\include\jpeglib.h"
	Delete $INSTDIR\include\turbojpeg.h"
	Delete $INSTDIR\uninstall_1.5.1.exe
	Delete $INSTDIR\doc\README.ijg
	Delete $INSTDIR\doc\README.md
	Delete $INSTDIR\doc\LICENSE.md
	Delete $INSTDIR\doc\example.c
	Delete $INSTDIR\doc\libjpeg.txt
	Delete $INSTDIR\doc\structure.txt
	Delete $INSTDIR\doc\usage.txt
	Delete $INSTDIR\doc\wizard.txt

	RMDir "$INSTDIR\include"
	RMDir "$INSTDIR\lib"
	RMDir "$INSTDIR\doc"
!ifdef JAVA
	RMDir "$INSTDIR\classes"
!endif
	RMDir "$INSTDIR\bin"
	RMDir "$INSTDIR"

SectionEnd

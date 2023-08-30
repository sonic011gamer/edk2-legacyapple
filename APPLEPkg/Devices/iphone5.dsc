[Defines]
  PLATFORM_NAME                  = APPLEPkg
  PLATFORM_GUID                  = 28f1a3bf-193a-47e3-a7b9-5a435eaab2ee
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010019
  OUTPUT_DIRECTORY               = Build/$(PLATFORM_NAME)
  SUPPORTED_ARCHITECTURES        = ARM
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = APPLEPkg/APPLEPkg.fdf

[BuildOptions.common]
  GCC:*_*_ARM_CC_FLAGS = -DSILICON_PLATFORM=S5L8950

[PcdsFixedAtBuild.common]
  # System Memory (0.5GB)
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x80000000
  gArmTokenSpaceGuid.PcdSystemMemorySize|0x40000000
  
  gArmPlatformTokenSpaceGuid.PcdCoreCount|1
  gArmPlatformTokenSpaceGuid.PcdClusterCount|1

  gArmTokenSpaceGuid.PcdCpuVectorBaseAddress|0x80C40000

  # Framebuffer (720x1280)
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferWidth|640
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferHeight|1136
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferVisibleWidth|640
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferVisibleHeight|1136
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferPixelBpp|32
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferAddress|0x80400000

!include APPLEPkg/APPLEPkg.dsc
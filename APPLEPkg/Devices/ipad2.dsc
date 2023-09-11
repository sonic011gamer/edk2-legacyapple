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
  GCC:*_*_ARM_CC_FLAGS = -DSILICON_PLATFORM=S5L8940

[PcdsFixedAtBuild.common]
  # System Memory (0.5GB)
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x80000000
  gArmTokenSpaceGuid.PcdSystemMemorySize|0x20000000
  
  gArmPlatformTokenSpaceGuid.PcdCoreCount|1
  gArmPlatformTokenSpaceGuid.PcdClusterCount|1

  gArmTokenSpaceGuid.PcdCpuVectorBaseAddress|0x80C40000


  # Framebuffer (720x1280)
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferWidth|1024
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferHeight|768
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferVisibleWidth|1024
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferVisibleHeight|768
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferPixelBpp|32
  gAPPLEPkgTokenSpaceGuid.PcdMipiFrameBufferAddress|0x80400000

# Make it so ConOut will choose what's best at startup 
  [PcdsDynamicDefault.common]
  gEfiMdeModulePkgTokenSpaceGuid.PcdVideoHorizontalResolution|1024 # /8 = column
  gEfiMdeModulePkgTokenSpaceGuid.PcdVideoVerticalResolution|768 #/19 = row
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupVideoHorizontalResolution|1024
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupVideoVerticalResolution|768
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupConOutColumn|128
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupConOutRow|40
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutColumn|128
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutRow|40

!include APPLEPkg/APPLEPkg.dsc
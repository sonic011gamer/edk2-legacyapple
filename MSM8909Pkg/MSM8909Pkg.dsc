#
#  Copyright (c) 2018, Linaro Limited. All rights reserved.
#
#  This program and the accompanying materials
#  are licensed and made available under the terms and conditions of the BSD License
#  which accompanies this distribution.  The full text of the license may be found at
#  http://opensource.org/licenses/bsd-license.php
#
#  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
#  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
#

################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                  = MSM8909Pkg
  PLATFORM_GUID                  = 28f1a3bf-193a-47e3-a7b9-5a435eaab2ee
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010019
  OUTPUT_DIRECTORY               = Build/$(PLATFORM_NAME)
  SUPPORTED_ARCHITECTURES        = ARM
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = MSM8909Pkg/MSM8909Pkg.fdf
  DEFINE USE_SCREEN_FOR_SERIAL_OUTPUT = 1

!include MSM8909Pkg/CommonDsc.dsc.inc


[LibraryClasses]
  RegisterFilterLib|MdePkg/Library/RegisterFilterLibNull/RegisterFilterLibNull.inf
  VariablePolicyHelperLib|MdeModulePkg/Library/VariablePolicyHelperLib/VariablePolicyHelperLib.inf
  VariableFlashInfoLib|MdeModulePkg/Library/BaseVariableFlashInfoLib/BaseVariableFlashInfoLib.inf

[LibraryClasses.common.DXE_RUNTIME_DRIVER]
  VariablePolicyLib|MdeModulePkg/Library/VariablePolicyLib/VariablePolicyLibRuntimeDxe.inf

[LibraryClasses.common]
  PrePiMemoryAllocationLib|EmbeddedPkg/Library/PrePiMemoryAllocationLib/PrePiMemoryAllocationLib.inf
  OrderedCollectionLib|MdePkg/Library/BaseOrderedCollectionRedBlackTreeLib/BaseOrderedCollectionRedBlackTreeLib.inf
  ArmLib|ArmPkg/Library/ArmLib/ArmBaseLib.inf
  ArmPlatformLib|MSM8909Pkg/Library/MSM8909PkgLib/MSM8909PkgLib.inf
  CompilerIntrinsicsLib|ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib.inf

  CapsuleLib|MdeModulePkg/Library/DxeCapsuleLibNull/DxeCapsuleLibNull.inf
  UefiBootManagerLib|MdeModulePkg/Library/UefiBootManagerLib/UefiBootManagerLib.inf
  PlatformBootManagerLib|ArmPkg/Library/PlatformBootManagerLib/PlatformBootManagerLib.inf
  CustomizedDisplayLib|MdeModulePkg/Library/CustomizedDisplayLib/CustomizedDisplayLib.inf

  # SoC Drivers
  QTimerLib|MSM8909Pkg/Library/QTimerLib/QTimerLib.inf
  InterruptsLib|MSM8909Pkg/Library/InterruptsLib/InterruptsLib.inf
  MallocLib|MSM8909Pkg/Library/MallocLib/MallocLib.inf
#  KeypadDeviceHelperLib|MSM8909Pkg/Library/KeypadDeviceHelperLib/KeypadDeviceHelperLib.inf
#  KeypadDeviceImplLib|MSM8909Pkg/Library/KeypadDeviceImplLib/KeypadDeviceImplLib.inf
  DloadUtilLib|MSM8909Pkg/Library/DloadUtilLib/DloadUtilLib.inf
  QcomPlatformClockInitLib|MSM8909Pkg/Library/QcomPlatformClockInitLib/QcomPlatformClockInitLib.inf
  QcomPlatformMmcLib|MSM8909Pkg/Library/PlatformMmcLib/QcomPlatformMmcLib.inf
  QcomPlatformMmcClockOverrideLib|MSM8909Pkg/Library/QcomPlatformMmcClockOverrideLib/QcomPlatformMmcClockOverrideLib.inf
  QcomTargetMmcSdhciLib|MSM8909Pkg/Library/TargetMmcSdhciLib/QcomTargetMmcSdhciLib.inf
  LcmLib|MSM8909Pkg/Library/LcmLib/LcmLib.inf
  MicroLibC|MSM8909Pkg/Library/MicroLibC/MicroLibC.inf
  StrLib|MSM8909Pkg/Library/StrLib/StrLib.inf

  # UiApp dependencies
  ReportStatusCodeLib|MdeModulePkg/Library/DxeReportStatusCodeLib/DxeReportStatusCodeLib.inf
  FileExplorerLib|MdeModulePkg/Library/FileExplorerLib/FileExplorerLib.inf
  DxeServicesLib|MdePkg/Library/DxeServicesLib/DxeServicesLib.inf
  BootLogoLib|MdeModulePkg/Library/BootLogoLib/BootLogoLib.inf

  SerialPortLib|MSM8909Pkg/Library/InMemorySerialPortLib/InMemorySerialPortLib.inf
  RealTimeClockLib|EmbeddedPkg/Library/VirtualRealTimeClockLib/VirtualRealTimeClockLib.inf
  TimeBaseLib|EmbeddedPkg/Library/TimeBaseLib/TimeBaseLib.inf

  # USB Requirements
  UefiUsbLib|MdePkg/Library/UefiUsbLib/UefiUsbLib.inf

  # Network Libraries
  UefiScsiLib|MdePkg/Library/UefiScsiLib/UefiScsiLib.inf
  NetLib|NetworkPkg/Library/DxeNetLib/DxeNetLib.inf
  DpcLib|NetworkPkg/Library/DxeDpcLib/DxeDpcLib.inf
  IpIoLib|NetworkPkg/Library/DxeIpIoLib/DxeIpIoLib.inf
  UdpIoLib|NetworkPkg/Library/DxeUdpIoLib/DxeUdpIoLib.inf

  # VariableRuntimeDxe Requirements
  SynchronizationLib|MdePkg/Library/BaseSynchronizationLib/BaseSynchronizationLib.inf
  AuthVariableLib|MdeModulePkg/Library/AuthVariableLibNull/AuthVariableLibNull.inf
  TpmMeasurementLib|MdeModulePkg/Library/TpmMeasurementLibNull/TpmMeasurementLibNull.inf
  VarCheckLib|MdeModulePkg/Library/VarCheckLib/VarCheckLib.inf

  # SimpleFbDxe
  FrameBufferBltLib|MSM8909Pkg/Library/FrameBufferBltLib/FrameBufferBltLib.inf
  
    # Platform Drivers
!if $(USE_SCREEN_FOR_SERIAL_OUTPUT) == 1
  SerialPortLib|MSM8909Pkg/Library/FrameBufferSerialPortLib/FrameBufferSerialPortLib.inf
!else
  SerialPortLib|MdePkg/Library/BaseSerialPortLibNull/BaseSerialPortLibNull.inf
!endif

  PlatformBootManagerLib|MSM8909Pkg/Library/PlatformBootManagerLib/PlatformBootManagerLib.inf
  MemoryInitPeiLib|MSM8909Pkg/Library/MemoryInitPeiLib/PeiMemoryAllocationLib.inf
  PlatformPeiLib|MSM8909Pkg/Library/PlatformPeiLib/PlatformPeiLib.inf

  # SoC Drivers
  QcomPlatformClockInitLib|MSM8909Pkg/Library/QcomPlatformClockInitLib/QcomPlatformClockInitLib.inf

[LibraryClasses.common.SEC]
  PrePiLib|EmbeddedPkg/Library/PrePiLib/PrePiLib.inf
  ExtractGuidedSectionLib|EmbeddedPkg/Library/PrePiExtractGuidedSectionLib/PrePiExtractGuidedSectionLib.inf
  HobLib|EmbeddedPkg/Library/PrePiHobLib/PrePiHobLib.inf
  MemoryAllocationLib|EmbeddedPkg/Library/PrePiMemoryAllocationLib/PrePiMemoryAllocationLib.inf
  PrePiHobListPointerLib|ArmPlatformPkg/Library/PrePiHobListPointerLib/PrePiHobListPointerLib.inf

  # SoC Drivers
  GpioTlmmLib|MSM8909Pkg/Drivers/GpioTlmmDxe/GpioTlmmImplLib.inf
  SpmiLib|MSM8909Pkg/Drivers/SpmiDxe/SpmiImplLib.inf
  Pm8x41Lib|MSM8909Pkg/Drivers/Pm8x41Dxe/Pm8x41ImplLib.inf
  ClockLib|MSM8909Pkg/Drivers/ClockDxe/ClockImplLib.inf


[LibraryClasses.common.DXE_DRIVER]
  # SoC Drivers
  QcomDxeTimerLib|MSM8909Pkg/Library/QTimerLib/QcomQTimerDxeTimerLib.inf
  GpioTlmmLib|MSM8909Pkg/Drivers/GpioTlmmDxe/GpioTlmmLib.inf
  SpmiLib|MSM8909Pkg/Drivers/SpmiDxe/SpmiLib.inf
  Pm8x41Lib|MSM8909Pkg/Drivers/Pm8x41Dxe/Pm8x41Lib.inf
  ClockLib|MSM8909Pkg/Drivers/ClockDxe/ClockImplLib.inf

[LibraryClasses.common.UEFI_APPLICATION]
  # SoC Drivers
  GpioTlmmLib|MSM8909Pkg/Drivers/GpioTlmmDxe/GpioTlmmLib.inf
  SpmiLib|MSM8909Pkg/Drivers/SpmiDxe/SpmiLib.inf
  Pm8x41Lib|MSM8909Pkg/Drivers/Pm8x41Dxe/Pm8x41Lib.inf
  ClockLib|MSM8909Pkg/Drivers/ClockDxe/ClockImplLib.inf

[LibraryClasses.common.UEFI_DRIVER]
  # SoC Drivers
  GpioTlmmLib|MSM8909Pkg/Drivers/GpioTlmmDxe/GpioTlmmLib.inf
  SpmiLib|MSM8909Pkg/Drivers/SpmiDxe/SpmiLib.inf
  Pm8x41Lib|MSM8909Pkg/Drivers/Pm8x41Dxe/Pm8x41Lib.inf
  ClockLib|MSM8909Pkg/Drivers/ClockDxe/ClockImplLib.inf


################################################################################
#
# Pcd Section - list of all EDK II PCD Entries defined by this Platform
#
################################################################################

[PcdsFeatureFlag.common]
  ## If TRUE, Graphics Output Protocol will be installed on virtual handle created by ConsplitterDxe.
  #  It could be set FALSE to save size.
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutGopSupport|TRUE
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutUgaSupport|FALSE

[PcdsFixedAtBuild.common]
  gEfiMdePkgTokenSpaceGuid.PcdDefaultTerminalType|4

  gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString|L"Alpha"

  # Boot all cores or nothing :)
  gArmPlatformTokenSpaceGuid.PcdCoreCount|4
  gArmPlatformTokenSpaceGuid.PcdClusterCount|1


  #
  # ARM General Interrupt Controller
  #
  gArmTokenSpaceGuid.PcdGicDistributorBase|0x0b000000
  gArmTokenSpaceGuid.PcdGicInterruptInterfaceBase|0x0b002000

  # SoC Drivers GPIO TLMM
  gQcomTokenSpaceGuid.PcdGpioTlmmBaseAddress|0x1000000
  gQcomTokenSpaceGuid.PcdGpioTlmmSummaryIrq|240
  gQcomTokenSpaceGuid.PcdGpioTlmmIoOffset|0x1004
  gQcomTokenSpaceGuid.PcdGpioTlmmIoElementSize|0x10
  gQcomTokenSpaceGuid.PcdGpioTlmmCtlOffset|0x1000
  gQcomTokenSpaceGuid.PcdGpioTlmmCtlElementSize|0x10
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrCfgOffset|0x1008
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrCfgElementSize|0x10
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrStatusOffset|0x100c
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrStatusElementSize|0x10
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrTargetOffset|0x1008
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrTargetElementSize|0x10
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrEnableBit|0
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrStatusBit|0
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrAckHigh|FALSE
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrTargetBit|5
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrTargetKpssValue|4
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrRawStatusBit|4
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrPolarityBit|1
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrDetectionBit|2
  gQcomTokenSpaceGuid.PcdGpioTlmmIntrDetectionWidth|2
  gQcomTokenSpaceGuid.PcdGpioTlmmInBit|0
  gQcomTokenSpaceGuid.PcdGpioTlmmOutBit|1
  gQcomTokenSpaceGuid.PcdGpioTlmmOeBit|9
  gQcomTokenSpaceGuid.PcdGpioTlmmMuxBit|2
  gQcomTokenSpaceGuid.PcdGpioTlmmDrvBit|6
  gQcomTokenSpaceGuid.PcdGpioTlmmPullBit|0
  gQcomTokenSpaceGuid.PcdGpioTlmmNumFunctions|12

  # SoC Drivers SPMI
  gQcomTokenSpaceGuid.PcdSpmiBaseAddress|0x02000000
  
   # SoC Drivers MMC
  gQcomTokenSpaceGuid.PcdSdccMciHcMode|0x00000078
  gQcomTokenSpaceGuid.PcdSdccHcPwrctlStatusReg|0x000000DC
  gQcomTokenSpaceGuid.PcdSdccHcPwrctlMaskReg|0x000000E0
  gQcomTokenSpaceGuid.PcdSdccHcPwrctlClearReg|0x000000E4
  gQcomTokenSpaceGuid.PcdSdccHcPwrctlCtlReg|0x000000E8
  gQcomTokenSpaceGuid.PcdMmcSdhciDdrCfgVal|0x80040870 # DDR_CFG_DLY_VAL Not using here
  gQcomTokenSpaceGuid.PcdMmcSdc1HdrvPullCtlOffset|0x00002044
  gQcomTokenSpaceGuid.PcdMmcSdc2HdrvPullCtlOffset|0x00002048

  # SoC Drivers Misc
  gQcomTokenSpaceGuid.PcdGicSpiStart|32

  gArmTokenSpaceGuid.PcdArmArchTimerIntrNum|0x12
  gArmTokenSpaceGuid.PcdArmArchTimerVirtIntrNum|0x13

  # GUID of the UI app
  gEfiMdeModulePkgTokenSpaceGuid.PcdBootManagerMenuFile|{ 0x21, 0xaa, 0x2c, 0x46, 0x14, 0x76, 0x03, 0x45, 0x83, 0x6e, 0x8a, 0xb6, 0xf4, 0x66, 0x23, 0x31 }

  gEfiMdePkgTokenSpaceGuid.PcdPlatformBootTimeOut|5

  gEfiMdeModulePkgTokenSpaceGuid.PcdResetOnMemoryTypeInformationChange|FALSE

  gEmbeddedTokenSpaceGuid.PcdMetronomeTickPeriod|1000

  #
  #
  # Fastboot
  #
  gEmbeddedTokenSpaceGuid.PcdAndroidFastbootUsbVendorId|0x18d1
  gEmbeddedTokenSpaceGuid.PcdAndroidFastbootUsbProductId|0xd00d

  #
  # Make VariableRuntimeDxe work at emulated non-volatile variable mode.
  #
  gEfiMdeModulePkgTokenSpaceGuid.PcdEmuVariableNvModeEnable|TRUE

  gEfiMdeModulePkgTokenSpaceGuid.PcdAcpiExposedTableVersions|0x20


# Make it so ConOut will choose what's best at startup 
  [PcdsDynamicDefault.common]
  gEfiMdeModulePkgTokenSpaceGuid.PcdVideoHorizontalResolution|0 # /8 = column
  gEfiMdeModulePkgTokenSpaceGuid.PcdVideoVerticalResolution|0 #/19 = row
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupVideoHorizontalResolution|0
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupVideoVerticalResolution|0
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupConOutRow|0
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupConOutColumn|0
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutRow|0
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutColumn|0

################################################################################
#
# Components Section - list of all EDK II Modules needed by this Platform
#
################################################################################
[Components.common]
  #
  # PEI Phase modules
  #
  MSM8909Pkg/PrePi/PrePi.inf

  #
  # DXE
  #
  MdeModulePkg/Core/Dxe/DxeMain.inf {
    <LibraryClasses>
      PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
      NULL|MdeModulePkg/Library/DxeCrc32GuidedSectionExtractLib/DxeCrc32GuidedSectionExtractLib.inf
  }

  #
  # Architectural Protocols
  #
  ArmPkg/Drivers/CpuDxe/CpuDxe.inf
  MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
  MdeModulePkg/Universal/CapsuleRuntimeDxe/CapsuleRuntimeDxe.inf
  EmbeddedPkg/EmbeddedMonotonicCounter/EmbeddedMonotonicCounter.inf
  EmbeddedPkg/ResetRuntimeDxe/ResetRuntimeDxe.inf
  EmbeddedPkg/RealTimeClockRuntimeDxe/RealTimeClockRuntimeDxe.inf
  EmbeddedPkg/MetronomeDxe/MetronomeDxe.inf

  MdeModulePkg/Universal/Console/ConPlatformDxe/ConPlatformDxe.inf
  MSM8909Pkg/Drivers/ConSplitterDxe/ConSplitterDxe.inf
  MSM8909Pkg/Drivers/GraphicsConsoleDxe/GraphicsConsoleDxe.inf
  MdeModulePkg/Universal/Console/TerminalDxe/TerminalDxe.inf
  MdeModulePkg/Universal/SerialDxe/SerialDxe.inf

  MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf

  ArmPkg/Drivers/ArmGic/ArmGicDxe.inf
  ArmPkg/Drivers/TimerDxe/TimerDxe.inf

  MdeModulePkg/Universal/WatchdogTimerDxe/WatchdogTimer.inf

  MdeModulePkg/Universal/PCD/Dxe/Pcd.inf

  #
  # SoC Drivers
  #

  # SoC Drivers (Cross-referenced from EFIDroid and Ben)
  MSM8909Pkg/Drivers/BamDxe/BamDxe.inf
  MSM8909Pkg/Drivers/GpioTlmmDxe/GpioTlmmDxe.inf
  MSM8909Pkg/Drivers/GpioTlmmInterruptDxe/GpioTlmmInterruptDxe.inf
  MSM8909Pkg/Drivers/SpmiDxe/SpmiDxe.inf
  MSM8909Pkg/Drivers/Pm8x41Dxe/Pm8x41Dxe.inf
#  MSM8909Pkg/Drivers/GenericKeypadDeviceDxe/GenericKeypadDeviceDxe.inf
#  MSM8909Pkg/Drivers/KeypadDxe/KeypadDxe.inf
  MSM8909Pkg/Drivers/ClockDxe/ClockDxe.inf
  MSM8909Pkg/Drivers/SdhciMMCHSDxe/SdhciMMCHS.inf

  #
  # Virtual Keyboard
  #
  EmbeddedPkg/Drivers/VirtualKeyboardDxe/VirtualKeyboardDxe.inf

  #
  # Platform Dxes
  #
  MSM8909Pkg/Drivers/MSM8909PkgDxe/MSM8909PkgDxe.inf
  MSM8909Pkg/Drivers/SimpleFbDxe/SimpleFbDxe.inf
  MSM8909Pkg/Drivers/LogoDxe/LogoDxe.inf
  #
  # USB Host Support
  #
  MdeModulePkg/Bus/Usb/UsbBusDxe/UsbBusDxe.inf

  #
  # USB Mass Storage Support
  #
  MdeModulePkg/Bus/Usb/UsbMassStorageDxe/UsbMassStorageDxe.inf

  #
  # USB Peripheral Support
  #
  EmbeddedPkg/Drivers/AndroidFastbootTransportUsbDxe/FastbootTransportUsbDxe.inf

  #
  # Fastboot
  #
  EmbeddedPkg/Application/AndroidFastboot/AndroidFastbootApp.inf


  #
  # FAT filesystem + GPT/MBR partitioning
  #
  MdeModulePkg/Universal/Disk/DiskIoDxe/DiskIoDxe.inf
  MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe.inf
  MdeModulePkg/Universal/Disk/UnicodeCollation/EnglishDxe/EnglishDxe.inf
  FatPkg/EnhancedFatDxe/Fat.inf

  #
  # ACPI Support
  #
  MdeModulePkg/Universal/Acpi/AcpiTableDxe/AcpiTableDxe.inf
  MdeModulePkg/Universal/Acpi/AcpiPlatformDxe/AcpiPlatformDxe.inf
  MdeModulePkg/Universal/Acpi/BootGraphicsResourceTableDxe/BootGraphicsResourceTableDxe.inf

  #
  # SMBIOS Support
  #
  MSM8909Pkg/Drivers/SmbiosPlatformDxe/SmbiosPlatformDxe.inf
  MdeModulePkg/Universal/SmbiosDxe/SmbiosDxe.inf

  #
  # Bds
  #
  MdeModulePkg/Universal/PrintDxe/PrintDxe.inf
  MdeModulePkg/Universal/DevicePathDxe/DevicePathDxe.inf
  MdeModulePkg/Universal/HiiDatabaseDxe/HiiDatabaseDxe.inf {
    <LibraryClasses>
      PcdLib|MdePkg/Library/DxePcdLib/DxePcdLib.inf
  }
  MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe.inf
  MdeModulePkg/Universal/SetupBrowserDxe/SetupBrowserDxe.inf
  MdeModulePkg/Universal/DriverHealthManagerDxe/DriverHealthManagerDxe.inf
  MdeModulePkg/Universal/BdsDxe/BdsDxe.inf
  MdeModulePkg/Application/UiApp/UiApp.inf {
    <LibraryClasses>
      NULL|MdeModulePkg/Library/DeviceManagerUiLib/DeviceManagerUiLib.inf
      NULL|MdeModulePkg/Library/BootManagerUiLib/BootManagerUiLib.inf
      NULL|MdeModulePkg/Library/BootMaintenanceManagerUiLib/BootMaintenanceManagerUiLib.inf
      PcdLib|MdePkg/Library/DxePcdLib/DxePcdLib.inf
  }
  ShellPkg/Application/Shell/Shell.inf {
    <LibraryClasses>
      ShellCommandLib|ShellPkg/Library/UefiShellCommandLib/UefiShellCommandLib.inf
      NULL|ShellPkg/Library/UefiShellLevel2CommandsLib/UefiShellLevel2CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellLevel1CommandsLib/UefiShellLevel1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellLevel3CommandsLib/UefiShellLevel3CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellDriver1CommandsLib/UefiShellDriver1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellDebug1CommandsLib/UefiShellDebug1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellInstall1CommandsLib/UefiShellInstall1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellNetwork1CommandsLib/UefiShellNetwork1CommandsLib.inf
      NULL|ShellPkg/Library/UefiShellAcpiViewCommandLib/UefiShellAcpiViewCommandLib.inf
      HandleParsingLib|ShellPkg/Library/UefiHandleParsingLib/UefiHandleParsingLib.inf
      PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
      BcfgCommandLib|ShellPkg/Library/UefiShellBcfgCommandLib/UefiShellBcfgCommandLib.inf
    <PcdsFixedAtBuild>
      gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|0xFF
      gEfiShellPkgTokenSpaceGuid.PcdShellLibAutoInitialize|FALSE
      gEfiMdePkgTokenSpaceGuid.PcdUefiLibMaxPrintBufferSize|8000
  }
!ifdef $(INCLUDE_TFTP_COMMAND)
  ShellPkg/DynamicCommand/TftpDynamicCommand/TftpDynamicCommand.inf
!endif #$(INCLUDE_TFTP_COMMAND)

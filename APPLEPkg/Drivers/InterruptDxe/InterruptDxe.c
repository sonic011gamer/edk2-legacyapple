/** @file
  Handle OMAP35xx interrupt controller 

  Copyright (c) 2008 - 2010, Apple Inc. All rights reserved.<BR>
  
  This program and the accompanying materials
  are licensed and made available under the terms and conditions of the BSD License
  which accompanies this distribution.  The full text of the license may be found at
  http://opensource.org/licenses/bsd-license.php

  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

**/
#include <PiDxe.h>

#include <Library/BaseLib.h>
#include <Library/DebugLib.h>
#include <Library/BaseMemoryLib.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/UefiLib.h>
#include <Library/PcdLib.h>
#include <Library/IoLib.h>
#include <Library/ArmLib.h>

#include <Protocol/Cpu.h>
#include <Protocol/HardwareInterrupt.h>

#define VIC_START           0x3F200000
#define VIC_REGISTER_SIZE   0x10000
#define VIC(x)              (VIC_START + (x * VIC_REGISTER_SIZE))

#define VICIRQSTATUS    0x000
#define VICRAWINTR      0x8
#define VICINTSELECT    0xC
#define VICINTENABLE    0x10
#define VICINTENCLEAR     0x14
#define VICSWPRIORITYMASK 0x24
#define VICVECTADDRS    0x100
#define VICADDRESS      0xF00


//
// Notifications
//
EFI_EVENT EfiExitBootServicesEvent      = (EFI_EVENT)NULL;

#define MAX_VECTOR    32

HARDWARE_INTERRUPT_HANDLER  gRegisteredInterruptHandlers[MAX_VECTOR];

/**
  Shutdown our hardware
  
  DXE Core will disable interrupts and turn off the timer and disable interrupts
  after all the event handlers have run.

  @param[in]  Event   The Event that is being processed
  @param[in]  Context Event Context
**/
VOID
EFIAPI
ExitBootServicesEvent (
  IN EFI_EVENT  Event,
  IN VOID       *Context
  )
{
  // Disable all interrupts
  MmioWrite32(VIC(0) + VICINTENCLEAR, 0xFFFFFFFF);
  MmioWrite32(VIC(1) + VICINTENCLEAR, 0xFFFFFFFF);
  MmioWrite32(VIC(2) + VICINTENCLEAR, 0xFFFFFFFF);
  MmioWrite32(VIC(3) + VICINTENCLEAR, 0xFFFFFFFF);
  MmioWrite32(VIC(0) + VICSWPRIORITYMASK, 0xFFFF);
  MmioWrite32(VIC(1) + VICSWPRIORITYMASK, 0xFFFF);
  MmioWrite32(VIC(2) + VICSWPRIORITYMASK, 0xFFFF);
  MmioWrite32(VIC(3) + VICSWPRIORITYMASK, 0xFFFF);
  MmioWrite32(VIC(0) + VICINTENABLE, 0);
  MmioWrite32(VIC(1) + VICINTENABLE, 0);
  MmioWrite32(VIC(2) + VICINTENABLE, 0);
  MmioWrite32(VIC(3) + VICINTENABLE, 0);
  MmioWrite32(VIC(0) + VICINTSELECT, 0);
  MmioWrite32(VIC(1) + VICINTSELECT, 0);
  MmioWrite32(VIC(2) + VICINTSELECT, 0);
  MmioWrite32(VIC(3) + VICINTSELECT, 0);

  // Add code here to disable all FIQs as debugger may have turned one on
}

/**
  Register Handler for the specified interrupt source.

  @param This     Instance pointer for this protocol
  @param Source   Hardware source of the interrupt
  @param Handler  Callback for interrupt. NULL to unregister

  @retval EFI_SUCCESS Source was updated to support Handler.
  @retval EFI_DEVICE_ERROR  Hardware could not be programmed.

**/
EFI_STATUS
EFIAPI
RegisterInterruptSource (
  IN EFI_HARDWARE_INTERRUPT_PROTOCOL    *This,
  IN HARDWARE_INTERRUPT_SOURCE          Source,
  IN HARDWARE_INTERRUPT_HANDLER         Handler
  )
{
  if (Source > MAX_VECTOR) {
    ASSERT(FALSE);
    return EFI_UNSUPPORTED;
  } 
  
  if ((Handler == NULL) && (gRegisteredInterruptHandlers[Source] == NULL)) {
    return EFI_INVALID_PARAMETER;
  }

  if ((Handler != NULL) && (gRegisteredInterruptHandlers[Source] != NULL)) {
    return EFI_ALREADY_STARTED;
  }

  gRegisteredInterruptHandlers[Source] = Handler;
  return This->EnableInterruptSource(This, Source);
}


/**
  Enable interrupt source Source.

  @param This     Instance pointer for this protocol
  @param Source   Hardware source of the interrupt

  @retval EFI_SUCCESS       Source interrupt enabled.
  @retval EFI_DEVICE_ERROR  Hardware could not be programmed.

**/
EFI_STATUS
EFIAPI
EnableInterruptSource (
  IN EFI_HARDWARE_INTERRUPT_PROTOCOL    *This,
  IN HARDWARE_INTERRUPT_SOURCE          Source
  )
{
  UINTN Bank;
  UINTN Bit;
  
  if (Source > MAX_VECTOR) {
    ASSERT(FALSE);
    return EFI_UNSUPPORTED;
  }
  
  Bank = MmioRead32(VIC(0) + VICINTENABLE);
  Bit  = (Bank | (1 << Source));
  
  MmioWrite32 (VIC(0) + VICINTENABLE, Bit);
  
  return EFI_SUCCESS;
}


/**
  Disable interrupt source Source.

  @param This     Instance pointer for this protocol
  @param Source   Hardware source of the interrupt

  @retval EFI_SUCCESS       Source interrupt disabled.
  @retval EFI_DEVICE_ERROR  Hardware could not be programmed.

**/
EFI_STATUS
EFIAPI
DisableInterruptSource (
  IN EFI_HARDWARE_INTERRUPT_PROTOCOL    *This,
  IN HARDWARE_INTERRUPT_SOURCE          Source
  )
{
  UINTN Bank;
  UINTN Bit;
  
  if (Source > MAX_VECTOR) {
    ASSERT(FALSE);
    return EFI_UNSUPPORTED;
  }
  
  Bank = MmioRead32(VIC(0) + VICINTENABLE);
  Bit  = (Bank & ~(1 << Source));
  
  MmioWrite32 (VIC(0) + VICINTENABLE, Bit);

  return EFI_SUCCESS;
}



/**
  Return current state of interrupt source Source.

  @param This     Instance pointer for this protocol
  @param Source   Hardware source of the interrupt
  @param InterruptState  TRUE: source enabled, FALSE: source disabled.

  @retval EFI_SUCCESS       InterruptState is valid
  @retval EFI_DEVICE_ERROR  InterruptState is not valid

**/
EFI_STATUS
EFIAPI
GetInterruptSourceState (
  IN EFI_HARDWARE_INTERRUPT_PROTOCOL    *This,
  IN HARDWARE_INTERRUPT_SOURCE          Source,
  IN BOOLEAN                            *InterruptState
  )
{
  UINTN Bit;
  
  if (InterruptState == NULL) {
    return EFI_INVALID_PARAMETER;
  }
  
  if (Source > MAX_VECTOR) {
    ASSERT(FALSE);
    return EFI_UNSUPPORTED;
  }

  Bit  = 1UL << (Source % 32);
    
  if ((MmioRead32(VIC(0) + VICINTENABLE) & Bit) == Bit) {
    *InterruptState = FALSE;
  } else {
    *InterruptState = TRUE;
  }
  
  return EFI_SUCCESS;
}

/**
  Signal to the hardware that the End Of Intrrupt state 
  has been reached.

  @param This     Instance pointer for this protocol
  @param Source   Hardware source of the interrupt

  @retval EFI_SUCCESS       Source interrupt EOI'ed.
  @retval EFI_DEVICE_ERROR  Hardware could not be programmed.

**/
EFI_STATUS
EFIAPI
EndOfInterrupt (
  IN EFI_HARDWARE_INTERRUPT_PROTOCOL    *This,
  IN HARDWARE_INTERRUPT_SOURCE          Source
  )
{
  MmioWrite32 (VIC(0) + VICADDRESS, 0);
  ArmDataSynchronizationBarrier ();
  return EFI_SUCCESS;
}


/**
  EFI_CPU_INTERRUPT_HANDLER that is called when a processor interrupt occurs.

  @param  InterruptType    Defines the type of interrupt or exception that
                           occurred on the processor.This parameter is processor architecture specific.
  @param  SystemContext    A pointer to the processor context when
                           the interrupt occurred on the processor.

  @return None

**/
VOID
EFIAPI
IrqInterruptHandler (
  IN EFI_EXCEPTION_TYPE           InterruptType,
  IN EFI_SYSTEM_CONTEXT           SystemContext
  )
{
  //UINT32                     Vector;
  //HARDWARE_INTERRUPT_HANDLER InterruptHandler;
  //
  //Vector = MmioRead32 (VIC(0) + VICADDRESS);
  //
  //// Needed to prevent infinite nesting when Time Driver lowers TPL
  //ArmDataSynchronizationBarrier ();
  //
  //InterruptHandler = gRegisteredInterruptHandlers[Vector];
  //if (InterruptHandler != NULL) {
  //  // Call the registered interrupt handler.
  //  InterruptHandler (Vector, SystemContext);
  //}
  //
  //// Needed to clear after running the handler
  //MmioWrite32 (VIC(0) + VICADDRESS, 0);
  //ArmDataSynchronizationBarrier ();
}

//
// Making this global saves a few bytes in image size
//
EFI_HANDLE  gHardwareInterruptHandle = NULL;

//
// The protocol instance produced by this driver
//
EFI_HARDWARE_INTERRUPT_PROTOCOL gHardwareInterruptProtocol = {
  RegisterInterruptSource,
  EnableInterruptSource,
  DisableInterruptSource,
  GetInterruptSourceState,
  EndOfInterrupt
};

/**
  Initialize the state information for the CPU Architectural Protocol

  @param  ImageHandle   of the loaded driver
  @param  SystemTable   Pointer to the System Table

  @retval EFI_SUCCESS           Protocol registered
  @retval EFI_OUT_OF_RESOURCES  Cannot allocate protocol data structure
  @retval EFI_DEVICE_ERROR      Hardware problems

**/
EFI_STATUS
InterruptDxeInitialize (
  IN EFI_HANDLE         ImageHandle,
  IN EFI_SYSTEM_TABLE   *SystemTable
  )
{
  EFI_STATUS  Status;
  EFI_CPU_ARCH_PROTOCOL   *Cpu;

  // Make sure the Interrupt Controller Protocol is not already installed in the system.
  ASSERT_PROTOCOL_ALREADY_INSTALLED (NULL, &gHardwareInterruptProtocolGuid);

  // Make sure all interrupts are disabled by default.
  //MmioWrite32(VIC(0) + VICINTENCLEAR, 0xFFFFFFFF);
  //MmioWrite32(VIC(1) + VICINTENCLEAR, 0xFFFFFFFF);
  //MmioWrite32(VIC(2) + VICINTENCLEAR, 0xFFFFFFFF);
  //MmioWrite32(VIC(3) + VICINTENCLEAR, 0xFFFFFFFF);
  //
  //MmioWrite32(VIC(0) + VICINTENABLE, 0);
  //MmioWrite32(VIC(1) + VICINTENABLE, 0);
  //MmioWrite32(VIC(2) + VICINTENABLE, 0);
  //MmioWrite32(VIC(3) + VICINTENABLE, 0);
  //
  //MmioWrite32(VIC(0) + VICINTSELECT, 0);
  //MmioWrite32(VIC(1) + VICINTSELECT, 0);
  //MmioWrite32(VIC(2) + VICINTSELECT, 0);
  //MmioWrite32(VIC(3) + VICINTSELECT, 0);
  //
  //MmioWrite32(VIC(0) + VICSWPRIORITYMASK, 0xFFFF);
  //MmioWrite32(VIC(1) + VICSWPRIORITYMASK, 0xFFFF);
  //MmioWrite32(VIC(2) + VICSWPRIORITYMASK, 0xFFFF);
  //MmioWrite32(VIC(3) + VICSWPRIORITYMASK, 0xFFFF);
  //
  //int i;
  //for (i = 0; i < 0x20; i++) {
  //  MmioWrite32(VIC(0) + VICVECTADDRS + (i * 4), (0x20 * 0) + i);
  //  MmioWrite32(VIC(1) + VICVECTADDRS + (i * 4), (0x20 * 1) + i);
  //  MmioWrite32(VIC(2) + VICVECTADDRS + (i * 4), (0x20 * 2) + i);
  //  MmioWrite32(VIC(3) + VICVECTADDRS + (i * 4), (0x20 * 3) + i);
  //}

 
  Status = gBS->InstallMultipleProtocolInterfaces(&gHardwareInterruptHandle,
                                                  &gHardwareInterruptProtocolGuid,   &gHardwareInterruptProtocol,
                                                  NULL);
  ASSERT_EFI_ERROR(Status);
  
  //
  // Get the CPU protocol that this driver requires.
  //
  Status = gBS->LocateProtocol(&gEfiCpuArchProtocolGuid, NULL, (VOID **)&Cpu);
  ASSERT_EFI_ERROR(Status);

  //
  // Unregister the default exception handler.
  //
  Status = Cpu->RegisterInterruptHandler(Cpu, EXCEPT_ARM_IRQ, NULL);
  //ASSERT_EFI_ERROR(Status);

  //
  // Register to receive interrupts
  //
  Status = Cpu->RegisterInterruptHandler(Cpu, EXCEPT_ARM_IRQ, IrqInterruptHandler);
  //ASSERT_EFI_ERROR(Status);

  // Register for an ExitBootServicesEvent
  Status = gBS->CreateEvent(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_NOTIFY, ExitBootServicesEvent, NULL, &EfiExitBootServicesEvent);
  //ASSERT_EFI_ERROR(Status);

  return Status;
}


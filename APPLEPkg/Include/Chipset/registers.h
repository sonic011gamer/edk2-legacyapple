/*
 * Copyright (c) 2008 Travis Geiselbrecht
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files
 * (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#ifndef _REGISTERS_H
#define _REGISTERS_H

#define AIC_BASE_ADDR			(0x3F200000)

#define	rAIC_GLB_CFG		(*(volatile UINT32 *)(AIC_BASE_ADDR + 0x0010))
#define	AIC_GLBCFG_IEN		(1 << 0)
#define	AIC_GLBCFG_TEN		(1 << 1)
#define	AIC_GLBCFG_EWT(_t)	((_t) << 4)
#define	AIC_GLBCFG_IWT(_t)	((_t) << 8)
#define	AIC_GLBCFG_ACG		(1 << 16)
#define	AIC_GLBCFG_WT_MASK	(7)
#define	AIC_GLBCFG_WT_64MICRO	(7)

#define AIC_INT_COUNT			(192)
#define kAIC_MAX_EXTID			(AIC_INT_COUNT)
#define AIC_SRC_TO_EIR(_s)		((_s) >> 5)
#define kAIC_NUM_EIRS			AIC_SRC_TO_EIR(kAIC_MAX_EXTID)

#define rAIC_EIR_MASK_SET(_n)			(*(volatile UINT32 *)(AIC_BASE_ADDR + 0x4100 + ((_n) * 4)))

#define TimerSystemCount  (*(volatile UINT32 *)(AIC_BASE_ADDR + 0x0020))

#endif
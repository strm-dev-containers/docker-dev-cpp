/* float Floor function.  PowerPC64 version.
   Copyright (C) 2004 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */

#include <sysdep.h>

	.section	".toc","aw"
.LC0:	/* 2**23 */
	.tc FD_4b000000_0[TC],0x4b00000000000000
	.section	".text"

EALIGN (__floorf, 4, 0)
	CALL_MCOUNT 0
	mffs	fp11		/* Save current FPU rounding mode.  */
	lfs	fp13,.LC0@toc(2)
	fabs	fp0,fp1
	fsubs	fp12,fp13,fp13	/* generate 0.0  */
	fcmpu	cr7,fp0,fp13	/* if (fabs(x) > TWO23)  */
	fcmpu	cr6,fp1,fp12	/* if (x > 0.0)  */
	bnllr-	cr7
	mtfsfi	7,3		/* Set rounding mode toward -inf.  */
	ble-	cr6,.L4
	fadds	fp1,fp1,fp13	/* x+= TWO23;  */
	fsubs	fp1,fp1,fp13	/* x-= TWO23;  */
	fabs	fp1,fp1		/* if (x == 0.0)  */
				/* x = 0.0; */
	mtfsf	0x01,fp11	/* restore previous rounding mode.  */
	blr
.L4:
	bge-	cr6,.L9		/* if (x < 0.0)  */
	fsubs	fp1,fp1,fp13	/* x-= TWO23;  */
	fadds	fp1,fp1,fp13	/* x+= TWO23;  */
	fnabs	fp1,fp1		/* if (x == 0.0)  */
				/* x = -0.0; */
.L9:
	mtfsf	0x01,fp11	/* restore previous rounding mode.  */	
	blr
	END (__floorf)

weak_alias (__floorf, floorf)


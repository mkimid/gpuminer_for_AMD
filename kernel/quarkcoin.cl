/*
 * QuarkCoin kernel implementation.
 *
 * ==========================(LICENSE BEGIN)============================
 *
 * Copyright (c) 2014  phm
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
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
 *
 * ===========================(LICENSE END)=============================
 *
 * @author   phm <phm@inbox.com>
 */

#ifndef QUARKCOIN_CL
#define QUARKCOIN_CL

#if __ENDIAN_LITTLE__
    #define SPH_LITTLE_ENDIAN 1
#else
    #define SPH_BIG_ENDIAN 1
#endif

#define SPH_UPTRs                         sph_u64

typedef uint                              sph_u32;
typedef int                               sph_s32;

typedef ulong                             sph_u64;
typedef long                              sph_s64;


#define SPH_64                            1
#define SPH_64_TRUE                       1

#define SPH_C32(x)                        ((sph_u32)(x ## U))
#define SPH_T32(x)                        ((x) & SPH_C32(0xFFFFFFFF))
#define SPH_ROTL32(x, n)                  rotate(x, n)

#define SPH_ROTR32(x, n)                  SPH_ROTL32(x, (32 - (n)))

#define SPH_C64(x)                        ((sph_u64)(x ## UL))
#define SPH_T64(x)                        ((x) & SPH_C64(0xFFFFFFFFFFFFFFFF))
#define SPH_ROTL64(x, n)                  rotate(x, (ulong)(n))

#define SPH_ROTR64(x, n)                  SPH_ROTL64(x, (64 - (n)))

#define SPH_KECCAK_64                     1
#define SPH_KECCAK_NOCOPY                 0
#define SPH_KECCAK_UNROLL                 0

#define SPH_COMPACT_BLAKE_64              0

#include "blake.cl"
#include "bmw.cl"
#include "__groestl.cl"
#include "jh.cl"
#include "keccak.cl"
#include "skein.cl"

#define SWAP4(x)                          as_uint(as_uchar4(x).wzyx)
#define SWAP8(x)                          as_ulong(as_uchar8(x).s76543210)

#define DEC64E(x)                         SWAP8(x)
#define DEC64BE(x)                        SWAP8(*(const __global sph_u64 *) (x));






#define BLAKE512_COMPRESS64(BITLEN) \
		M0 = X[0]; \
		M1 = X[1]; \
		M2 = X[2]; \
		M3 = X[3]; \
		M4 = X[4]; \
		M5 = X[5]; \
		M6 = X[6]; \
		M7 = X[7]; \
		MB = 0; \
		MC = 0; \
		MD = 1; \
		ME = 0; \
		MF = BITLEN; \
		V0 = H0; \
		V1 = H1; \
		V2 = H2; \
		V3 = H3; \
		V4 = H4; \
		V5 = H5; \
		V6 = H6; \
		V7 = H7; \
		V8 = CB0; \
		V9 = CB1; \
		VA = CB2; \
		VB = CB3; \
		VC = CB4 ^ BITLEN; \
		VD = CB5 ^ BITLEN; \
		VE = CB6; \
		VF = CB7; \
		ROUND_B(0); \
		ROUND_B(1); \
		ROUND_B(2); \
		ROUND_B(3); \
		ROUND_B(4); \
		ROUND_B(5); \
		ROUND_B(6); \
		ROUND_B(7); \
		ROUND_B(8); \
		ROUND_B(9); \
		ROUND_B(0); \
		ROUND_B(1); \
		ROUND_B(2); \
		ROUND_B(3); \
		ROUND_B(4); \
		ROUND_B(5); \
		X[0] = H0 ^ V0 ^ V8; \
		X[1] = H1 ^ V1 ^ V9; \
		X[2] = H2 ^ V2 ^ VA; \
		X[3] = H3 ^ V3 ^ VB; \
		X[4] = H4 ^ V4 ^ VC; \
		X[5] = H5 ^ V5 ^ VD; \
		X[6] = H6 ^ V6 ^ VE; \
		X[7] = H7 ^ V7 ^ VF;



void BLAKE512_80(ulong X[16])	{

     ulong H0 = BLAKE_IV512[0], H1 = BLAKE_IV512[1];

     ulong H2 = BLAKE_IV512[2], H3 = BLAKE_IV512[3];

     ulong H4 = BLAKE_IV512[4], H5 = BLAKE_IV512[5];

     ulong H6 = BLAKE_IV512[6], H7 = BLAKE_IV512[7];

     ulong M0, M1, M2, M3, M4, M5, M6, M7;

     ulong M8, M9, MA, MB, MC, MD, ME, MF;

		 ulong V0, V1, V2, V3, V4, V5, V6, V7;

		 ulong V8, V9, VA, VB, VC, VD, VE, VF;

     M8 = X[8];

     M9 = X[9];

     MA = 0x8000000000000000;

     BLAKE512_COMPRESS64(0x280);

}



void BLAKE512_64(ulong X[16])	{

     ulong H0 = BLAKE_IV512[0], H1 = BLAKE_IV512[1];

     ulong H2 = BLAKE_IV512[2], H3 = BLAKE_IV512[3];

     ulong H4 = BLAKE_IV512[4], H5 = BLAKE_IV512[5];

     ulong H6 = BLAKE_IV512[6], H7 = BLAKE_IV512[7];

     ulong M0, M1, M2, M3, M4, M5, M6, M7;

     ulong M8, M9, MA, MB, MC, MD, ME, MF;

		 ulong V0, V1, V2, V3, V4, V5, V6, V7;

		 ulong V8, V9, VA, VB, VC, VD, VE, VF;

		 M8 = 0x8000000000000000;

		 M9 = 0;

		 MA = 0;

		 BLAKE512_COMPRESS64(0x200);

}





void BMW512(ulong X[16]) {

     ulong BMW_h1[16], BMW_h2[16], mv[16];

     #pragma unroll

     for (uint u = 0; u <  8; u++) mv[u] = SWAP8(X[u]);

     mv[0x08] = 0x80;

     mv[0x09] = 0;

     mv[0x0A] = 0;

     mv[0x0B] = 0;

     mv[0x0C] = 0;

     mv[0x0D] = 0;

     mv[0x0E] = 0;

     mv[0x0F] = 0x200;

#define M(x)    (mv[x])

#define H(x)    (BMW_IV512[x])

#define dH(x)   (BMW_h2[x])

     FOLDb;

#undef M

#undef H

#undef dH



#define M(x)    (BMW_h2[x])

#define H(x)    (final_b[x])

#define dH(x)   (BMW_h1[x])

     FOLDb;

#undef M

#undef H

#undef dH

     #pragma unroll

     for (uint u = 0; u <  8; u ++) X[u]  = SWAP8(BMW_h1[u + 0x08]);

}





void GROESTL512(ulong X[16], __local const ulong LT0[256],

                             __local const ulong LT1[256],

                             __local const ulong LT2[256],

                             __local const ulong LT3[256],

                             __local const ulong LT4[256],

                             __local const ulong LT5[256],

                             __local const ulong LT6[256],

                             __local const ulong LT7[256]) {

     ulong g[16], m[16], x[16], t[16];

	   ulong H[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x2000000000000UL };

     #pragma unroll

		 for (uint u = 0; u < 8; u++) m[u] = DEC64E(X[u]);

		 #pragma unroll

		 for (uint u = 0; u < 8; u++) g[u] = m[u];

		 m[0x08] = 0x80;              g[0x08] = 0x80;

		 m[0x09] = 0;                 g[0x09] = 0;

		 m[0x0A] = 0;                 g[0x0A] = 0;

		 m[0x0B] = 0;                 g[0x0B] = 0;

		 m[0x0C] = 0;                 g[0x0C] = 0;

		 m[0x0D] = 0;                 g[0x0D] = 0;

		 m[0x0E] = 0;                 g[0x0E] = 0;

		 m[0x0F] = 0x100000000000000; g[0x0F] = m[0x0F] ^ H[0x0F];

		 for (uint r = 0; r < 14; r++) {

			   ROUND_BIG_P(g, r);

		 }

		 for (uint r = 0; r < 14; r++) {

			   ROUND_BIG_Q(m, r);

		 }

		 for (uint u = 0; u < 16; u++) x[u]  = (H[u] ^= (g[u] ^ m[u]));

		 for (uint r = 0; r < 14; r++) {

         ROUND_BIG_P(x, r);

		 }

		 #pragma unroll

		 for (uint u = 8; u < 16; u++) H[u] ^= x[u];

		 #pragma unroll

		 for (uint u = 0; u <  8; u++) X[u]  = DEC64E(H[u + 0x08]);

}





void SKEIN512(ulong X[16]) {

     ulong h0 = SKEIN_IV512[0x00], h1 = SKEIN_IV512[0x01];

	   ulong h2 = SKEIN_IV512[0x02], h3 = SKEIN_IV512[0x03];

	   ulong h4 = SKEIN_IV512[0x04], h5 = SKEIN_IV512[0x05];

	   ulong h6 = SKEIN_IV512[0x06], h7 = SKEIN_IV512[0x07];

     ulong m0 = SWAP8(X[0x00]);

     ulong m1 = SWAP8(X[0x01]);

     ulong m2 = SWAP8(X[0x02]);

     ulong m3 = SWAP8(X[0x03]);

     ulong m4 = SWAP8(X[0x04]);

     ulong m5 = SWAP8(X[0x05]);

     ulong m6 = SWAP8(X[0x06]);

     ulong m7 = SWAP8(X[0x07]);

     ulong bcount = 0;

     UBI_BIG(480, 64);

     bcount = 0;

     m0 = m1 = m2 = m3 = m4 = m5 = m6 = m7 = 0;

     UBI_BIG(510, 8);

     X[0x00] = SWAP8(h0);

     X[0x01] = SWAP8(h1);

     X[0x02] = SWAP8(h2);

     X[0x03] = SWAP8(h3);

     X[0x04] = SWAP8(h4);

     X[0x05] = SWAP8(h5);

     X[0x06] = SWAP8(h6);

     X[0x07] = SWAP8(h7);

}





void JH512(ulong X[16]) {

     ulong h0h = JH_IV512[0x00], h0l = JH_IV512[0x01];

	   ulong h1h = JH_IV512[0x02], h1l = JH_IV512[0x03];

     ulong h2h = JH_IV512[0x04], h2l = JH_IV512[0x05];

     ulong h3h = JH_IV512[0x06], h3l = JH_IV512[0x07];

     ulong h4h = JH_IV512[0x08], h4l = JH_IV512[0x09];

	   ulong h5h = JH_IV512[0x0A], h5l = JH_IV512[0x0B];

	   ulong h6h = JH_IV512[0x0C], h6l = JH_IV512[0x0D];

     ulong h7h = JH_IV512[0x0E], h7l = JH_IV512[0x0F];

     ulong tmp;
     for(uint i = 0; i < 2; i++) {

        if (i == 0) {

            h0h ^= DEC64E(X[0x00]);

            h0l ^= DEC64E(X[0x01]);

            h1h ^= DEC64E(X[0x02]);

            h1l ^= DEC64E(X[0x03]);

            h2h ^= DEC64E(X[0x04]);

            h2l ^= DEC64E(X[0x05]);

            h3h ^= DEC64E(X[0x06]);

            h3l ^= DEC64E(X[0x07]);

        } else if (i == 1) {

            h4h ^= DEC64E(X[0x00]);

            h4l ^= DEC64E(X[0x01]);

            h5h ^= DEC64E(X[0x02]);

            h5l ^= DEC64E(X[0x03]);

            h6h ^= DEC64E(X[0x04]);

            h6l ^= DEC64E(X[0x05]);

            h7h ^= DEC64E(X[0x06]);

            h7l ^= DEC64E(X[0x07]);

            h0h ^= 0x80;

            h3l ^= 0x2000000000000;

        }

        E8;

     }

     h4h ^= 0x80;

     h7l ^= 0x2000000000000;

     X[0x00] = DEC64E(h4h);

     X[0x01] = DEC64E(h4l);

     X[0x02] = DEC64E(h5h);

     X[0x03] = DEC64E(h5l);

     X[0x04] = DEC64E(h6h);

     X[0x05] = DEC64E(h6l);

     X[0x06] = DEC64E(h7h);

     X[0x07] = DEC64E(h7l);

}



void KECCAK512(ulong X[16]) {

     ulong a00  =  SWAP8(X[0x00]);

     ulong a01  =  SWAP8(X[0x05]);

     ulong a02  =  0;

	   ulong a03  =  0;

     ulong a04  =  0xFFFFFFFFFFFFFFFFUL;

     ulong a10  = ~SWAP8(X[0x01]);

     ulong a11  =  SWAP8(X[0x06]);

     ulong a12  =  0;

	   ulong a13  =  0;

	   ulong a14  =  0;

     ulong a20  = ~SWAP8(X[0x02]);

     ulong a21  =  SWAP8(X[0x07]);

     ulong a22  =  0xFFFFFFFFFFFFFFFFUL;

     ulong a23  =  0xFFFFFFFFFFFFFFFFUL;

     ulong a24  =  0;

     ulong a30  =  SWAP8(X[0x03]);

     ulong a31  =  0x7FFFFFFFFFFFFFFEUL;

     ulong a32  =  0;

	   ulong a33  =  0;

	   ulong a34  =  0;

     ulong a40  =  SWAP8(X[0x04]);

     ulong a41  =  0;

	   ulong a42  =  0;

	   ulong a43  =  0;

	   ulong a44  =  0;

     KECCAK_F_1600;

     a10        = ~a10;

     a20        = ~a20;

     X[0x00]    = SWAP8(a00);

     X[0x01]    = SWAP8(a10);

     X[0x02]    = SWAP8(a20);

     X[0x03]    = SWAP8(a30);

     X[0x04]    = SWAP8(a40);

     X[0x05]    = SWAP8(a01);

     X[0x06]    = SWAP8(a11);

     X[0x07]    = SWAP8(a21);

}




__attribute__((reqd_work_group_size(WORKSIZE, 1, 1)))
__kernel void search(__global unsigned char* block, volatile __global uint* output, const ulong target) {



	__local ulong LT0[256], LT1[256], LT2[256], LT3[256], LT4[256], LT5[256], LT6[256], LT7[256];

    uint init = get_local_id(0);

    uint step = get_local_size(0);

    for (uint i = init; i < 256; i += step) {

        LT0[i] = T0[i];

        LT1[i] = T1[i];

        LT2[i] = T2[i];

        LT3[i] = T3[i];

        LT4[i] = T4[i];

        LT5[i] = T5[i];

        LT6[i] = T6[i];

        LT7[i] = T7[i];

    }

    barrier(CLK_LOCAL_MEM_FENCE);




    uint  gid = SWAP4(get_global_id(0));



	  ulong HASH[16];

		HASH[0]  = DEC64BE(block +  0);

    HASH[1]  = DEC64BE(block +  8);

    HASH[2]  = DEC64BE(block + 16);

    HASH[3]  = DEC64BE(block + 24);

    HASH[4]  = DEC64BE(block + 32);

    HASH[5]  = DEC64BE(block + 40);

    HASH[6]  = DEC64BE(block + 48);

    HASH[7]  = DEC64BE(block + 56);

    HASH[8]  = DEC64BE(block + 64);

    HASH[9]  = DEC64BE(block + 72);

    HASH[9] &= 0xFFFFFFFF00000000;

    HASH[9] ^= gid;



	  BLAKE512_80(HASH);

		BMW512(HASH);



    if (as_uchar8(HASH[0x00]).s7 & 0x08) {

		   GROESTL512(HASH, LT0, LT1, LT2, LT3, LT4, LT5, LT6, LT7);

    }

		else {

		   SKEIN512(HASH);

    }

		GROESTL512(HASH, LT0, LT1, LT2, LT3, LT4, LT5, LT6, LT7);

		JH512(HASH);

    if (as_uchar8(HASH[0x00]).s7 & 0x08) {

	     BLAKE512_64(HASH);

    }

		else {

		   BMW512(HASH);

		}

	  KECCAK512(HASH);

		SKEIN512(HASH);

    if (as_uchar8(HASH[0x00]).s7 & 0x08) {

			 KECCAK512(HASH);

    } else {

			 JH512(HASH);

    }



    if (SWAP8(HASH[3]) <= target) {

       output[output[0xFF]++] = gid;

		}
}

#endif // QUARKCOIN_CL


avx.out:     формат файла elf64-x86-64


Дизассемблирование раздела .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 c1 2f 00 00 	mov    0x2fc1(%rip),%rax        # 3fd0 <__gmon_start__@Base>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	call   *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	ret

Дизассемблирование раздела .plt:

0000000000001020 <_Znam@plt-0x10>:
    1020:	ff 35 ca 2f 00 00    	push   0x2fca(%rip)        # 3ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 cc 2f 00 00    	jmp    *0x2fcc(%rip)        # 3ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001030 <_Znam@plt>:
    1030:	ff 25 ca 2f 00 00    	jmp    *0x2fca(%rip)        # 4000 <_Znam@GLIBCXX_3.4>
    1036:	68 00 00 00 00       	push   $0x0
    103b:	e9 e0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001040 <rand@plt>:
    1040:	ff 25 c2 2f 00 00    	jmp    *0x2fc2(%rip)        # 4008 <rand@GLIBC_2.2.5>
    1046:	68 01 00 00 00       	push   $0x1
    104b:	e9 d0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001050 <memset@plt>:
    1050:	ff 25 ba 2f 00 00    	jmp    *0x2fba(%rip)        # 4010 <memset@GLIBC_2.2.5>
    1056:	68 02 00 00 00       	push   $0x2
    105b:	e9 c0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001060 <__cxa_atexit@plt>:
    1060:	ff 25 b2 2f 00 00    	jmp    *0x2fb2(%rip)        # 4018 <__cxa_atexit@GLIBC_2.2.5>
    1066:	68 03 00 00 00       	push   $0x3
    106b:	e9 b0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001070 <_ZdaPv@plt>:
    1070:	ff 25 aa 2f 00 00    	jmp    *0x2faa(%rip)        # 4020 <_ZdaPv@GLIBCXX_3.4>
    1076:	68 04 00 00 00       	push   $0x4
    107b:	e9 a0 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001080 <__cxa_throw_bad_array_new_length@plt>:
    1080:	ff 25 a2 2f 00 00    	jmp    *0x2fa2(%rip)        # 4028 <__cxa_throw_bad_array_new_length@CXXABI_1.3.8>
    1086:	68 05 00 00 00       	push   $0x5
    108b:	e9 90 ff ff ff       	jmp    1020 <_init+0x20>

0000000000001090 <_ZNSt8ios_base4InitC1Ev@plt>:
    1090:	ff 25 9a 2f 00 00    	jmp    *0x2f9a(%rip)        # 4030 <_ZNSt8ios_base4InitC1Ev@GLIBCXX_3.4>
    1096:	68 06 00 00 00       	push   $0x6
    109b:	e9 80 ff ff ff       	jmp    1020 <_init+0x20>

Дизассемблирование раздела .text:

00000000000010a0 <_Z12CreateMatrixPPdiiii.cold>:
    10a0:	e8 db ff ff ff       	call   1080 <__cxa_throw_bad_array_new_length@plt>
    10a5:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    10ac:	00 00 00 
    10af:	90                   	nop

00000000000010b0 <main>:
    10b0:	55                   	push   %rbp
    10b1:	53                   	push   %rbx
    10b2:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    10b8:	b9 10 00 00 00       	mov    $0x10,%ecx
    10bd:	48 83 ec 08          	sub    $0x8,%rsp
    10c1:	ba c8 00 00 00       	mov    $0xc8,%edx
    10c6:	be 96 00 00 00       	mov    $0x96,%esi
    10cb:	31 ff                	xor    %edi,%edi
    10cd:	e8 fe 04 00 00       	call   15d0 <_Z12CreateMatrixPPdiiii>
    10d2:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    10d8:	b9 10 00 00 00       	mov    $0x10,%ecx
    10dd:	ba 96 00 00 00       	mov    $0x96,%edx
    10e2:	be c8 00 00 00       	mov    $0xc8,%esi
    10e7:	31 ff                	xor    %edi,%edi
    10e9:	48 89 c3             	mov    %rax,%rbx
    10ec:	e8 df 04 00 00       	call   15d0 <_Z12CreateMatrixPPdiiii>
    10f1:	45 31 c0             	xor    %r8d,%r8d
    10f4:	b9 10 00 00 00       	mov    $0x10,%ecx
    10f9:	ba 96 00 00 00       	mov    $0x96,%edx
    10fe:	be 96 00 00 00       	mov    $0x96,%esi
    1103:	31 ff                	xor    %edi,%edi
    1105:	48 89 c5             	mov    %rax,%rbp
    1108:	e8 c3 04 00 00       	call   15d0 <_Z12CreateMatrixPPdiiii>
    110d:	48 83 ec 08          	sub    $0x8,%rsp
    1111:	48 89 ea             	mov    %rbp,%rdx
    1114:	48 89 de             	mov    %rbx,%rsi
    1117:	48 89 c7             	mov    %rax,%rdi
    111a:	6a 10                	push   $0x10
    111c:	41 b9 c8 00 00 00    	mov    $0xc8,%r9d
    1122:	41 b8 96 00 00 00    	mov    $0x96,%r8d
    1128:	b9 96 00 00 00       	mov    $0x96,%ecx
    112d:	e8 3e 01 00 00       	call   1270 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii>
    1132:	48 83 c4 18          	add    $0x18,%rsp
    1136:	31 c0                	xor    %eax,%eax
    1138:	5b                   	pop    %rbx
    1139:	5d                   	pop    %rbp
    113a:	c3                   	ret
    113b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001140 <_GLOBAL__sub_I_main>:
    1140:	53                   	push   %rbx
    1141:	48 8d 1d 01 2f 00 00 	lea    0x2f01(%rip),%rbx        # 4049 <_ZStL8__ioinit>
    1148:	48 89 df             	mov    %rbx,%rdi
    114b:	e8 40 ff ff ff       	call   1090 <_ZNSt8ios_base4InitC1Ev@plt>
    1150:	48 89 de             	mov    %rbx,%rsi
    1153:	48 8b 3d 86 2e 00 00 	mov    0x2e86(%rip),%rdi        # 3fe0 <_ZNSt8ios_base4InitD1Ev@GLIBCXX_3.4>
    115a:	48 8d 15 df 2e 00 00 	lea    0x2edf(%rip),%rdx        # 4040 <__dso_handle>
    1161:	5b                   	pop    %rbx
    1162:	e9 f9 fe ff ff       	jmp    1060 <__cxa_atexit@plt>
    1167:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    116e:	00 00 

0000000000001170 <_start>:
    1170:	f3 0f 1e fa          	endbr64
    1174:	31 ed                	xor    %ebp,%ebp
    1176:	49 89 d1             	mov    %rdx,%r9
    1179:	5e                   	pop    %rsi
    117a:	48 89 e2             	mov    %rsp,%rdx
    117d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    1181:	50                   	push   %rax
    1182:	54                   	push   %rsp
    1183:	45 31 c0             	xor    %r8d,%r8d
    1186:	31 c9                	xor    %ecx,%ecx
    1188:	48 8d 3d 21 ff ff ff 	lea    -0xdf(%rip),%rdi        # 10b0 <main>
    118f:	ff 15 2b 2e 00 00    	call   *0x2e2b(%rip)        # 3fc0 <__libc_start_main@GLIBC_2.34>
    1195:	f4                   	hlt
    1196:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    119d:	00 00 00 
    11a0:	48 8d 3d a1 2e 00 00 	lea    0x2ea1(%rip),%rdi        # 4048 <__TMC_END__>
    11a7:	48 8d 05 9a 2e 00 00 	lea    0x2e9a(%rip),%rax        # 4048 <__TMC_END__>
    11ae:	48 39 f8             	cmp    %rdi,%rax
    11b1:	74 15                	je     11c8 <_start+0x58>
    11b3:	48 8b 05 0e 2e 00 00 	mov    0x2e0e(%rip),%rax        # 3fc8 <_ITM_deregisterTMCloneTable@Base>
    11ba:	48 85 c0             	test   %rax,%rax
    11bd:	74 09                	je     11c8 <_start+0x58>
    11bf:	ff e0                	jmp    *%rax
    11c1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    11c8:	c3                   	ret
    11c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    11d0:	48 8d 3d 71 2e 00 00 	lea    0x2e71(%rip),%rdi        # 4048 <__TMC_END__>
    11d7:	48 8d 35 6a 2e 00 00 	lea    0x2e6a(%rip),%rsi        # 4048 <__TMC_END__>
    11de:	48 29 fe             	sub    %rdi,%rsi
    11e1:	48 89 f0             	mov    %rsi,%rax
    11e4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    11e8:	48 c1 f8 03          	sar    $0x3,%rax
    11ec:	48 01 c6             	add    %rax,%rsi
    11ef:	48 d1 fe             	sar    %rsi
    11f2:	74 14                	je     1208 <_start+0x98>
    11f4:	48 8b 05 dd 2d 00 00 	mov    0x2ddd(%rip),%rax        # 3fd8 <_ITM_registerTMCloneTable@Base>
    11fb:	48 85 c0             	test   %rax,%rax
    11fe:	74 08                	je     1208 <_start+0x98>
    1200:	ff e0                	jmp    *%rax
    1202:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1208:	c3                   	ret
    1209:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1210:	f3 0f 1e fa          	endbr64
    1214:	80 3d 2d 2e 00 00 00 	cmpb   $0x0,0x2e2d(%rip)        # 4048 <__TMC_END__>
    121b:	75 33                	jne    1250 <_start+0xe0>
    121d:	55                   	push   %rbp
    121e:	48 83 3d 92 2d 00 00 	cmpq   $0x0,0x2d92(%rip)        # 3fb8 <__cxa_finalize@GLIBC_2.2.5>
    1225:	00 
    1226:	48 89 e5             	mov    %rsp,%rbp
    1229:	74 0d                	je     1238 <_start+0xc8>
    122b:	48 8b 3d 0e 2e 00 00 	mov    0x2e0e(%rip),%rdi        # 4040 <__dso_handle>
    1232:	ff 15 80 2d 00 00    	call   *0x2d80(%rip)        # 3fb8 <__cxa_finalize@GLIBC_2.2.5>
    1238:	e8 63 ff ff ff       	call   11a0 <_start+0x30>
    123d:	c6 05 04 2e 00 00 01 	movb   $0x1,0x2e04(%rip)        # 4048 <__TMC_END__>
    1244:	5d                   	pop    %rbp
    1245:	c3                   	ret
    1246:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    124d:	00 00 00 
    1250:	c3                   	ret
    1251:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1258:	00 00 00 00 
    125c:	0f 1f 40 00          	nopl   0x0(%rax)
    1260:	f3 0f 1e fa          	endbr64
    1264:	e9 67 ff ff ff       	jmp    11d0 <_start+0x60>
    1269:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001270 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii>:
    1270:	55                   	push   %rbp
    1271:	48 89 e5             	mov    %rsp,%rbp
    1274:	41 57                	push   %r15
    1276:	41 56                	push   %r14
    1278:	41 55                	push   %r13
    127a:	41 54                	push   %r12
    127c:	53                   	push   %rbx
    127d:	41 89 cd             	mov    %ecx,%r13d
    1280:	44 89 c3             	mov    %r8d,%ebx
    1283:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
    1287:	45 89 cf             	mov    %r9d,%r15d
    128a:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
    128e:	44 8b 75 10          	mov    0x10(%rbp),%r14d
    1292:	48 89 7c 24 60       	mov    %rdi,0x60(%rsp)
    1297:	bf 00 08 00 00       	mov    $0x800,%edi
    129c:	48 89 74 24 58       	mov    %rsi,0x58(%rsp)
    12a1:	48 89 54 24 50       	mov    %rdx,0x50(%rsp)
    12a6:	89 4c 24 4c          	mov    %ecx,0x4c(%rsp)
    12aa:	e8 81 fd ff ff       	call   1030 <_Znam@plt>
    12af:	49 89 c4             	mov    %rax,%r12
    12b2:	45 85 ed             	test   %r13d,%r13d
    12b5:	0f 8e 06 02 00 00    	jle    14c1 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x251>
    12bb:	48 63 f3             	movslq %ebx,%rsi
    12be:	45 31 c0             	xor    %r8d,%r8d
    12c1:	45 31 c9             	xor    %r9d,%r9d
    12c4:	31 ff                	xor    %edi,%edi
    12c6:	48 8d 04 f5 00 00 00 	lea    0x0(,%rsi,8),%rax
    12cd:	00 
    12ce:	4d 63 d7             	movslq %r15d,%r10
    12d1:	c5 e9 57 d2          	vxorpd %xmm2,%xmm2,%xmm2
    12d5:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
    12da:	49 63 c6             	movslq %r14d,%rax
    12dd:	4c 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%r13
    12e4:	00 
    12e5:	85 db                	test   %ebx,%ebx
    12e7:	0f 8e ef 01 00 00    	jle    14dc <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x26c>
    12ed:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
    12f2:	49 63 c1             	movslq %r9d,%rax
    12f5:	31 d2                	xor    %edx,%edx
    12f7:	4c 8d 1c c1          	lea    (%rcx,%rax,8),%r11
    12fb:	4c 01 d0             	add    %r10,%rax
    12fe:	48 8d 04 c1          	lea    (%rcx,%rax,8),%rax
    1302:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
    1307:	45 85 ff             	test   %r15d,%r15d
    130a:	0f 8e 90 01 00 00    	jle    14a0 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x230>
    1310:	89 d0                	mov    %edx,%eax
    1312:	89 d9                	mov    %ebx,%ecx
    1314:	48 89 d3             	mov    %rdx,%rbx
    1317:	4c 89 d2             	mov    %r10,%rdx
    131a:	4c 8b 54 24 60       	mov    0x60(%rsp),%r10
    131f:	44 01 c0             	add    %r8d,%eax
    1322:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    1327:	89 7c 24 48          	mov    %edi,0x48(%rsp)
    132b:	48 98                	cltq
    132d:	89 cf                	mov    %ecx,%edi
    132f:	48 89 74 24 40       	mov    %rsi,0x40(%rsp)
    1334:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
    1339:	44 89 f9             	mov    %r15d,%ecx
    133c:	49 8d 04 c2          	lea    (%r10,%rax,8),%rax
    1340:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
    1345:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
    134a:	4c 8d 14 d8          	lea    (%rax,%rbx,8),%r10
    134e:	44 89 c3             	mov    %r8d,%ebx
    1351:	4c 89 d8             	mov    %r11,%rax
    1354:	45 89 c8             	mov    %r9d,%r8d
    1357:	41 89 d9             	mov    %ebx,%r9d
    135a:	4c 8b 18             	mov    (%rax),%r11
    135d:	4d 8b 3a             	mov    (%r10),%r15
    1360:	4c 89 e6             	mov    %r12,%rsi
    1363:	4c 89 64 24 28       	mov    %r12,0x28(%rsp)
    1368:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
    136d:	4c 89 54 24 18       	mov    %r10,0x18(%rsp)
    1372:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    1377:	49 8d 9b 00 08 00 00 	lea    0x800(%r11),%rbx
    137e:	66 90                	xchg   %ax,%ax
    1380:	c5 fd 11 16          	vmovupd %ymm2,(%rsi)
    1384:	c5 fd 11 56 20       	vmovupd %ymm2,0x20(%rsi)
    1389:	c5 fd 11 56 40       	vmovupd %ymm2,0x40(%rsi)
    138e:	4d 89 fa             	mov    %r15,%r10
    1391:	c5 fd 11 56 60       	vmovupd %ymm2,0x60(%rsi)
    1396:	4d 89 dd             	mov    %r11,%r13
    1399:	45 31 e4             	xor    %r12d,%r12d
    139c:	0f 1f 40 00          	nopl   0x0(%rax)
    13a0:	c4 c2 7d 19 4d 00    	vbroadcastsd 0x0(%r13),%ymm1
    13a6:	31 c0                	xor    %eax,%eax
    13a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    13af:	00 
    13b0:	c4 c1 7d 10 04 02    	vmovupd (%r10,%rax,1),%ymm0
    13b6:	c4 e2 f5 a8 04 06    	vfmadd213pd (%rsi,%rax,1),%ymm1,%ymm0
    13bc:	c5 fd 11 04 06       	vmovupd %ymm0,(%rsi,%rax,1)
    13c1:	48 83 c0 20          	add    $0x20,%rax
    13c5:	48 3d 80 00 00 00    	cmp    $0x80,%rax
    13cb:	75 e3                	jne    13b0 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x140>
    13cd:	49 83 c4 10          	add    $0x10,%r12
    13d1:	49 83 c5 08          	add    $0x8,%r13
    13d5:	49 83 ea 80          	sub    $0xffffffffffffff80,%r10
    13d9:	49 81 fc 00 01 00 00 	cmp    $0x100,%r12
    13e0:	75 be                	jne    13a0 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x130>
    13e2:	49 83 eb 80          	sub    $0xffffffffffffff80,%r11
    13e6:	48 83 ee 80          	sub    $0xffffffffffffff80,%rsi
    13ea:	49 39 db             	cmp    %rbx,%r11
    13ed:	75 91                	jne    1380 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x110>
    13ef:	4c 8b 64 24 28       	mov    0x28(%rsp),%r12
    13f4:	4c 8b 6c 24 20       	mov    0x20(%rsp),%r13
    13f9:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
    13fe:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    1403:	45 85 f6             	test   %r14d,%r14d
    1406:	7e 4e                	jle    1456 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x1e6>
    1408:	48 8b 5c 24 78       	mov    0x78(%rsp),%rbx
    140d:	45 31 ff             	xor    %r15d,%r15d
    1410:	4c 8b 1b             	mov    (%rbx),%r11
    1413:	4c 89 eb             	mov    %r13,%rbx
    1416:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    141d:	00 00 00 
    1420:	48 89 de             	mov    %rbx,%rsi
    1423:	4c 29 ee             	sub    %r13,%rsi
    1426:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    142d:	00 00 00 
    1430:	c4 c1 7b 10 04 33    	vmovsd (%r11,%rsi,1),%xmm0
    1436:	c4 c1 7b 58 04 34    	vaddsd (%r12,%rsi,1),%xmm0,%xmm0
    143c:	c4 c1 7b 11 04 33    	vmovsd %xmm0,(%r11,%rsi,1)
    1442:	48 83 c6 08          	add    $0x8,%rsi
    1446:	48 39 de             	cmp    %rbx,%rsi
    1449:	75 e5                	jne    1430 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x1c0>
    144b:	41 ff c7             	inc    %r15d
    144e:	4c 01 eb             	add    %r13,%rbx
    1451:	45 39 fe             	cmp    %r15d,%r14d
    1454:	75 ca                	jne    1420 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x1b0>
    1456:	48 8b 5c 24 70       	mov    0x70(%rsp),%rbx
    145b:	48 83 c0 08          	add    $0x8,%rax
    145f:	49 01 da             	add    %rbx,%r10
    1462:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
    1467:	48 39 d8             	cmp    %rbx,%rax
    146a:	0f 85 ea fe ff ff    	jne    135a <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0xea>
    1470:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    1475:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
    147a:	44 89 c8             	mov    %r9d,%eax
    147d:	41 89 cf             	mov    %ecx,%r15d
    1480:	45 89 c1             	mov    %r8d,%r9d
    1483:	89 f9                	mov    %edi,%ecx
    1485:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
    148a:	8b 7c 24 48          	mov    0x48(%rsp),%edi
    148e:	41 89 c0             	mov    %eax,%r8d
    1491:	48 ff c3             	inc    %rbx
    1494:	48 39 f3             	cmp    %rsi,%rbx
    1497:	74 3e                	je     14d7 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x267>
    1499:	89 d8                	mov    %ebx,%eax
    149b:	e9 7a fe ff ff       	jmp    131a <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0xaa>
    14a0:	48 ff c2             	inc    %rdx
    14a3:	48 39 d6             	cmp    %rdx,%rsi
    14a6:	0f 85 5b fe ff ff    	jne    1307 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x97>
    14ac:	ff c7                	inc    %edi
    14ae:	45 01 f9             	add    %r15d,%r9d
    14b1:	41 01 d8             	add    %ebx,%r8d
    14b4:	39 7c 24 4c          	cmp    %edi,0x4c(%rsp)
    14b8:	0f 85 27 fe ff ff    	jne    12e5 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x75>
    14be:	c5 f8 77             	vzeroupper
    14c1:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    14c5:	4c 89 e7             	mov    %r12,%rdi
    14c8:	5b                   	pop    %rbx
    14c9:	41 5c                	pop    %r12
    14cb:	41 5d                	pop    %r13
    14cd:	41 5e                	pop    %r14
    14cf:	41 5f                	pop    %r15
    14d1:	5d                   	pop    %rbp
    14d2:	e9 99 fb ff ff       	jmp    1070 <_ZdaPv@plt>
    14d7:	89 cb                	mov    %ecx,%ebx
    14d9:	49 89 d2             	mov    %rdx,%r10
    14dc:	ff c7                	inc    %edi
    14de:	45 01 f9             	add    %r15d,%r9d
    14e1:	41 01 d8             	add    %ebx,%r8d
    14e4:	39 7c 24 4c          	cmp    %edi,0x4c(%rsp)
    14e8:	0f 85 f7 fd ff ff    	jne    12e5 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x75>
    14ee:	c5 f8 77             	vzeroupper
    14f1:	eb ce                	jmp    14c1 <_Z29AVXVectorizedMultiplyMatricesPPdS0_S0_iiii+0x251>
    14f3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    14fa:	00 00 00 00 
    14fe:	66 90                	xchg   %ax,%ax

0000000000001500 <_Z32AVXVectorizedMultiplySubmatricesPdS_S_i>:
    1500:	85 c9                	test   %ecx,%ecx
    1502:	0f 8e c1 00 00 00    	jle    15c9 <_Z32AVXVectorizedMultiplySubmatricesPdS_S_i+0xc9>
    1508:	55                   	push   %rbp
    1509:	48 89 e5             	mov    %rsp,%rbp
    150c:	41 57                	push   %r15
    150e:	41 56                	push   %r14
    1510:	41 55                	push   %r13
    1512:	41 89 cd             	mov    %ecx,%r13d
    1515:	41 54                	push   %r12
    1517:	53                   	push   %rbx
    1518:	4c 63 f9             	movslq %ecx,%r15
    151b:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    151f:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
    1523:	49 89 f6             	mov    %rsi,%r14
    1526:	49 c1 e7 03          	shl    $0x3,%r15
    152a:	c1 eb 02             	shr    $0x2,%ebx
    152d:	48 83 ec 20          	sub    $0x20,%rsp
    1531:	49 89 d4             	mov    %rdx,%r12
    1534:	48 89 f9             	mov    %rdi,%rcx
    1537:	ff c3                	inc    %ebx
    1539:	4d 01 fe             	add    %r15,%r14
    153c:	48 c1 e3 05          	shl    $0x5,%rbx
    1540:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    1545:	31 db                	xor    %ebx,%ebx
    1547:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    154e:	00 00 
    1550:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    1555:	31 f6                	xor    %esi,%esi
    1557:	48 89 cf             	mov    %rcx,%rdi
    155a:	e8 f1 fa ff ff       	call   1050 <memset@plt>
    155f:	4c 89 f6             	mov    %r14,%rsi
    1562:	4c 89 e2             	mov    %r12,%rdx
    1565:	48 89 c1             	mov    %rax,%rcx
    1568:	4c 29 fe             	sub    %r15,%rsi
    156b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    1570:	c4 e2 7d 19 0e       	vbroadcastsd (%rsi),%ymm1
    1575:	31 c0                	xor    %eax,%eax
    1577:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    157e:	00 00 
    1580:	c5 fd 10 04 c2       	vmovupd (%rdx,%rax,8),%ymm0
    1585:	c4 e2 f5 a8 04 c1    	vfmadd213pd (%rcx,%rax,8),%ymm1,%ymm0
    158b:	c5 fd 11 04 c1       	vmovupd %ymm0,(%rcx,%rax,8)
    1590:	48 83 c0 04          	add    $0x4,%rax
    1594:	41 39 c5             	cmp    %eax,%r13d
    1597:	7f e7                	jg     1580 <_Z32AVXVectorizedMultiplySubmatricesPdS_S_i+0x80>
    1599:	48 83 c6 08          	add    $0x8,%rsi
    159d:	4c 01 fa             	add    %r15,%rdx
    15a0:	49 39 f6             	cmp    %rsi,%r14
    15a3:	75 cb                	jne    1570 <_Z32AVXVectorizedMultiplySubmatricesPdS_S_i+0x70>
    15a5:	ff c3                	inc    %ebx
    15a7:	4c 01 f9             	add    %r15,%rcx
    15aa:	4d 01 fe             	add    %r15,%r14
    15ad:	41 39 dd             	cmp    %ebx,%r13d
    15b0:	74 05                	je     15b7 <_Z32AVXVectorizedMultiplySubmatricesPdS_S_i+0xb7>
    15b2:	c5 f8 77             	vzeroupper
    15b5:	eb 99                	jmp    1550 <_Z32AVXVectorizedMultiplySubmatricesPdS_S_i+0x50>
    15b7:	c5 f8 77             	vzeroupper
    15ba:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    15be:	5b                   	pop    %rbx
    15bf:	41 5c                	pop    %r12
    15c1:	41 5d                	pop    %r13
    15c3:	41 5e                	pop    %r14
    15c5:	41 5f                	pop    %r15
    15c7:	5d                   	pop    %rbp
    15c8:	c3                   	ret
    15c9:	c3                   	ret
    15ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000015d0 <_Z12CreateMatrixPPdiiii>:
    15d0:	0f af f2             	imul   %edx,%esi
    15d3:	41 57                	push   %r15
    15d5:	41 56                	push   %r14
    15d7:	41 55                	push   %r13
    15d9:	41 89 cd             	mov    %ecx,%r13d
    15dc:	41 54                	push   %r12
    15de:	55                   	push   %rbp
    15df:	53                   	push   %rbx
    15e0:	48 83 ec 18          	sub    $0x18,%rsp
    15e4:	48 63 c6             	movslq %esi,%rax
    15e7:	48 89 c1             	mov    %rax,%rcx
    15ea:	48 c1 e9 3c          	shr    $0x3c,%rcx
    15ee:	0f 85 ac fa ff ff    	jne    10a0 <_Z12CreateMatrixPPdiiii.cold>
    15f4:	4c 8d 24 c5 00 00 00 	lea    0x0(,%rax,8),%r12
    15fb:	00 
    15fc:	44 89 c3             	mov    %r8d,%ebx
    15ff:	48 89 c5             	mov    %rax,%rbp
    1602:	4c 89 e7             	mov    %r12,%rdi
    1605:	e8 26 fa ff ff       	call   1030 <_Znam@plt>
    160a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    160f:	85 ed                	test   %ebp,%ebp
    1611:	0f 84 92 00 00 00    	je     16a9 <_Z12CreateMatrixPPdiiii+0xd9>
    1617:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    161c:	45 0f af ed          	imul   %r13d,%r13d
    1620:	49 63 ed             	movslq %r13d,%rbp
    1623:	48 c1 e5 03          	shl    $0x3,%rbp
    1627:	49 89 c6             	mov    %rax,%r14
    162a:	49 01 c4             	add    %rax,%r12
    162d:	0f 1f 00             	nopl   (%rax)
    1630:	48 89 ef             	mov    %rbp,%rdi
    1633:	e8 f8 f9 ff ff       	call   1030 <_Znam@plt>
    1638:	49 89 06             	mov    %rax,(%r14)
    163b:	45 85 ed             	test   %r13d,%r13d
    163e:	74 60                	je     16a0 <_Z12CreateMatrixPPdiiii+0xd0>
    1640:	45 31 ff             	xor    %r15d,%r15d
    1643:	eb 1d                	jmp    1662 <_Z12CreateMatrixPPdiiii+0x92>
    1645:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    164c:	00 00 00 00 
    1650:	49 8b 06             	mov    (%r14),%rax
    1653:	c4 a1 7b 11 04 38    	vmovsd %xmm0,(%rax,%r15,1)
    1659:	49 83 c7 08          	add    $0x8,%r15
    165d:	4c 39 fd             	cmp    %r15,%rbp
    1660:	74 3e                	je     16a0 <_Z12CreateMatrixPPdiiii+0xd0>
    1662:	c5 f9 57 c0          	vxorpd %xmm0,%xmm0,%xmm0
    1666:	85 db                	test   %ebx,%ebx
    1668:	74 e6                	je     1650 <_Z12CreateMatrixPPdiiii+0x80>
    166a:	e8 d1 f9 ff ff       	call   1040 <rand@plt>
    166f:	c5 f1 57 c9          	vxorpd %xmm1,%xmm1,%xmm1
    1673:	99                   	cltd
    1674:	f7 fb                	idiv   %ebx
    1676:	c5 f3 2a c2          	vcvtsi2sd %edx,%xmm1,%xmm0
    167a:	c5 fb 11 04 24       	vmovsd %xmm0,(%rsp)
    167f:	e8 bc f9 ff ff       	call   1040 <rand@plt>
    1684:	c5 f1 57 c9          	vxorpd %xmm1,%xmm1,%xmm1
    1688:	c5 f3 2a c0          	vcvtsi2sd %eax,%xmm1,%xmm0
    168c:	c5 fb 5e 05 74 09 00 	vdivsd 0x974(%rip),%xmm0,%xmm0        # 2008 <_IO_stdin_used+0x8>
    1693:	00 
    1694:	c5 fb 58 04 24       	vaddsd (%rsp),%xmm0,%xmm0
    1699:	eb b5                	jmp    1650 <_Z12CreateMatrixPPdiiii+0x80>
    169b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    16a0:	49 83 c6 08          	add    $0x8,%r14
    16a4:	4d 39 e6             	cmp    %r12,%r14
    16a7:	75 87                	jne    1630 <_Z12CreateMatrixPPdiiii+0x60>
    16a9:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    16ae:	48 83 c4 18          	add    $0x18,%rsp
    16b2:	5b                   	pop    %rbx
    16b3:	5d                   	pop    %rbp
    16b4:	41 5c                	pop    %r12
    16b6:	41 5d                	pop    %r13
    16b8:	41 5e                	pop    %r14
    16ba:	41 5f                	pop    %r15
    16bc:	c3                   	ret

Дизассемблирование раздела .fini:

00000000000016c0 <_fini>:
    16c0:	f3 0f 1e fa          	endbr64
    16c4:	48 83 ec 08          	sub    $0x8,%rsp
    16c8:	48 83 c4 08          	add    $0x8,%rsp
    16cc:	c3                   	ret

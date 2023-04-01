
auto_vectorization.out:     формат файла elf64-x86-64


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
    112d:	e8 3e 01 00 00       	call   1270 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii>
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

0000000000001270 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii>:
    1270:	55                   	push   %rbp
    1271:	48 89 e5             	mov    %rsp,%rbp
    1274:	41 57                	push   %r15
    1276:	41 56                	push   %r14
    1278:	41 55                	push   %r13
    127a:	41 54                	push   %r12
    127c:	53                   	push   %rbx
    127d:	41 89 cf             	mov    %ecx,%r15d
    1280:	45 89 c4             	mov    %r8d,%r12d
    1283:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
    1287:	44 89 cb             	mov    %r9d,%ebx
    128a:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
    128e:	89 4c 24 78          	mov    %ecx,0x78(%rsp)
    1292:	8b 4d 10             	mov    0x10(%rbp),%ecx
    1295:	48 89 7c 24 50       	mov    %rdi,0x50(%rsp)
    129a:	bf 00 08 00 00       	mov    $0x800,%edi
    129f:	48 89 74 24 48       	mov    %rsi,0x48(%rsp)
    12a4:	48 89 54 24 40       	mov    %rdx,0x40(%rsp)
    12a9:	89 4c 24 7c          	mov    %ecx,0x7c(%rsp)
    12ad:	e8 7e fd ff ff       	call   1030 <_Znam@plt>
    12b2:	49 89 c6             	mov    %rax,%r14
    12b5:	45 85 ff             	test   %r15d,%r15d
    12b8:	0f 8e fe 01 00 00    	jle    14bc <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x24c>
    12be:	49 63 f4             	movslq %r12d,%rsi
    12c1:	48 63 fb             	movslq %ebx,%rdi
    12c4:	45 31 d2             	xor    %r10d,%r10d
    12c7:	45 31 ed             	xor    %r13d,%r13d
    12ca:	48 8d 04 f5 00 00 00 	lea    0x0(,%rsi,8),%rax
    12d1:	00 
    12d2:	48 89 f1             	mov    %rsi,%rcx
    12d5:	45 31 c9             	xor    %r9d,%r9d
    12d8:	45 31 db             	xor    %r11d,%r11d
    12db:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    12e0:	48 63 44 24 7c       	movslq 0x7c(%rsp),%rax
    12e5:	89 de                	mov    %ebx,%esi
    12e7:	49 89 f8             	mov    %rdi,%r8
    12ea:	4c 8d 3c c5 00 00 00 	lea    0x0(,%rax,8),%r15
    12f1:	00 
    12f2:	45 85 e4             	test   %r12d,%r12d
    12f5:	0f 8e f6 01 00 00    	jle    14f1 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x281>
    12fb:	48 8b 5c 24 48       	mov    0x48(%rsp),%rbx
    1300:	49 63 d5             	movslq %r13d,%rdx
    1303:	48 8d 3c d3          	lea    (%rbx,%rdx,8),%rdi
    1307:	4c 01 c2             	add    %r8,%rdx
    130a:	48 8d 1c d3          	lea    (%rbx,%rdx,8),%rbx
    130e:	48 89 7c 24 60       	mov    %rdi,0x60(%rsp)
    1313:	31 d2                	xor    %edx,%edx
    1315:	48 89 5c 24 68       	mov    %rbx,0x68(%rsp)
    131a:	85 f6                	test   %esi,%esi
    131c:	0f 8e 77 01 00 00    	jle    1499 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x229>
    1322:	44 89 6c 24 3c       	mov    %r13d,0x3c(%rsp)
    1327:	44 89 4c 24 38       	mov    %r9d,0x38(%rsp)
    132c:	89 f3                	mov    %esi,%ebx
    132e:	89 d7                	mov    %edx,%edi
    1330:	44 89 54 24 7c       	mov    %r10d,0x7c(%rsp)
    1335:	44 89 64 24 34       	mov    %r12d,0x34(%rsp)
    133a:	48 89 ce             	mov    %rcx,%rsi
    133d:	41 89 c5             	mov    %eax,%r13d
    1340:	4d 89 c1             	mov    %r8,%r9
    1343:	8b 44 24 7c          	mov    0x7c(%rsp),%eax
    1347:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
    134c:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
    1351:	01 f8                	add    %edi,%eax
    1353:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
    1358:	48 98                	cltq
    135a:	48 8d 04 c7          	lea    (%rdi,%rax,8),%rax
    135e:	89 df                	mov    %ebx,%edi
    1360:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
    1365:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    136a:	4c 8d 14 d0          	lea    (%rax,%rdx,8),%r10
    136e:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
    1373:	48 89 c2             	mov    %rax,%rdx
    1376:	4c 89 c8             	mov    %r9,%rax
    1379:	49 8b 1a             	mov    (%r10),%rbx
    137c:	4c 8b 0a             	mov    (%rdx),%r9
    137f:	4c 89 f6             	mov    %r14,%rsi
    1382:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    1387:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
    138c:	49 89 c6             	mov    %rax,%r14
    138f:	41 89 fa             	mov    %edi,%r10d
    1392:	4d 8d a1 00 08 00 00 	lea    0x800(%r9),%r12
    1399:	4c 8d 83 00 08 00 00 	lea    0x800(%rbx),%r8
    13a0:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    13a4:	48 89 f1             	mov    %rsi,%rcx
    13a7:	4c 89 d8             	mov    %r11,%rax
    13aa:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    13b1:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    13b5:	48 c7 46 78 00 00 00 	movq   $0x0,0x78(%rsi)
    13bc:	00 
    13bd:	48 29 f9             	sub    %rdi,%rcx
    13c0:	83 e9 80             	sub    $0xffffff80,%ecx
    13c3:	c1 e9 03             	shr    $0x3,%ecx
    13c6:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    13c9:	48 89 d9             	mov    %rbx,%rcx
    13cc:	4c 89 cf             	mov    %r9,%rdi
    13cf:	90                   	nop
    13d0:	c4 e2 7d 19 0f       	vbroadcastsd (%rdi),%ymm1
    13d5:	31 c0                	xor    %eax,%eax
    13d7:	c5 fd 10 04 01       	vmovupd (%rcx,%rax,1),%ymm0
    13dc:	c4 e2 f5 a8 04 06    	vfmadd213pd (%rsi,%rax,1),%ymm1,%ymm0
    13e2:	c5 fd 11 04 06       	vmovupd %ymm0,(%rsi,%rax,1)
    13e7:	48 83 c0 20          	add    $0x20,%rax
    13eb:	48 3d 80 00 00 00    	cmp    $0x80,%rax
    13f1:	75 e4                	jne    13d7 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x167>
    13f3:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
    13f7:	48 83 c7 08          	add    $0x8,%rdi
    13fb:	49 39 c8             	cmp    %rcx,%r8
    13fe:	75 d0                	jne    13d0 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x160>
    1400:	49 83 e9 80          	sub    $0xffffffffffffff80,%r9
    1404:	48 83 ee 80          	sub    $0xffffffffffffff80,%rsi
    1408:	4d 39 cc             	cmp    %r9,%r12
    140b:	75 93                	jne    13a0 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x130>
    140d:	44 89 d7             	mov    %r10d,%edi
    1410:	4c 89 f0             	mov    %r14,%rax
    1413:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
    1418:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
    141d:	45 85 ed             	test   %r13d,%r13d
    1420:	7e 42                	jle    1464 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x1f4>
    1422:	48 8b 5c 24 70       	mov    0x70(%rsp),%rbx
    1427:	4d 89 f8             	mov    %r15,%r8
    142a:	45 31 c9             	xor    %r9d,%r9d
    142d:	48 8b 33             	mov    (%rbx),%rsi
    1430:	4c 89 c1             	mov    %r8,%rcx
    1433:	4c 29 f9             	sub    %r15,%rcx
    1436:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    143d:	00 00 00 
    1440:	c5 fb 10 04 0e       	vmovsd (%rsi,%rcx,1),%xmm0
    1445:	c4 c1 7b 58 04 0e    	vaddsd (%r14,%rcx,1),%xmm0,%xmm0
    144b:	c5 fb 11 04 0e       	vmovsd %xmm0,(%rsi,%rcx,1)
    1450:	48 83 c1 08          	add    $0x8,%rcx
    1454:	49 39 c8             	cmp    %rcx,%r8
    1457:	75 e7                	jne    1440 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x1d0>
    1459:	41 ff c1             	inc    %r9d
    145c:	4d 01 f8             	add    %r15,%r8
    145f:	45 39 cd             	cmp    %r9d,%r13d
    1462:	75 cc                	jne    1430 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x1c0>
    1464:	48 8b 5c 24 58       	mov    0x58(%rsp),%rbx
    1469:	48 83 c2 08          	add    $0x8,%rdx
    146d:	49 01 da             	add    %rbx,%r10
    1470:	48 39 54 24 68       	cmp    %rdx,0x68(%rsp)
    1475:	0f 85 fe fe ff ff    	jne    1379 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x109>
    147b:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
    1480:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    1485:	89 fb                	mov    %edi,%ebx
    1487:	49 89 c1             	mov    %rax,%r9
    148a:	48 ff c2             	inc    %rdx
    148d:	48 39 d6             	cmp    %rdx,%rsi
    1490:	74 40                	je     14d2 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x262>
    1492:	89 d7                	mov    %edx,%edi
    1494:	e9 aa fe ff ff       	jmp    1343 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0xd3>
    1499:	48 ff c2             	inc    %rdx
    149c:	48 39 ca             	cmp    %rcx,%rdx
    149f:	0f 85 75 fe ff ff    	jne    131a <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0xaa>
    14a5:	41 ff c1             	inc    %r9d
    14a8:	41 01 f5             	add    %esi,%r13d
    14ab:	45 01 e2             	add    %r12d,%r10d
    14ae:	44 39 4c 24 78       	cmp    %r9d,0x78(%rsp)
    14b3:	0f 85 39 fe ff ff    	jne    12f2 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x82>
    14b9:	c5 f8 77             	vzeroupper
    14bc:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    14c0:	4c 89 f7             	mov    %r14,%rdi
    14c3:	5b                   	pop    %rbx
    14c4:	41 5c                	pop    %r12
    14c6:	41 5d                	pop    %r13
    14c8:	41 5e                	pop    %r14
    14ca:	41 5f                	pop    %r15
    14cc:	5d                   	pop    %rbp
    14cd:	e9 9e fb ff ff       	jmp    1070 <_ZdaPv@plt>
    14d2:	44 89 e8             	mov    %r13d,%eax
    14d5:	4d 89 c8             	mov    %r9,%r8
    14d8:	44 8b 54 24 7c       	mov    0x7c(%rsp),%r10d
    14dd:	44 8b 64 24 34       	mov    0x34(%rsp),%r12d
    14e2:	44 8b 6c 24 3c       	mov    0x3c(%rsp),%r13d
    14e7:	44 8b 4c 24 38       	mov    0x38(%rsp),%r9d
    14ec:	48 89 f1             	mov    %rsi,%rcx
    14ef:	89 fe                	mov    %edi,%esi
    14f1:	41 ff c1             	inc    %r9d
    14f4:	41 01 f5             	add    %esi,%r13d
    14f7:	45 01 e2             	add    %r12d,%r10d
    14fa:	44 39 4c 24 78       	cmp    %r9d,0x78(%rsp)
    14ff:	0f 85 ed fd ff ff    	jne    12f2 <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x82>
    1505:	c5 f8 77             	vzeroupper
    1508:	eb b2                	jmp    14bc <_Z30AutoVectorizedMultiplyMatricesPPdS0_S0_iiii+0x24c>
    150a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000001510 <_Z33AutoVectorizedMultiplySubmatricesPdS_S_i>:
    1510:	85 c9                	test   %ecx,%ecx
    1512:	0f 8e aa 00 00 00    	jle    15c2 <_Z33AutoVectorizedMultiplySubmatricesPdS_S_i+0xb2>
    1518:	41 57                	push   %r15
    151a:	41 56                	push   %r14
    151c:	41 55                	push   %r13
    151e:	4c 63 e9             	movslq %ecx,%r13
    1521:	41 54                	push   %r12
    1523:	55                   	push   %rbp
    1524:	53                   	push   %rbx
    1525:	89 cb                	mov    %ecx,%ebx
    1527:	49 89 f6             	mov    %rsi,%r14
    152a:	49 c1 e5 03          	shl    $0x3,%r13
    152e:	89 dd                	mov    %ebx,%ebp
    1530:	48 83 ec 08          	sub    $0x8,%rsp
    1534:	49 89 d4             	mov    %rdx,%r12
    1537:	48 89 f9             	mov    %rdi,%rcx
    153a:	4d 01 ee             	add    %r13,%r14
    153d:	48 c1 e5 03          	shl    $0x3,%rbp
    1541:	45 31 ff             	xor    %r15d,%r15d
    1544:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    154b:	00 00 00 00 
    154f:	90                   	nop
    1550:	48 89 ea             	mov    %rbp,%rdx
    1553:	31 f6                	xor    %esi,%esi
    1555:	48 89 cf             	mov    %rcx,%rdi
    1558:	e8 f3 fa ff ff       	call   1050 <memset@plt>
    155d:	4c 89 f6             	mov    %r14,%rsi
    1560:	4c 89 e2             	mov    %r12,%rdx
    1563:	48 89 c1             	mov    %rax,%rcx
    1566:	4c 29 ee             	sub    %r13,%rsi
    1569:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1570:	c5 fb 10 0e          	vmovsd (%rsi),%xmm1
    1574:	31 c0                	xor    %eax,%eax
    1576:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    157d:	00 00 00 
    1580:	c5 fb 10 04 02       	vmovsd (%rdx,%rax,1),%xmm0
    1585:	c4 e2 f1 a9 04 01    	vfmadd213sd (%rcx,%rax,1),%xmm1,%xmm0
    158b:	c5 fb 11 04 01       	vmovsd %xmm0,(%rcx,%rax,1)
    1590:	48 83 c0 08          	add    $0x8,%rax
    1594:	49 39 c5             	cmp    %rax,%r13
    1597:	75 e7                	jne    1580 <_Z33AutoVectorizedMultiplySubmatricesPdS_S_i+0x70>
    1599:	48 83 c6 08          	add    $0x8,%rsi
    159d:	4c 01 ea             	add    %r13,%rdx
    15a0:	49 39 f6             	cmp    %rsi,%r14
    15a3:	75 cb                	jne    1570 <_Z33AutoVectorizedMultiplySubmatricesPdS_S_i+0x60>
    15a5:	41 ff c7             	inc    %r15d
    15a8:	4c 01 e9             	add    %r13,%rcx
    15ab:	4d 01 ee             	add    %r13,%r14
    15ae:	44 39 fb             	cmp    %r15d,%ebx
    15b1:	75 9d                	jne    1550 <_Z33AutoVectorizedMultiplySubmatricesPdS_S_i+0x40>
    15b3:	48 83 c4 08          	add    $0x8,%rsp
    15b7:	5b                   	pop    %rbx
    15b8:	5d                   	pop    %rbp
    15b9:	41 5c                	pop    %r12
    15bb:	41 5d                	pop    %r13
    15bd:	41 5e                	pop    %r14
    15bf:	41 5f                	pop    %r15
    15c1:	c3                   	ret
    15c2:	c3                   	ret
    15c3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    15ca:	00 00 00 00 
    15ce:	66 90                	xchg   %ax,%ax

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

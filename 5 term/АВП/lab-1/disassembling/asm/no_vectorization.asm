
no_vectorization.out:     формат файла elf64-x86-64


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
    112d:	e8 3e 01 00 00       	call   1270 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii>
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

0000000000001270 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii>:
    1270:	41 57                	push   %r15
    1272:	41 56                	push   %r14
    1274:	41 55                	push   %r13
    1276:	41 89 cf             	mov    %ecx,%r15d
    1279:	41 54                	push   %r12
    127b:	55                   	push   %rbp
    127c:	53                   	push   %rbx
    127d:	45 89 c4             	mov    %r8d,%r12d
    1280:	48 83 ec 78          	sub    $0x78,%rsp
    1284:	44 89 cd             	mov    %r9d,%ebp
    1287:	48 89 7c 24 20       	mov    %rdi,0x20(%rsp)
    128c:	bf 00 08 00 00       	mov    $0x800,%edi
    1291:	8b 9c 24 b0 00 00 00 	mov    0xb0(%rsp),%ebx
    1298:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    129d:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    12a2:	89 4c 24 3c          	mov    %ecx,0x3c(%rsp)
    12a6:	e8 85 fd ff ff       	call   1030 <_Znam@plt>
    12ab:	49 89 c0             	mov    %rax,%r8
    12ae:	45 85 ff             	test   %r15d,%r15d
    12b1:	0f 8e 1c 02 00 00    	jle    14d3 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x263>
    12b7:	4d 63 cc             	movslq %r12d,%r9
    12ba:	45 31 d2             	xor    %r10d,%r10d
    12bd:	45 31 ed             	xor    %r13d,%r13d
    12c0:	45 31 db             	xor    %r11d,%r11d
    12c3:	4a 8d 04 cd 00 00 00 	lea    0x0(,%r9,8),%rax
    12ca:	00 
    12cb:	44 89 d6             	mov    %r10d,%esi
    12ce:	48 63 cd             	movslq %ebp,%rcx
    12d1:	4d 89 ca             	mov    %r9,%r10
    12d4:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    12d9:	48 63 c3             	movslq %ebx,%rax
    12dc:	45 31 ff             	xor    %r15d,%r15d
    12df:	41 89 e9             	mov    %ebp,%r9d
    12e2:	4c 8d 34 c5 00 00 00 	lea    0x0(,%rax,8),%r14
    12e9:	00 
    12ea:	45 85 e4             	test   %r12d,%r12d
    12ed:	0f 8e 09 02 00 00    	jle    14fc <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x28c>
    12f3:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
    12f8:	49 63 c5             	movslq %r13d,%rax
    12fb:	48 8d 14 c7          	lea    (%rdi,%rax,8),%rdx
    12ff:	48 01 c8             	add    %rcx,%rax
    1302:	48 8d 04 c7          	lea    (%rdi,%rax,8),%rax
    1306:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
    130b:	31 d2                	xor    %edx,%edx
    130d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1312:	45 85 c9             	test   %r9d,%r9d
    1315:	0f 8e 98 01 00 00    	jle    14b3 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x243>
    131b:	44 89 6c 24 58       	mov    %r13d,0x58(%rsp)
    1320:	44 89 e5             	mov    %r12d,%ebp
    1323:	89 d0                	mov    %edx,%eax
    1325:	45 89 dd             	mov    %r11d,%r13d
    1328:	4d 89 d4             	mov    %r10,%r12
    132b:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
    1330:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    1335:	01 f0                	add    %esi,%eax
    1337:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    133c:	4c 89 e1             	mov    %r12,%rcx
    133f:	48 98                	cltq
    1341:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
    1346:	48 8d 04 c7          	lea    (%rdi,%rax,8),%rax
    134a:	44 89 ef             	mov    %r13d,%edi
    134d:	48 89 04 24          	mov    %rax,(%rsp)
    1351:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    1356:	4c 8d 14 d0          	lea    (%rax,%rdx,8),%r10
    135a:	89 e8                	mov    %ebp,%eax
    135c:	49 8b 2b             	mov    (%r11),%rbp
    135f:	4d 8b 2a             	mov    (%r10),%r13
    1362:	4c 89 c2             	mov    %r8,%rdx
    1365:	4c 89 44 24 50       	mov    %r8,0x50(%rsp)
    136a:	89 7c 24 5c          	mov    %edi,0x5c(%rsp)
    136e:	4c 89 5c 24 60       	mov    %r11,0x60(%rsp)
    1373:	48 89 4c 24 68       	mov    %rcx,0x68(%rsp)
    1378:	41 89 c0             	mov    %eax,%r8d
    137b:	4c 8d a5 00 08 00 00 	lea    0x800(%rbp),%r12
    1382:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1389:	00 00 00 00 
    138d:	0f 1f 00             	nopl   (%rax)
    1390:	48 8d 7a 08          	lea    0x8(%rdx),%rdi
    1394:	48 89 d1             	mov    %rdx,%rcx
    1397:	4c 89 f8             	mov    %r15,%rax
    139a:	48 c7 02 00 00 00 00 	movq   $0x0,(%rdx)
    13a1:	48 83 e7 f8          	and    $0xfffffffffffffff8,%rdi
    13a5:	48 c7 42 78 00 00 00 	movq   $0x0,0x78(%rdx)
    13ac:	00 
    13ad:	49 89 eb             	mov    %rbp,%r11
    13b0:	48 29 f9             	sub    %rdi,%rcx
    13b3:	83 e9 80             	sub    $0xffffff80,%ecx
    13b6:	c1 e9 03             	shr    $0x3,%ecx
    13b9:	f3 48 ab             	rep stos %rax,%es:(%rdi)
    13bc:	4c 89 e9             	mov    %r13,%rcx
    13bf:	31 ff                	xor    %edi,%edi
    13c1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    13c8:	00 00 00 00 
    13cc:	0f 1f 40 00          	nopl   0x0(%rax)
    13d0:	41 dd 03             	fldl   (%r11)
    13d3:	31 c0                	xor    %eax,%eax
    13d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    13dc:	00 00 00 00 
    13e0:	dd 04 01             	fldl   (%rcx,%rax,1)
    13e3:	d8 c9                	fmul   %st(1),%st
    13e5:	dc 04 02             	faddl  (%rdx,%rax,1)
    13e8:	dd 1c 02             	fstpl  (%rdx,%rax,1)
    13eb:	48 83 c0 08          	add    $0x8,%rax
    13ef:	48 3d 80 00 00 00    	cmp    $0x80,%rax
    13f5:	75 e9                	jne    13e0 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x170>
    13f7:	df c0                	ffreep %st(0)
    13f9:	48 83 c7 10          	add    $0x10,%rdi
    13fd:	49 83 c3 08          	add    $0x8,%r11
    1401:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
    1405:	48 81 ff 00 01 00 00 	cmp    $0x100,%rdi
    140c:	75 c2                	jne    13d0 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x160>
    140e:	48 83 ed 80          	sub    $0xffffffffffffff80,%rbp
    1412:	48 83 ea 80          	sub    $0xffffffffffffff80,%rdx
    1416:	49 39 ec             	cmp    %rbp,%r12
    1419:	0f 85 71 ff ff ff    	jne    1390 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x120>
    141f:	44 89 c0             	mov    %r8d,%eax
    1422:	8b 7c 24 5c          	mov    0x5c(%rsp),%edi
    1426:	4c 8b 5c 24 60       	mov    0x60(%rsp),%r11
    142b:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
    1430:	4c 8b 44 24 50       	mov    0x50(%rsp),%r8
    1435:	85 db                	test   %ebx,%ebx
    1437:	7e 47                	jle    1480 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x210>
    1439:	48 8b 14 24          	mov    (%rsp),%rdx
    143d:	4d 89 f4             	mov    %r14,%r12
    1440:	45 31 ed             	xor    %r13d,%r13d
    1443:	48 8b 2a             	mov    (%rdx),%rbp
    1446:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    144d:	00 00 00 
    1450:	4c 89 e2             	mov    %r12,%rdx
    1453:	4c 29 f2             	sub    %r14,%rdx
    1456:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    145d:	00 00 00 
    1460:	dd 44 15 00          	fldl   0x0(%rbp,%rdx,1)
    1464:	41 dc 04 10          	faddl  (%r8,%rdx,1)
    1468:	dd 5c 15 00          	fstpl  0x0(%rbp,%rdx,1)
    146c:	48 83 c2 08          	add    $0x8,%rdx
    1470:	4c 39 e2             	cmp    %r12,%rdx
    1473:	75 eb                	jne    1460 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x1f0>
    1475:	41 ff c5             	inc    %r13d
    1478:	4d 01 f4             	add    %r14,%r12
    147b:	44 39 eb             	cmp    %r13d,%ebx
    147e:	75 d0                	jne    1450 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x1e0>
    1480:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    1485:	49 83 c3 08          	add    $0x8,%r11
    1489:	49 01 d2             	add    %rdx,%r10
    148c:	4c 39 5c 24 08       	cmp    %r11,0x8(%rsp)
    1491:	0f 85 c5 fe ff ff    	jne    135c <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0xec>
    1497:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    149c:	41 89 fd             	mov    %edi,%r13d
    149f:	49 89 cc             	mov    %rcx,%r12
    14a2:	89 c5                	mov    %eax,%ebp
    14a4:	48 ff c2             	inc    %rdx
    14a7:	48 39 d1             	cmp    %rdx,%rcx
    14aa:	74 3d                	je     14e9 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x279>
    14ac:	89 d0                	mov    %edx,%eax
    14ae:	e9 7d fe ff ff       	jmp    1330 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0xc0>
    14b3:	48 ff c2             	inc    %rdx
    14b6:	4c 39 d2             	cmp    %r10,%rdx
    14b9:	0f 85 53 fe ff ff    	jne    1312 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0xa2>
    14bf:	41 ff c3             	inc    %r11d
    14c2:	45 01 cd             	add    %r9d,%r13d
    14c5:	44 01 e6             	add    %r12d,%esi
    14c8:	44 39 5c 24 3c       	cmp    %r11d,0x3c(%rsp)
    14cd:	0f 85 17 fe ff ff    	jne    12ea <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x7a>
    14d3:	48 83 c4 78          	add    $0x78,%rsp
    14d7:	4c 89 c7             	mov    %r8,%rdi
    14da:	5b                   	pop    %rbx
    14db:	5d                   	pop    %rbp
    14dc:	41 5c                	pop    %r12
    14de:	41 5d                	pop    %r13
    14e0:	41 5e                	pop    %r14
    14e2:	41 5f                	pop    %r15
    14e4:	e9 87 fb ff ff       	jmp    1070 <_ZdaPv@plt>
    14e9:	49 89 ca             	mov    %rcx,%r10
    14ec:	44 8b 6c 24 58       	mov    0x58(%rsp),%r13d
    14f1:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
    14f6:	41 89 fb             	mov    %edi,%r11d
    14f9:	41 89 c4             	mov    %eax,%r12d
    14fc:	41 ff c3             	inc    %r11d
    14ff:	45 01 cd             	add    %r9d,%r13d
    1502:	44 01 e6             	add    %r12d,%esi
    1505:	44 39 5c 24 3c       	cmp    %r11d,0x3c(%rsp)
    150a:	0f 85 da fd ff ff    	jne    12ea <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x7a>
    1510:	eb c1                	jmp    14d3 <_Z29NotVectorizedMultiplyMatricesPPdS0_S0_iiii+0x263>
    1512:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1519:	00 00 00 00 
    151d:	0f 1f 00             	nopl   (%rax)

0000000000001520 <_Z32NotVectorizedMultiplySubmatricesPdS_S_i>:
    1520:	85 c9                	test   %ecx,%ecx
    1522:	0f 8e a7 00 00 00    	jle    15cf <_Z32NotVectorizedMultiplySubmatricesPdS_S_i+0xaf>
    1528:	41 57                	push   %r15
    152a:	41 56                	push   %r14
    152c:	41 55                	push   %r13
    152e:	4c 63 e9             	movslq %ecx,%r13
    1531:	41 54                	push   %r12
    1533:	55                   	push   %rbp
    1534:	53                   	push   %rbx
    1535:	89 cb                	mov    %ecx,%ebx
    1537:	49 89 f6             	mov    %rsi,%r14
    153a:	49 c1 e5 03          	shl    $0x3,%r13
    153e:	41 89 dc             	mov    %ebx,%r12d
    1541:	48 83 ec 08          	sub    $0x8,%rsp
    1545:	48 89 d5             	mov    %rdx,%rbp
    1548:	48 89 f9             	mov    %rdi,%rcx
    154b:	4d 01 ee             	add    %r13,%r14
    154e:	49 c1 e4 03          	shl    $0x3,%r12
    1552:	45 31 ff             	xor    %r15d,%r15d
    1555:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    155c:	00 00 00 00 
    1560:	4c 89 e2             	mov    %r12,%rdx
    1563:	31 f6                	xor    %esi,%esi
    1565:	48 89 cf             	mov    %rcx,%rdi
    1568:	e8 e3 fa ff ff       	call   1050 <memset@plt>
    156d:	4c 89 f6             	mov    %r14,%rsi
    1570:	48 89 ea             	mov    %rbp,%rdx
    1573:	48 89 c1             	mov    %rax,%rcx
    1576:	4c 29 ee             	sub    %r13,%rsi
    1579:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1580:	dd 06                	fldl   (%rsi)
    1582:	31 c0                	xor    %eax,%eax
    1584:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    158b:	00 00 00 00 
    158f:	90                   	nop
    1590:	dd 04 02             	fldl   (%rdx,%rax,1)
    1593:	d8 c9                	fmul   %st(1),%st
    1595:	dc 04 01             	faddl  (%rcx,%rax,1)
    1598:	dd 1c 01             	fstpl  (%rcx,%rax,1)
    159b:	48 83 c0 08          	add    $0x8,%rax
    159f:	4c 39 e8             	cmp    %r13,%rax
    15a2:	75 ec                	jne    1590 <_Z32NotVectorizedMultiplySubmatricesPdS_S_i+0x70>
    15a4:	df c0                	ffreep %st(0)
    15a6:	48 83 c6 08          	add    $0x8,%rsi
    15aa:	4c 01 ea             	add    %r13,%rdx
    15ad:	49 39 f6             	cmp    %rsi,%r14
    15b0:	75 ce                	jne    1580 <_Z32NotVectorizedMultiplySubmatricesPdS_S_i+0x60>
    15b2:	41 ff c7             	inc    %r15d
    15b5:	4c 01 e9             	add    %r13,%rcx
    15b8:	4d 01 ee             	add    %r13,%r14
    15bb:	44 39 fb             	cmp    %r15d,%ebx
    15be:	75 a0                	jne    1560 <_Z32NotVectorizedMultiplySubmatricesPdS_S_i+0x40>
    15c0:	48 83 c4 08          	add    $0x8,%rsp
    15c4:	5b                   	pop    %rbx
    15c5:	5d                   	pop    %rbp
    15c6:	41 5c                	pop    %r12
    15c8:	41 5d                	pop    %r13
    15ca:	41 5e                	pop    %r14
    15cc:	41 5f                	pop    %r15
    15ce:	c3                   	ret
    15cf:	c3                   	ret

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

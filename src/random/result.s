
result：     文件格式 elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	48 83 ec 08          	sub    $0x8,%rsp
    1008:	48 8b 05 d9 2f 00 00 	mov    0x2fd9(%rip),%rax        # 3fe8 <__gmon_start__>
    100f:	48 85 c0             	test   %rax,%rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	callq  *%rax
    1016:	48 83 c4 08          	add    $0x8,%rsp
    101a:	c3                   	retq   

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 7a 2f 00 00    	pushq  0x2f7a(%rip)        # 3fa0 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	f2 ff 25 7b 2f 00 00 	bnd jmpq *0x2f7b(%rip)        # 3fa8 <_GLOBAL_OFFSET_TABLE_+0x10>
    102d:	0f 1f 00             	nopl   (%rax)
    1030:	f3 0f 1e fa          	endbr64 
    1034:	68 00 00 00 00       	pushq  $0x0
    1039:	f2 e9 e1 ff ff ff    	bnd jmpq 1020 <.plt>
    103f:	90                   	nop
    1040:	f3 0f 1e fa          	endbr64 
    1044:	68 01 00 00 00       	pushq  $0x1
    1049:	f2 e9 d1 ff ff ff    	bnd jmpq 1020 <.plt>
    104f:	90                   	nop
    1050:	f3 0f 1e fa          	endbr64 
    1054:	68 02 00 00 00       	pushq  $0x2
    1059:	f2 e9 c1 ff ff ff    	bnd jmpq 1020 <.plt>
    105f:	90                   	nop
    1060:	f3 0f 1e fa          	endbr64 
    1064:	68 03 00 00 00       	pushq  $0x3
    1069:	f2 e9 b1 ff ff ff    	bnd jmpq 1020 <.plt>
    106f:	90                   	nop
    1070:	f3 0f 1e fa          	endbr64 
    1074:	68 04 00 00 00       	pushq  $0x4
    1079:	f2 e9 a1 ff ff ff    	bnd jmpq 1020 <.plt>
    107f:	90                   	nop

Disassembly of section .plt.got:

0000000000001080 <__cxa_finalize@plt>:
    1080:	f3 0f 1e fa          	endbr64 
    1084:	f2 ff 25 6d 2f 00 00 	bnd jmpq *0x2f6d(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    108b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

Disassembly of section .plt.sec:

0000000000001090 <puts@plt>:
    1090:	f3 0f 1e fa          	endbr64 
    1094:	f2 ff 25 15 2f 00 00 	bnd jmpq *0x2f15(%rip)        # 3fb0 <puts@GLIBC_2.2.5>
    109b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000010a0 <printf@plt>:
    10a0:	f3 0f 1e fa          	endbr64 
    10a4:	f2 ff 25 0d 2f 00 00 	bnd jmpq *0x2f0d(%rip)        # 3fb8 <printf@GLIBC_2.2.5>
    10ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000010b0 <syscall@plt>:
    10b0:	f3 0f 1e fa          	endbr64 
    10b4:	f2 ff 25 05 2f 00 00 	bnd jmpq *0x2f05(%rip)        # 3fc0 <syscall@GLIBC_2.2.5>
    10bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000010c0 <malloc@plt>:
    10c0:	f3 0f 1e fa          	endbr64 
    10c4:	f2 ff 25 fd 2e 00 00 	bnd jmpq *0x2efd(%rip)        # 3fc8 <malloc@GLIBC_2.2.5>
    10cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000010d0 <sleep@plt>:
    10d0:	f3 0f 1e fa          	endbr64 
    10d4:	f2 ff 25 f5 2e 00 00 	bnd jmpq *0x2ef5(%rip)        # 3fd0 <sleep@GLIBC_2.2.5>
    10db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

Disassembly of section .text:

00000000000010e0 <_start>:
    10e0:	f3 0f 1e fa          	endbr64 
    10e4:	31 ed                	xor    %ebp,%ebp
    10e6:	49 89 d1             	mov    %rdx,%r9
    10e9:	5e                   	pop    %rsi
    10ea:	48 89 e2             	mov    %rsp,%rdx
    10ed:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    10f1:	50                   	push   %rax
    10f2:	54                   	push   %rsp
    10f3:	4c 8d 05 06 07 00 00 	lea    0x706(%rip),%r8        # 1800 <__libc_csu_fini>
    10fa:	48 8d 0d 8f 06 00 00 	lea    0x68f(%rip),%rcx        # 1790 <__libc_csu_init>
    1101:	48 8d 3d ba 05 00 00 	lea    0x5ba(%rip),%rdi        # 16c2 <main>
    1108:	ff 15 d2 2e 00 00    	callq  *0x2ed2(%rip)        # 3fe0 <__libc_start_main@GLIBC_2.2.5>
    110e:	f4                   	hlt    
    110f:	90                   	nop

0000000000001110 <deregister_tm_clones>:
    1110:	48 8d 3d f9 2e 00 00 	lea    0x2ef9(%rip),%rdi        # 4010 <__TMC_END__>
    1117:	48 8d 05 f2 2e 00 00 	lea    0x2ef2(%rip),%rax        # 4010 <__TMC_END__>
    111e:	48 39 f8             	cmp    %rdi,%rax
    1121:	74 15                	je     1138 <deregister_tm_clones+0x28>
    1123:	48 8b 05 ae 2e 00 00 	mov    0x2eae(%rip),%rax        # 3fd8 <_ITM_deregisterTMCloneTable>
    112a:	48 85 c0             	test   %rax,%rax
    112d:	74 09                	je     1138 <deregister_tm_clones+0x28>
    112f:	ff e0                	jmpq   *%rax
    1131:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1138:	c3                   	retq   
    1139:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001140 <register_tm_clones>:
    1140:	48 8d 3d c9 2e 00 00 	lea    0x2ec9(%rip),%rdi        # 4010 <__TMC_END__>
    1147:	48 8d 35 c2 2e 00 00 	lea    0x2ec2(%rip),%rsi        # 4010 <__TMC_END__>
    114e:	48 29 fe             	sub    %rdi,%rsi
    1151:	48 89 f0             	mov    %rsi,%rax
    1154:	48 c1 ee 3f          	shr    $0x3f,%rsi
    1158:	48 c1 f8 03          	sar    $0x3,%rax
    115c:	48 01 c6             	add    %rax,%rsi
    115f:	48 d1 fe             	sar    %rsi
    1162:	74 14                	je     1178 <register_tm_clones+0x38>
    1164:	48 8b 05 85 2e 00 00 	mov    0x2e85(%rip),%rax        # 3ff0 <_ITM_registerTMCloneTable>
    116b:	48 85 c0             	test   %rax,%rax
    116e:	74 08                	je     1178 <register_tm_clones+0x38>
    1170:	ff e0                	jmpq   *%rax
    1172:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1178:	c3                   	retq   
    1179:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001180 <__do_global_dtors_aux>:
    1180:	f3 0f 1e fa          	endbr64 
    1184:	80 3d 85 2e 00 00 00 	cmpb   $0x0,0x2e85(%rip)        # 4010 <__TMC_END__>
    118b:	75 2b                	jne    11b8 <__do_global_dtors_aux+0x38>
    118d:	55                   	push   %rbp
    118e:	48 83 3d 62 2e 00 00 	cmpq   $0x0,0x2e62(%rip)        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1195:	00 
    1196:	48 89 e5             	mov    %rsp,%rbp
    1199:	74 0c                	je     11a7 <__do_global_dtors_aux+0x27>
    119b:	48 8b 3d 66 2e 00 00 	mov    0x2e66(%rip),%rdi        # 4008 <__dso_handle>
    11a2:	e8 d9 fe ff ff       	callq  1080 <__cxa_finalize@plt>
    11a7:	e8 64 ff ff ff       	callq  1110 <deregister_tm_clones>
    11ac:	c6 05 5d 2e 00 00 01 	movb   $0x1,0x2e5d(%rip)        # 4010 <__TMC_END__>
    11b3:	5d                   	pop    %rbp
    11b4:	c3                   	retq   
    11b5:	0f 1f 00             	nopl   (%rax)
    11b8:	c3                   	retq   
    11b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000011c0 <frame_dummy>:
    11c0:	f3 0f 1e fa          	endbr64 
    11c4:	e9 77 ff ff ff       	jmpq   1140 <register_tm_clones>

00000000000011c9 <fun1>:
    11c9:	f3 0f 1e fa          	endbr64 
    11cd:	55                   	push   %rbp
    11ce:	48 89 e5             	mov    %rsp,%rbp
    11d1:	b8 01 00 00 00       	mov    $0x1,%eax
    11d6:	5d                   	pop    %rbp
    11d7:	c3                   	retq   

00000000000011d8 <fun3>:
    11d8:	f3 0f 1e fa          	endbr64 
    11dc:	55                   	push   %rbp
    11dd:	48 89 e5             	mov    %rsp,%rbp
    11e0:	b8 03 00 00 00       	mov    $0x3,%eax
    11e5:	5d                   	pop    %rbp
    11e6:	c3                   	retq   

00000000000011e7 <fun2>:
    11e7:	f3 0f 1e fa          	endbr64 
    11eb:	55                   	push   %rbp
    11ec:	48 89 e5             	mov    %rsp,%rbp
    11ef:	48 83 ec 30          	sub    $0x30,%rsp
    11f3:	c7 45 d0 02 00 00 00 	movl   $0x2,-0x30(%rbp)
    11fa:	bf 04 00 00 00       	mov    $0x4,%edi
    11ff:	e8 bc fe ff ff       	callq  10c0 <malloc@plt>
    1204:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1208:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    120c:	8b 55 d0             	mov    -0x30(%rbp),%edx
    120f:	89 10                	mov    %edx,(%rax)
    1211:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    1215:	74 0e                	je     1225 <fun2+0x3e>
    1217:	48 8d 3d e6 0d 00 00 	lea    0xde6(%rip),%rdi        # 2004 <_IO_stdin_used+0x4>
    121e:	e8 6d fe ff ff       	callq  1090 <puts@plt>
    1223:	eb 0c                	jmp    1231 <fun2+0x4a>
    1225:	48 8d 3d dc 0d 00 00 	lea    0xddc(%rip),%rdi        # 2008 <_IO_stdin_used+0x8>
    122c:	e8 5f fe ff ff       	callq  1090 <puts@plt>
    1231:	bf ba 00 00 00       	mov    $0xba,%edi
    1236:	b8 00 00 00 00       	mov    $0x0,%eax
    123b:	e8 70 fe ff ff       	callq  10b0 <syscall@plt>
    1240:	89 45 e8             	mov    %eax,-0x18(%rbp)
    1243:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
    124a:	e9 6e 02 00 00       	jmpq   14bd <fun2+0x2d6>
    124f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1256:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    125d:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1264:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    126b:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1272:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1279:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1280:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1287:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    128e:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1295:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    129c:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12a3:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12aa:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12b1:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12b8:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12bf:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12c6:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12cd:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12d4:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12db:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12e2:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12e9:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12f0:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12f7:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12fe:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1305:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    130c:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1313:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    131a:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1321:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1328:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    132f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1336:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    133d:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1344:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    134b:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
    134f:	7e 06                	jle    1357 <fun2+0x170>
    1351:	83 45 d0 01          	addl   $0x1,-0x30(%rbp)
    1355:	eb 04                	jmp    135b <fun2+0x174>
    1357:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
    135b:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1362:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1369:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1370:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1377:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    137e:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1385:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    138c:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1393:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    139a:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13a1:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13a8:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13af:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13b6:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13bd:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13c4:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13cb:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13d2:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13d9:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13e0:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13e7:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13ee:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13f5:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13fc:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1403:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    140a:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1411:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1418:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    141f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1426:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    142d:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1434:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    143b:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1442:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1449:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1450:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1457:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    145e:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1465:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    146c:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1473:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    147a:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1481:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1488:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    148f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1496:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    149d:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14a4:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14ab:	83 45 d8 01          	addl   $0x1,-0x28(%rbp)
    14af:	83 7d d8 04          	cmpl   $0x4,-0x28(%rbp)
    14b3:	0f 8e 96 fd ff ff    	jle    124f <fun2+0x68>
    14b9:	83 45 d4 01          	addl   $0x1,-0x2c(%rbp)
    14bd:	83 7d d4 04          	cmpl   $0x4,-0x2c(%rbp)
    14c1:	0f 8e cc 01 00 00    	jle    1693 <fun2+0x4ac>
    14c7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    14cb:	74 09                	je     14d6 <fun2+0x2ef>
    14cd:	83 45 e4 01          	addl   $0x1,-0x1c(%rbp)
    14d1:	e9 d9 00 00 00       	jmpq   15af <fun2+0x3c8>
    14d6:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    14dd:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    14e4:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    14eb:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    14f2:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    14f9:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1500:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1507:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    150e:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1515:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    151c:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1523:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    152a:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1531:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1538:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    153f:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1546:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    154d:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1554:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    155b:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1562:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1569:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1570:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1577:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    157e:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1585:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    158c:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1593:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    159a:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15a1:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15a8:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15af:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
    15b6:	eb 40                	jmp    15f8 <fun2+0x411>
    15b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15bc:	8b 10                	mov    (%rax),%edx
    15be:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15c1:	89 c6                	mov    %eax,%esi
    15c3:	48 8d 3d 42 0a 00 00 	lea    0xa42(%rip),%rdi        # 200c <_IO_stdin_used+0xc>
    15ca:	b8 00 00 00 00       	mov    $0x0,%eax
    15cf:	e8 cc fa ff ff       	callq  10a0 <printf@plt>
    15d4:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15d7:	89 c6                	mov    %eax,%esi
    15d9:	48 8d 3d 36 0a 00 00 	lea    0xa36(%rip),%rdi        # 2016 <_IO_stdin_used+0x16>
    15e0:	b8 00 00 00 00       	mov    $0x0,%eax
    15e5:	e8 b6 fa ff ff       	callq  10a0 <printf@plt>
    15ea:	bf 01 00 00 00       	mov    $0x1,%edi
    15ef:	e8 dc fa ff ff       	callq  10d0 <sleep@plt>
    15f4:	83 45 dc 01          	addl   $0x1,-0x24(%rbp)
    15f8:	83 7d dc 04          	cmpl   $0x4,-0x24(%rbp)
    15fc:	7e ba                	jle    15b8 <fun2+0x3d1>
    15fe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    1605:	eb 2f                	jmp    1636 <fun2+0x44f>
    1607:	8b 05 07 2a 00 00    	mov    0x2a07(%rip),%eax        # 4014 <mutex>
    160d:	83 c0 01             	add    $0x1,%eax
    1610:	89 05 fe 29 00 00    	mov    %eax,0x29fe(%rip)        # 4014 <mutex>
    1616:	8b 15 f8 29 00 00    	mov    0x29f8(%rip),%edx        # 4014 <mutex>
    161c:	8b 45 e8             	mov    -0x18(%rbp),%eax
    161f:	89 c6                	mov    %eax,%esi
    1621:	48 8d 3d 02 0a 00 00 	lea    0xa02(%rip),%rdi        # 202a <_IO_stdin_used+0x2a>
    1628:	b8 00 00 00 00       	mov    $0x0,%eax
    162d:	e8 6e fa ff ff       	callq  10a0 <printf@plt>
    1632:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
    1636:	83 7d e0 09          	cmpl   $0x9,-0x20(%rbp)
    163a:	7e cb                	jle    1607 <fun2+0x420>
    163c:	48 8b 05 d5 29 00 00 	mov    0x29d5(%rip),%rax        # 4018 <mutex2>
    1643:	8b 10                	mov    (%rax),%edx
    1645:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1648:	89 c6                	mov    %eax,%esi
    164a:	48 8d 3d d9 09 00 00 	lea    0x9d9(%rip),%rdi        # 202a <_IO_stdin_used+0x2a>
    1651:	b8 00 00 00 00       	mov    $0x0,%eax
    1656:	e8 45 fa ff ff       	callq  10a0 <printf@plt>
    165b:	48 8b 05 b6 29 00 00 	mov    0x29b6(%rip),%rax        # 4018 <mutex2>
    1662:	c7 00 0c 00 00 00    	movl   $0xc,(%rax)
    1668:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    166c:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
    1672:	48 8d 05 9b 29 00 00 	lea    0x299b(%rip),%rax        # 4014 <mutex>
    1679:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    167d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1681:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
    1687:	b8 00 00 00 00       	mov    $0x0,%eax
    168c:	e8 47 fb ff ff       	callq  11d8 <fun3>
    1691:	c9                   	leaveq 
    1692:	c3                   	retq   
    1693:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    169a:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    16a1:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    16a8:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    16af:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    16b6:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
    16bd:	e9 ed fd ff ff       	jmpq   14af <fun2+0x2c8>

00000000000016c2 <main>:
    16c2:	f3 0f 1e fa          	endbr64 
    16c6:	55                   	push   %rbp
    16c7:	48 89 e5             	mov    %rsp,%rbp
    16ca:	53                   	push   %rbx
    16cb:	48 83 ec 18          	sub    $0x18,%rsp
    16cf:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
    16d6:	44 8b 45 ec          	mov    -0x14(%rbp),%r8d
    16da:	8b 7d ec             	mov    -0x14(%rbp),%edi
    16dd:	8b 4d ec             	mov    -0x14(%rbp),%ecx
    16e0:	8b 55 ec             	mov    -0x14(%rbp),%edx
    16e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16e6:	8b 75 ec             	mov    -0x14(%rbp),%esi
    16e9:	56                   	push   %rsi
    16ea:	8b 75 ec             	mov    -0x14(%rbp),%esi
    16ed:	56                   	push   %rsi
    16ee:	8b 75 ec             	mov    -0x14(%rbp),%esi
    16f1:	56                   	push   %rsi
    16f2:	8b 75 ec             	mov    -0x14(%rbp),%esi
    16f5:	56                   	push   %rsi
    16f6:	45 89 c1             	mov    %r8d,%r9d
    16f9:	41 89 f8             	mov    %edi,%r8d
    16fc:	89 c6                	mov    %eax,%esi
    16fe:	48 8d 3d 2e 09 00 00 	lea    0x92e(%rip),%rdi        # 2033 <_IO_stdin_used+0x33>
    1705:	b8 00 00 00 00       	mov    $0x0,%eax
    170a:	e8 91 f9 ff ff       	callq  10a0 <printf@plt>
    170f:	48 83 c4 20          	add    $0x20,%rsp
    1713:	bf 04 00 00 00       	mov    $0x4,%edi
    1718:	e8 a3 f9 ff ff       	callq  10c0 <malloc@plt>
    171d:	48 89 05 f4 28 00 00 	mov    %rax,0x28f4(%rip)        # 4018 <mutex2>
    1724:	48 8b 05 ed 28 00 00 	mov    0x28ed(%rip),%rax        # 4018 <mutex2>
    172b:	c7 00 04 00 00 00    	movl   $0x4,(%rax)
    1731:	bf 05 00 00 00       	mov    $0x5,%edi
    1736:	e8 95 f9 ff ff       	callq  10d0 <sleep@plt>
    173b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
    1742:	eb 33                	jmp    1777 <main+0xb5>
    1744:	8b 1d ca 28 00 00    	mov    0x28ca(%rip),%ebx        # 4014 <mutex>
    174a:	b8 00 00 00 00       	mov    $0x0,%eax
    174f:	e8 75 fa ff ff       	callq  11c9 <fun1>
    1754:	89 da                	mov    %ebx,%edx
    1756:	89 c6                	mov    %eax,%esi
    1758:	48 8d 3d f1 08 00 00 	lea    0x8f1(%rip),%rdi        # 2050 <_IO_stdin_used+0x50>
    175f:	b8 00 00 00 00       	mov    $0x0,%eax
    1764:	e8 37 f9 ff ff       	callq  10a0 <printf@plt>
    1769:	bf 05 00 00 00       	mov    $0x5,%edi
    176e:	e8 5d f9 ff ff       	callq  10d0 <sleep@plt>
    1773:	83 45 e8 01          	addl   $0x1,-0x18(%rbp)
    1777:	83 7d e8 07          	cmpl   $0x7,-0x18(%rbp)
    177b:	7e c7                	jle    1744 <main+0x82>
    177d:	b8 00 00 00 00       	mov    $0x0,%eax
    1782:	e8 60 fa ff ff       	callq  11e7 <fun2>
    1787:	eb a8                	jmp    1731 <main+0x6f>
    1789:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001790 <__libc_csu_init>:
    1790:	f3 0f 1e fa          	endbr64 
    1794:	41 57                	push   %r15
    1796:	4c 8d 3d fb 25 00 00 	lea    0x25fb(%rip),%r15        # 3d98 <__frame_dummy_init_array_entry>
    179d:	41 56                	push   %r14
    179f:	49 89 d6             	mov    %rdx,%r14
    17a2:	41 55                	push   %r13
    17a4:	49 89 f5             	mov    %rsi,%r13
    17a7:	41 54                	push   %r12
    17a9:	41 89 fc             	mov    %edi,%r12d
    17ac:	55                   	push   %rbp
    17ad:	48 8d 2d ec 25 00 00 	lea    0x25ec(%rip),%rbp        # 3da0 <__do_global_dtors_aux_fini_array_entry>
    17b4:	53                   	push   %rbx
    17b5:	4c 29 fd             	sub    %r15,%rbp
    17b8:	48 83 ec 08          	sub    $0x8,%rsp
    17bc:	e8 3f f8 ff ff       	callq  1000 <_init>
    17c1:	48 c1 fd 03          	sar    $0x3,%rbp
    17c5:	74 1f                	je     17e6 <__libc_csu_init+0x56>
    17c7:	31 db                	xor    %ebx,%ebx
    17c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    17d0:	4c 89 f2             	mov    %r14,%rdx
    17d3:	4c 89 ee             	mov    %r13,%rsi
    17d6:	44 89 e7             	mov    %r12d,%edi
    17d9:	41 ff 14 df          	callq  *(%r15,%rbx,8)
    17dd:	48 83 c3 01          	add    $0x1,%rbx
    17e1:	48 39 dd             	cmp    %rbx,%rbp
    17e4:	75 ea                	jne    17d0 <__libc_csu_init+0x40>
    17e6:	48 83 c4 08          	add    $0x8,%rsp
    17ea:	5b                   	pop    %rbx
    17eb:	5d                   	pop    %rbp
    17ec:	41 5c                	pop    %r12
    17ee:	41 5d                	pop    %r13
    17f0:	41 5e                	pop    %r14
    17f2:	41 5f                	pop    %r15
    17f4:	c3                   	retq   
    17f5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
    17fc:	00 00 00 00 

0000000000001800 <__libc_csu_fini>:
    1800:	f3 0f 1e fa          	endbr64 
    1804:	c3                   	retq   

Disassembly of section .fini:

0000000000001808 <_fini>:
    1808:	f3 0f 1e fa          	endbr64 
    180c:	48 83 ec 08          	sub    $0x8,%rsp
    1810:	48 83 c4 08          	add    $0x8,%rsp
    1814:	c3                   	retq   

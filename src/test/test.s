
a.out：     文件格式 elf64-x86-64


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
    124a:	e9 9d 02 00 00       	jmpq   14ec <fun2+0x305>
    124f:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    1256:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    125d:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    1264:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    126b:	c7 45 f0 09 00 00 00 	movl   $0x9,-0x10(%rbp)
    1272:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%rbp)
    1279:	e9 60 02 00 00       	jmpq   14de <fun2+0x2f7>
    127e:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1285:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    128c:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1293:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    129a:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12a1:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12a8:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12af:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12b6:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12bd:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12c4:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12cb:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12d2:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12d9:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12e0:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12e7:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12ee:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12f5:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    12fc:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1303:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    130a:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1311:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1318:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    131f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1326:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    132d:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1334:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    133b:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1342:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1349:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1350:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1357:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    135e:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1365:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    136c:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1373:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    137a:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
    137e:	7e 06                	jle    1386 <fun2+0x19f>
    1380:	83 45 d0 01          	addl   $0x1,-0x30(%rbp)
    1384:	eb 04                	jmp    138a <fun2+0x1a3>
    1386:	83 6d d0 01          	subl   $0x1,-0x30(%rbp)
    138a:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1391:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1398:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    139f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13a6:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13ad:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13b4:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13bb:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13c2:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13c9:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13d0:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13d7:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13de:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13e5:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13ec:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13f3:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    13fa:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1401:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1408:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    140f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1416:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    141d:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1424:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    142b:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1432:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1439:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1440:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1447:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    144e:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1455:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    145c:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1463:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    146a:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1471:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1478:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    147f:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1486:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    148d:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    1494:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    149b:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14a2:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14a9:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14b0:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14b7:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14be:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14c5:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14cc:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14d3:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
    14da:	83 45 d8 01          	addl   $0x1,-0x28(%rbp)
    14de:	83 7d d8 04          	cmpl   $0x4,-0x28(%rbp)
    14e2:	0f 8e 96 fd ff ff    	jle    127e <fun2+0x97>
    14e8:	83 45 d4 01          	addl   $0x1,-0x2c(%rbp)
    14ec:	83 7d d4 04          	cmpl   $0x4,-0x2c(%rbp)
    14f0:	0f 8e 59 fd ff ff    	jle    124f <fun2+0x68>
    14f6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    14fa:	74 09                	je     1505 <fun2+0x31e>
    14fc:	83 45 e4 01          	addl   $0x1,-0x1c(%rbp)
    1500:	e9 d9 00 00 00       	jmpq   15de <fun2+0x3f7>
    1505:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    150c:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1513:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    151a:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1521:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1528:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    152f:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1536:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    153d:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1544:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    154b:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1552:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1559:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1560:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1567:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    156e:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1575:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    157c:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1583:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    158a:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1591:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    1598:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    159f:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15a6:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15ad:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15b4:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15bb:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15c2:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15c9:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15d0:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15d7:	c7 45 ec 09 00 00 00 	movl   $0x9,-0x14(%rbp)
    15de:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
    15e5:	eb 40                	jmp    1627 <fun2+0x440>
    15e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15eb:	8b 10                	mov    (%rax),%edx
    15ed:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15f0:	89 c6                	mov    %eax,%esi
    15f2:	48 8d 3d 13 0a 00 00 	lea    0xa13(%rip),%rdi        # 200c <_IO_stdin_used+0xc>
    15f9:	b8 00 00 00 00       	mov    $0x0,%eax
    15fe:	e8 9d fa ff ff       	callq  10a0 <printf@plt>
    1603:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1606:	89 c6                	mov    %eax,%esi
    1608:	48 8d 3d 07 0a 00 00 	lea    0xa07(%rip),%rdi        # 2016 <_IO_stdin_used+0x16>
    160f:	b8 00 00 00 00       	mov    $0x0,%eax
    1614:	e8 87 fa ff ff       	callq  10a0 <printf@plt>
    1619:	bf 01 00 00 00       	mov    $0x1,%edi
    161e:	e8 ad fa ff ff       	callq  10d0 <sleep@plt>
    1623:	83 45 dc 01          	addl   $0x1,-0x24(%rbp)
    1627:	83 7d dc 04          	cmpl   $0x4,-0x24(%rbp)
    162b:	7e ba                	jle    15e7 <fun2+0x400>
    162d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    1634:	eb 2f                	jmp    1665 <fun2+0x47e>
    1636:	8b 05 d8 29 00 00    	mov    0x29d8(%rip),%eax        # 4014 <mutex>
    163c:	83 c0 01             	add    $0x1,%eax
    163f:	89 05 cf 29 00 00    	mov    %eax,0x29cf(%rip)        # 4014 <mutex>
    1645:	8b 15 c9 29 00 00    	mov    0x29c9(%rip),%edx        # 4014 <mutex>
    164b:	8b 45 e8             	mov    -0x18(%rbp),%eax
    164e:	89 c6                	mov    %eax,%esi
    1650:	48 8d 3d d3 09 00 00 	lea    0x9d3(%rip),%rdi        # 202a <_IO_stdin_used+0x2a>
    1657:	b8 00 00 00 00       	mov    $0x0,%eax
    165c:	e8 3f fa ff ff       	callq  10a0 <printf@plt>
    1661:	83 45 e0 01          	addl   $0x1,-0x20(%rbp)
    1665:	83 7d e0 09          	cmpl   $0x9,-0x20(%rbp)
    1669:	7e cb                	jle    1636 <fun2+0x44f>
    166b:	48 8b 05 a6 29 00 00 	mov    0x29a6(%rip),%rax        # 4018 <mutex2>
    1672:	8b 10                	mov    (%rax),%edx
    1674:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1677:	89 c6                	mov    %eax,%esi
    1679:	48 8d 3d aa 09 00 00 	lea    0x9aa(%rip),%rdi        # 202a <_IO_stdin_used+0x2a>
    1680:	b8 00 00 00 00       	mov    $0x0,%eax
    1685:	e8 16 fa ff ff       	callq  10a0 <printf@plt>
    168a:	48 8b 05 87 29 00 00 	mov    0x2987(%rip),%rax        # 4018 <mutex2>
    1691:	c7 00 0c 00 00 00    	movl   $0xc,(%rax)
    1697:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    169b:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
    16a1:	48 8d 05 6c 29 00 00 	lea    0x296c(%rip),%rax        # 4014 <mutex>
    16a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    16ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16b0:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
    16b6:	b8 00 00 00 00       	mov    $0x0,%eax
    16bb:	e8 18 fb ff ff       	callq  11d8 <fun3>
    16c0:	c9                   	leaveq 
    16c1:	c3                   	retq   

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

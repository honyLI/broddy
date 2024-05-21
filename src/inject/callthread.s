
callthread：     文件格式 elf64-x86-64


Disassembly of section .text:

0000000000001000 <_write>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	55                   	push   %rbp
    1005:	48 89 e5             	mov    %rsp,%rbp
    1008:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    100c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1010:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    1014:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
    1018:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
    101c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    1020:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1027:	0f 05                	syscall 
    1029:	48 89 c0             	mov    %rax,%rax
    102c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1030:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1034:	5d                   	pop    %rbp
    1035:	c3                   	retq   

0000000000001036 <_fun>:
    1036:	f3 0f 1e fa          	endbr64 
    103a:	55                   	push   %rbp
    103b:	48 89 e5             	mov    %rsp,%rbp
    103e:	5d                   	pop    %rbp
    103f:	ff 25 bb 2f 00 00    	jmpq   *0x2fbb(%rip)        # 4000 <addr>
    1045:	90                   	nop
    1046:	5d                   	pop    %rbp
    1047:	c3                   	retq   

0000000000001048 <_pthread>:
    1048:	f3 0f 1e fa          	endbr64 
    104c:	55                   	push   %rbp
    104d:	48 89 e5             	mov    %rsp,%rbp
    1050:	48 83 ec 10          	sub    $0x10,%rsp
    1054:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    105b:	00 00 
    105d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1061:	31 c0                	xor    %eax,%eax
    1063:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
    1067:	b9 00 00 00 00       	mov    $0x0,%ecx
    106c:	48 8d 15 8d df ff ff 	lea    -0x2073(%rip),%rdx        # fffffffffffff000 <__bss_start+0xffffffffffffaff8>
    1073:	be 00 00 00 00       	mov    $0x0,%esi
    1078:	48 89 c7             	mov    %rax,%rdi
    107b:	e8 b6 ff ff ff       	callq  1036 <_fun>
    1080:	48 89 ec             	mov    %rbp,%rsp
    1083:	0f 1f 00             	nopl   (%rax)
    1086:	90                   	nop
    1087:	5d                   	pop    %rbp
    1088:	c3                   	retq   

0000000000001089 <_exit>:
    1089:	f3 0f 1e fa          	endbr64 
    108d:	55                   	push   %rbp
    108e:	48 89 e5             	mov    %rsp,%rbp
    1091:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1094:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1097:	48 c7 c0 3c 00 00 00 	mov    $0x3c,%rax
    109e:	0f 05                	syscall 
    10a0:	90                   	nop
    10a1:	5d                   	pop    %rbp
    10a2:	c3                   	retq   

00000000000010a3 <_start>:
    10a3:	f3 0f 1e fa          	endbr64 
    10a7:	55                   	push   %rbp
    10a8:	48 89 e5             	mov    %rsp,%rbp
    10ab:	48 83 ec 10          	sub    $0x10,%rsp
    10af:	89 7d fc             	mov    %edi,-0x4(%rbp)
    10b2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    10b6:	48 89 35 43 2f 00 00 	mov    %rsi,0x2f43(%rip)        # 4000 <addr>
    10bd:	b8 00 00 00 00       	mov    $0x0,%eax
    10c2:	e8 81 ff ff ff       	callq  1048 <_pthread>
    10c7:	cc                   	int3   
    10c8:	bf 00 00 00 00       	mov    $0x0,%edi
    10cd:	e8 b7 ff ff ff       	callq  1089 <_exit>

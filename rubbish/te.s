
a.out：     文件格式 elf64-x86-64


Disassembly of section .init:

0000000000000810 <_init>:
 810:	48 83 ec 08          	sub    $0x8,%rsp
 814:	48 8b 05 cd 17 20 00 	mov    0x2017cd(%rip),%rax        # 201fe8 <__gmon_start__>
 81b:	48 85 c0             	test   %rax,%rax
 81e:	74 02                	je     822 <_init+0x12>
 820:	ff d0                	callq  *%rax
 822:	48 83 c4 08          	add    $0x8,%rsp
 826:	c3                   	retq   

Disassembly of section .plt:

0000000000000830 <.plt>:
 830:	ff 35 22 17 20 00    	pushq  0x201722(%rip)        # 201f58 <_GLOBAL_OFFSET_TABLE_+0x8>
 836:	ff 25 24 17 20 00    	jmpq   *0x201724(%rip)        # 201f60 <_GLOBAL_OFFSET_TABLE_+0x10>
 83c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000840 <__isoc99_fscanf@plt>:
 840:	ff 25 22 17 20 00    	jmpq   *0x201722(%rip)        # 201f68 <__isoc99_fscanf@GLIBC_2.7>
 846:	68 00 00 00 00       	pushq  $0x0
 84b:	e9 e0 ff ff ff       	jmpq   830 <.plt>

0000000000000850 <puts@plt>:
 850:	ff 25 1a 17 20 00    	jmpq   *0x20171a(%rip)        # 201f70 <puts@GLIBC_2.2.5>
 856:	68 01 00 00 00       	pushq  $0x1
 85b:	e9 d0 ff ff ff       	jmpq   830 <.plt>

0000000000000860 <fclose@plt>:
 860:	ff 25 12 17 20 00    	jmpq   *0x201712(%rip)        # 201f78 <fclose@GLIBC_2.2.5>
 866:	68 02 00 00 00       	pushq  $0x2
 86b:	e9 c0 ff ff ff       	jmpq   830 <.plt>

0000000000000870 <__stack_chk_fail@plt>:
 870:	ff 25 0a 17 20 00    	jmpq   *0x20170a(%rip)        # 201f80 <__stack_chk_fail@GLIBC_2.4>
 876:	68 03 00 00 00       	pushq  $0x3
 87b:	e9 b0 ff ff ff       	jmpq   830 <.plt>

0000000000000880 <mmap@plt>:
 880:	ff 25 02 17 20 00    	jmpq   *0x201702(%rip)        # 201f88 <mmap@GLIBC_2.2.5>
 886:	68 04 00 00 00       	pushq  $0x4
 88b:	e9 a0 ff ff ff       	jmpq   830 <.plt>

0000000000000890 <printf@plt>:
 890:	ff 25 fa 16 20 00    	jmpq   *0x2016fa(%rip)        # 201f90 <printf@GLIBC_2.2.5>
 896:	68 05 00 00 00       	pushq  $0x5
 89b:	e9 90 ff ff ff       	jmpq   830 <.plt>

00000000000008a0 <__assert_fail@plt>:
 8a0:	ff 25 f2 16 20 00    	jmpq   *0x2016f2(%rip)        # 201f98 <__assert_fail@GLIBC_2.2.5>
 8a6:	68 06 00 00 00       	pushq  $0x6
 8ab:	e9 80 ff ff ff       	jmpq   830 <.plt>

00000000000008b0 <close@plt>:
 8b0:	ff 25 ea 16 20 00    	jmpq   *0x2016ea(%rip)        # 201fa0 <close@GLIBC_2.2.5>
 8b6:	68 07 00 00 00       	pushq  $0x7
 8bb:	e9 70 ff ff ff       	jmpq   830 <.plt>

00000000000008c0 <__fxstat@plt>:
 8c0:	ff 25 e2 16 20 00    	jmpq   *0x2016e2(%rip)        # 201fa8 <__fxstat@GLIBC_2.2.5>
 8c6:	68 08 00 00 00       	pushq  $0x8
 8cb:	e9 60 ff ff ff       	jmpq   830 <.plt>

00000000000008d0 <munmap@plt>:
 8d0:	ff 25 da 16 20 00    	jmpq   *0x2016da(%rip)        # 201fb0 <munmap@GLIBC_2.2.5>
 8d6:	68 09 00 00 00       	pushq  $0x9
 8db:	e9 50 ff ff ff       	jmpq   830 <.plt>

00000000000008e0 <open@plt>:
 8e0:	ff 25 d2 16 20 00    	jmpq   *0x2016d2(%rip)        # 201fb8 <open@GLIBC_2.2.5>
 8e6:	68 0a 00 00 00       	pushq  $0xa
 8eb:	e9 40 ff ff ff       	jmpq   830 <.plt>

00000000000008f0 <fopen@plt>:
 8f0:	ff 25 ca 16 20 00    	jmpq   *0x2016ca(%rip)        # 201fc0 <fopen@GLIBC_2.2.5>
 8f6:	68 0b 00 00 00       	pushq  $0xb
 8fb:	e9 30 ff ff ff       	jmpq   830 <.plt>

0000000000000900 <perror@plt>:
 900:	ff 25 c2 16 20 00    	jmpq   *0x2016c2(%rip)        # 201fc8 <perror@GLIBC_2.2.5>
 906:	68 0c 00 00 00       	pushq  $0xc
 90b:	e9 20 ff ff ff       	jmpq   830 <.plt>

0000000000000910 <sleep@plt>:
 910:	ff 25 ba 16 20 00    	jmpq   *0x2016ba(%rip)        # 201fd0 <sleep@GLIBC_2.2.5>
 916:	68 0d 00 00 00       	pushq  $0xd
 91b:	e9 10 ff ff ff       	jmpq   830 <.plt>

Disassembly of section .plt.got:

0000000000000920 <__cxa_finalize@plt>:
 920:	ff 25 d2 16 20 00    	jmpq   *0x2016d2(%rip)        # 201ff8 <__cxa_finalize@GLIBC_2.2.5>
 926:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000000930 <_start>:
 930:	31 ed                	xor    %ebp,%ebp
 932:	49 89 d1             	mov    %rdx,%r9
 935:	5e                   	pop    %rsi
 936:	48 89 e2             	mov    %rsp,%rdx
 939:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 93d:	50                   	push   %rax
 93e:	54                   	push   %rsp
 93f:	4c 8d 05 ea 04 00 00 	lea    0x4ea(%rip),%r8        # e30 <__libc_csu_fini>
 946:	48 8d 0d 73 04 00 00 	lea    0x473(%rip),%rcx        # dc0 <__libc_csu_init>
 94d:	48 8d 3d e6 00 00 00 	lea    0xe6(%rip),%rdi        # a3a <main>
 954:	ff 15 86 16 20 00    	callq  *0x201686(%rip)        # 201fe0 <__libc_start_main@GLIBC_2.2.5>
 95a:	f4                   	hlt    
 95b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000960 <deregister_tm_clones>:
 960:	48 8d 3d a9 16 20 00 	lea    0x2016a9(%rip),%rdi        # 202010 <__TMC_END__>
 967:	55                   	push   %rbp
 968:	48 8d 05 a1 16 20 00 	lea    0x2016a1(%rip),%rax        # 202010 <__TMC_END__>
 96f:	48 39 f8             	cmp    %rdi,%rax
 972:	48 89 e5             	mov    %rsp,%rbp
 975:	74 19                	je     990 <deregister_tm_clones+0x30>
 977:	48 8b 05 5a 16 20 00 	mov    0x20165a(%rip),%rax        # 201fd8 <_ITM_deregisterTMCloneTable>
 97e:	48 85 c0             	test   %rax,%rax
 981:	74 0d                	je     990 <deregister_tm_clones+0x30>
 983:	5d                   	pop    %rbp
 984:	ff e0                	jmpq   *%rax
 986:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 98d:	00 00 00 
 990:	5d                   	pop    %rbp
 991:	c3                   	retq   
 992:	0f 1f 40 00          	nopl   0x0(%rax)
 996:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 99d:	00 00 00 

00000000000009a0 <register_tm_clones>:
 9a0:	48 8d 3d 69 16 20 00 	lea    0x201669(%rip),%rdi        # 202010 <__TMC_END__>
 9a7:	48 8d 35 62 16 20 00 	lea    0x201662(%rip),%rsi        # 202010 <__TMC_END__>
 9ae:	55                   	push   %rbp
 9af:	48 29 fe             	sub    %rdi,%rsi
 9b2:	48 89 e5             	mov    %rsp,%rbp
 9b5:	48 c1 fe 03          	sar    $0x3,%rsi
 9b9:	48 89 f0             	mov    %rsi,%rax
 9bc:	48 c1 e8 3f          	shr    $0x3f,%rax
 9c0:	48 01 c6             	add    %rax,%rsi
 9c3:	48 d1 fe             	sar    %rsi
 9c6:	74 18                	je     9e0 <register_tm_clones+0x40>
 9c8:	48 8b 05 21 16 20 00 	mov    0x201621(%rip),%rax        # 201ff0 <_ITM_registerTMCloneTable>
 9cf:	48 85 c0             	test   %rax,%rax
 9d2:	74 0c                	je     9e0 <register_tm_clones+0x40>
 9d4:	5d                   	pop    %rbp
 9d5:	ff e0                	jmpq   *%rax
 9d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 9de:	00 00 
 9e0:	5d                   	pop    %rbp
 9e1:	c3                   	retq   
 9e2:	0f 1f 40 00          	nopl   0x0(%rax)
 9e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 9ed:	00 00 00 

00000000000009f0 <__do_global_dtors_aux>:
 9f0:	80 3d 19 16 20 00 00 	cmpb   $0x0,0x201619(%rip)        # 202010 <__TMC_END__>
 9f7:	75 2f                	jne    a28 <__do_global_dtors_aux+0x38>
 9f9:	48 83 3d f7 15 20 00 	cmpq   $0x0,0x2015f7(%rip)        # 201ff8 <__cxa_finalize@GLIBC_2.2.5>
 a00:	00 
 a01:	55                   	push   %rbp
 a02:	48 89 e5             	mov    %rsp,%rbp
 a05:	74 0c                	je     a13 <__do_global_dtors_aux+0x23>
 a07:	48 8b 3d fa 15 20 00 	mov    0x2015fa(%rip),%rdi        # 202008 <__dso_handle>
 a0e:	e8 0d ff ff ff       	callq  920 <__cxa_finalize@plt>
 a13:	e8 48 ff ff ff       	callq  960 <deregister_tm_clones>
 a18:	c6 05 f1 15 20 00 01 	movb   $0x1,0x2015f1(%rip)        # 202010 <__TMC_END__>
 a1f:	5d                   	pop    %rbp
 a20:	c3                   	retq   
 a21:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 a28:	f3 c3                	repz retq 
 a2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000a30 <frame_dummy>:
 a30:	55                   	push   %rbp
 a31:	48 89 e5             	mov    %rsp,%rbp
 a34:	5d                   	pop    %rbp
 a35:	e9 66 ff ff ff       	jmpq   9a0 <register_tm_clones>

0000000000000a3a <main>:
 a3a:	55                   	push   %rbp
 a3b:	48 89 e5             	mov    %rsp,%rbp
 a3e:	48 81 ec d0 00 00 00 	sub    $0xd0,%rsp
 a45:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 a4c:	00 00 
 a4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a52:	31 c0                	xor    %eax,%eax
 a54:	48 8d 05 0d 04 00 00 	lea    0x40d(%rip),%rax        # e68 <_IO_stdin_used+0x8>
 a5b:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
 a62:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
 a69:	be 00 00 00 00       	mov    $0x0,%esi
 a6e:	48 89 c7             	mov    %rax,%rdi
 a71:	b8 00 00 00 00       	mov    $0x0,%eax
 a76:	e8 65 fe ff ff       	callq  8e0 <open@plt>
 a7b:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%rbp)
 a81:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
 a87:	89 c6                	mov    %eax,%esi
 a89:	48 8d 3d ed 03 00 00 	lea    0x3ed(%rip),%rdi        # e7d <_IO_stdin_used+0x1d>
 a90:	b8 00 00 00 00       	mov    $0x0,%eax
 a95:	e8 f6 fd ff ff       	callq  890 <printf@plt>
 a9a:	83 bd 34 ff ff ff ff 	cmpl   $0xffffffff,-0xcc(%rbp)
 aa1:	75 1f                	jne    ac2 <main+0x88>
 aa3:	48 8d 0d fc 04 00 00 	lea    0x4fc(%rip),%rcx        # fa6 <__PRETTY_FUNCTION__.4021>
 aaa:	ba 1e 00 00 00       	mov    $0x1e,%edx
 aaf:	48 8d 35 ca 03 00 00 	lea    0x3ca(%rip),%rsi        # e80 <_IO_stdin_used+0x20>
 ab6:	48 8d 3d ca 03 00 00 	lea    0x3ca(%rip),%rdi        # e87 <_IO_stdin_used+0x27>
 abd:	e8 de fd ff ff       	callq  8a0 <__assert_fail@plt>
 ac2:	48 8d 35 c7 03 00 00 	lea    0x3c7(%rip),%rsi        # e90 <_IO_stdin_used+0x30>
 ac9:	48 8d 3d c2 03 00 00 	lea    0x3c2(%rip),%rdi        # e92 <_IO_stdin_used+0x32>
 ad0:	e8 1b fe ff ff       	callq  8f0 <fopen@plt>
 ad5:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
 adc:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 ae3:	00 
 ae4:	74 4e                	je     b34 <main+0xfa>
 ae6:	48 8d 95 38 ff ff ff 	lea    -0xc8(%rbp),%rdx
 aed:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 af4:	48 8d 35 a7 03 00 00 	lea    0x3a7(%rip),%rsi        # ea2 <_IO_stdin_used+0x42>
 afb:	48 89 c7             	mov    %rax,%rdi
 afe:	b8 00 00 00 00       	mov    $0x0,%eax
 b03:	e8 38 fd ff ff       	callq  840 <__isoc99_fscanf@plt>
 b08:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 b0f:	48 89 c7             	mov    %rax,%rdi
 b12:	e8 49 fd ff ff       	callq  860 <fclose@plt>
 b17:	48 8b 85 38 ff ff ff 	mov    -0xc8(%rbp),%rax
 b1e:	48 89 c6             	mov    %rax,%rsi
 b21:	48 8d 3d 80 03 00 00 	lea    0x380(%rip),%rdi        # ea8 <_IO_stdin_used+0x48>
 b28:	b8 00 00 00 00       	mov    $0x0,%eax
 b2d:	e8 5e fd ff ff       	callq  890 <printf@plt>
 b32:	eb 0c                	jmp    b40 <main+0x106>
 b34:	48 8d 3d 95 03 00 00 	lea    0x395(%rip),%rdi        # ed0 <_IO_stdin_used+0x70>
 b3b:	e8 10 fd ff ff       	callq  850 <puts@plt>
 b40:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
 b47:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
 b4d:	48 89 d6             	mov    %rdx,%rsi
 b50:	89 c7                	mov    %eax,%edi
 b52:	e8 e9 02 00 00       	callq  e40 <__fstat>
 b57:	83 f8 ff             	cmp    $0xffffffff,%eax
 b5a:	75 16                	jne    b72 <main+0x138>
 b5c:	48 8d 3d 8c 03 00 00 	lea    0x38c(%rip),%rdi        # eef <_IO_stdin_used+0x8f>
 b63:	e8 98 fd ff ff       	callq  900 <perror@plt>
 b68:	b8 01 00 00 00       	mov    $0x1,%eax
 b6d:	e9 b2 01 00 00       	jmpq   d24 <main+0x2ea>
 b72:	48 8b 45 90          	mov    -0x70(%rbp),%rax
 b76:	48 89 c6             	mov    %rax,%rsi
 b79:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
 b7f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
 b85:	41 89 c0             	mov    %eax,%r8d
 b88:	b9 02 00 00 00       	mov    $0x2,%ecx
 b8d:	ba 05 00 00 00       	mov    $0x5,%edx
 b92:	bf 00 00 00 00       	mov    $0x0,%edi
 b97:	e8 e4 fc ff ff       	callq  880 <mmap@plt>
 b9c:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
 ba3:	48 83 bd 50 ff ff ff 	cmpq   $0xffffffffffffffff,-0xb0(%rbp)
 baa:	ff 
 bab:	75 1f                	jne    bcc <main+0x192>
 bad:	48 8d 0d f2 03 00 00 	lea    0x3f2(%rip),%rcx        # fa6 <__PRETTY_FUNCTION__.4021>
 bb4:	ba 36 00 00 00       	mov    $0x36,%edx
 bb9:	48 8d 35 c0 02 00 00 	lea    0x2c0(%rip),%rsi        # e80 <_IO_stdin_used+0x20>
 bc0:	48 8d 3d 2e 03 00 00 	lea    0x32e(%rip),%rdi        # ef5 <_IO_stdin_used+0x95>
 bc7:	e8 d4 fc ff ff       	callq  8a0 <__assert_fail@plt>
 bcc:	48 8d 05 67 01 00 00 	lea    0x167(%rip),%rax        # d3a <fun1>
 bd3:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
 bda:	48 8b 45 90          	mov    -0x70(%rbp),%rax
 bde:	48 89 c6             	mov    %rax,%rsi
 be1:	48 8d 3d 25 03 00 00 	lea    0x325(%rip),%rdi        # f0d <_IO_stdin_used+0xad>
 be8:	b8 00 00 00 00       	mov    $0x0,%eax
 bed:	e8 9e fc ff ff       	callq  890 <printf@plt>
 bf2:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
 bf9:	48 89 c6             	mov    %rax,%rsi
 bfc:	48 8d 3d 1d 03 00 00 	lea    0x31d(%rip),%rdi        # f20 <_IO_stdin_used+0xc0>
 c03:	b8 00 00 00 00       	mov    $0x0,%eax
 c08:	e8 83 fc ff ff       	callq  890 <printf@plt>
 c0d:	48 8d 35 26 01 00 00 	lea    0x126(%rip),%rsi        # d3a <fun1>
 c14:	48 8d 3d 05 03 00 00 	lea    0x305(%rip),%rdi        # f20 <_IO_stdin_used+0xc0>
 c1b:	b8 00 00 00 00       	mov    $0x0,%eax
 c20:	e8 6b fc ff ff       	callq  890 <printf@plt>
 c25:	48 8d 35 23 01 00 00 	lea    0x123(%rip),%rsi        # d4f <fun2>
 c2c:	48 8d 3d 00 03 00 00 	lea    0x300(%rip),%rdi        # f33 <_IO_stdin_used+0xd3>
 c33:	b8 00 00 00 00       	mov    $0x0,%eax
 c38:	e8 53 fc ff ff       	callq  890 <printf@plt>
 c3d:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
 c44:	48 89 c6             	mov    %rax,%rsi
 c47:	48 8d 3d f8 02 00 00 	lea    0x2f8(%rip),%rdi        # f46 <_IO_stdin_used+0xe6>
 c4e:	b8 00 00 00 00       	mov    $0x0,%eax
 c53:	e8 38 fc ff ff       	callq  890 <printf@plt>
 c58:	48 8b 95 50 ff ff ff 	mov    -0xb0(%rbp),%rdx
 c5f:	48 8b 85 38 ff ff ff 	mov    -0xc8(%rbp),%rax
 c66:	48 29 c2             	sub    %rax,%rdx
 c69:	48 89 d0             	mov    %rdx,%rax
 c6c:	48 01 85 58 ff ff ff 	add    %rax,-0xa8(%rbp)
 c73:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
 c7a:	48 89 c6             	mov    %rax,%rsi
 c7d:	48 8d 3d da 02 00 00 	lea    0x2da(%rip),%rdi        # f5e <_IO_stdin_used+0xfe>
 c84:	b8 00 00 00 00       	mov    $0x0,%eax
 c89:	e8 02 fc ff ff       	callq  890 <printf@plt>
 c8e:	b8 00 00 00 00       	mov    $0x0,%eax
 c93:	e8 a2 00 00 00       	callq  d3a <fun1>
 c98:	bf 00 00 00 00       	mov    $0x0,%edi
 c9d:	e8 6e fc ff ff       	callq  910 <sleep@plt>
 ca2:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
 ca9:	48 89 c6             	mov    %rax,%rsi
 cac:	48 8d 3d c7 02 00 00 	lea    0x2c7(%rip),%rdi        # f7a <_IO_stdin_used+0x11a>
 cb3:	b8 00 00 00 00       	mov    $0x0,%eax
 cb8:	e8 d3 fb ff ff       	callq  890 <printf@plt>
 cbd:	48 8b 95 58 ff ff ff 	mov    -0xa8(%rbp),%rdx
 cc4:	b8 00 00 00 00       	mov    $0x0,%eax
 cc9:	ff d2                	callq  *%rdx
 ccb:	bf 01 00 00 00       	mov    $0x1,%edi
 cd0:	e8 3b fc ff ff       	callq  910 <sleep@plt>
 cd5:	48 8b 45 90          	mov    -0x70(%rbp),%rax
 cd9:	48 89 c2             	mov    %rax,%rdx
 cdc:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
 ce3:	48 89 d6             	mov    %rdx,%rsi
 ce6:	48 89 c7             	mov    %rax,%rdi
 ce9:	e8 e2 fb ff ff       	callq  8d0 <munmap@plt>
 cee:	83 f8 ff             	cmp    $0xffffffff,%eax
 cf1:	75 1f                	jne    d12 <main+0x2d8>
 cf3:	48 8d 3d 85 02 00 00 	lea    0x285(%rip),%rdi        # f7f <_IO_stdin_used+0x11f>
 cfa:	e8 51 fb ff ff       	callq  850 <puts@plt>
 cff:	48 8d 3d 80 02 00 00 	lea    0x280(%rip),%rdi        # f86 <_IO_stdin_used+0x126>
 d06:	e8 f5 fb ff ff       	callq  900 <perror@plt>
 d0b:	b8 01 00 00 00       	mov    $0x1,%eax
 d10:	eb 12                	jmp    d24 <main+0x2ea>
 d12:	8b 85 34 ff ff ff    	mov    -0xcc(%rbp),%eax
 d18:	89 c7                	mov    %eax,%edi
 d1a:	e8 91 fb ff ff       	callq  8b0 <close@plt>
 d1f:	b8 00 00 00 00       	mov    $0x0,%eax
 d24:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 d28:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
 d2f:	00 00 
 d31:	74 05                	je     d38 <main+0x2fe>
 d33:	e8 38 fb ff ff       	callq  870 <__stack_chk_fail@plt>
 d38:	c9                   	leaveq 
 d39:	c3                   	retq   

0000000000000d3a <fun1>:
 d3a:	55                   	push   %rbp
 d3b:	48 89 e5             	mov    %rsp,%rbp
 d3e:	b8 00 00 00 00       	mov    $0x0,%eax
 d43:	e8 07 00 00 00       	callq  d4f <fun2>
 d48:	b8 03 00 00 00       	mov    $0x3,%eax
 d4d:	5d                   	pop    %rbp
 d4e:	c3                   	retq   

0000000000000d4f <fun2>:
 d4f:	55                   	push   %rbp
 d50:	48 89 e5             	mov    %rsp,%rbp
 d53:	b8 00 00 00 00       	mov    $0x0,%eax
 d58:	e8 0f 00 00 00       	callq  d6c <fun3>
 d5d:	48 8d 3d 29 02 00 00 	lea    0x229(%rip),%rdi        # f8d <_IO_stdin_used+0x12d>
 d64:	e8 e7 fa ff ff       	callq  850 <puts@plt>
 d69:	90                   	nop
 d6a:	5d                   	pop    %rbp
 d6b:	c3                   	retq   

0000000000000d6c <fun3>:
 d6c:	55                   	push   %rbp
 d6d:	48 89 e5             	mov    %rsp,%rbp
 d70:	48 8d 3d 1b 02 00 00 	lea    0x21b(%rip),%rdi        # f92 <_IO_stdin_used+0x132>
 d77:	e8 d4 fa ff ff       	callq  850 <puts@plt>
 d7c:	90                   	nop
 d7d:	5d                   	pop    %rbp
 d7e:	c3                   	retq   

0000000000000d7f <fun4>:
 d7f:	55                   	push   %rbp
 d80:	48 89 e5             	mov    %rsp,%rbp
 d83:	48 8d 3d 0d 02 00 00 	lea    0x20d(%rip),%rdi        # f97 <_IO_stdin_used+0x137>
 d8a:	e8 c1 fa ff ff       	callq  850 <puts@plt>
 d8f:	90                   	nop
 d90:	5d                   	pop    %rbp
 d91:	c3                   	retq   

0000000000000d92 <fun5>:
 d92:	55                   	push   %rbp
 d93:	48 89 e5             	mov    %rsp,%rbp
 d96:	48 8d 3d ff 01 00 00 	lea    0x1ff(%rip),%rdi        # f9c <_IO_stdin_used+0x13c>
 d9d:	e8 ae fa ff ff       	callq  850 <puts@plt>
 da2:	90                   	nop
 da3:	5d                   	pop    %rbp
 da4:	c3                   	retq   

0000000000000da5 <fun6>:
 da5:	55                   	push   %rbp
 da6:	48 89 e5             	mov    %rsp,%rbp
 da9:	48 8d 3d f1 01 00 00 	lea    0x1f1(%rip),%rdi        # fa1 <_IO_stdin_used+0x141>
 db0:	e8 9b fa ff ff       	callq  850 <puts@plt>
 db5:	90                   	nop
 db6:	5d                   	pop    %rbp
 db7:	c3                   	retq   
 db8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 dbf:	00 

0000000000000dc0 <__libc_csu_init>:
 dc0:	41 57                	push   %r15
 dc2:	41 56                	push   %r14
 dc4:	49 89 d7             	mov    %rdx,%r15
 dc7:	41 55                	push   %r13
 dc9:	41 54                	push   %r12
 dcb:	4c 8d 25 7e 0f 20 00 	lea    0x200f7e(%rip),%r12        # 201d50 <__frame_dummy_init_array_entry>
 dd2:	55                   	push   %rbp
 dd3:	48 8d 2d 7e 0f 20 00 	lea    0x200f7e(%rip),%rbp        # 201d58 <__init_array_end>
 dda:	53                   	push   %rbx
 ddb:	41 89 fd             	mov    %edi,%r13d
 dde:	49 89 f6             	mov    %rsi,%r14
 de1:	4c 29 e5             	sub    %r12,%rbp
 de4:	48 83 ec 08          	sub    $0x8,%rsp
 de8:	48 c1 fd 03          	sar    $0x3,%rbp
 dec:	e8 1f fa ff ff       	callq  810 <_init>
 df1:	48 85 ed             	test   %rbp,%rbp
 df4:	74 20                	je     e16 <__libc_csu_init+0x56>
 df6:	31 db                	xor    %ebx,%ebx
 df8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 dff:	00 
 e00:	4c 89 fa             	mov    %r15,%rdx
 e03:	4c 89 f6             	mov    %r14,%rsi
 e06:	44 89 ef             	mov    %r13d,%edi
 e09:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 e0d:	48 83 c3 01          	add    $0x1,%rbx
 e11:	48 39 dd             	cmp    %rbx,%rbp
 e14:	75 ea                	jne    e00 <__libc_csu_init+0x40>
 e16:	48 83 c4 08          	add    $0x8,%rsp
 e1a:	5b                   	pop    %rbx
 e1b:	5d                   	pop    %rbp
 e1c:	41 5c                	pop    %r12
 e1e:	41 5d                	pop    %r13
 e20:	41 5e                	pop    %r14
 e22:	41 5f                	pop    %r15
 e24:	c3                   	retq   
 e25:	90                   	nop
 e26:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 e2d:	00 00 00 

0000000000000e30 <__libc_csu_fini>:
 e30:	f3 c3                	repz retq 
 e32:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 e39:	00 00 00 
 e3c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000e40 <__fstat>:
 e40:	48 89 f2             	mov    %rsi,%rdx
 e43:	89 fe                	mov    %edi,%esi
 e45:	bf 01 00 00 00       	mov    $0x1,%edi
 e4a:	e9 71 fa ff ff       	jmpq   8c0 <__fxstat@plt>

Disassembly of section .fini:

0000000000000e50 <_fini>:
 e50:	48 83 ec 08          	sub    $0x8,%rsp
 e54:	48 83 c4 08          	add    $0x8,%rsp
 e58:	c3                   	retq   

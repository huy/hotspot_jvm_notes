OpenJDK Server VM warning: PrintAssembly is enabled; turning on DebugNonSafepoints to gain additional output
Loaded disassembler from hsdis-i386.so
Decoding compiled method 0xb4f48a48:
Code:
[Disassembling for mach='i386']
[Entry Point]
[Verified Entry Point]
[Constants]
  # {method} 'main' '([Ljava/lang/String;)V' in 'TestVolatile'
  0xb4f48b40: call   0x00f97f00         ;...e8bbf304 4c
                                        ;   {runtime_call}
  0xb4f48b45: xchg   %ax,%ax            ;...666690
  0xb4f48b48: mov    %eax,-0x3000(%esp)  ;...89842400 d0ffff
  0xb4f48b4f: push   %ebp               ;...55
  0xb4f48b50: sub    $0x18,%esp         ;...81ec1800 0000
  0xb4f48b56: mov    (%ecx),%edi        ;...8b39
  0xb4f48b58: mov    0x10(%ecx),%ebp    ;...8b6910
  0xb4f48b5b: mov    0xc(%ecx),%esi     ;...8b710c
  0xb4f48b5e: mov    0x8(%ecx),%ebx     ;...8b5908
  0xb4f48b61: mov    %ecx,(%esp)        ;...890c24
  0xb4f48b64: call   0x01019af0         ;...e8870f0d 4c
                                        ;   {runtime_call}
  0xb4f48b69: test   %ebp,%ebp          ;...85ed
  0xb4f48b6b: je     0xb4f48c2f         ;...0f84be00 0000
  0xb4f48b71: mov    0x4(%ebp),%ecx     ;...8b4d04
  0xb4f48b74: cmp    $0xad01a930,%ecx   ;...81f930a9 01ad
                                        ;   {oop('TestVolatile')}
  0xb4f48b7a: jne    0xb4f48c55         ;...0f85d500 0000
                                        ;*iload
                                        ; - TestVolatile::main@30 (line 43)
  0xb4f48b80: cmp    $0xf4240,%edi      ;...81ff4042 0f00
  0xb4f48b86: jge    0xb4f48c07         ;...0f8d7b00 0000
                                        ;*if_icmpge
                                        ; - TestVolatile::main@34 (line 43)
  0xb4f48b8c: test   %ebp,%ebp          ;...85ed
  0xb4f48b8e: je     0xb4f48c39         ;...0f84a500 0000
  0xb4f48b94: mov    %edi,%eax          ;...8bc7
  0xb4f48b96: inc    %eax               ;...40
                                        ;*synchronization entry
                                        ; - TestVolatile::readA@-1 (line 6)
                                        ; - TestVolatile::main@38 (line 44)
  0xb4f48b97: mov    0x8(%ebp),%edx     ;...8b5508
                                        ;*getfield a
                                        ; - TestVolatile::readA@1 (line 6)
                                        ; - TestVolatile::main@38 (line 44)
  0xb4f48b9a: test   %edx,%edx          ;...85d2
  0xb4f48b9c: jne    0xb4f48c71         ;...0f85cf00 0000
                                        ;*aload_1
                                        ; - TestVolatile::main@47 (line 46)
  0xb4f48ba2: mov    0xc(%ebp),%ecx     ;...8b4d0c
                                        ;*getfield b
                                        ; - TestVolatile::readB@1 (line 10)
                                        ; - TestVolatile::main@48 (line 46)
  0xb4f48ba5: test   %ecx,%ecx          ;...85c9
  0xb4f48ba7: jne    0xb4f48c77         ;...0f85ca00 0000
  0xb4f48bad: inc    %edi               ;...47
                                        ;*iinc
                                        ; - TestVolatile::main@57 (line 43)
  0xb4f48bae: cmp    %eax,%edi          ;...3bf8
  0xb4f48bb0: jl     0xb4f48b97         ;...7ce5
  0xb4f48bb2: mov    $0xf4240,%edx      ;...ba40420f 00
  0xb4f48bb7: sub    %edi,%edx          ;...2bd7
  0xb4f48bb9: and    $0xfffffffe,%edx   ;...83e2fe
  0xb4f48bbc: add    %edi,%edx          ;...03d7
  0xb4f48bbe: cmp    %edx,%edi          ;...3bfa
  0xb4f48bc0: jge    0xb4f48be5         ;...7d23
                                        ;*aload_1
                                        ; - TestVolatile::main@37 (line 44)
  0xb4f48bc2: mov    0x8(%ebp),%eax     ;...8b4508
                                        ;*getfield a
                                        ; - TestVolatile::readA@1 (line 6)
                                        ; - TestVolatile::main@38 (line 44)
  0xb4f48bc5: test   %eax,%eax          ;...85c0
  0xb4f48bc7: jne    0xb4f48c1d         ;...7554
                                        ;*aload_1
                                        ; - TestVolatile::main@47 (line 46)
  0xb4f48bc9: mov    0xc(%ebp),%ecx     ;...8b4d0c
                                        ;*getfield b
                                        ; - TestVolatile::readB@1 (line 10)
                                        ; - TestVolatile::main@48 (line 46)
  0xb4f48bcc: test   %ecx,%ecx          ;...85c9
  0xb4f48bce: jne    0xb4f48c20         ;...7550
                                        ;*iinc
                                        ; - TestVolatile::main@57 (line 43)
  0xb4f48bd0: mov    0x8(%ebp),%ecx     ;...8b4d08
                                        ;*getfield a
                                        ; - TestVolatile::readA@1 (line 6)
                                        ; - TestVolatile::main@38 (line 44)
  0xb4f48bd3: test   %ecx,%ecx          ;...85c9
  0xb4f48bd5: jne    0xb4f48c23         ;...754c
                                        ;*aload_1
                                        ; - TestVolatile::main@47 (line 46)
  0xb4f48bd7: mov    0xc(%ebp),%eax     ;...8b450c
                                        ;*getfield b
                                        ; - TestVolatile::readB@1 (line 10)
                                        ; - TestVolatile::main@48 (line 46)
  0xb4f48bda: test   %eax,%eax          ;...85c0
  0xb4f48bdc: jne    0xb4f48c26         ;...7548
  0xb4f48bde: add    $0x2,%edi          ;...83c702
                                        ;*iinc
                                        ; - TestVolatile::main@57 (line 43)
  0xb4f48be1: cmp    %edx,%edi          ;...3bfa
  0xb4f48be3: jl     0xb4f48bc2         ;...7cdd
  0xb4f48be5: cmp    $0xf4240,%edi      ;...81ff4042 0f00
  0xb4f48beb: jge    0xb4f48c07         ;...7d1a
  0xb4f48bed: xchg   %ax,%ax            ;...666690
                                        ;*aload_1
                                        ; - TestVolatile::main@37 (line 44)
  0xb4f48bf0: mov    0x8(%ebp),%eax     ;...8b4508
                                        ;*getfield a
                                        ; - TestVolatile::readA@1 (line 6)
                                        ; - TestVolatile::main@38 (line 44)
  0xb4f48bf3: test   %eax,%eax          ;...85c0
  0xb4f48bf5: jne    0xb4f48c29         ;...7532
                                        ;*aload_1
                                        ; - TestVolatile::main@47 (line 46)
  0xb4f48bf7: mov    0xc(%ebp),%ecx     ;...8b4d0c
                                        ;*getfield b
                                        ; - TestVolatile::readB@1 (line 10)
                                        ; - TestVolatile::main@48 (line 46)
  0xb4f48bfa: test   %ecx,%ecx          ;...85c9
  0xb4f48bfc: jne    0xb4f48c2c         ;...752e
  0xb4f48bfe: inc    %edi               ;...47
                                        ;*iinc
                                        ; - TestVolatile::main@57 (line 43)
  0xb4f48bff: cmp    $0xf4240,%edi      ;...81ff4042 0f00
  0xb4f48c05: jl     0xb4f48bf0         ;...7ce9
                                        ;*if_icmpge
                                        ; - TestVolatile::main@34 (line 43)
  0xb4f48c07: mov    $0x30,%ecx         ;...b9300000 00
  0xb4f48c0c: mov    %esi,%ebp          ;...8bee
  0xb4f48c0e: mov    %ebx,0x4(%esp)     ;...895c2404
  0xb4f48c12: nop                       ;...90
  0xb4f48c13: call   0xb4f2c720         ;...e8083bfe ff
                                        ; OopMap{off=216}
                                        ;*getstatic out
                                        ; - TestVolatile::main@63 (line 49)
                                        ;   {runtime_call}
  0xb4f48c18: call   0x00f97f00         ;...e8e3f204 4c
                                        ;*getstatic out
                                        ; - TestVolatile::main@63 (line 49)
                                        ;   {runtime_call}
  0xb4f48c1d: inc    %esi               ;...46
                                        ;*iinc
                                        ; - TestVolatile::main@44 (line 45)
  0xb4f48c1e: jmp    0xb4f48bc9         ;...eba9
  0xb4f48c20: inc    %ebx               ;...43
                                        ;*iinc
                                        ; - TestVolatile::main@54 (line 47)
  0xb4f48c21: jmp    0xb4f48bd0         ;...ebad
  0xb4f48c23: inc    %esi               ;...46
                                        ;*iinc
                                        ; - TestVolatile::main@44 (line 45)
  0xb4f48c24: jmp    0xb4f48bd7         ;...ebb1
  0xb4f48c26: inc    %ebx               ;...43
                                        ;*iinc
                                        ; - TestVolatile::main@54 (line 47)
  0xb4f48c27: jmp    0xb4f48bde         ;...ebb5
  0xb4f48c29: inc    %esi               ;...46
                                        ;*iinc
                                        ; - TestVolatile::main@44 (line 45)
  0xb4f48c2a: jmp    0xb4f48bf7         ;...ebcb
  0xb4f48c2c: inc    %ebx               ;...43
                                        ;*iinc
                                        ; - TestVolatile::main@54 (line 47)
  0xb4f48c2d: jmp    0xb4f48bfe         ;...ebcf
  0xb4f48c2f: mov    $0x0,%ebp          ;...bd000000 00
  0xb4f48c34: jmp    0xb4f48b80         ;...e947ffff ff
  0xb4f48c39: mov    $0xffffff86,%ecx   ;...b986ffff ff
  0xb4f48c3e: mov    %esi,0x4(%esp)     ;...89742404
  0xb4f48c42: mov    %ebx,0x8(%esp)     ;...895c2408
  0xb4f48c46: mov    %edi,0xc(%esp)     ;...897c240c
  0xb4f48c4a: nop                       ;...90
  0xb4f48c4b: call   0xb4f2c720         ;...e8d03afe ff
                                        ; OopMap{ebp=Oop off=272}
                                        ;*aload_1
                                        ; - TestVolatile::main@37 (line 44)
                                        ;   {runtime_call}
  0xb4f48c50: call   0x00f97f00         ;...e8abf204 4c
                                        ;   {runtime_call}
  0xb4f48c55: mov    $0xffffffad,%ecx   ;...b9adffff ff
  0xb4f48c5a: mov    %esi,0x4(%esp)     ;...89742404
  0xb4f48c5e: mov    %ebx,0x8(%esp)     ;...895c2408
  0xb4f48c62: mov    %edi,0xc(%esp)     ;...897c240c
  0xb4f48c66: nop                       ;...90
  0xb4f48c67: call   0xb4f2c720         ;...e8b43afe ff
                                        ; OopMap{ebp=Oop off=300}
                                        ;*iload
                                        ; - TestVolatile::main@30 (line 43)
                                        ;   {runtime_call}
  0xb4f48c6c: call   0x00f97f00         ;...e88ff204 4c
                                        ;*iload
                                        ; - TestVolatile::main@30 (line 43)
                                        ;   {runtime_call}
  0xb4f48c71: inc    %esi               ;...46
                                        ;*iinc
                                        ; - TestVolatile::main@44 (line 45)
  0xb4f48c72: jmp    0xb4f48ba2         ;...e92bffff ff
  0xb4f48c77: inc    %ebx               ;...43
                                        ;*iinc
                                        ; - TestVolatile::main@54 (line 47)
  0xb4f48c78: jmp    0xb4f48bad         ;...e930ffff ff
  0xb4f48c7d: hlt                       ;...f4
  0xb4f48c7e: hlt                       ;...f4
  0xb4f48c7f: hlt                       ;...f4
[Exception Handler]
[Stub Code]
  0xb4f48c80: jmp    0xb4f47760         ;...e9dbeaff ff
                                        ;   {no_reloc}
[Deopt Handler Code]
  0xb4f48c85: push   $0xb4f48c85        ;...68858cf4 b4
                                        ;   {section_word}
  0xb4f48c8a: jmp    0xb4f2dbe0         ;...e9514ffe ff
                                        ;   {runtime_call}
  0xb4f48c8f: .byte 0x0                 ;...00
Decoding compiled method 0xb4f48888:
Code:
[Disassembling for mach='i386']
[Entry Point]
[Constants]
  # {method} 'setA' '(I)V' in 'TestVolatile'
  # this:     ecx       = 'TestVolatile'
  # parm0:    edx       = int
  #           [sp+0x10]  (sp of caller)
  0xb4f48980: cmp    0x4(%ecx),%eax     ;...3b4104
  0xb4f48983: jne    0xb4f2cea0         ;...0f851745 feff
                                        ;   {runtime_call}
  0xb4f48989: xchg   %ax,%ax            ;...666690
[Verified Entry Point]
  0xb4f4898c: push   %ebp               ;...55
  0xb4f4898d: sub    $0x8,%esp          ;...81ec0800 0000
  0xb4f48993: mov    %edx,0x8(%ecx)     ;...895108
  0xb4f48996: lock addl $0x0,(%esp)     ;...f0830424 00
                                        ;*synchronization entry
                                        ; - TestVolatile::setA@-1 (line 14)
  0xb4f4899b: add    $0x8,%esp          ;...83c408
  0xb4f4899e: pop    %ebp               ;...5d
  0xb4f4899f: test   %eax,0xb7f62000    ;...85050020 f6b7
                                        ;   {poll_return}
  0xb4f489a5: ret                       ;...c3
  0xb4f489a6: hlt                       ;...f4
  0xb4f489a7: hlt                       ;...f4
  0xb4f489a8: hlt                       ;...f4
  0xb4f489a9: hlt                       ;...f4
  0xb4f489aa: hlt                       ;...f4
  0xb4f489ab: hlt                       ;...f4
  0xb4f489ac: hlt                       ;...f4
  0xb4f489ad: hlt                       ;...f4
  0xb4f489ae: hlt                       ;...f4
  0xb4f489af: hlt                       ;...f4
  0xb4f489b0: hlt                       ;...f4
  0xb4f489b1: hlt                       ;...f4
  0xb4f489b2: hlt                       ;...f4
  0xb4f489b3: hlt                       ;...f4
  0xb4f489b4: hlt                       ;...f4
  0xb4f489b5: hlt                       ;...f4
  0xb4f489b6: hlt                       ;...f4
  0xb4f489b7: hlt                       ;...f4
  0xb4f489b8: hlt                       ;...f4
  0xb4f489b9: hlt                       ;...f4
  0xb4f489ba: hlt                       ;...f4
  0xb4f489bb: hlt                       ;...f4
  0xb4f489bc: hlt                       ;...f4
  0xb4f489bd: hlt                       ;...f4
  0xb4f489be: hlt                       ;...f4
  0xb4f489bf: hlt                       ;...f4
[Exception Handler]
[Stub Code]
  0xb4f489c0: jmp    0xb4f47760         ;...e99bedff ff
                                        ;   {no_reloc}
[Deopt Handler Code]
  0xb4f489c5: push   $0xb4f489c5        ;...68c589f4 b4
                                        ;   {section_word}
  0xb4f489ca: jmp    0xb4f2dbe0         ;...e91152fe ff
                                        ;   {runtime_call}
  0xb4f489cf: .byte 0x0                 ;...00
0
934528
Decoding compiled method 0xb4f486c8:
Code:
[Disassembling for mach='i386']
[Entry Point]
[Constants]
  # {method} 'setB' '(I)V' in 'TestVolatile'
  # this:     ecx       = 'TestVolatile'
  # parm0:    edx       = int
  #           [sp+0x10]  (sp of caller)
  0xb4f487c0: cmp    0x4(%ecx),%eax     ;...3b4104
  0xb4f487c3: jne    0xb4f2cea0         ;...0f85d746 feff
                                        ;   {runtime_call}
  0xb4f487c9: xchg   %ax,%ax            ;...666690
[Verified Entry Point]
  0xb4f487cc: push   %ebp               ;...55
  0xb4f487cd: sub    $0x8,%esp          ;...81ec0800 0000
                                        ;*synchronization entry
                                        ; - TestVolatile::setB@-1 (line 18)
  0xb4f487d3: mov    %edx,0xc(%ecx)     ;...89510c
                                        ;*putfield b
                                        ; - TestVolatile::setB@2 (line 18)
  0xb4f487d6: add    $0x8,%esp          ;...83c408
  0xb4f487d9: pop    %ebp               ;...5d
  0xb4f487da: test   %eax,0xb7f62000    ;...85050020 f6b7
                                        ;   {poll_return}
  0xb4f487e0: ret                       ;...c3
  0xb4f487e1: hlt                       ;...f4
  0xb4f487e2: hlt                       ;...f4
  0xb4f487e3: hlt                       ;...f4
  0xb4f487e4: hlt                       ;...f4
  0xb4f487e5: hlt                       ;...f4
  0xb4f487e6: hlt                       ;...f4
  0xb4f487e7: hlt                       ;...f4
  0xb4f487e8: hlt                       ;...f4
  0xb4f487e9: hlt                       ;...f4
  0xb4f487ea: hlt                       ;...f4
  0xb4f487eb: hlt                       ;...f4
  0xb4f487ec: hlt                       ;...f4
  0xb4f487ed: hlt                       ;...f4
  0xb4f487ee: hlt                       ;...f4
  0xb4f487ef: hlt                       ;...f4
  0xb4f487f0: hlt                       ;...f4
  0xb4f487f1: hlt                       ;...f4
  0xb4f487f2: hlt                       ;...f4
  0xb4f487f3: hlt                       ;...f4
  0xb4f487f4: hlt                       ;...f4
  0xb4f487f5: hlt                       ;...f4
  0xb4f487f6: hlt                       ;...f4
  0xb4f487f7: hlt                       ;...f4
  0xb4f487f8: hlt                       ;...f4
  0xb4f487f9: hlt                       ;...f4
  0xb4f487fa: hlt                       ;...f4
  0xb4f487fb: hlt                       ;...f4
  0xb4f487fc: hlt                       ;...f4
  0xb4f487fd: hlt                       ;...f4
  0xb4f487fe: hlt                       ;...f4
  0xb4f487ff: hlt                       ;...f4
[Exception Handler]
[Stub Code]
  0xb4f48800: jmp    0xb4f47760         ;...e95befff ff
                                        ;   {no_reloc}
[Deopt Handler Code]
  0xb4f48805: push   $0xb4f48805        ;...680588f4 b4
                                        ;   {section_word}
  0xb4f4880a: jmp    0xb4f2dbe0         ;...e9d153fe ff
                                        ;   {runtime_call}
  0xb4f4880f: .byte 0x0                 ;...00
Decoding compiled method 0xb4f48108:
Code:
[Disassembling for mach='i386']
[Entry Point]
[Verified Entry Point]
[Constants]
  # {method} 'run' '()V' in 'TestVolatile$TestThread'
  0xb4f48200: call   0x00f97f00         ;...e8fbfc04 4c
                                        ;   {runtime_call}
  0xb4f48205: xchg   %ax,%ax            ;...666690
  0xb4f48208: mov    %eax,-0x3000(%esp)  ;...89842400 d0ffff
  0xb4f4820f: push   %ebp               ;...55
  0xb4f48210: sub    $0x18,%esp         ;...81ec1800 0000
  0xb4f48216: mov    (%ecx),%edi        ;...8b39
  0xb4f48218: mov    0x4(%ecx),%ebx     ;...8b5904
  0xb4f4821b: mov    %ecx,(%esp)        ;...890c24
  0xb4f4821e: call   0x01019af0         ;...e8cd180d 4c
                                        ;   {runtime_call}
  0xb4f48223: test   %ebx,%ebx          ;...85db
  0xb4f48225: je     0xb4f48331         ;...0f840601 0000
  0xb4f4822b: mov    0x4(%ebx),%ecx     ;...8b4b04
  0xb4f4822e: cmp    $0xad01adc0,%ecx   ;...81f9c0ad 01ad
                                        ;   {oop('TestVolatile$TestThread')}
  0xb4f48234: jne    0xb4f48351         ;...0f851701 0000
                                        ;*iload_1
                                        ; - TestVolatile$TestThread::run@2 (line 28)
  0xb4f4823a: cmp    $0xf4240,%edi      ;...81ff4042 0f00
  0xb4f48240: jge    0xb4f48314         ;...0f8dce00 0000
                                        ;*if_icmpge
                                        ; - TestVolatile$TestThread::run@5 (line 28)
  0xb4f48246: test   %ebx,%ebx          ;...85db
  0xb4f48248: je     0xb4f4833b         ;...0f84ed00 0000
  0xb4f4824e: mov    %edi,%ecx          ;...8bcf
  0xb4f48250: inc    %ecx               ;...41
                                        ;*aload_0
                                        ; - TestVolatile$TestThread::run@8 (line 29)
  0xb4f48251: mov    0x6c(%ebx),%eax    ;...8b436c
                                        ;*getfield t
                                        ; - TestVolatile$TestThread::run@9 (line 29)
  0xb4f48254: mov    %edi,%edx          ;...8bd7
  0xb4f48256: and    $0x1,%edx          ;...83e201
  0xb4f48259: mov    %edx,%ebp          ;...8bea
  0xb4f4825b: neg    %ebp               ;...f7dd
  0xb4f4825d: test   %edi,%edi          ;...85ff
  0xb4f4825f: cmovl  %ebp,%edx          ;...0f4cd5
                                        ;*irem
                                        ; - TestVolatile$TestThread::run@14 (line 29)
  0xb4f48262: test   %eax,%eax          ;...85c0
  0xb4f48264: je     0xb4f4831f         ;...0f84b500 0000
  0xb4f4826a: mov    %edx,0x8(%eax)     ;...895008
  0xb4f4826d: lock addl $0x0,(%esp)     ;...f0830424 00
                                        ;*putfield a
                                        ; - TestVolatile::setA@2 (line 14)
                                        ; - TestVolatile$TestThread::run@15 (line 29)
  0xb4f48272: mov    0x6c(%ebx),%eax    ;...8b436c
                                        ;*getfield t
                                        ; - TestVolatile$TestThread::run@19 (line 30)
  0xb4f48275: mov    %edx,0xc(%eax)     ;...89500c
                                        ;*aload_0
                                        ; - TestVolatile$TestThread::run@8 (line 29)
                                        ; implicit exception: dispatches to 0xb4f48369
  0xb4f48278: inc    %edi               ;...47
                                        ;*iinc
                                        ; - TestVolatile$TestThread::run@28 (line 28)
  0xb4f48279: cmp    %ecx,%edi          ;...3bf9
  0xb4f4827b: jl     0xb4f48251         ;...7cd4
  0xb4f4827d: mov    $0xf4240,%eax      ;...b840420f 00
  0xb4f48282: sub    %edi,%eax          ;...2bc7
  0xb4f48284: and    $0xfffffffe,%eax   ;...83e0fe
  0xb4f48287: add    %edi,%eax          ;...03c7
  0xb4f48289: cmp    %eax,%edi          ;...3bf8
  0xb4f4828b: jge    0xb4f482dd         ;...7d50
  0xb4f4828d: xchg   %ax,%ax            ;...666690
                                        ;*aload_0
                                        ; - TestVolatile$TestThread::run@8 (line 29)
  0xb4f48290: mov    0x6c(%ebx),%ecx    ;...8b4b6c
                                        ;*getfield t
                                        ; - TestVolatile$TestThread::run@9 (line 29)
  0xb4f48293: mov    %edi,%edx          ;...8bd7
  0xb4f48295: and    $0x1,%edx          ;...83e201
  0xb4f48298: mov    %edx,%ebp          ;...8bea
  0xb4f4829a: neg    %ebp               ;...f7dd
  0xb4f4829c: test   %edi,%edi          ;...85ff
  0xb4f4829e: cmovl  %ebp,%edx          ;...0f4cd5
                                        ;*irem
                                        ; - TestVolatile$TestThread::run@14 (line 29)
  0xb4f482a1: test   %ecx,%ecx          ;...85c9
  0xb4f482a3: je     0xb4f4831f         ;...0f847600 0000
  0xb4f482a9: mov    %edx,0x8(%ecx)     ;...895108
  0xb4f482ac: lock addl $0x0,(%esp)     ;...f0830424 00
                                        ;*putfield a
                                        ; - TestVolatile::setA@2 (line 14)
                                        ; - TestVolatile$TestThread::run@15 (line 29)
  0xb4f482b1: mov    0x6c(%ebx),%ebp    ;...8b6b6c
                                        ;*getfield t
                                        ; - TestVolatile$TestThread::run@19 (line 30)
  0xb4f482b4: mov    %edx,0xc(%ebp)     ;...89550c
                                        ;*putfield a
                                        ; - TestVolatile::setA@2 (line 14)
                                        ; - TestVolatile$TestThread::run@15 (line 29)
                                        ; implicit exception: dispatches to 0xb4f48369
  0xb4f482b7: mov    %edi,%esi          ;...8bf7
  0xb4f482b9: inc    %esi               ;...46
                                        ;*iinc
                                        ; - TestVolatile$TestThread::run@28 (line 28)
  0xb4f482ba: mov    %esi,%edx          ;...8bd6
  0xb4f482bc: and    $0x1,%edx          ;...83e201
  0xb4f482bf: mov    %edx,%ecx          ;...8bca
  0xb4f482c1: neg    %ecx               ;...f7d9
  0xb4f482c3: test   %esi,%esi          ;...85f6
  0xb4f482c5: cmovl  %ecx,%edx          ;...0f4cd1
                                        ;*irem
                                        ; - TestVolatile$TestThread::run@14 (line 29)
  0xb4f482c8: mov    %edx,0x8(%ebp)     ;...895508
  0xb4f482cb: lock addl $0x0,(%esp)     ;...f0830424 00
                                        ;*putfield a
                                        ; - TestVolatile::setA@2 (line 14)
                                        ; - TestVolatile$TestThread::run@15 (line 29)
  0xb4f482d0: mov    0x6c(%ebx),%ecx    ;...8b4b6c
                                        ;*getfield t
                                        ; - TestVolatile$TestThread::run@19 (line 30)
  0xb4f482d3: mov    %edx,0xc(%ecx)     ;...89510c
                                        ;*aload_0
                                        ; - TestVolatile$TestThread::run@8 (line 29)
                                        ; implicit exception: dispatches to 0xb4f48369
  0xb4f482d6: add    $0x2,%edi          ;...83c702
                                        ;*iinc
                                        ; - TestVolatile$TestThread::run@28 (line 28)
  0xb4f482d9: cmp    %eax,%edi          ;...3bf8
  0xb4f482db: jl     0xb4f48290         ;...7cb3
  0xb4f482dd: cmp    $0xf4240,%edi      ;...81ff4042 0f00
  0xb4f482e3: jge    0xb4f48314         ;...7d2f
  0xb4f482e5: xchg   %ax,%ax            ;...666690
                                        ;*aload_0
                                        ; - TestVolatile$TestThread::run@8 (line 29)
  0xb4f482e8: mov    0x6c(%ebx),%ecx    ;...8b4b6c
                                        ;*getfield t
                                        ; - TestVolatile$TestThread::run@9 (line 29)
  0xb4f482eb: mov    %edi,%edx          ;...8bd7
  0xb4f482ed: and    $0x1,%edx          ;...83e201
  0xb4f482f0: mov    %edx,%ebp          ;...8bea
  0xb4f482f2: neg    %ebp               ;...f7dd
  0xb4f482f4: test   %edi,%edi          ;...85ff
  0xb4f482f6: cmovl  %ebp,%edx          ;...0f4cd5
                                        ;*irem
                                        ; - TestVolatile$TestThread::run@14 (line 29)
  0xb4f482f9: test   %ecx,%ecx          ;...85c9
  0xb4f482fb: je     0xb4f4831f         ;...7422
  0xb4f482fd: mov    %edx,0x8(%ecx)     ;...895108
  0xb4f48300: lock addl $0x0,(%esp)     ;...f0830424 00
                                        ;*putfield a
                                        ; - TestVolatile::setA@2 (line 14)
                                        ; - TestVolatile$TestThread::run@15 (line 29)
  0xb4f48305: mov    0x6c(%ebx),%ebp    ;...8b6b6c
                                        ;*getfield t
                                        ; - TestVolatile$TestThread::run@19 (line 30)
  0xb4f48308: mov    %edx,0xc(%ebp)     ;...89550c
                                        ;*putfield b
                                        ; - TestVolatile::setB@2 (line 18)
                                        ; - TestVolatile$TestThread::run@25 (line 30)
                                        ; implicit exception: dispatches to 0xb4f48369
  0xb4f4830b: inc    %edi               ;...47
                                        ;*iinc
                                        ; - TestVolatile$TestThread::run@28 (line 28)
  0xb4f4830c: cmp    $0xf4240,%edi      ;...81ff4042 0f00
  0xb4f48312: jl     0xb4f482e8         ;...7cd4
                                        ;*iload_1
                                        ; - TestVolatile$TestThread::run@2 (line 28)
  0xb4f48314: add    $0x18,%esp         ;...83c418
  0xb4f48317: pop    %ebp               ;...5d
  0xb4f48318: test   %eax,0xb7f62000    ;...85050020 f6b7
                                        ;   {poll_return}
  0xb4f4831e: ret                       ;...c3
  0xb4f4831f: mov    $0xfffffff6,%ecx   ;...b9f6ffff ff
  0xb4f48324: mov    %edx,%ebp          ;...8bea
  0xb4f48326: nop                       ;...90
  0xb4f48327: call   0xb4f2c720         ;...e8f443fe ff
                                        ; OopMap{off=300}
                                        ;*invokevirtual setA
                                        ; - TestVolatile$TestThread::run@15 (line 29)
                                        ;   {runtime_call}
  0xb4f4832c: call   0x00f97f00         ;...e8cffb04 4c
                                        ;*invokevirtual setA
                                        ; - TestVolatile$TestThread::run@15 (line 29)
                                        ;   {runtime_call}
  0xb4f48331: mov    $0x0,%ebx          ;...bb000000 00
  0xb4f48336: jmp    0xb4f4823a         ;...e9fffeff ff
  0xb4f4833b: mov    $0xffffff86,%ecx   ;...b986ffff ff
  0xb4f48340: mov    %ebx,%ebp          ;...8beb
  0xb4f48342: mov    %edi,0x4(%esp)     ;...897c2404
  0xb4f48346: nop                       ;...90
  0xb4f48347: call   0xb4f2c720         ;...e8d443fe ff
                                        ; OopMap{ebp=Oop off=332}
                                        ;*aload_0
                                        ; - TestVolatile$TestThread::run@8 (line 29)
                                        ;   {runtime_call}
  0xb4f4834c: call   0x00f97f00         ;...e8affb04 4c
                                        ;   {runtime_call}
  0xb4f48351: mov    $0xffffffad,%ecx   ;...b9adffff ff
  0xb4f48356: mov    %ebx,%ebp          ;...8beb
  0xb4f48358: mov    %edi,0x4(%esp)     ;...897c2404
  0xb4f4835c: xchg   %ax,%ax            ;...666690
  0xb4f4835f: call   0xb4f2c720         ;...e8bc43fe ff
                                        ; OopMap{ebp=Oop off=356}
                                        ;*iload_1
                                        ; - TestVolatile$TestThread::run@2 (line 28)
                                        ;   {runtime_call}
  0xb4f48364: call   0x00f97f00         ;...e897fb04 4c
                                        ;   {runtime_call}
  0xb4f48369: mov    $0xfffffff6,%ecx   ;...b9f6ffff ff
  0xb4f4836e: mov    %edx,%ebp          ;...8bea
  0xb4f48370: xchg   %ax,%ax            ;...666690
  0xb4f48373: call   0xb4f2c720         ;...e8a843fe ff
                                        ; OopMap{off=376}
                                        ;*invokevirtual setB
                                        ; - TestVolatile$TestThread::run@25 (line 30)
                                        ;   {runtime_call}
  0xb4f48378: call   0x00f97f00         ;...e883fb04 4c
                                        ;*aload_0
                                        ; - TestVolatile$TestThread::run@8 (line 29)
                                        ;   {runtime_call}
  0xb4f4837d: hlt                       ;...f4
  0xb4f4837e: hlt                       ;...f4
  0xb4f4837f: hlt                       ;...f4
[Exception Handler]
[Stub Code]
  0xb4f48380: jmp    0xb4f47760         ;...e9dbf3ff ff
                                        ;   {no_reloc}
[Deopt Handler Code]
  0xb4f48385: push   $0xb4f48385        ;...688583f4 b4
                                        ;   {section_word}
  0xb4f4838a: jmp    0xb4f2dbe0         ;...e95158fe ff
                                        ;   {runtime_call}
  0xb4f4838f: .byte 0x0                 ;...00

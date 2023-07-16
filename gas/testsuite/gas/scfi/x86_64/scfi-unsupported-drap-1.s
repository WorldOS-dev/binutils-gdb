# Testcase with Dynamically Realigned Argument Pointer (DRAP)
# register usage.
#
# There are two reasons why this cannot be supported with the current
# SCFI machinery
# 1. Not allowed: REG_CFA is r10 based for the few insns after
#    'leaq    8(%rsp), %r10'.
# 2. Untraceable stack size after 'andq    $-16, %rsp'
# Both of these shortcomings may be worked out. FIXME DISCUSS Keep the rather
# long testcase until then.
	.text
	.globl	drap_foo
	.type	drap_foo, @function
drap_foo:
.LFB0:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-16, %rsp
	pushq	-8(%r10)
        .cfi_def_cfa 7, 8
	pushq	%rbp
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	pushq	%rbx
	.cfi_offset 3, -64
	subq	$32, %rsp
	movq	$0, (%rdx)
	cmpq	$0, (%rdi)
	movq	$0, -56(%rbp)
	je	.L21
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	movq	%rsi, %r12
	call	func2@PLT
	movq	(%rbx), %rdi
	leaq	-56(%rbp), %rdx
	movslq	%eax, %rsi
	call	func1@PLT
	testl	%eax, %eax
	je	.L21
	movq	-56(%rbp), %r13
.L21:
	addq	$32, %rsp
	xorl	%eax, %eax
	popq	%rbx
	.cfi_restore 3
	popq	%r10
	popq	%r12
	.cfi_restore 12
	popq	%r13
	.cfi_restore 13
	popq	%r14
	.cfi_restore 14
	popq	%r15
	.cfi_restore 15
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_register 7
	.cfi_def_cfa_offset 8
	leaq	-8(%r10), %rsp
	ret
	.cfi_endproc
.LFE0:
	.size	drap_foo, .-drap_foo

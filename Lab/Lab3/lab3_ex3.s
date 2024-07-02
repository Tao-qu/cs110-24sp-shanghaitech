.data
test_input: .word -6 -3 5 11

.text
main:
	add t0, x0, x0
	addi t1, x0, 4
	la t2, test_input
main_loop:
	beq t0, t1, main_exit
	slli t3, t0, 2
	add t4, t2, t3
	lw a0, 0(t4)

	addi sp, sp, -20
	sw t0, 0(sp)
	sw t1, 4(sp)
	sw t2, 8(sp)
	sw t3, 12(sp)
	sw t4, 16(sp)

	jal ra, squareSum

	lw t0, 0(sp)
	lw t1, 4(sp)
	lw t2, 8(sp)
	lw t3, 12(sp)
	lw t4, 16(sp)
	addi sp, sp, 20

	addi a1, a0, 0
	addi a0, x0, 1
	ecall # Print Result
	addi a1, x0, ' '
	addi a0, x0, 11
	ecall
	
	addi t0, t0, 1
	jal x0, main_loop
main_exit:  
	addi a0, x0, 10
	ecall # Exit

squareSum: 
	addi t0, x0, 0
	beq a0, x0, done
	add t1, a0, x0

loop:
	blt a0, x0, negative

positive:
	mul t2, t1, t1
	add t0, t0, t2
	addi t1, t1, -1
	beq t1, x0, done
	j loop

negative:
	mul t2, t1, t1
	add t0, t0, t2
	addi t1, t1, 1
	beq t1, x0, done
	j loop

done:
	add a0, t0, x0
	jr ra
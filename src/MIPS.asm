# MIPS.asm
# David_Harris@hmc.edu 9 November 2005 
#
# Test the MIPS processor.
# Primary instructions - add, sub, and, or, slt, addi, lw, sw, beq, j
# Added shift instructions - sll, srl, sra, ror, rol
# If successful, it should write the value 7 to address 84

#       Assembly             Description          	            Address		Machine		Converted assembly
main:   addi $2,  $0, 5      # initialize $2 = 5  				@0      	20020005	addi $v0	$zero	0x5 
        addi $3,  $0, 12     # initialize $3 = 12 				@4      	2003000C	addi $v1	$zero	0xC
        addi $7,  $3, -9     # initialize $7 = 3  				@8      	2067FFF7 	addi $a3	$v1		0xFFFFFFFFF7
        or   $4,  $7, $2     # $4 <= 3 or 5 = 7   				@C      	00E22025	or   $a0	$a3		$v0
        and  $5,  $3, $4     # $5 <= 12 and 7 = 4 				@10     	00642824	and  $a1	$v1		$a0
        add  $5,  $5, $4     # $5 = 4 + 7 = 11    				@14     	00A42820	add  $a1	$a1		$a0
        beq  $5,  $7, end    # 11 != 3, shouldn’t be taken		@18     	10A7000A	beq  $a1	$a3		end
        slt  $4,  $3, $4     # $4 = 12 < 7 = 0    				@1C     	0064202A	slt  $a0	$v1		$a0
        beq  $4,  $0, around # 0 = 0, should be taken			@20     	10800001	beq  $a0	$zero	0x1
        addi $5,  $0, 0      # shouldn’t happen   				@24     	20050000	addi $a1	$zero	0x0
around: slt  $4,  $7, $2     # $4 = 3 < 5 = 1     				@28     	00E2202A	slt  $a0	$a3		$v0
        add  $7,  $4, $5     # $7 = 1 + 11 = 12   				@2C     	00853820	add  $a3	$a0		$a1
        sub  $7,  $7, $2     # $7 = 12 - 5 = 7					@30     	00E23822	sub  $a3	$a3		$v0
        sw   $7,  68($3)     # write [80] = 7           		@34     	AC670044	sw   $a3	0x44	$v1
        lw   $2,  80($0)     # $2(5) = [80] = 7    				@38     	8C020050	lw   $v0	0x50	$zero
        j    end             # should be taken    				@3C     	08000011	j    0x1
        addi $2,  $0, 1      # shouldn’t happen   				@40     	20020001	addi $v0	$zero	0x1
end:    sw   $2,  84($0)     # write [84] = 7					@44     	AC020054	sw   $v0	0x54	$zero
		addi $8,  $4,  25 	 # initialize $8 = 27				@48     	2088001A	addi $t0 	$a0		0x1A
		addi $9,  $4,  19 	 # initialize $9 = 21				@4C     	20890014	addi $t1 	$a0		0x14
		xor	 $10, $9,  $8	 # $10 = 21^27 = 14					@50     	01285026	xor	 $t2	$t1		$t0
		nor	 $11, $9,  $4	 # $11 = ~(21|1) = 10				@54     	01245827	nor	 $t3	$t1		$a0
		andi $13, $10, 7	 # $13 = 14 & 7 = 6 				@58     	314D0007	andi $t5	$t2		0x7
		ori  $14, $10, 13	 # $14 = 14 | 13 = 15  				@5c     	354E000D	ori	 $t6	$t2		0xD
		xori $15, $10, 27	 # $15 = 14 ^ 27 = 21				@60     	394F001B	xori $t7	$t2		0x1B
		bne  $15, $14, label # 21 != 15, should be taken		@64     	15EE0001	bne  $t7	$t6		0x1
		xor	 $15, $15, $14	 # shouldn’t happen					@68     	01EE7826	xor	 $t7	$t7		$t6	
label:	slti $12, $10, 11	 # $12 = 14 < 11 = 0				@6C	     	294C000B	slti $t4	$t2		0xB
		addi $13, $0,  50	 # initialize $13 = 50				@70     	200D0032	addi $t5 	$zero	0x32
		sll  $14, $13, 4	 # $17 = 50 sll 4 = 800				@74 		000D7100	sll	 $t6	$t5		0x4
		srl  $14, $13, 4     # $18 = 50 srl 4 = 3				@78 		000D7102	srl	 $t6	$t5		0x4		
		sra  $14, $13, 4     # $19 = 50 sra 4 = 3				@7C			000D7103	sra	 $t6	$t5		0x4
		ror  $14, $13, 4     # $20 = 50 ror 4 = 536870915		@80 		000D7104	ror  $t6	$t5		0x4
		rol  $14, $13, 4     # $21 = 50 rol 4 = 800				@84 		000D7105	rol	 $t6	$t5		0x4

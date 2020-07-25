   		org	00h
		mov	r4,#00h	;// sec reg
		mov	r5,#00h	;//min reg
		mov	r6,#00h	;//hour reg
start:	mov	a,r6  ;//copy content of r6 into accumulater  a=00h
		acall seven_seg	// call subroutine for display into seven segment with appropriate code
		mov	p1,a	// output current data into port 1
		jb	p0.0,kk2 //check increment switch  ,if switch is pressed increment r6 otherwise jump to level kk1
		inc	r6
		cjne	r6,#0dh,kk1	;// check r6 =13 ,if yes r6=1 else jump to kk1 
		mov	r6,#01h
kk1:	acall delay
		acall delay	
		acall delay
		sjmp	start // jump to start

kk2:	jb	p0.1,cj1//check changeover switch ,if pressed jump to min(next1) otherwise jump to cj1 ( check for start switch
		acall delay	
		acall delay
		sjmp	next1
cj1:	jb	p0.2,start		//check start switch if not pressed jump to start otherwise jump exe
		sjmp	exe


next1:	mov	a,r5 ;//copy content of r5 into accumulater  a=00h
		mov	b,#0ah	; load b register with 10
		div	ab
		acall seven_seg	// call subroutine for display into seven segment with appropriate code
		mov	p2,a
		mov	a,b
		acall seven_seg	// call subroutine for display into seven segment with appropriate code
		mov	p3,a
		jb	p0.0,cj11 //check increment switch
		inc	r5
		cjne	r5,#3ch,kk11 // check r5 =60 ,if yes r5=0 else jump to kk11 
		mov	r5,#00h
kk11:		acall delay
		acall delay	
		acall delay
		sjmp	next1


cj11:	jb	p0.2,next1		//check start switch
		sjmp	exe


exe:	 mov	r4,#3ch	 //start of a clock	r4=60
t11:	/*call	delay //delay for 500ms	 */
		call	delay
		setb	p2.7
		call	delay //delay for 500ms
	/*	call	delay */
		clr		p2.7
		djnz	r4,t11	; decrement and jump  to t11 till r4=0
		inc	r5	  // increment min
		cjne	r5,#3ch,t12	  // check min-60 ,if true  min=00,increment hour value else jump to t12
		mov	r5,#00h
		inc	r6
		cjne	r6,#0dh,t12
		mov	r6,#01h
	    mov	r5,#00h
 t12:	mov	a,r5		 /* prgram for min display---  */
		mov	b,#0ah		/* prgram for min display---  */	 
		div	ab			   /* prgram for min display---  */
		acall seven_seg	/* prgram for min display---  */	 
		mov	p2,a		  /* prgram for min display---  */
		mov	a,b				/* prgram for min display---  */  
		acall seven_seg	  /* prgram for min display---  */
		mov	p3,a		  	/* prgram for min display---  */
		mov	a,r6			// copy content r6 into acc
		acall seven_seg
		mov	p1,a			//display hour
		ljmp	exe
delay :
		 MOV R2, #196
    L2: MOV R3, #255
    L1: NOP;
         NOP;
         NOP;
		 DJNZ R3, L1;
		 DJNZ R2, L2; 
		 RET
seven_seg:	cjne	a,#00h,b11 // compare acc content with 00h ,if equal load value c0 into acc
			mov	a,#0c0h
			ret
	b11:	cjne	a,#01,b12
			mov	a,#0f9h
			ret
	b12:	   cjne	a,#	02h	,b13
			mov	a,#0a4h
			ret
	 	b13:	   cjne	a,#03h,b14
			mov	a,#0b0h
			ret
	
	  	b14:	   cjne	a,#04h,b15
			mov	a,#99h
			ret
	
	 	b15:	   cjne	a,#05h,b16
			mov	a,#92h
			ret
	
	  	b16:	   cjne	a,#06h,b17
			mov	a,#82h
			ret
	  	b17:	   cjne	a,#07h,b18
			mov	a,#0f8h
			ret
	   	b18: cjne	a,#	08h	,b19
			mov	a,#80h
			ret
		b19:cjne	a,#09h	,b20
			mov	a,#90h
			ret
		b20:	   cjne	a,#0ah,b21
			mov	a,#40h
			ret
		b21:	   cjne	a,#0bh,b22
			mov	a,#79h
			ret
		b22: cjne	a,#0ch,b23
			mov	a,#24h
			ret
		b23:cjne	a,#0dh,b24
		    mov	a,#30h
		b24:	ret
		
		end
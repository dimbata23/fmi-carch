masm
model	small
.data
message	db	'Hello World!$'
.stack	256
.code
main:
	mov	ax, @data
	mov	ds, ax
	mov	ah, 9
	mov	dx, offset message
	int	21h
	mov	ax,4c00h
	int	21h
end	main

# exemplo de registro
#	nome: string de ateh 30 caracteres + caractere de final de string = 31 
#	Rua:	31 bytes
#	numero:	 4 bytes
#	bairro:	31 bytes
#	cep: 	9 byte
#	cidade: 31 bytes
#	telefone: 10 bytes
#	email: 31 bytes
#	data_nasc: 11 bytes
#	genero: 4 bytes
# 	cpf: 12 bytes
#	rg: 10 bytes
#	data_contrato: 11 bytes
#	cargo: 31 bytes
#	salario: 4 bytes
# 	prox: 4 bytes para conter o endereco do proximo registro
#	
#	total de bytes: 265 bytes

.section .data

	
	abertura:	.asciz	"\n=================SistemaRegistros======================\n"
	opcoes:		.asciz 	"\n Para inserir aperte <1> Para remover aperte <2> Para relatório aperte <3> Para consulta aperte <4>:"
	pedenome:	.asciz	"\nDigite o nome: "
	pedeRua:	.asciz	"\nDigite a rua: "
	pedeNumero: .asciz	"\nDigite o numero: "
	pedeBairro: .asciz	"\nDigite o bairro: "
	pedeCEP:	.asciz	"\nDigite o CEP: "
	pedeCidade:	.asciz	"\nDigite o cidade: "
	pedeTelefone: .asciz	"\nDigite o telefone: "
	pedeEmail:        .asciz "\nDigite o email: "
    pedeDataNascimento:    .asciz "\nDigite a data de nascimeto: "
    pedeGenero:       .asciz "\nDigite o gênero (<M>asculino, <F>eminino): "
    pedeCPF:          .asciz "\nDigite o CPF: "
    pedeRG:           .asciz "\nDigite o RG: "
    pedeDataContrato:   .asciz "\nDigite a data do contrato: "
    pedeCargo:        .asciz "\nDigite o cargo: "
    pedeSalario:      .asciz "\nDigite o salario: "
	eh_nula: 		   .asciz "\nNome não foi encontrado no banco de dados"

    
	pedeNomeRemover: .asciz "\nDigite o nome para remoção: "
    pedeNomeBusca: .asciz "\nDigite o nome que deseja buscar: "


 	mostraNome:       .asciz "\n\tNome :%s \n"
    mostraRua:        .asciz "\tRua          : %s\n"
    mostraNumero:     .asciz "\tNumero       : %d\n"
    mostraBairro:     .asciz "\tBairro       : %s\n"
    mostraCep:        .asciz "\tCep          : %s\n"
    mostraCidade:     .asciz "\tCidade       : %s\n"
    mostraTelefone:   .asciz "\tTelefone     : %s\n"
    mostraEmail:      .asciz "\tEmail        : %s\n"
    mostraDataNasc:  .asciz "\tNascimento   : %s\n"
    mostraGenero:     .asciz "\tGenero       : %c\n"
    mostraCpf:        .asciz "\tCPF          : %s\n"
    mostraRg:         .asciz "\tRG           : %s\n"
    mostradataContr: .asciz "\tData de contrato: %s\n"
    mostraCargo:      .asciz "\tPosição na empresa: %s\n"
    mostraSalario:    .asciz "\tSalario: R$ %d\n"
	
	tamreg:		.int	265
	tamLista:	.int	0

	

	tipoint:	.asciz	"%d"
	tipoaddr:   .asciz  "%X\n"
	tipocar:	.asciz	"%c"
	tipostr:	.ASCIZ	"%S"
	pulaLinha:	.asciz	"\n"

	lista:		.int	0
	opcao: 		.int	0 	

	nomeBuffer: .int

	NULL:		.int	0

.section .text 


.globl _start

_start:
	movl $NULL, lista
	inicio:
	# abertura para escolher a função
	

	pushl	$abertura
	call	printf

	pushl	$opcoes
	call	printf
	
	# pegando a opcao
	pushl	$opcao
	pushl	$tipoint
	call	scanf



	addl	$20, %esp
	# realizando comparacao inserir
	cmpl	$1, opcao
	je		ler_registro

	# realizando comparacao para remover
	cmpl	$2, opcao
	je		remover_registro
	
	# realizando comparacao pintara mostrar
	cmpl 	$3, opcao
	je		relatorio
	# comp para consulta
	cmpl 	$4, opcao
	je		mostrar_1_registro



	pushl	$0
	call	exit
# Essa função serve para que sejam mostrado todos os funcionários
# cadastrados e suas respectivas informações
relatorio:
	movl lista, %eax
	# verificação de que a lista é nula
	laco3:
		cmpl $NULL, %eax
		je inicio
	
	pushl %eax
	pushl $mostraNome
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax
	
	pushl %eax
	pushl $mostraRua
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax


	pushl %eax
	pushl (%eax)	
	pushl $mostraNumero
	call printf
	addl $8, %esp
	popl %eax

	addl $4, %eax

	pushl %eax
	pushl $mostraBairro
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $mostraCep
	call printf
	addl $4, %esp
	popl %eax

	addl $9, %eax

	pushl %eax
	pushl $mostraCidade
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $mostraTelefone
	call printf
	addl $4, %esp
	popl %eax

	addl $10, %eax

	pushl %eax
	pushl $mostraEmail
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $mostraDataNasc
	call printf
	addl $4, %esp
	popl %eax

	addl $11, %eax

	pushl %eax
	pushl (%eax)
	pushl $mostraGenero
	call printf
	addl $8, %esp
	popl %eax

	addl $4, %eax

	pushl %eax
	pushl $mostraCpf
	call printf
	addl $4, %esp
	popl %eax

	addl $12, %eax

	pushl %eax
	pushl $mostraRg
	call printf
	addl $4, %esp
	popl %eax

	addl $10, %eax

	pushl %eax
	pushl $mostradataContr
	call printf
	addl $4, %esp
	popl %eax

	addl $11, %eax

	pushl %eax
	pushl $mostraCargo
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl (%eax)
	pushl $mostraSalario
	call printf
	addl $8, %esp
	popl %eax
	addl $4, %eax
	movl (%eax), %eax
	jmp laco3



ler_registro:
	# Antes que ocorra a alocação de um registro 
	# pede-se o nome da pessoa
	pushl 	$pedenome
	call 	printf
	addl 	$4, %esp

	pushl	$nomeBuffer
	call	gets 
	call 	gets
	addl 	$4, %esp
	
	# No caso de a lista estar vazia 
	cmpl	$NULL ,lista
	je		alocaPrimeiro
	# No caso da lista ja ter funcionários
	jne		alocaOrdenado

alocaOrdenado:
	movl lista, %ecx # atual
	movl $NULL, %ebx # anterior

	laco:
		# A lista está vazia
		cmpl $NULL, %ecx
		je 	 inserir

		# chamando strcmp 
		# iterando na lista buscando a posição onde inserir
		
		pushl %ebx 
		pushl %ecx
		pushl $nomeBuffer
		call  strcmp

		addl $4, %esp
		popl %ecx
		popl %ebx

		

		cmpl $0, %eax
		jle  inserir
		
		movl %ecx, %ebx
		movl 261(%ecx), %ecx
		jmp laco


	inserir:
		pushl %ebx
		pushl %ecx
		
		pushl tamreg
		call malloc
		addl $4, %esp

		popl %ecx
		popl %ebx

		cmpl $NULL, %ebx
		je inserePrimeiro
		
		movl %ecx, 261(%eax) # novo.prox = atual
		movl %eax, 261(%ebx) # anterior.prox = novo

		call ler
		jmp inicio

	inserePrimeiro:
		movl %ecx, 261(%eax) 
		movl %eax, lista 

		call ler
		jmp inicio

alocaPrimeiro:
	# registro em eax
	pushl tamreg
	call malloc
	addl $4, %esp

	movl %eax, lista # lista aponta para eax
	movl $NULL, 261(%eax) # no campo do proximo do novo NULL é setado
	incl tamLista

	call ler
	jmp inicio

# Função de leitrua de dados
ler:
	pushl $nomeBuffer 
	pushl %eax 
    call strcpy 
    popl %eax 
    addl $4, %esp

	addl $31, %eax
	
	pushl %eax 
	pushl $pedeRua 
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $31, %eax
	
	pushl %eax
	pushl $pedeNumero
	call  printf
	addl $4, %esp
	popl %eax
	pushl %eax
	pushl $tipoint
	call  scanf
	addl $4, %esp
	popl %eax

	addl $4, %eax

	pushl %eax
	pushl $pedeBairro
	call  printf
	addl $4, %esp
	call gets
	call gets
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $pedeCEP
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $9, %eax

	pushl %eax
	pushl $pedeCidade
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $pedeTelefone
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $10,  %eax

	pushl %eax
	pushl $pedeEmail
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $pedeDataNascimento
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $11, %eax

	pushl %eax
	pushl $pedeGenero
	call printf
	addl $4, %esp
	pushl $tipocar
	call scanf
	addl $4, %esp
	popl %eax

	addl $4, %eax

	pushl %eax
	pushl $pedeCPF
	call printf
	addl $4, %esp
    call gets
	call gets
	popl %eax

	addl $12,%eax

	pushl %eax
	pushl $pedeRG
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $10, %eax

	pushl %eax
	pushl $pedeDataContrato
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $11, %eax

	pushl %eax
	pushl $pedeCargo
	call printf
	addl $4, %esp
	call gets
	popl %eax

	addl $31, %eax
	
	pushl %eax
	pushl $pedeSalario
	call printf
	addl $4, %esp
	pushl $tipoint
	call scanf
	addl $4, %esp
	popl %eax

	ret

# Função que recebe um nome digitado e retorna um registro 
# caso ele exista
Busca_nome:
	pushl $nomeBuffer
	pushl $pedeNomeBusca
	call printf
	addl $4, %esp
	call gets
	call gets
	addl $4, %esp

	movl lista, %edi
	# Lista em EDI iterar para buscar um nome 
	# Armazena ele em EAX
	laco2:
		cmpl $NULL, %edi
		je naoAchou

		pushl %edi
		pushl $nomeBuffer
		call strcmp
		addl $4, %esp
		popl %edi

		cmpl $0, %eax
		je encontrado

		movl 261(%edi), %edi
		jmp laco2

	encontrado:
		movl %edi, %eax
		ret

	naoAchou:
		movl $NULL, %eax
		ret

# ocorre a chamada da função busca nome
# caso o nome exista o registro relativo ao mesmo ficará salvo em EAX
# e será mostrado
mostrar_1_registro:
	call Busca_nome
	cmpl $NULL, %eax
	je eh_nulo

	pushl %eax
	pushl $mostraNome
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax
	
	pushl %eax
	pushl $mostraRua
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax


	pushl %eax
	pushl (%eax)
	pushl $mostraNumero
	call printf
	addl $8, %esp
	popl %eax

	addl $4, %eax

	pushl %eax
	pushl $mostraBairro
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $mostraCep
	call printf
	addl $4, %esp
	popl %eax

	addl $9, %eax

	pushl %eax
	pushl $mostraCidade
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $mostraTelefone
	call printf
	addl $4, %esp
	popl %eax

	addl $10, %eax

	pushl %eax
	pushl $mostraEmail
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl $mostraDataNasc
	call printf
	addl $4, %esp
	popl %eax

	addl $11, %eax

	pushl %eax
	pushl (%eax)
	pushl $mostraGenero
	call printf
	addl $8, %esp
	popl %eax

	addl $4, %eax

	pushl %eax
	pushl $mostraCpf
	call printf
	addl $4, %esp
	popl %eax

	addl $12, %eax

	pushl %eax
	pushl $mostraRg
	call printf
	addl $4, %esp
	popl %eax

	addl $10, %eax

	pushl %eax
	pushl $mostradataContr
	call printf
	addl $4, %esp
	popl %eax

	addl $11, %eax

	pushl %eax
	pushl $mostraCargo
	call printf
	addl $4, %esp
	popl %eax

	addl $31, %eax

	pushl %eax
	pushl (%eax)
	pushl $mostraSalario
	call printf
	addl $8, %esp
	popl %eax
	jmp inicio


	eh_nulo:
		pushl $eh_nula
		call printf
		addl $4, %esp
		jmp inicio
	
# função para remover um registro da lista
# é pedido um nome e ocorre a verificação da existencia do mesmo
remover_registro:
	pushl $pedeNomeRemover
	call printf
	addl $4, %esp

	pushl $nomeBuffer
	call gets
	call gets

	addl $4, %esp

	movl lista, %ecx # tem o atual
	movl $NULL, %ebx # tem o anterior
	# busca pelo nome na lista
	laco4:
		cmpl $NULL, %ecx
		je eh_nulo

		pushl %ebx
		pushl %ecx
		pushl $nomeBuffer

		call strcmp
		addl $4, %esp

		popl %ecx
		popl %ebx

		cmpl $0, %eax
		je removerAtual

		movl %ecx, %ebx
		movl 261(%ecx), %ecx
		jmp laco4
	
	# função para remover o registro
	removerAtual:
		cmpl $NULL, %ebx # se o registro encontrado for o primeiro a remoção é diferente
		je removePrimeiro

		movl 261(%ecx), %edx
		movl %edx, 261(%ebx) 
		
		pushl %ecx
		call free
		addl $4,%esp
		jmp inicio
		# remoção do 1o resgitro da lista
		removePrimeiro:
			movl 261(%ecx), %edx
			movl %edx, lista
			pushl %ecx
			call free
			addl $4,%esp
			jmp inicio

sair:
	pushl $0
	call exit

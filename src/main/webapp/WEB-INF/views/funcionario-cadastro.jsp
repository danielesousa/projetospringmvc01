<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>

<!--Referencia para o arquivo css-->
<link rel="stylesheet" href="resources/css/bootstrap.min.css" />

<!-- estilo css para o jquery validate -->
<style>
/*Formata as mensagens de erro do Jquery Validate */
label.error {
	color: #d9534f;
}

input.error {
	border: 1px solid #d9534f;
}

select.error {
	border: 1px solid #d9534f;
}
</style>

</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Controle de Funcionários</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/projetoSpringMVC01/">Página Inicial</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							Gerenciar Funcionários </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item"
								href="/projetoSpringMVC01/funcionario-cadastro">Cadastrar
									Funcionários</a></li>
							<li><a class="dropdown-item"
								href="/projetoSpringMVC01/funcionario-consulta">Consultar
									Funcionários</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item"
								href="/projetoSpringMVC01/funcionario-relatorio">Relatório
									de Funcionários</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="nav-scroller bg-body shadow-sm">
		<nav class="nav nav-undeline">
			<p class="mt-3 ml-4">&nbsp;&nbsp;&nbsp;Sistema desenvolvido em
				Spring MVC com Spring JDBC, Bootstrap e JQUERY.</p>
		</nav>
	</div>
	
	<!-- Mensagem de sucesso -->
	<c:if test="${not empty mensagem_sucesso }">
		<div class="alert alert-success alert-dismissible fade show"
			role="alert">
			<strong>Sucesso!</strong> ${mensagem_sucesso}
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
	</c:if>
	
	<!-- Mensagem de erro -->
	<c:if test="${not empty mensagem_erro }">
		<div class="alert alert-danger alert-dismissible fade show"
			role="alert">
			<strong>Erro!</strong> ${mensagem_erro}
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
	</c:if>


	<div class="container mt-4">
		<h5>Cadastro de Funcionário</h5>
		<hr>

		<form id="formcadastro" action="cadastrarFuncionario" method="post">
			<div class="row">
				<div class="col-md-4">
					<label>Nome do Funcionário</label>
					<form:input path="dto.nome" name="nome" id="nome" type="text"
						class="form-control" placeholder="Ex: Joao da Silva" />
					<br> <label>CPF</label>
					<form:input path="dto.cpf" name="cpf" id="cpf" type="text"
						class="form-control" placeholder="Ex: 123.456.789.00" />
					<br> <label>Matrícula</label> <form:input path="dto.matricula" name="matricula"
						id="matricula" type="text" class="form-control"
						placeholder="Ex: 2021-001" /> <br>
				</div>

				<div class="col-md-4">
					<label>Data de Admissão</label>
					<form:input path="dto.dataadmissao" name="dataadmissao"
						id="dataadmissao" type="date" class="form-control" />
					<br> <label>Situação do Funcionario</label>
					<form:select path="dto.situacao" name="situacao" id="situacao"
						class="form-select">
						<option value="">Escolha uma opção</option>
						<option value="Admitido">Funcionario Admitido</option>
						<option value="Ferias">Funcionario de Férias</option>
						<option value="Afastado">Funcionario Afastado</option>
						<option value="Demitido">Funcionario Demitido</option>
					</form:select>
				</div>
			</div>
			<div>

				<div class="row">
					<div class="col-md-4">

						<div class="d-grid gap-2">
							<button class="btn btn-success" type="submit">Realizar
								Cadastro</button>
						</div>

					</div>
				</div>

			</div>
		</form>

	</div>

	<!-- referencia para arquivo JS -->
	<script src="resources/js/bootstrap.min.js"></script>

	<!-- referencia para o arquivo do jquery -->
	<script src="resources/js/jquery-3.6.0.min.js"></script>

	<!-- referencia para o jquery masked input -->
	<script src="resources/js/jquery.maskedinput.min.js"></script>

	<!-- referencias para o jquery validate -->
	<script src="resources/js/jquery.validate.min.js"></script>
	<script src="resources/js/messages_pt_BR.min.js"></script>

	<script>
		//quando a pagina for carregada faça
		$(document).ready(function() {

			//aplicando mascara nos campos do formulário..
			$("#cpf").mask("999.999.999.99");
			$("#matricula").mask("9999-9999");

			//aplicando validaçao ao formulário...
			$("#formcadastro").validate({
				//regras de validaçao
				rules : {
					"nome" : {
						required : true,
						minlength : 6,
						maxlength : 150
					},
					"cpf" : {
						required : true
					},
					"matricula" : {
						required : true
					},
					"dataadmissao" : {
						required : true
					},
					"situacao" : {
						required : true
					}

				}

			});

		})
	</script>


</body>
</html>

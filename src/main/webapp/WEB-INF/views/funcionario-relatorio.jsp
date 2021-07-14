<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>

<!--Referencia para o arquivo css-->
<link rel="stylesheet" href="resources/css/bootstrap.min.css" />

<!-- referencias para o jquery dataTable -->
<link rel="stylesheet" href="resources/css/jquery.dataTables.min.css" />

<!-- estilo css para o jquery validate -->
<style>
/*Formata as mensagens de erro do Jquery Validate */
label.error {
	color: #d9534f;
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
						aria-current="page" href="/projetoSpringMVC01/home">Página
							Inicial</a></li>
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
				<form class="d-flex">
					<span class="text-white mt-3" style="margin-right: 20px;">
						${usuario_autenticado.nome} (${usuario_autenticado.email}) </span> <a
						href="/projetoSpringMVC01/logout"
						class="btn btn-outline-secondary mt-2"
						onclick="return confirm('Deseja realmente sair do sistema?')">
						Sair do Sistema </a>
				</form>
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
		<h5>Relatório de Funcionários</h5>
		<hr>

		<form id="formrelatorio" action="gerarRelatorioFuncionarios" method="post">
			<label>Relatório de Funcionários por período de admissão:</label>
			<div class="row">
				<div class="col-md-3">
					<form:input path="dto.dataInicio" id="dataInicio" name="dataInicio"
						type="date" class="form-control" />
				</div>
				<div class="col-md-3">
					<form:input path="dto.dataFim" id="dataFim" name="dataFim"
						type="date" class="form-control" />
				</div>

				<div class="col-md-4">

					<input type="submit" value="Gerar Relatório" class="btn btn-success" />
				</div>
			</div>
		</form>
	</div>

	<!-- referencia para arquivo JS -->
	<script src="resources/js/bootstrap.min.js"></script>

	<!-- referencia para o arquivo do jquery -->
	<script src="resources/js/jquery-3.6.0.min.js"></script>

	<!-- referencias para o jquery validate -->
	<script src="resources/js/jquery.validate.min.js"></script>
	<script src="resources/js/messages_pt_BR.min.js"></script>

	<script>
		//quando a pagina for carregada faça
		$(document)
				.ready(
						function() {

							//aplicando validaçao ao formulário...
							$("#formrelatorio").validate({
								//regras de validaçao
								rules : {
									"dataInicio" : {
										required : true
									},
									"dataFim" : {
										required : true
									}

								}

							});


						})
	</script>

</body>
</html>

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
</style>

</head>
<body style="background-color:#eee;">


	<div class="container mt-4">
		<div class="row">

			<div class="col-md-4 offset-4">

				<div class="card mt-5">
					<div class="card-body text-center">
						<img
							src="https://www.cotiinformatica.com.br/imagens/logo-coti-informatica.png"
							style="width: 260px;" class="mb-2" />
						<h5 class="card-title">Acesso ao sistema</h5>
						<hr />
						<form id="formlogin" action="autenticarUsuario" method="post">

							<label>Email de Acesso</label>
							<form:input path="dto.email" name="email" id="email" type="text"
								class="form-control" />

							<br> <label>Senha de Acesso</label>
							<form:input path="dto.senha" name="senha" id="senha"
								type="password" class="form-control" />
							<br /> <br />

							<div class="d-grid gap-2">
								<button class="btn btn-dark" type="submit">Entrar</button>
							</div>

						</form>

						<!-- Mensagem de erro -->
						<c:if test="${not empty mensagem_erro }">
							<div class="alert alert-danger alert-dismissible fade show"
								role="alert">
								<strong>Erro!</strong> ${mensagem_erro}
								<button type="button" class="btn-close" data-bs-dismiss="alert"
									aria-label="Close"></button>
							</div>
						</c:if>

					</div>
				</div>

			</div>

		</div>
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
		$(document).ready(function() {


			//aplicando validaçao ao formulário...
			$("#formlogin").validate({
				//regras de validaçao
				rules : {
					"email" : {
						required : true,
						email: true
						
					},
					"senha" : {
						required : true,
						minlength : 8,
						maxlength : 20
					}

				}

			});

		})
	</script>


</body>
</html>

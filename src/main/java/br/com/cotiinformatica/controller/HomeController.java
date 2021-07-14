package br.com.cotiinformatica.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.com.cotiinformatica.dto.LoginDTO;
import br.com.cotiinformatica.entities.Usuario;
import br.com.cotiinformatica.enums.SituacaoFuncionario;
import br.com.cotiinformatica.repositories.FuncionarioRepository;
import br.com.cotiinformatica.repositories.UsuarioRepository;

@Controller
public class HomeController {
	
	@Autowired //Inicializa automaticamente.
	private UsuarioRepository usuarioRepository;
	
	@Autowired 
	private FuncionarioRepository funcionarioRepository;
	
	@RequestMapping(value="/") //URL raiz do projeto 
	public ModelAndView login() {
		
		ModelAndView modelAndView = new ModelAndView("login");
		modelAndView.addObject("dto", new LoginDTO());
		return modelAndView;
	}
    
	@RequestMapping(value="autenticarUsuario", method = RequestMethod.POST)
	public ModelAndView autenticarUsuario(LoginDTO dto, HttpServletRequest request) {
		
	    ModelAndView modelAndView = new ModelAndView("login");
	    
	    try {
	    	
	    	//consultar no banco de dados o usuario atraves do seu email e senha.
	    	Usuario usuario = usuarioRepository.findByEmailAndSenha(dto.getEmail(), dto.getSenha());
	    	
	    	
	    	//verificar se o usuario foi encontrado
	    	
	    	if(usuario != null) {
	    		
	    		//armazenar os dados de um usuario em uma sess�o...
	    		request.getSession().setAttribute("usuario_autenticado", usuario);
	    		
	    		//redireciona para  a pagina home do sistema.
	    		modelAndView.setViewName("redirect:home");
	    		
	    	}else {
	    		modelAndView.addObject("mensagem_erro","Acesso negado. Email e senha inv�lidos");
	    	}
	    	
	    	
	    }catch(Exception e){
	    	modelAndView.addObject("mensagem_erro","Erro: " +e.getMessage());
	    	
	    }
	    
		modelAndView.addObject("dto", new LoginDTO());
		return modelAndView;
	}
	
	
	@RequestMapping(value="/home")
	public ModelAndView home(HttpServletResponse response) throws IOException{
		ModelAndView modelAndView = new ModelAndView("home");
		try {
			modelAndView.addObject("qtd_admitido", funcionarioRepository.countBySituacao(SituacaoFuncionario.Admitido));
			modelAndView.addObject("qtd_afastado", funcionarioRepository.countBySituacao(SituacaoFuncionario.Afastado));
			modelAndView.addObject("qtd_ferias", funcionarioRepository.countBySituacao(SituacaoFuncionario.Ferias));
			modelAndView.addObject("qtd_demitido", funcionarioRepository.countBySituacao(SituacaoFuncionario.Demitido));
			
			
			
		}catch(Exception e) {
			modelAndView.addObject("mensagem_erro","Erro: " +e.getMessage());
		}
		
		return modelAndView;
	}
	//m�todo para fazer o logout do usuario autenticado.
	@RequestMapping(value="/logout")
	public ModelAndView logout(HttpServletRequest request) {
		//remover usuario autenticado da sessao
		request.getSession().removeAttribute("usuario_autenticado");
		
		//redirecionar para a pagina raiz do projeto.
		ModelAndView modelAndView = new ModelAndView("redirect:/");
		return modelAndView;
	}
	
}

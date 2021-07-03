package br.com.cotiinformatica.filters;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class AuthorizationFilter
 */
public class AuthorizationFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AuthorizationFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//converter os objetos request e response em versoes mais atualizadas..
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		/*
		 * Iremos criar uma regra que verifique se o usuario está autenticado.
		 * Esta regra deverá ser aplicada a todas as paginas do sistema exceto:
		 * Navegando em /
		 * Navegando em /autenticarUsuario
		 * Navegando em /logout
		 */

		String path = req.getServletPath();
		
		List<String> urlsPermitidas = new ArrayList<String>();
		urlsPermitidas.add("/");
		urlsPermitidas.add("/autenticarUsuario");
		urlsPermitidas.add("/logout");
		
		if(!urlsPermitidas.contains(path)) {
			
			//verificar se o sistemas contem session 'usuario_autenticado'
			
			if(req.getSession().getAttribute("usuario_autenticado")==null) {
				resp.sendRedirect("/projetoSpringMVC01/");
			}
			
		}
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}

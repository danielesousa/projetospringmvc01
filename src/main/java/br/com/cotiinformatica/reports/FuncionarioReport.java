package br.com.cotiinformatica.reports;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.net.URL;
import java.util.Date;
import java.util.List;

import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import br.com.cotiinformatica.entities.Funcionario;
import br.com.cotiinformatica.entities.Usuario;
import br.com.cotiinformatica.helpers.DateHelper;

public class FuncionarioReport {
	
	public ByteArrayInputStream generatePdfReport(Date dataInicio, Date dataFim, List<Funcionario> funcionarios, 
			Usuario usuario) throws Exception{
		//criar um objeto que nos permitir� fazer o retorno do arquivo do objeto
		//em formato byte (ser� utilizado posteriormente para download do arquivo)
		
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		
		//desenhando o documento pdf com a biblioteca itext..
		Document document = new Document();
		PdfWriter witer = PdfWriter.getInstance(document, out);
		
		//abrir o documento pdf
		document.open();
		
		//inserindo uma logo no relatorio
		Image logo = Image.getInstance(new URL("https://www.cotiinformatica.com.br/imagens/logo-coti-informatica.png"));
		document.add(logo);
		
		//escrevendo paragrafos no relat�rio...
		document.add(new Paragraph("Relat�rio de Funcion�rios", fmtTitle()));
		
		document.add(new Paragraph("\n")); //quebra de linha
		
		document.add(new Paragraph("Data de Gera��o: " + DateHelper.toStringPtBR(new Date()), fmtProfile()));
		
		document.add(new Paragraph("Periodo de admissao de funcionarios :" + DateHelper.toStringPtBR(dataInicio) + " at� " + DateHelper.toStringPtBR(dataFim), fmtProfile()));
		
		document.add(new Paragraph("Nome do Usu�rio: "+ usuario.getNome(), fmtProfile()));
		document.add(new Paragraph("Email : "+ usuario.getEmail(), fmtProfile()));
		
		document.add(new Paragraph("\n")); //quebra de linha
		
		//desenhando uma tabela
		PdfPTable table = new PdfPTable(5);   //5 colunas para a tabela.
		table.setWidthPercentage(100); //largura da tabela
		
		//cabecalho da coluna
		table.addCell(new Paragraph("Nome do Funcionario", fmtHeaderCell()));
		table.addCell(new Paragraph("CPF", fmtHeaderCell()));
		table.addCell(new Paragraph("Matr�cula", fmtHeaderCell()));
		table.addCell(new Paragraph("Data de admissao", fmtHeaderCell()));
		table.addCell(new Paragraph("Situa�ao", fmtHeaderCell()));
		
		//percorrer os funcionarios e exibir os registros 
		for(Funcionario funcionario: funcionarios) {
			table.addCell(new Paragraph(funcionario.getNome(), fmtDataCell()));
			table.addCell(new Paragraph(funcionario.getCpf(), fmtDataCell()));
			table.addCell(new Paragraph(funcionario.getMatricula(), fmtDataCell()));
			table.addCell(new Paragraph((DateHelper.toStringPtBR(funcionario.getDataAdmissao()))));
			table.addCell(new Paragraph((funcionario.getSituacao().toString())));
			
		}
		//adicionar a tabela no pdf
		document.add(table);
		
		document.add(new Paragraph("\n"));
		document.add(new Paragraph("Quantidade de funcion�rios : " + funcionarios.size(), fmtProfile()));
		
		document.close(); //fechando o documento 
		witer.close();   //fechando o buffer de mem�ria
		

		//retornando o conteudo do relat�rio em bytes..
		return new ByteArrayInputStream(out.toByteArray());
	}
	//formata�ao do titulo do relat�rio
	private Font fmtTitle() {
		
		Font font = new Font();
		font.setSize(20);
		font.setStyle("bold");
		font.setColor(15, 60, 120);
		return font;
	}
	//formata�ao dos dados do relat�rio
	private Font fmtProfile() {
		Font font = new Font();
		font.setSize(12);
		return font;
	}
	//formata�ao do cabecalho da tabela
	private Font fmtHeaderCell() {
		Font font = new Font();
		font.setSize(11);
		font.setStyle("bold");
		return font;
	}
	//formata�ao das celulas da tabela
		private Font fmtDataCell() {
			Font font = new Font();
			font.setSize(11);
			return font;
		}

}
 
namespace Controllers.CAD
{
    using Infra.Base.Interface.Base;
    using Models.Cadastros;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.Entity;
    using System.Linq;
    using System.Net;
    using System.Net.Http;
    using System.Web.Http;
    using System.Web.Http.Description;

    public class CAD_PESSOAVERSAOController : CrudControllerBase<CAD_PESSOAVERSAO>
    {
        protected override IOrderedQueryable<CAD_PESSOAVERSAO> Ordenar(IQueryable<CAD_PESSOAVERSAO> query)
        {
            return query.OrderBy(e => e.id);
        }
                
        [Route("api/CAD_PESSOAVERSAO/atual/{app}/{doc}/{versao}")]
        [HttpGet]
        public IHttpActionResult Atual(string app, string doc, string versao)
        {
            CAD_PESSOA cadpessoa = db.CAD_PESSOA
                  .Where(m => m.DOCUMENTO == doc).FirstOrDefault();

            if (cadpessoa == null)
            {
                return Content(HttpStatusCode.NotFound, new { mensagem_erro = "Cliente não localizado: " + doc });
            }

            if  (cadpessoa.ATUALIZAR_VERSAO != "S") {
                return Content(HttpStatusCode.NotFound, new { mensagem_erro = "Cliente não recebe atualização: " + doc });
            }

            CAD_VERSAO cadversao = db.CAD_VERSAO
                  .Where(m => m.NOME_APP.ToUpper() == app.ToUpper())
                  .OrderByDescending(e => e.id).FirstOrDefault();

            if (cadversao == null)
            {
                return Content(HttpStatusCode.NotFound, new { mensagem_erro = "Versão não encontrada: " + doc });
            }

            versao = versao.Replace('-', '.');

            if (cadversao.VERSAO != versao)
            {
                return Content(HttpStatusCode.NotFound, new { mensagem_erro = "Cliente nao atualizado: " + doc });
            }

            CAD_PESSOAVERSAO cadpessoaversao = new CAD_PESSOAVERSAO();
            cadpessoaversao.COD_CADPESSOA = cadpessoa.id;
            cadpessoaversao.COD_CADVERSAO = cadversao.id;

            /*CAD_PESSOAVERSAO cadpessoaversao = db.CAD_PESSOAVERSAO
                  .Where(m => m.COD_CADVERSAO == cadversao.id && m.COD_CADPESSOA == cadpessoa.id)
                  .OrderByDescending(e => e.id).FirstOrDefault();
                  
            if (cadpessoaversao == null)
            {
                return Content(HttpStatusCode.NotFound, new { mensagem_erro = "Cliente nao atualizado: " + doc });
            }
            */

            return Ok(cadpessoaversao);
        }
       

    }

}

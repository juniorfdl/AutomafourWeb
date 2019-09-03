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

    public class cad_pessoaController : CrudControllerBase<CAD_PESSOA>
    {
        protected override IOrderedQueryable<CAD_PESSOA> Ordenar(IQueryable<CAD_PESSOA> query)
        {
            return query.OrderBy(e => e.id);
        }

        [Route("api/cad_pessoa/documento/{doc}")]
        [HttpGet]
        public IHttpActionResult Documento(string doc)
        {
            CAD_PESSOA item = db.CAD_PESSOA.Where(w => w.DOCUMENTO == doc).FirstOrDefault();

            if (item == null)
            {
                return Content(HttpStatusCode.NotFound, new { mensagem_erro = "Cliente não localizado: " + doc});
            }
            
            /*if (item.VERSAO_ATUAL == null || item.VERSAO_ATUAL == string.Empty)
            {
              item.DEVE_ATUALIZAR = "S";
            }
            else {
                CAD_PESSOAVERSAO versao = db.CAD_PESSOAVERSAO
                    .Where(m => m.id.ToString() == item.VERSAO_ATUAL)
                    .FirstOrDefault();

                CAD_PESSOAVERSAO ultversao = db.CAD_PESSOAVERSAO
                  .Where(m => m.NOME_APP.ToUpper() == versao.NOME_APP.ToUpper())
                  .OrderByDescending(e => e.id).FirstOrDefault();

                if (versao.id != ultversao.id)
                {
                    item.DEVE_ATUALIZAR = "S";
                }                
            }
            */            
            
            return Ok(item);
        }


    }

}

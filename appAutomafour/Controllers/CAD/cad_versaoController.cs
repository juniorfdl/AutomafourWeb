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

    public class CAD_VERSAOController : CrudControllerBase<CAD_VERSAO>
    {
        protected override IOrderedQueryable<CAD_VERSAO> Ordenar(IQueryable<CAD_VERSAO> query)
        {
            return query.OrderBy(e => e.id);
        }
                
        [Route("api/CAD_VERSAO/atual/{app}")]
        [HttpGet]
        public IHttpActionResult Atual(string app)
        {        
            CAD_VERSAO item = db.CAD_VERSAO
                  .Where(m => m.NOME_APP.ToUpper() == app.ToUpper())
                  .OrderByDescending(e => e.id).FirstOrDefault();

            return Ok(item);
        }


    }

}

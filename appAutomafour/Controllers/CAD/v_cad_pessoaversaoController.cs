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

    public class v_Cad_PessoaVersaoController : CrudControllerBase<V_CAD_PESSOAVERSAO>
    {
        protected override IOrderedQueryable<V_CAD_PESSOAVERSAO> Ordenar(IQueryable<V_CAD_PESSOAVERSAO> query)
        {
            return query.OrderBy(e => e.id);
        }
    }

}

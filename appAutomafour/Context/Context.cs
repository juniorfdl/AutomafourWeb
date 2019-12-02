using FirebirdSql.Data.FirebirdClient;
using Models.Cadastros;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.SIS;
using System.Data.Entity.ModelConfiguration.Conventions;

namespace Infra.Base
{
    public class Context : DbContext
    {

        public static FbConnection connection
        {
            get
            {
                var x = System.Configuration.ConfigurationManager.ConnectionStrings["base"].ConnectionString;
                return new FbConnection(x);
            }
        }

        public Context() : 
            base(connection, true)
        {
            Database.SetInitializer<Context>(null);
            Database.Initialize(false);
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            base.Configuration.LazyLoadingEnabled = false;
            
            modelBuilder.Conventions.AddBefore<ForeignKeyIndexConvention>(new ForeignKeyNamingConvention());
        }

        #region Entidades tipo sistema
        public virtual DbSet<SIS_USUARIO> SIS_USUARIO { get; set; }
        public virtual DbSet<SIS_USUARIO_EMPRESA> SIS_USUARIO_EMPRESA { get; set; }
        public virtual DbSet<SIS_MENU> SIS_MENU { get; set; }
        #endregion

        #region Entidades tipo Cadastros        
        public virtual DbSet<CAD_EMPRESA> CAD_EMPRESA { get; set; }
        public virtual DbSet<CAD_PESSOA> CAD_PESSOA { get; set; }
        public virtual DbSet<CAD_VERSAO> CAD_VERSAO { get; set; }
        public virtual DbSet<CAD_PESSOAVERSAO> CAD_PESSOAVERSAO { get; set; }
        public virtual DbSet<V_CAD_PESSOAVERSAO> v_CAD_PESSOAVERSAO { get; set; }
        #endregion
    }
}

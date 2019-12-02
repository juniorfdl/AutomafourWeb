namespace Models.Cadastros
{
    using Infra.Base.Interface;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    public class V_CAD_PESSOAVERSAO : IEntidadeBase
    {
        [Key]
        [Column("COD_CADPESSOAVERSAO")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int id { get; set; }
        public string CLIENTE { get; set; }
        public string VERSAO { get; set; }   
        public string DADOS_MAQUINA { get; set; }   
        public string TERMINAL { get; set; }
        public DateTime DATA { get; set; }
        [NotMapped]
        public string CEMP { get; set; }
    }
}

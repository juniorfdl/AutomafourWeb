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

    public class CAD_PESSOAVERSAO : IEntidadeBase
    {
        [Key]
        [Column("COD_CADPESSOAVERSAO")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int id { get; set; }
        public int COD_CADVERSAO { get; set; }
        public int COD_CADPESSOA { get; set; }   
        public string DADOS_MAQUINA { get; set; }        
        [NotMapped]
        public string CEMP { get; set; }
    }
}

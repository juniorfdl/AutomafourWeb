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

    public class CAD_PESSOA : IEntidadeBase
    {
        [Key]
        [Column("COD_CADPESSOA")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int id { get; set; }
        [Required]
        public string NOME { get; set; }
        [Required]
        public string DOCUMENTO { get; set; }
        public string CEMP { get; set; }
        [Required]
        public string TIPO { get; set; }
        public string ATIVO { get; set; }
        public string OBS { get; set; }
        public int? COD_CADAPARTAMENTO { get; set; }
    }
}

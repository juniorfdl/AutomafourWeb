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

    public class CAD_VERSAO : IEntidadeBase
    {
        [Key]
        [Column("COD_CADVERSAO")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int id { get; set; }
        [Required]
        public string VERSAO { get; set; }        
        public string OBSERVACAO { get; set; }
        public string NOME_APP { get; set; }
        public string FTP { get; set; }
        public string FTP_USER { get; set; }
        public string FTP_PASS { get; set; }
        //[DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        //[DataType(DataType.DateTime)]
        //[Display(Name = "Data de Autorização")]
        //public DateTime? DATA_INICIO { get; set; }
        [NotMapped]
        public string CEMP { get; set; }        
    }
}

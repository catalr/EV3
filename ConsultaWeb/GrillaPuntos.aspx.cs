using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ConsultaWeb
{
    public partial class GrillaPuntos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void Filtrar(object sender, EventArgs e)
        {
            string filtro = filtroCcb.SelectedValue;
            switch (filtro)
            {
                case "0":
                    puntosODS.SelectMethod = "ObtenerPuntosCargaElectricos";
                    break;
                case "1":
                    puntosODS.SelectMethod = "ObtenerPuntosCargaDuales";
                    break;
                case "2":
                    puntosODS.SelectMethod = "ObtenerPuntosCarga";
                    break;
                default:
                    puntosODS.SelectMethod = "ObtenerPuntosCarga";
                    break;
            }
        }

        protected void SetFormViewCardVisible(object sender,EventArgs e)
        {
            FormViewCard.Visible = true;
        }

        protected void HideFormView(object sender, EventArgs e)
        {
            FormViewCard.Visible = false;
        }

    }
}
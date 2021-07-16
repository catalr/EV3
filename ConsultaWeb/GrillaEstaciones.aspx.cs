using ComunicacionesModel.DAL;
using ComunicacionesModel.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ConsultaWeb
{
    public partial class GrillaEstaciones : System.Web.UI.Page
    {
        static IEstacionesDAL esDao = EstacionServicioDALFactory.CreateDAL();
        private IEstacionesDAL daEs = EstacionServicioDALFactory.CreateDAL();
        protected void Page_Load(object sender, EventArgs e)
        {
            //var bindingList = new BindingList<EstacionServicio>(daEs.ObtenerEstaciones());
            //EstacionesGridView.DataSource = bindingList;
             //< asp:ObjectDataSource ID = "estacionesODS" runat = "server"
             //               SelectMethod = "ObtenerEstaciones" TypeName = "ComunicacionesModel.DAL.EstacionServicioDALArchivos" ></ asp:ObjectDataSource >

        }

        protected void Borrar(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Object et = gvr.DataItemIndex;
           // esDao.ActualizarEstacion(et);

        }

    }
}
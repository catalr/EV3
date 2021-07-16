using System;
using System.Collections.Generic;
using ComunicacionesModel.DTO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.Json;




namespace ConsultaWeb
{
    public partial class AgregarEstacionFormView : System.Web.UI.Page
    {
        static DropDownList RegionesDdl;
        static DropDownList ComunasDdl;
        System.Net.WebClient wc = new System.Net.WebClient();
        static List<Comuna> comunas;



        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Change_Mode_View(object sender, FormViewInsertedEventArgs e)
        {
            EstacionesFormView.ChangeMode(0);
        }

        protected void Change_Mode_View(object sender, FormViewInsertEventArgs e)
        {
            EstacionesFormView.ChangeMode(0);
        }

        protected void ComunasDDLBinding(object sender, EventArgs e)
        {
            if (ComunasDdl == null)
            {
                ComunasDdl = (DropDownList)sender;
                Bind_Comunas(sender, e);
            }

        }

        protected void RegionesDDLBinding(object sender, EventArgs e)
        {
            if(RegionesDdl == null)
            {
                RegionesDdl = (DropDownList)sender;
                Set_Regiones(sender, e);
            }
        }

        protected void Set_Regiones(object sender, EventArgs e)
        {
            if (((DropDownList)sender).DataSource == null)
            {
                RegionesDdl = (DropDownList)sender;
                String jsonResponseRegiones = wc.DownloadString("https://apis.digital.gob.cl/dpa/regiones");
                List<Region> Regiones = JsonSerializer.Deserialize<List<Region>>(jsonResponseRegiones);
                RegionesDdl.DataSource = Regiones;
                RegionesDdl.DataTextField = "Nombre";
                RegionesDdl.DataValueField = "Codigo";
                RegionesDdl.SelectedIndex = 5;
                RegionesDdl.DataBind();
                Set_Comunas(sender, e);
            }
        }

        private void Bind_Comunas(object sender, EventArgs e)
        {
            ComunasDdl.DataSource = comunas;
            ComunasDdl.DataTextField = "Nombre";
            ComunasDdl.DataValueField = "Codigo";
            ComunasDdl.DataBind();
        }

        protected void Set_Comunas(object sender, EventArgs e)
        {
            String codRegion = RegionesDdl.SelectedValue;
            String jsonResponseComunas = wc.DownloadString("https://apis.digital.gob.cl/dpa/regiones/" + codRegion + "/comunas");
            comunas = JsonSerializer.Deserialize<List<Comuna>>(jsonResponseComunas); 
        }

        protected void Validate_Comuna(object sender, ServerValidateEventArgs e)
        {
            Comuna comuna = comunas.Find(x => x.codigo == ComunasDdl.SelectedValue);
            e.IsValid = false;
            if (ComunasDdl.SelectedValue != null && comuna != null)
            {
                String jsonResponseProvincia = wc.DownloadString("https://apis.digital.gob.cl/dpa/provincias/" + comuna.codigo_padre);
                Provincia provincia = JsonSerializer.Deserialize<Provincia>(jsonResponseProvincia);
                if (provincia.codigo_padre == RegionesDdl.SelectedValue)
                {
                    e.IsValid = true;
                }
            }
        }

    }
}
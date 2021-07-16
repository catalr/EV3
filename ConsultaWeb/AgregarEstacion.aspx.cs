using ComunicacionesModel.DAL;
using ComunicacionesModel.DAL.DALInterfaces;
using ComunicacionesModel.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ConsultaWeb
{
    public partial class AgregarEstacion : System.Web.UI.Page
    {
        System.Net.WebClient wc = new System.Net.WebClient();
        IEstacionesDAL esDao = EstacionServicioDALFactory.CreateDAL();
        ITarifaDAL tarDao = EstacionServicioDALFactory.CreateTarifaDAL();
        static List<Comuna> comunas;
        static List<Region> regiones;



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String jsonResponseRegiones = wc.DownloadString("https://apis.digital.gob.cl/dpa/regiones");
                regiones = JsonSerializer.Deserialize<List<Region>>(jsonResponseRegiones);
                RegionDdl.DataSource = regiones;
                RegionDdl.DataTextField = "Nombre";
                RegionDdl.DataValueField = "Codigo";
                RegionDdl.DataBind();

                List<Tarifa> tarifas = tarDao.getAll();
                TarifaDdl.DataSource = tarifas;
                TarifaDdl.DataTextField = "codigo";
                TarifaDdl.DataValueField = "codigo";
                TarifaDdl.DataBind();

            }
        }

        protected void Get_Comunas(object sender, EventArgs e)
        {
            String codRegion = RegionDdl.SelectedValue;
            String jsonResponseComunas = wc.DownloadString("https://apis.digital.gob.cl/dpa/regiones/" + codRegion + "/comunas");
            comunas = JsonSerializer.Deserialize<List<Comuna>>(jsonResponseComunas);
            ComunaDdl.DataSource = comunas;
            ComunaDdl.DataTextField = "Nombre";
            ComunaDdl.DataValueField = "Codigo";
            ComunaDdl.DataBind();
        }

        protected void Validate_Comuna(object sender, ServerValidateEventArgs e)
        {
            Comuna comuna = comunas.Find(x => x.codigo == ComunaDdl.SelectedValue);
            e.IsValid = false;
            if (ComunaDdl.SelectedValue != null)
            {
                String jsonResponseProvincia = wc.DownloadString("https://apis.digital.gob.cl/dpa/provincias/" + comuna.codigo_padre);
                Provincia provincia = JsonSerializer.Deserialize<Provincia>(jsonResponseProvincia);
                if (provincia.codigo_padre == RegionDdl.SelectedValue)
                {
                    e.IsValid = true;
                }
            }
        }

        protected void Agregar(object sender, EventArgs e)
        {
            if (Page.IsValid){
                EstacionServicio nueva = new EstacionServicio
                {
                    Direccion = new Direccion
                    {
                        Region = regiones.Find(x => x.codigo == RegionDdl.SelectedValue).nombre,
                        Comuna = comunas.Find(x => x.codigo == ComunaDdl.SelectedValue).nombre,
                        CodPostal = Int32.Parse(CodigoPostalTextBox.Text),
                        Nro = Int32.Parse(NroTextBox.Text),
                        Calle =  CalleTextBox.Text
                    },
                    CapacidadMaxima = Int32.Parse(CapacidadMaximaTextBox.Text),
                    Tarifa = tarDao.getTarifa(TarifaDdl.SelectedValue)
                };
                esDao.RegistrarEstacion(nueva);
            }
        }
    }
}
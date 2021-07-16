<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarEstacionFormView.aspx.cs" Inherits="ConsultaWeb.AgregarEstacionFormView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">
    <div class="row mt-5">
        <div class="col-12 col-md-6 col-lg-5 mx-auto">
            <div class="card">
                <asp:ObjectDataSource
                    ID="estacionesODS"
                    runat="server"
                    SelectMethod="ObtenerEstaciones"
                    TypeName="ComunicacionesModel.DAL.EstacionServicioDALArchivos"
                    DataObjectTypeName="ComunicacionesModel.DTO.EstacionServicio"
                    DeleteMethod="EliminarEstacion" InsertMethod="RegistrarEstacion"
                    UpdateMethod="ActualizarEstacion"></asp:ObjectDataSource>
                <asp:FormView
                    DefaultMode="Insert"
                    ID="EstacionesFormView"
                    runat="server"
                    DataSourceID="estacionesODS"
                    OnItemInserting="Change_Mode_View"
                    OnItemInserted="Change_Mode_View"
                    >
                    <EditItemTemplate>
                        <div class="form-group">
                            <label>Capacidad Maxima</label>
                            <asp:TextBox ID="CapacidadMaximaTextBox" CssClass="form-control" runat="server" Text='<%# Bind("CapacidadMaxima") %>' />
                        </div>

                        <br />
                        Direccion:
                            <asp:TextBox ID="DireccionTextBox" runat="server" Text='<%# Bind("Direccion") %>' />
                        <br />
                        Tarifa:
                            <asp:TextBox ID="TarifaTextBox" runat="server" Text='<%# Bind("Tarifa") %>' />
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-dark" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-dark" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card-header bg-success text-white text-center">
                            <h5>Agregar Estacion de Servicio</h5>
                        </div>
                        <div class="card-body" style="width: 100%; overflow-x: auto">
                        <div class="form-group">
                            <label>Region</label>
                            <asp:DropDownList
                                ID="RegionDdl"
                                CssClass="form-control"
                                OnDataBinding="RegionesDDLBinding"
                                runat="server"/>
                        </div>
                        <div class="form-group">
                            <label>Comuna</label>
                            <div class="input-group">
                            <div class="input-group-prepend">
                                <asp:Button runat="server" OnClick="Set_Comunas" Text="Cargar Comunas" CssClass="btn btn-outline-success" />
                            </div>
                            <asp:DropDownList ID="ComunaDdl"
                                CssClass="form-control"
                                runat="server"
                                OnDataBinding="ComunasDDLBinding"
                                />
                                </div>
                            <asp:CustomValidator 
                                runat="server" 
                                id="comunaVAl" 
                                controltovalidate="ComunaDdl" 
                                onservervalidate="Validate_Comuna"
                                CssClass ="text-danger"
                                errormessage="Debe cargar comunas despues de elegir la region" />
                        </div>
                        <div class="form-group">
                            <label>Calle</label>
                            <asp:TextBox ID="CalleTextBox" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="CityReqValidator"
                                ControlToValidate="CalleTextBox"
                                ErrorMessage="Ingrese el Nombre de la calle."
                                CssClass ="text-danger"
                                Display="Dynamic"
                                EnableClientScript="False"
                                runat="server"/>
                        </div>
                        <div class="form-group">
                            <label>Nro</label>
                            <asp:TextBox ID="NroTextBox" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                ControlToValidate="NroTextBox"
                                ErrorMessage="Ingrese el numero"
                                CssClass ="text-danger"
                                Display="Dynamic"
                                EnableClientScript="False"
                                runat="server"/>
                            <asp:RangeValidator  ID="RangeValidator2"
                                ControlToValidate="CapacidadMaximaTextBox"
                                MinimumValue="1"
                                MaximumValue="100000"
                                CssClass ="text-danger"
                                Type="Integer"
                                ErrorMessage="Ingrese un Numero"
                                Display="Dynamic"
                                EnableClientScript="False"
                                runat="server"/>
                        </div>
                        <div class="form-group">
                            <label>Codigo Postal</label>
                            <asp:TextBox ID="CodigoPostalTextBox" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                                ControlToValidate="CodigoPostalTextBox"
                                ErrorMessage="Ingrese el codigo postal"
                                CssClass ="text-danger"
                                Display="Dynamic"
                                EnableClientScript="False"
                                runat="server"/>
                            <asp:RangeValidator  ID="RangeValidator3"
                                ControlToValidate="CodigoPostalTextBox"
                                MinimumValue="1"
                                MaximumValue="100000"
                                CssClass ="text-danger"
                                Type="Integer"
                                ErrorMessage="Ingrese un Numero Valido"
                                Display="Dynamic"
                                EnableClientScript="False"
                                runat="server"/>
                        </div>
                        <div class="form-group">
                            <label>Capacidad</label>
                            <asp:TextBox ID="CapacidadMaximaTextBox" CssClass="form-control" runat="server" />
                            <asp:RangeValidator  ID="RangeValidator1"
                                ControlToValidate="CapacidadMaximaTextBox"
                                MinimumValue="1"
                                MaximumValue="10000"
                                CssClass ="text-danger"
                                Type="Integer"
                                ErrorMessage="Ingrese un Numero."
                                Display="Dynamic"
                                EnableClientScript="False"
                                runat="server"/>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                ControlToValidate="CapacidadMaximaTextBox"
                                ErrorMessage="Ingrese la capacidad maxima."
                                CssClass ="text-danger"
                                Display="Dynamic"
                                EnableClientScript="False"
                                runat="server"/>
                        <div class="form-group">
                            <label>Tarifa</label>
                            <asp:DropDownList ID="TarifaDdl" CssClass="form-control" runat="server" />
                        </div>
                    </div>
                        <div class="card-footer d-grid gap-1">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-success d-inline" />
                            <a href="GrillaEstaciones.aspx" class="btn btn-secondary d-inline">Cancelar</a>
                        </div>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        Region:
                            <asp:Label ID="RegionLabel" runat="server" Text='<%# Bind("Direccion.Region") %>' />
                        <br />
                        Comuna:
                            <asp:Label ID="ComunaLabel" runat="server" Text='<%# Bind("Direccion.Comuna") %>' />
                        <br />
                        Calle:
                            <asp:Label ID="CalleLabel" runat="server" Text='<%# Bind("Direccion.Calle") %>' />
                        <br />
                        Nro:
                            <asp:Label ID="NroLabel" runat="server" Text='<%# Bind("Direccion.Nro") %>' />
                        <br />
                        Capacidad Maxima:
                            <asp:Label ID="CapacidadMaximaLabel" runat="server" Text='<%# Bind("CapacidadMaxima") %>' />
                        <br />
                        Tarifa:
                            <asp:Label ID="TarifaLabel" runat="server" Text='<%# Bind("Tarifa.codigo") %>' />
                        <br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Editar" CssClass="btn btn-dark" />
                        &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Borrar" CssClass="btn btn-dark" />
                        &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="Agregar" CssClass="btn btn-dark" />
                    </ItemTemplate>
                </asp:FormView>
            </div>
        </div>
    </div>
</asp:Content>

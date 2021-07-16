<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GrillaPuntos.aspx.cs" Inherits="ConsultaWeb.GrillaPuntos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenido" runat="server">
    <div class="row mt-5">
        <div class="col-12 col-md-6 col-lg-5 mx-auto">
            <div class="card">
                <div class="card-header bg-success text-white text-center">
                    <h5>Estaciones de Servicio</h5>
                </div>
                <div class="card-body" style="width: 100%; overflow-x: auto">
                    <asp:ObjectDataSource ID="puntosODS" runat="server"
                        SelectMethod="ObtenerPuntosCarga" TypeName="ComunicacionesModel.DAL.PuntoCargaDALArchivos" DataObjectTypeName="ComunicacionesModel.DTO.PuntoCarga" InsertMethod="RegistrarPunto" UpdateMethod="ActualizaPunto"></asp:ObjectDataSource>
                    <asp:GridView CssClass="table table-hover" DataKeyNames="Id" ID="PuntosGridView" runat="server" AutoGenerateEditButton="True" DataSourceID="puntosODS" AllowPaging="True" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" ReadOnly="true" />
                            <asp:BoundField DataField="Tipo" HeaderText="Tipo" SortExpression="Tipo" />
                            <asp:BoundField DataField="CapacidadMaxima" HeaderText="CapacidadMaxima" SortExpression="CapacidadMaxima" />
                            <asp:BoundField DataField="FechaVencimiento" HeaderText="FechaVencimiento" ApplyFormatInEditMode="true" DataFormatString="{0:d}" SortExpression="FechaVencimiento" />
                        </Columns>
                    </asp:GridView>
                    <div class="input-group mb-3">
                        <asp:DropDownList CssClass="form-control" runat="server" ID="filtroCcb">
                            <asp:ListItem Value="0">Electricos</asp:ListItem>
                            <asp:ListItem Value="1">Duales</asp:ListItem>
                        </asp:DropDownList>
                        <div class="input-group-append">
                             <asp:Button CssClass="btn btn-outline-secondary" runat=server OnClick="Filtrar" Text="Filtrar"/>
                        </div>
                    </div>
                 </div>
                <div class="card-footer d-grid gap-1">
                    <asp:Button runat="server" CssClass="btn btn-success" OnClick="SetFormViewCardVisible" Text="Agregar Punto de Carga Nuevo" />
                </div>
            </div>
            <div class="card" id="FormViewCard" runat="server" visible="false">
                <asp:FormView
                    DefaultMode="Insert"
                    ID="EstacionesFormView"
                    runat="server"
                    OnItemInserted="HideFormView"
                    DataSourceID="puntosODS">
                    <EditItemTemplate>
                        <div class="card-header bg-success text-white text-center">
                            <h5>Modificar</h5>
                        </div>
                        <div class="card-body" style="width: 100%; overflow-x: auto">
                            <div class="form-group">
                                <label>Id:</label>
                                <asp:TextBox ID="IdTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Id") %>' />
                            </div>
                            <div class="form-group">
                                <label>Tipo</label>
                                <asp:TextBox ID="TipoTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Tipo") %>' />
                            </div>
                            <div class="form-group">
                                <label>Capacidad</label>
                                <asp:TextBox ID="CapacidadMaximaTextBox" CssClass="form-control" runat="server" Text='<%# Bind("CapacidadMaxima") %>' />
                            </div>
                            <div class="form-group">
                                <label>Fecha Vencimiento</label>
                                <asp:TextBox ID="FechaVencimientoTextBox" CssClass="form-control" runat="server" Text='<%# Bind("FechaVencimiento","{0:d}") %>' />
                            </div>
                        </div>
                        <div class="card-footer d-grid gap-1">
                            <asp:LinkButton ID="UpdateButton" runat="server" CssClass="btn btn-success" CausesValidation="True" CommandName="Update" Text="Actualizar" />
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-secondary" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </div>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card-header bg-success text-white text-center">
                            <h5>Agregar</h5>
                        </div>
                        <div class="card-body" style="width: 100%; overflow-x: auto">
                            <div class="form-group">
                                <label>Id:</label>
                                <asp:TextBox ID="IdTextBox" runat="server" CssClass="form-control" Text='<%# Bind("Id") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                    ControlToValidate="IdTextBox"
                                    ErrorMessage="Ingrese el numero"
                                    CssClass="text-danger"
                                    Display="Dynamic"
                                    EnableClientScript="False"
                                    runat="server" />
                                <asp:RangeValidator ID="RangeValidator1"
                                    ControlToValidate="IdTextBox"
                                    MinimumValue="0"
                                    MaximumValue="999999"
                                    CssClass="text-danger"
                                    Type="Integer"
                                    ErrorMessage="Ingrese Id Valida"
                                    Display="Dynamic"
                                    EnableClientScript="False"
                                    runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Tipo</label>
                                <asp:TextBox ID="TipoTextBox" runat="server" CssClass="form-control" Text='<%# Bind("Tipo") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                    ControlToValidate="TipoTextBox"
                                    ErrorMessage="Ingrese el tipo"
                                    CssClass="text-danger"
                                    Display="Dynamic"
                                    EnableClientScript="False"
                                    runat="server" />
                                <asp:RangeValidator ID="RangeValidator2"
                                    ControlToValidate="TipoTextBox"
                                    MinimumValue="0"
                                    MaximumValue="1"
                                    CssClass="text-danger"
                                    Type="Integer"
                                    ErrorMessage="0: Electrico, 1: Dual"
                                    Display="Dynamic"
                                    EnableClientScript="False"
                                    runat="server" />
                            </div>
                            <div class="form-group">
                                <label>Capacidad</label>
                                <asp:TextBox ID="CapacidadMaximaTextBox" CssClass="form-control" runat="server" Text='<%# Bind("CapacidadMaxima") %>' />
                            </div>
                            <div class="form-group">
                                <label>Fecha Vencimiento</label>
                                <asp:TextBox ID="FechaVencimientoTextBox" CssClass="form-control" runat="server" Text='<%# Bind("FechaVencimiento","{0:d}") %>' />
                            </div>
                        </div>
                        <div class="card-footer d-grid gap-1">
                            <asp:LinkButton ID="InsertButton" runat="server" CssClass="btn btn-success" CausesValidation="True" CommandName="Insert" Text="Agregar" />
                            <asp:LinkButton ID="InsertCancelButton" runat="server" CssClass="btn btn-secondary" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </div>
                    </InsertItemTemplate>
                </asp:FormView>
            </div>
        </div>
    </div>
</asp:Content>

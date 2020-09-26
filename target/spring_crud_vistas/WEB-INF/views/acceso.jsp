<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>

        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/bootstrap/css/bootstrap.min.css">

        <!-- DataTables .-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables/datatables.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables/DataTables-1.10.18/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables/datatables-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables/datatables-responsive/css/responsive.bootstrap4.min.css">

        <!-- sweetalert2 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/sweetalert2/sweetalert2.min.css">
        <!-- SweetAlert 2 -->
        <script src="${pageContext.request.contextPath}/plugins/sweetalert2/sweetalert2.all.js"></script>


        <title>Acceso</title>
    </head>
    <body class="bg-dark">


        <div class="container-fluid pt-4">
            <div class="row">

                <div class="col-6 col-md-6">

                    <div class="card collapse" id="collapseTablaPerfil">

                        <!-- /.card-header -->
                        <div class="card-body">

                            <!-- TABLA PERFIL -->
                            <table id="tablaPerfil" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Status</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>

                                </tbody>

                            </table>
                            <!-- /. TABLA PERFIL -->

                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">

                            <button id="btnNuevoPerfil" class="btn btn-primary" data-toggle="collapse" data-target="#collapseTablaPerfil">
                                Nuevo perfil
                            </button> 

                        </div>

                    </div>
                    <!-- /.card -->

                    <div class="card collapse" id="collapseFormularioPerfil">
                        <form id="formAddPerfil">
                            <div class="card-header">
                                <h2 id="tituloModalPerfil" class="badge badge-primary">Creación de perfil</h2>
                            </div>

                            <div class="card-body">

                                <!-- ENTRADA PARA EL NOMBRE DEL PERFIL -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <input type="text" class="form-control" id="nombrePerfil"
                                           placeholder="Nombre" required>
                                </div>

                            </div>

                            <div class="card-footer">
                                <button id="btnFormCancelarPerfil" class="btn btn-light" type="button" data-toggle="collapse" data-target="#collapseFormularioPerfil">
                                    Cancelar
                                </button> 
                                <button id="btnFormAddPerfil" type="submit" class="btn btn-primary">
                                    Guardar perfil
                                </button> 
                            </div>
                        </form>

                    </div> 

                </div>
                <!-- /.col -->

                <div class="col-6 col-md-6">

                    <div class="card collapse" id="collapseTablaModulo">

                        <!-- /.card-header -->
                        <div class="card-body">

                            <!-- TABLA MODULO -->
                            <table id="tablaModulo" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th>Status</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>

                                </tbody>

                            </table>
                            <!-- /. TABLA MODULO -->

                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">

                            <button id="btnNuevoModulo" class="btn btn-primary" data-toggle="collapse" data-target="#collapseTablaModulo">
                                Nuevo modulo
                            </button> 

                        </div>

                    </div>
                    <!-- /.card -->

                    <div class="card collapse" id="collapseFormularioModulo">
                        <form id="formAddModulo">
                            <div class="card-header">
                                <h2 id="tituloModalModulo" class="badge badge-primary">Creación de modulo</h2>
                            </div>

                            <div class="card-body">

                                <!-- ENTRADA PARA EL NOMBRE DEL MODULO -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <input type="text" class="form-control" id="nombreModulo"
                                           placeholder="Nombre" required>
                                </div>

                                <!-- ENTRADA PARA LA DESCRIPCION DEL MODULO -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <input type="text" class="form-control" id="descripcionModulo"
                                           placeholder="Descripción" required>
                                </div>

                            </div>

                            <div class="card-footer">
                                <button id="btnFormCancelarModulo" class="btn btn-light" type="button" data-toggle="collapse" data-target="#collapseFormularioModulo">
                                    Cancelar
                                </button> 
                                <button id="btnFormAddModulo" type="submit" class="btn btn-primary">
                                    Guardar modulo
                                </button> 
                            </div>
                        </form>

                    </div> 

                </div>
                <!-- /.col -->

            </div>
            <!-- /.row -->

            <div class="row mt-3">
                <div class="col-6 col-md-6">

                    <div class="card collapse" id="collapseTablaPermiso">

                        <!-- /.card-header -->
                        <div class="card-body">

                            <!-- TABLA MODULO -->
                            <table id="tablaPermiso" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th>Status</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>

                                </tbody>

                            </table>
                            <!-- /. TABLA MODULO -->

                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">

                            <button id="btnNuevoPermiso" class="btn btn-primary" data-toggle="collapse" data-target="#collapseTablaPermiso">
                                Nuevo permiso
                            </button> 

                        </div>

                    </div>
                    <!-- /.card -->

                    <div class="card collapse" id="collapseFormularioPermiso">
                        <form id="formAddPermiso">
                            <div class="card-header">
                                <h2 id="tituloModalPermiso" class="badge badge-primary">Creación de permiso</h2>
                            </div>

                            <div class="card-body">

                                <!-- ENTRADA PARA EL NOMBRE DEL PERMISO -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <input type="text" class="form-control" id="nombrePermiso"
                                           placeholder="Nombre" required>
                                </div>

                                <!-- ENTRADA PARA LA DESCRIPCION DEL PERMISO -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <input type="text" class="form-control" id="descripcionPermiso"
                                           placeholder="Descripción" required>
                                </div>

                            </div>

                            <div class="card-footer">
                                <button id="btnFormCancelarPermiso" class="btn btn-light" type="button" data-toggle="collapse" data-target="#collapseFormularioPermiso">
                                    Cancelar
                                </button> 
                                <button id="btnFormAddPermiso" type="submit" class="btn btn-primary">
                                    Guardar permiso
                                </button> 
                            </div>
                        </form>

                    </div> 

                </div>
                <!-- /.col -->

                <div class="col-6 col-md-6">

                    <div class="card collapse" id="collapseTablaUsuario">

                        <!-- /.card-header -->
                        <div class="card-body">

                            <!-- TABLA USUARISO -->
                            <table id="tablaUsuario" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Login</th>
                                        <th>Password</th>
                                        <th>Id perfil</th>
                                        <th>Perfil</th>
                                        <th>Status</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>

                                </tbody>

                            </table>
                            <!-- /. TABLA MODULO -->

                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">

                            <button id="btnNuevoUsuario" class="btn btn-primary" data-toggle="collapse" data-target="#collapseTablaUsuario">
                                Nuevo usuario
                            </button> 

                        </div>

                    </div>
                    <!-- /.card -->

                    <div class="card collapse" id="collapseFormularioUsuario">
                        <form id="formAddUsuario">
                            <div class="card-header">
                                <h2 id="tituloModalUsuario" class="badge badge-primary">Creación de usuario</h2>
                            </div>

                            <div class="card-body">

                                <!-- ENTRADA PARA EL LOGIN -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <input type="text" class="form-control" id="loginUsuario"
                                           placeholder="Login" required>
                                </div>

                                <!-- ENTRADA PARA LA PASSWORD -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <input type="password" class="form-control" id="passwordUsuario"
                                           placeholder="Password" required>
                                </div>

                                <!-- ENTRADA PARA EL TIPO DE PERFIL -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fab fa-cuttlefish"></i>
                                        </span>
                                    </div>
                                    <select class="form-control" name="tipoTarjeta" id="selectPerfil">
                                        <option value="default" >Seleccione un tipo de perfil</option>
                                    </select>
                                </div>

                            </div>

                            <div class="card-footer">
                                <button id="btnFormCancelarUsuario" class="btn btn-light" type="button" data-toggle="collapse" data-target="#collapseFormularioUsuario">
                                    Cancelar
                                </button> 
                                <button id="btnFormAddUsuario" type="submit" class="btn btn-primary">
                                    Guardar usuario
                                </button> 
                            </div>
                        </form>

                    </div> 

                </div>

            </div>
            <!-- /.row -->

            <div class="row mt-3">

                <div class="col-6 col-md-6">

                    <div class="card collapse" id="collapseTablaPermisoModulo">

                        <!-- /.card-header -->
                        <div class="card-body">

                            <!-- TABLA PERMISO MODULO -->
                            <table id="tablaPermisoModulo" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre modulo</th>
                                        <th>Id modulo</th>
                                        <th>Nombre permiso</th>
                                        <th>Id permiso</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>

                                </tbody>

                            </table>
                            <!-- /. TABLA PERMISO MODULO -->

                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">

                            <button id="btnNuevoPermisoModulo" class="btn btn-primary" data-toggle="collapse" data-target="#collapseTablaPermisoModulo">
                                Nuevo permiso modulo
                            </button> 

                        </div>

                    </div>
                    <!-- /.card -->

                    <div class="card collapse" id="collapseFormularioPermisoModulo">
                        <form id="formAddPermisoModulo">
                            <div class="card-header">
                                <h2 id="tituloModalPermisoModulo" class="badge badge-primary">Creación de permiso modulo</h2>
                            </div>

                            <div class="card-body">

                                <!-- ENTRADA PARA EL MODULO -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <select class="form-control" id="selectModulo_pm">
                                        <option value="default" >Selecciona un modulo</option>
                                    </select>
                                </div>
                                
                                <!-- SALIDA PARA LA DESCRIPCION DEL MODULO -->
                                <div class=" pt-3">
                                    <label id="descripcionModuloLabel" class=""></label>
                                </div>

                                <!-- ENTRADA PARA EL PERMISO -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <select class="form-control" id="selectPermiso_pm">
                                        <option value="default" >Selecciona un permiso</option>
                                    </select>
                                </div>
                                
                                <!-- SALIDA PARA LA DESCRIPCION DEL PERMISO -->
                                <div class="input-group pt-3">
                                    <label id="descripcionPermisoLabel" class=""></label>
                                </div>

                            </div>

                            <div class="card-footer">
                                <button id="btnFormCancelarPermisoModulo" class="btn btn-light" type="button" data-toggle="collapse" data-target="#collapseFormularioPermisoModulo">
                                    Cancelar
                                </button> 
                                <button id="btnFormAddPermisoModulo" type="submit" class="btn btn-primary">
                                    Guardar permiso modulo
                                </button> 
                            </div>
                        </form>

                    </div> 

                </div>
                <!-- /.col -->

                <div class="col-6 col-md-6">

                    <div class="card " id="collapseFormularioConfiPerfil">
                        <form id="formGuardarPermisos">
                            <div class="card-header">
                                <h2 id="tituloModalConfiPerfil" class="badge badge-primary">Configuración de perfil</h2>
                            </div>

                            <div class="card-body">

                                <!-- ENTRADA PARA EL PERFIL -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <select class="form-control" id="selectConfigPerfil">
                                        <option value="default" >Selecciona un perfil</option>
                                    </select>
                                </div>

                                <!-- ENTRADA PARA EL MODULO -->
                                <div class="input-group pt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <select class="form-control" id="selectConfigModulo">
                                        <option value="default" >Selecciona un modulo</option>
                                    </select>
                                </div>

                                <div class="row">
                                    <div class="col-9 col-md-9">
                                        <!-- ENTRADA PARA EL PERMISO -->
                                        <div class="input-group pt-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    <i class="fas fa-user"></i>
                                                </span>
                                            </div>
                                            <select class="form-control" id="selectConfigPermiso">
                                                <option value="default" >Selecciona un permiso</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-3 col-md-3">
                                        <div class="pt-3">
                                            <button type="button" id="btnAddPermiso" class="btn btn-primary btn-sm form-control">Agregar</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="row pt-4">
                                    <div class="col-12 col-md-12">
                                        <div style="overflow: scroll; height: 200px">
                                            <table id="tablaPermisosPerfil" class="table table-striped table-bordered table-sm" >
                                                <thead>
                                                    <tr>
                                                        <th>Modulo</th>
                                                        <th>Permiso</th>
                                                        <th>Eliminar</th>
                                                    </tr>
                                                <tbody>
                                                </tbody>
                                                </thead>
                                            </table>
                                        </div>
                                    </div>
                                </div>





                            </div>

                            <div class="card-footer">
                                <button id="btnFormCancelarPermisoModulo" class="btn btn-light" type="button" data-toggle="collapse" data-target="#collapseFormularioPermisoModulo">
                                    Cancelar
                                </button> 
                                <button type="submit" class="btn btn-primary">
                                    Guardar Cambios
                                </button> 
                            </div>
                        </form>

                    </div> 

                </div>
                <!-- /.col -->

            </div>
        </div>





        <!--=====================================
        MODAL EDITAR MODULO 
        ======================================-->

        <div id="modalEditarModulo" class="modal fade" role="dialog">

            <div class="modal-dialog">

                <div class="modal-content">

                    <form id="formEditModulo">

                        <!--=====================================
                            HEADER DEL MODAL
                        ======================================-->

                        <div class="modal-header">

                            <h5 class="modal-title" id="exampleModalLabel">Editar Modulo</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>

                        </div>

                        <!--=====================================
                            CUERPO DEL MODAL
                        ====================================== -->

                        <div class="modal-body">

                            <!-- ENTRADA PARA EL NOMBRE DEL MODULO -->
                            <div class="input-group pt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" id="nombreEdit"
                                       placeholder="Nombre" required>
                            </div>

                            <!-- ENTRADA PARA LA DESCRIPCION DEL MODULO -->
                            <div class="input-group pt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" id="descEdit"
                                       placeholder="Descripción" required>
                            </div>

                        </div>


                        <!--=====================================
                            PIE DEL MODAL
                        ======================================-->

                        <div class="modal-footer">
                            <button id="close" type="button" class="btn btn-light pull-left"
                                    data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">
                                Guardar Cambios
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="${pageContext.request.contextPath}/plugins/jquery/jquery-3.3.1.min.js"></script>  

        <script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.min.js"></script>  

        <!-- DataTables -->
        <script src="${pageContext.request.contextPath}/plugins/datatables/datatables.min.js"></script>
        <script src="${pageContext.request.contextPath}/plugins/datatables/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
        <script src="${pageContext.request.contextPath}/plugins/datatables/datatables-responsive/js/dataTables.responsive.min.js"></script>
        <script src="${pageContext.request.contextPath}/plugins/datatables/datatables-responsive/js/responsive.bootstrap4.min.js"></script>


        <script src="${pageContext.request.contextPath}/js/accesos.js"></script>


    </body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="es">

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


        <title>ALTA MNEMOTECNICO</title>
    </head>

    <body class="bg-dark">

        <!-- TABLA MNEMOTECNICO -->
        <div class="container-fluid pt-4">
            <div class="row">
                <div class="col-12">

                    <div class="card">
                        <div class="card-header">
                            <button id="btnAddControl" class="btn btn-outline-primary" data-toggle="modal" data-target="#modalAgregarMnemotecnicol">
                                Alta Mnemotecnico
                            </button>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <table id="tableMnemotecnico" class="table table-bordered table-striped tablaControl">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Id_tca</th>
                                        <th>Tipo campo</th>
                                        <th>Mnemotecnico</th>
                                        <th>Label</th>
                                        <th>Valor default</th>
                                        <th>id_m</th>
                                        <th>id_p</th>
                                        <th>pos x</th>
                                        <th>pos y</th>
                                        <th>id_e</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>
                                </tbody>

                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /. TABLA MNEMOTECNICO -->



        <!--=====================================
          MODAL AGREGAR MNEMOTECNICO 
        ======================================-->

        <div id="modalAgregarMnemotecnicol" class="modal fade" role="dialog">

            <div class="modal-dialog">

                <div class="modal-content">

                    <form id="formMnemotecnico">

                        <!--=====================================
                            HEADER DEL MODAL
                        ======================================-->

                        <div class="modal-header">

                            <h5 class="modal-title" id="exampleModalLabel">Alta Mnemotecnico</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>

                        </div>

                        <!--=====================================
                            CUERPO DEL MODAL
                        ====================================== -->

                        <div class="modal-body">

                            <!-- ENTRADA PARA EL TIPO DE CAMPO -->
                            <div class="input-group pt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fab fa-cuttlefish"></i>
                                    </span>
                                </div>
                                <select class="form-control" id="selectCampo">
                                    <option value="default">Seleccione un tipo de campo</option> 
                                </select>
                            </div>

                            <div class="row">

                                <div class="col-6">
                                    <!-- ENTRADA PARA LA POSICION X -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-user"></i>
                                            </span>
                                        </div>
                                        <input type="number" class="form-control" id="posX"
                                               placeholder="Posición X" required>
                                    </div>
                                </div>

                                <div class="col-6">
                                    <!-- ENTRADA PARA LA POSICION Y -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-users-cog"></i>
                                            </span>
                                        </div>
                                        <input type="number" class="form-control" id="posY"
                                               placeholder="Posición Y" required>
                                    </div>
                                </div>

                            </div>

                            <div class="row">

                                <div class="col-4">

                                    <!-- ENTRADA PARA MNEMOTECNICO -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-phone"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" id="mnemotecnico"
                                               placeholder="Mnemotecnico" required>
                                    </div>

                                </div>

                                <div class="col-4">

                                    <!-- ENTRADA PARA LABEL -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-phone"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" id="label"
                                               placeholder="Label" required>
                                    </div>

                                </div>

                                <div class="col-4">

                                    <!-- ENTRADA PARA VALOR DEFAULT -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-phone"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" id="valor_default"
                                               placeholder="Valor default" required>
                                    </div>

                                </div>

                            </div>


                            <!-- ENTRADA PARA EL MODULO -->
                            <div class="input-group pt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fab fa-cuttlefish"></i>
                                    </span>
                                </div>
                                <select class="form-control" id="selectModulo">
                                    <option value="default">Seleccione un tipo de modulo</option>
                                </select>
                            </div>

                            <!-- ENTRADA PARA CONTROL 1 -->
                            <div class="row">
                                <div class="col-9">
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fab fa-cuttlefish"></i>
                                            </span>
                                        </div>
                                        <select class="form-control" id="selectControl1">
                                            <option value="default">Seleccione control 1</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="pt-3">
                                        <button type="button" id="btnAddControl1" class="btn btn-success btn-sm form-control">Agregar</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-9">
                                    <!-- ENTRADA PARA CONTROL 2 -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fab fa-cuttlefish"></i>
                                            </span>
                                        </div>
                                        <select class="form-control" id="selectControl2">
                                            <option value="default">Seleccione control 2</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="pt-3">
                                        <button type="button" id="btnAddControl2" class="btn btn-success btn-sm form-control">Agregar</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-9">
                                    <!-- ENTRADA PARA CONTROL 3 -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fab fa-cuttlefish"></i>
                                            </span>
                                        </div>
                                        <select class="form-control" id="selectControl3">
                                            <option value="default">Seleccione control 3</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="pt-3">
                                        <button type="button" id="btnAddControl3" class="btn btn-success btn-sm form-control">Agregar</button>
                                    </div>
                                </div>
                            </div>

                            <div class="row pt-4">
                                <div class="col-12">
                                    <div style="overflow: scroll; height: 200px">
                                        <table id="tableControles" class="table table-striped table-bordered table-sm" >
                                            <thead>
                                                <tr>
                                                    <th>Eliminar</th>
                                                    <th>Control</th>
                                                    <th>Titulo</th>
                                                </tr>
                                            <tbody>
                                            </tbody>
                                            </thead>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>





                        <!--=====================================
                            PIE DEL MODAL
                        ======================================-->

                        <div class="modal-footer">
                            <button id="close" type="button" class="btn btn-light pull-left"
                                    data-dismiss="modal">Cancelar</button>
                            <button id="registrarSucursal" name="registrarSucursal" type="submit"
                                    class="btn btn-primary">Guardar</button>
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


        <script src="${pageContext.request.contextPath}/js/mnemotecnico.js"></script>


    </body>

</html>

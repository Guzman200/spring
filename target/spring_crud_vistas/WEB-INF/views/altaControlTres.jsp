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


        <title>ALTA CONTROL</title>
    </head>

    <body class="bg-dark">

        <!-- TABLA CONEXION -->
        <div class="container-fluid pt-4">
            <div class="row">
                <div class="col-12">

                    <div class="card">
                        <div class="card-header">
                            <button id="btnAddControl" class="btn btn-outline-primary" data-toggle="modal" data-target="#modalAgregarControl">
                                Alta Control
                            </button>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <table id="example1" class="table table-bordered table-striped tablaControl">
                                <thead>
                                    <tr>

                                        <th>id_g</th>
                                        <th>id_tg</th>
                                        <th>id_m</th>
                                        <th>id_e</th>
                                        <th>id_co</th>

                                        <th>Nombre Modulo</th>
                                        <th>Tipo</th>
                                        <th>Altura</th>
                                        <th>Anchura</th>
                                        <th>Color 1</th>
                                        <th>Color 2</th>
                                        <th>Titulo</th>
                                        <th>Descripción</th>
                                        <th>Posicion x</th>
                                        <th>Posicion y</th>
                                        <th>Tipo tabla</th>
                                        <th>Url</th>
                                        <th>Serie x</th>
                                        <th>Serie y</th>
                                        <th>id_p</th>
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
        <!-- /. TABLA CONEXION -->



        <!--=====================================
        MODAL AGREGAR CONTROL 
        ======================================-->

        <div id="modalAgregarControl" class="modal fade" role="dialog">

            <div class="modal-dialog">

                <div class="modal-content">

                    <form id="formAddControl">

                        <!--=====================================
                            HEADER DEL MODAL
                        ======================================-->

                        <div class="modal-header">

                            <h5 class="modal-title" id="exampleModalLabel">Alta Control Uno</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>

                        </div>

                        <!--=====================================
                            CUERPO DEL MODAL
                        ====================================== -->

                        <div class="modal-body">

                            <!-- ENTRADA PARA EL TIPO DE MODULO -->
                            <div class="input-group pt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fab fa-cuttlefish"></i>
                                    </span>
                                </div>
                                <select class="form-control" id="selectModulo">
                                    <option value="default">Seleccione un modulo</option> 
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

                                <div class="col-6">

                                    <!-- ENTRADA PARA LA ANCHURA -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-phone"></i>
                                            </span>
                                        </div>
                                        <input type="number" class="form-control" id="anchura"
                                               placeholder="Anchura" required>
                                    </div>

                                </div>

                                <div class="col-6">

                                    <!-- ENTRADA PARA LA ALTURA -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-phone"></i>
                                            </span>
                                        </div>
                                        <input type="number" class="form-control" id="altura"
                                               placeholder="Altura" required>
                                    </div>

                                </div>

                            </div>

                            <div class="row">

                                <div class="col-6">

                                    <!-- ENTRADA PARA EL COLOR 2 -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-route"></i>
                                            </span>
                                        </div>
                                        <input type="color" class="form-control" id="colorDos"
                                               placeholder="Color Dos" required>
                                    </div>

                                </div>

                                <div class="col-6">

                                    <!-- ENTRADA PARA EL COLOR 1 -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-route"></i>
                                            </span>
                                        </div>
                                        <input type="color" class="form-control" id="colorUno"
                                               placeholder="Color Uno" required>
                                    </div>

                                </div>

                            </div>

                            <div class="row">

                                <div class="col-6">

                                    <!-- ENTRADA PARA SERIE X -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-envelope"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" id="serieX"
                                               placeholder="Serie x" required>
                                    </div>

                                </div>

                                <div class="col-6">

                                    <!-- ENTRADA PARA SERIA Y -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-route"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" id="serieY"
                                               placeholder="Serie y" required>
                                    </div>
                                </div>

                            </div>

                            <div class="row">

                                <div class="col-6">

                                    <!-- ENTRADA PARA EL TIPO -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-envelope"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" id="tipo"
                                               placeholder="Tipo" required>
                                    </div>

                                </div>

                                <div class="col-6">

                                    <!-- ENTRADA PARA EL TITULO -->
                                    <div class="input-group pt-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="fas fa-route"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" id="titulo"
                                               placeholder="Titulo" required>
                                    </div>
                                </div>

                            </div>


                            <!-- ENTRADA PARA LA DESCRIPCION -->
                            <div class="input-group pt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-route"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" id="descripcion"
                                       placeholder="Descripción" required>
                            </div>


                            <!-- ENTRADA PARA EL TIPO DE GRAFICA -->
                            <div class="input-group pt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fab fa-cuttlefish"></i>
                                    </span>
                                </div>
                                <select class="form-control" id="selectGrafica">
                                    <option value="default" >Seleccione un tipo de grafica</option>
                                </select>
                            </div>


                            <!-- ENTRADA PARA EL TIPO DE CONEXION -->
                            <div class="input-group pt-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fab fa-cuttlefish"></i>
                                    </span>
                                </div>
                                <select class="form-control" id="selectConexion">
                                    <option value="default">Seleccione un tipo de conexion</option>
                                </select>
                            </div>

                        </div>





                        <!--=====================================
                            PIE DEL MODAL
                        ======================================-->

                        <div class="modal-footer">
                            <button id="close" type="button" class="btn btn-light pull-left"
                                    data-dismiss="modal">Cancelar</button>
                            <button id="registrarSucursal" name="registrarSucursal" type="submit"
                                    class="btn btn-primary">Guardar Control</button>
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


        <script src="${pageContext.request.contextPath}/js/altaControlTres.js"></script>


    </body>

</html>
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


    <title>TYPE CARD</title>
  </head>
  <body class="bg-dark">

    <!-- TABLA TYPE CARD -->
    <div class="container-fluid pt-4">
        <div class="row">
            <div class="col-12">

                <div class="card">
                    <div class="card-header">
                        <button id="addTypeCard" class="btn btn-outline-primary" data-toggle="modal" data-target="#modalAgregarTypeCard">
                            Agregar Type Card
                        </button>
                        <!--
                        <a id="actualizarPaginaCategoria" class="btn btn-outline-primary"
                            href="#">Actualizar
                        </a>
                        -->
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                        <table id="example1" class="table table-bordered table-striped tablaTypeCard">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tipo</th>
                                    <th>Descripción</th>
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
    <!-- /. TABLA TYPE CARD -->



    <!--=====================================
    MODAL AGREGAR TYPE CARD 
    ======================================-->

    <div id="modalAgregarTypeCard" class="modal fade" role="dialog">

        <div class="modal-dialog">

            <div class="modal-content">

                <form id="formAddTypeCard">

                    <!--=====================================
                        HEADER DEL MODAL
                    ======================================-->

                    <div class="modal-header">

                        <h5 class="modal-title" id="exampleModalLabel">Alta Tipo Tarjeta</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                    </div>

                    <!--=====================================
                        CUERPO DEL MODAL
                    ====================================== -->

                    <div class="modal-body">

                        <!-- ENTRADA PARA EL TIPO DE TARJETA -->
                        <div class="input-group pt-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-user"></i>
                                </span>
                            </div>
                            <input type="text" class="form-control" id="tipo" placeholder="Tipo" required>
                        </div>

                        <!-- ENTRADA PARA LA DESCRIPCION DE LA TARJETA -->
                        <div class="input-group pt-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-user"></i>
                                </span>
                            </div>
                            <input type="text" class="form-control" id="desc"
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
                            Guardar Tipo de Tarjeta
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--=====================================
    MODAL EDITAR TYPE CARD 
    ======================================-->

    <div id="modalEditarTypeCard" class="modal fade" role="dialog">

        <div class="modal-dialog">

            <div class="modal-content">

                <form id="formAEditTypeCard">

                    <!--=====================================
                        HEADER DEL MODAL
                    ======================================-->

                    <div class="modal-header">

                        <h5 class="modal-title" id="exampleModalLabel">Editar Tipo Tarjeta</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                    </div>

                    <!--=====================================
                        CUERPO DEL MODAL
                    ====================================== -->

                    <div class="modal-body">

                        <!-- ENTRADA PARA EL TIPO DE TARJETA -->
                        <div class="input-group pt-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-user"></i>
                                </span>
                            </div>
                            <input type="text" class="form-control" id="tipoEdit" placeholder="Tipo" required>
                        </div>

                        <!-- ENTRADA PARA LA DESCRIPCION DE LA TARJETA -->
                        <div class="input-group pt-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-user"></i>
                                </span>
                            </div>
                            <input type="text" class="form-control" id="descEdit" placeholder="Descripción" required>
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
    

    <script src="${pageContext.request.contextPath}/js/type_card.js"></script>
   
    
  </body>
</html>

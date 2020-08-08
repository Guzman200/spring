var tablaModulos;
var idModulo;

/* Inicializamos la datatables */
function init () {
   tablaModulos = $('#example1').DataTable({
        "responsive": true,
         "autoWidth": false,
        "ajax": "select_modulo.do",
        "columns": [
            { "data": "id_m" },
            { "data": "nombre" },
            { "data" : "descripcion" },
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    });
}

init();


const formAddModulo = document.getElementById('formAddModulo');
const formEditModulo = document.getElementById('formEditModulo');

formAddModulo.addEventListener('submit',  (e) => {
    e.preventDefault();
    
    $.ajax({
        url : 'add_modulo.do',
        type : "POST",
        data: {
            nombre:$("#nombre").val(),
            desc : $("#desc").val()
        },
        beforeSend : function(xhr) {
        },
        success : function(resp, textStatus, jqXHR) {
            if(resp === "OK"){
                notificacionExitosa("¡Alta exitosa!");
                tablaModulos.ajax.reload(null, false);
            }else{
                notificarError(resp);
            }
            console.log("Respuesta del servidor : " + resp);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
    
});

formEditModulo.addEventListener('submit', (e) => {
    e.preventDefault();
    
    $.ajax({
        url : 'edit_modulo.do',
        type : "POST",
        data: { 
            id : idModulo,
            nombre:$("#nombreEdit").val(),
            desc : $("#descEdit").val()
        },
        beforeSend : function(xhr) {
        },
        success : function(resp, textStatus, jqXHR) {
            if(resp === "OK"){
                notificacionExitosa("¡Modificación exitosa!");
                tablaModulos.ajax.reload(null, false);
               
            }else{
                notificarError(resp);
            }
            console.log("Respuesta del servidor : " + resp);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
    
});


$(document).on('click', '.btnEditar', function () {

    if(tablaModulos.row(this).child.isShown()){
        var data = tablaModulos.row(this).data();
    }else{
        var data = tablaModulos.row($(this).parents("tr")).data();
    }
    
    /* Cargamos los datos obtenidos al modal editar */
    idModulo = data["id_m"];
    console.log("Id del tipo de BD a editar = " + idModulo);
    $("#nombreEdit").val(data["nombre"]);
    $("#descEdit").val(data["descripcion"]);
    
    $('#modalEditarModulo').modal('show');
    
});

$(document).on('click', '.btnBorrar', async function () {
    
    if(tablaModulos.row(this).child.isShown()){
        var data = tablaModulos.row(this).data();
    }else{
        var data = tablaModulos.row($(this).parents("tr")).data();
    }

    idModulo = data["id_m"];
    console.log("id a eliminar " + idModulo);

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL MODULO?',
        text: "Si no lo esta puede cancelar la acción!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#5bc0de',
        cancelButtonColor: '#d9534f',
        confirmButtonText: 'Si, eliminar!'
    });
    
    if(result.value){
        try {

            $.ajax({
                url : 'delete_modulo.do',
                type : "POST",
                data: { 
                    id : idModulo
                },
                beforeSend : function(xhr) {
                },
                success : function(resp, textStatus, jqXHR) {
                    if(resp === "OK"){
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaModulos.ajax.reload(null, false);

                    }else{
                        notificarError(resp);
                    }
                    console.log("Respuesta del servidor : " + resp);
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
            
        } catch (error) {
            console.log(error);
        }
    }
    
});

$(document).on('click', '#btnAddModulo', () => {
    formAddModulo.reset();
});

function notificacionExitosa(mensaje){
    Swal.fire(
        mensaje,
        '',
        'success'
    ).then(result => {
         $('#modalEditarModulo').modal('hide');
         $('#modalAgregarModulo').modal('hide');
    });
}

function notificarError(mensaje){
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    })
}



   

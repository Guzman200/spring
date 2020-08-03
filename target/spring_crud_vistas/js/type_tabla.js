var tablaTabla;
var idTypeTabla;

/* Inicializamos la datatables */
function init () {
   tablaTabla = $('#example1').DataTable( {
        "responsive": true,
         "autoWidth": false,
        "ajax": "select_tabla.do",
        "columns": [
            { "data": "id_tt" },
            { "data": "type" },
            { "data" : "descripcion"},
           // { "data" : "botones"},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    } );
}

init();


const formAddTypeTabla = document.getElementById('formAddTypeTabla');
const formEditTypeTabla = document.getElementById('formEditTypeTabla');

formAddTypeTabla.addEventListener('submit',  (e) => {
    e.preventDefault();
    
    $.ajax({
        url : 'add_tabla.do',
        type : "POST",
        data: {
            tipo:$("#tipo").val(),
            desc : $("#desc").val()
        },
        beforeSend : function(xhr) {
        },
        success : function(resp, textStatus, jqXHR) {
            if(resp === "OK"){
                notificacionExitosa("¡Alta exitosa!");
                tablaTabla.ajax.reload(null, false);
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

formEditTypeTabla.addEventListener('submit', (e) => {
    e.preventDefault();
    
    $.ajax({
        url : 'edit_tabla.do',
        type : "POST",
        data: { 
            id : idTypeTabla,
            tipo:$("#tipoEdit").val(),
            desc : $("#descEdit").val()
        },
        beforeSend : function(xhr) {
        },
        success : function(resp, textStatus, jqXHR) {
            if(resp === "OK"){
                notificacionExitosa("¡Modificación exitosa!");
                tablaTabla.ajax.reload(null, false);
               
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

    if(tablaTabla.row(this).child.isShown()){
        var data = tablaTabla.row(this).data();
    }else{
        var data = tablaTabla.row($(this).parents("tr")).data();
    }
    
    /* Cargamos los datos obtenidos al modal editar */
    idTypeTabla = data["id_tt"];
    console.log("Id del tipo de BD a editar = " + idTypeTabla);
    $("#tipoEdit").val(data["type"]);
    $("#descEdit").val(data["descripcion"]);
    
    $('#modalEditarTypeTabla').modal('show');
    
});

$(document).on('click', '.btnBorrar', async function () {
    
    if(tablaTabla.row(this).child.isShown()){
        var data = tablaTabla.row(this).data();
    }else{
        var data = tablaTabla.row($(this).parents("tr")).data();
    }

    idTypeTabla = data["id_tt"];
    console.log("id a eliminar " + idTypeTabla);

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL TIPO DE GRAFICA?',
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
                url : 'delete_tabla.do',
                type : "POST",
                data: { 
                    id : idTypeTabla
                },
                beforeSend : function(xhr) {
                },
                success : function(resp, textStatus, jqXHR) {
                    if(resp === "OK"){
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaTabla.ajax.reload(null, false);

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

$(document).on('click', '#addTypeTabla', () => {
    formAddTypeTabla.reset();
});

function notificacionExitosa(mensaje){
    Swal.fire(
        mensaje,
        '',
        'success'
    ).then(result => {
         $('#modalEditarTypeTabla').modal('hide');
         $('#modalAgregarTypeTabla').modal('hide');
    });
}

function notificarError(mensaje){
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    });
}


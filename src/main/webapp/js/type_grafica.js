var tablaGrafica;
var idTypeGrafica;

/* Inicializamos la datatables */
function init () {
   tablaGrafica = $('#example1').DataTable( {
        "responsive": true,
         "autoWidth": false,
        "ajax": "select_grafica.do",
        "columns": [
            { "data": "id_tg" },
            { "data": "type" },
            { "data" : "descripcion"},
           // { "data" : "botones"},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    } );
}

init();


const formAddTypeGrafica = document.getElementById('formAddTypeGrafica');
const formEditTypeGrafica = document.getElementById('formEditTypeGrafica');

formAddTypeGrafica.addEventListener('submit',  (e) => {
    e.preventDefault();
    
    $.ajax({
        url : 'add_grafica.do',
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
                tablaGrafica.ajax.reload(null, false);
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

formEditTypeGrafica.addEventListener('submit', (e) => {
    e.preventDefault();
    
    $.ajax({
        url : 'edit_grafica.do',
        type : "POST",
        data: { 
            id : idTypeGrafica,
            tipo:$("#tipoEdit").val(),
            desc : $("#descEdit").val()
        },
        beforeSend : function(xhr) {
        },
        success : function(resp, textStatus, jqXHR) {
            if(resp === "OK"){
                notificacionExitosa("¡Modificación exitosa!");
                tablaGrafica.ajax.reload(null, false);
               
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

    if(tablaGrafica.row(this).child.isShown()){
        var data = tablaGrafica.row(this).data();
    }else{
        var data = tablaGrafica.row($(this).parents("tr")).data();
    }
    
    /* Cargamos los datos obtenidos al modal editar */
    idTypeGrafica = data["id_tg"];
    console.log("Id del tipo de BD a editar = " + idTypeGrafica);
    $("#tipoEdit").val(data["type"]);
    $("#descEdit").val(data["descripcion"]);
    
    $('#modalEditarTypeGrafica').modal('show');
    
});

$(document).on('click', '.btnBorrar', async function () {
    
    if(tablaGrafica.row(this).child.isShown()){
        var data = tablaGrafica.row(this).data();
    }else{
        var data = tablaGrafica.row($(this).parents("tr")).data();
    }

    idTypeGrafica = data["id_tg"];
    console.log("id a eliminar " + idTypeGrafica);

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
                url : 'delete_grafica.do',
                type : "POST",
                data: { 
                    id : idTypeGrafica
                },
                beforeSend : function(xhr) {
                },
                success : function(resp, textStatus, jqXHR) {
                    if(resp === "OK"){
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaGrafica.ajax.reload(null, false);

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

$(document).on('click', '#bntAddTypeGrafica', () => {
    formAddTypeGrafica.reset();
});

function notificacionExitosa(mensaje){
    Swal.fire(
        mensaje,
        '',
        'success'
    ).then(result => {
         $('#modalEditarTypeGrafica').modal('hide');
         $('#modalAgregarTypeGrafica').modal('hide');
    });
}

function notificarError(mensaje){
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    });
}


var tablaBD;
var idTypeBd;

/* Inicializamos la datatables */
function init () {
   tablaBD = $('#example1').DataTable( {
        "responsive": true,
         "autoWidth": false,
        "ajax": "select_bd.do",
        "columns": [
            { "data": "id_tbd" },
            { "data": "nombre" },
            { "data" : "descripcion"},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    } );
}

init();


const formAddTypeBD = document.getElementById('formAddTypeBD');
const formEditTypeBD = document.getElementById('formEditTypeBD');

formAddTypeBD.addEventListener('submit',  (e) => {
    e.preventDefault();
    
    $.ajax({
        url : 'add_bd.do',
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
                tablaBD.ajax.reload(null, false);
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

formEditTypeBD.addEventListener('submit', (e) => {
    e.preventDefault();
    
    $.ajax({
        url : 'edit_bd.do',
        type : "POST",
        data: { 
            id : idTypeBd,
            nombre:$("#nombreEdit").val(),
            desc : $("#descEdit").val()
        },
        beforeSend : function(xhr) {
        },
        success : function(resp, textStatus, jqXHR) {
            if(resp === "OK"){
                notificacionExitosa("¡Modificación exitosa!");
                tablaBD.ajax.reload(null, false);
               
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

    if(tablaBD.row(this).child.isShown()){
        var data = tablaBD.row(this).data();
        console.log(data["nombre"]);
    }else{
        var data = tablaBD.row($(this).parents("tr")).data();
        console.log(data["nombre"]);
    }
    
    /* Cargamos los datos obtenidos al modal editar */
    idTypeBd = data["id_tbd"];
    console.log("Id del tipo de BD a editar = " + idTypeBd);
    $("#nombreEdit").val(data["nombre"]);
    $("#descEdit").val(data["descripcion"]);
    
    $('#modalEditarTypeBD').modal('show');
    
});

$('.tablaTypeBD').on('click', '.btnBorrar', async function () {
    
    if(tablaBD.row(this).child.isShown()){
        var data = tablaBD.row(this).data();
    }else{
        var data = tablaBD.row($(this).parents("tr")).data();
    }

    idTypeBd = data["id_tbd"];
    console.log("id a eliminar " + idTypeBd);

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL TIPO DE BD?',
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
                url : 'delete_bd.do',
                type : "POST",
                data: { 
                    id : idTypeBd
                },
                beforeSend : function(xhr) {
                },
                success : function(resp, textStatus, jqXHR) {
                    if(resp === "OK"){
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaBD.ajax.reload(null, false);

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

$(document).on('click', '#bntAddTypeBd', () => {
    formAddTypeBD.reset();
});

function notificacionExitosa(mensaje){
    Swal.fire(
        mensaje,
        '',
        'success'
    ).then(result => {
         $('#modalEditarTypeBD').modal('hide');
         $('#modalAgregarTypeBD').modal('hide');
    });
}

function notificarError(mensaje){
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    })
}



   

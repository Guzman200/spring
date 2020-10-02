import { iconosGLOBAL } from './return_iconos.js';

var tablaCard;
var idTypeCard;
var claseIcono;

var icono = document.getElementById("icono");
var divIconos = document.getElementById("divIconos");  
var divIconosEdit = document.getElementById("divIconosEdit");
        
/* Inicializamos la datatables */
function init() {
    tablaCard = $('#example1').DataTable({
        "responsive": true,
        "autoWidth": false,
        "ajax": "select_card.do",
        "columns": [
            {"data": "id_tc"},
            {"data": "type"},
            {"data": "descripcion"},
            {"data": function (icono){
                    return `<span class="${icono.icono}"></span>`;
            }},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    });
}

init();


const formAddTypeCard = document.getElementById('formAddTypeCard');
const formEditTypeCard = document.getElementById('formAEditTypeCard');

formAddTypeCard.addEventListener('submit', (e) => {
    e.preventDefault();

    $.ajax({
        url: 'add_card.do',
        type: "POST",
        data: {
            tipo: $("#tipo").val(),
            desc: $("#desc").val(),
            icono: $("#icono").val()
        },
        beforeSend: function (xhr) {
        },
        success: function (resp, textStatus, jqXHR) {
            if (resp === "OK") {
                notificacionExitosa("¡Alta exitosa!");
                tablaCard.ajax.reload(null, false);
            } else {
                notificarError(resp);
            }
            console.log("Respuesta del servidor : " + resp);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log("Entro en este error");
        }
    });

});

formEditTypeCard.addEventListener('submit', (e) => {
    e.preventDefault();

    $.ajax({
        url: 'edit_card.do',
        type: "POST",
        data: {
            id: idTypeCard,
            tipo: $("#tipoEdit").val(),
            desc: $("#descEdit").val(),
            icono: $("#iconoEdit").val()
        },
        beforeSend: function (xhr) {
        },
        success: function (resp, textStatus, jqXHR) {
            if (resp === "OK") {
                notificacionExitosa("¡ Modificación exitosa !");
                tablaCard.ajax.reload(null, false);
            } else {
                notificarError(resp);
            }
            console.log("Respuesta del servidor : " + resp);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });

});


$(document).on('click', '.btnEditar', function () {

    if (tablaCard.row(this).child.isShown()) {
        var data = tablaCard.row(this).data();
    } else {
        var data = tablaCard.row($(this).parents("tr")).data();
    }

    /* Cargamos los datos obtenidos al modal editar */
    idTypeCard = data["id_tc"];
    console.log("Id del tipo de card a editar = " + idTypeCard);
    $("#tipoEdit").val(data["type"]);
    $("#descEdit").val(data["descripcion"]);
    $("#iconoEdit").val(data["icono"]);
    
     $("#i_iconoEdit").removeAttr('class');
     $("#i_iconoEdit").addClass(data['icono']);

    $('#modalEditarTypeCard').modal('show');

});

$(document).on('click', '.btnBorrar', async function () {

    if (tablaCard.row(this).child.isShown()) {
        var data = tablaCard.row(this).data();
    } else {
        var data = tablaCard.row($(this).parents("tr")).data();
    }

    idTypeCard = data["id_tc"];
    console.log("id a eliminar " + idTypeCard);

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL TIPO DE TARJETA?',
        text: "Si no lo esta puede cancelar la acción!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#5bc0de',
        cancelButtonColor: '#d9534f',
        confirmButtonText: 'Si, eliminar!'
    });

    if (result.value) {
        try {

            $.ajax({
                url: 'delete_card.do',
                type: "POST",
                data: {
                    id: idTypeCard
                },
                beforeSend: function (xhr) {
                },
                success: function (resp, textStatus, jqXHR) {
                    if (resp === "OK") {
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaCard.ajax.reload(null, false);
                    } else {
                        notificarError(resp);
                    }
                    console.log("Respuesta del servidor : " + resp);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });

        } catch (error) {
            console.log(error);
        }
    }

});

$(document).on('click', '#addTypeCard', () => {
    formAddTypeCard.reset();
});

function cargarIconos(){
   
    divIconos.innerHTML += iconosGLOBAL;
    divIconosEdit.innerHTML += iconosGLOBAL;
    console.log(divIconos);
} 

cargarIconos();

$(document).on('click', '.elegirIcono', function (e){
    var span = e.target;
    var clases = span.classList;
    
    claseIcono = clases[0] + " " + clases[1];
    $("#i_icono").removeAttr('class');
    $("#i_iconoEdit").removeAttr('class');
    $("#i_icono").addClass(claseIcono);
    $("#i_iconoEdit").addClass(claseIcono);
    $("#icono").val(claseIcono);
    $("#iconoEdit").val(claseIcono);
    
    console.log(claseIcono);
});
    




function notificacionExitosa(mensaje) {
    Swal.fire(
            mensaje,
            '',
            'success'
            ).then(result => {
        $('#modalEditarTypeCard').modal('hide');
        $('#modalAgregarTypeCard').modal('hide');
    });
}

function notificarError(mensaje) {
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    })
}
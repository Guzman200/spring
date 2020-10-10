import { iconosGLOBAL } from './return_iconos.js';

const btnAddControl = document.getElementById('btnAddControl');
const formAddControl = document.getElementById('formAddControl');
var tablaControl;
var option; // 1 es agregar, 2 es editar
var id_c; // id conexion
var id_e; // id elemento 
var id_p; // id posicion
var mensaje;

var divIconos = document.getElementById("sptm");

/* Inicializamos la datatables */
function init () {
   tablaControl = $('#example1').DataTable({
        "responsive": true,
         "autoWidth": false,
        "ajax": "select_controlUno.do",
        "columns": [
            { "data": "id_c",
              "visible" : false},
            { "data": "id_tc",
              "visible" : false },
            { "data" : "id_m" ,
              "visible" : false},
            { "data" : "id_f" ,
              "visible" : false},
            { "data" : "id_e" ,
              "visible" : false},
            { "data" : "id_co" ,
              "visible" : false},
            { "data" : "modulo"},
            { "data" : "tipo"},
            { "data" : "altura"},
            { "data" : "anchura"},
            { "data" : "color1"},
            { "data" : "color2"},
            { "data" : "titulo"},
            { "data" : "descripcion"},
            { "data" : "posicionx"},
            { "data" : "posiciony"},
            { "data" : "formato"},
            { "data" : "tc"},
            { "data" : "url"},
            { "data" : "id_p",
              "visible" : false},
            {"data" : function (icono){
                     return `<span class="${icono.icono}"></span>`;
            }},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    });
    
   divIconos.innerHTML += iconosGLOBAL;
     
}


function llenarSelects (){
    $.ajax({
        "url" : "select_modulo.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            let selectAdd = document.getElementById("selectModulo");
            for( let item of data.data ){
                let option = document.createElement("option");
                option.text = item.nombre;
                option.value = item.id_m;
                selectAdd.appendChild(option);     
            }  
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
    
    $.ajax({
        "url" : "select_card.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            let selectCard = document.getElementById("selectCard");
            for( let item of data.data ){
                let option = document.createElement("option");
                option.text = item.type;
                option.value = item.id_tc;
                selectCard.appendChild(option);     
            }  
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
    
    $.ajax({
        "url" : "select_conexion.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            let selectConexion = document.getElementById("selectConexion");
            for( let item of data.data ){
                let option = document.createElement("option");
                option.text = item.url;
                option.value = item.id_co;
                selectConexion.appendChild(option);     
            }  
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
    
     $.ajax({
        "url" : "select_formato.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            let selectFormato = document.getElementById("selectFormato");
            for( let item of data.data ){
                let option = document.createElement("option");
                option.text = item.nombre;
                option.value = item.id_f;
                selectFormato.appendChild(option);     
            }  
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
}

init();
llenarSelects();

btnAddControl.addEventListener('click', () => {
     option = 1;
     mensaje = "Alta exitosa";
     $('#posX').val("");
     $('#posY').val("");
     $('#altura').val("");
     $('#anchura').val("");
     $('#colorUno').val("");
     $('#colorDos').val("");
     $('#tipo').val("");
     $('#titulo').val("");
     $('#descripcion').val("");
     $("#selectModulo").val("default");
     $("#selectCard").val("default");
     $("#selectConexion").val("default");
     $("#selectFormato").val("default");
     $("#input_icono").val("");
     $("#i_icono").removeAttr('class');
});

$(document).on('click', '.btnEditar', function () {
    option = 2;
    mensaje = "Modificación exitosa";
    if(tablaControl.row(this).child.isShown()){
        var data = tablaControl.row(this).data();
    }else{
        var data = tablaControl.row($(this).parents("tr")).data();
    }
    
    id_c = data['id_c'];
    id_p = data['id_p'];
    id_e = data['id_e'];
    $('#posX').val(data['posicionx']);
    $('#posY').val(data['posiciony']);
    $('#altura').val(data['altura']);
    $('#anchura').val(data['anchura']);
    $('#colorUno').val(data['color1']);
    $('#colorDos').val(data['color2']);
    $('#tipo').val(data['tipo']);
    $('#titulo').val(data['titulo']);
    $('#descripcion').val(data['descripcion']);
    $("#selectModulo").val(data['id_m']);
    $("#selectCard").val(data['id_tc']);
    $("#selectConexion").val(data['id_co']);
    $("#selectFormato").val(data['id_f']);
    $("#input_icono").val(data['icono']);
    
     $("#i_icono").removeAttr('class');
     $("#i_icono").addClass(data['icono']);
    
    $("#modalAgregarControl").modal("show");
});

$(document).on('click', '.btnBorrar', async  function () {
    
    if(tablaControl.row(this).child.isShown()){
        var data = tablaControl.row(this).data();
    }else{
        var data = tablaControl.row($(this).parents("tr")).data();
    }
    
    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL CONTROL?',
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
                url : "delete_controlUno.do",
                type : "POST",
                data: { 
                    id_c : data['id_c']
                },
                beforeSend : function(xhr) {
                },
                success : function(resp, textStatus, jqXHR) {
                    if(resp === "OK"){
                        notificacionExitosa("¡Baja exitosa!");
                        tablaControl.ajax.reload(null, false);
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

formAddControl.addEventListener('submit', (e) => {
    e.preventDefault();
    let ban = validarSelects();
    let url;
    if(ban){
       if(option === 1){
           url = "insert_controlUno.do";
           id_c = 0;
           id_e = 0;
           id_p = 0;
       }else if(option === 2){
           url = "update_controlUno.do";
       }
        
       $.ajax({
            url : url,
            type : "POST",
            data: { 
                id_c : id_c,
                modulo : $("#selectModulo").val(),
                tarjeta : $("#selectCard").val(),
                conexion : $("#selectConexion").val(),
                formato : $("#selectFormato").val(),
                pos_x : $("#posX").val(),
                pos_y:$("#posY").val(),
                altura : $("#altura").val(),
                anchura : $("#anchura").val(),
                colorUno : $("#colorUno").val(),
                colorDos : $("#colorDos").val(),
                tipo : $("#tipo").val(),
                titulo : $("#titulo").val(),
                descripcion : $("#descripcion").val(),
                id_p : id_p,
                id_e : id_e,
                icono : $("#input_icono").val()
            },
            beforeSend : function(xhr) {
            },
            success : function(resp, textStatus, jqXHR) {
                if(resp === "OK"){
                    notificacionExitosa(mensaje);
                    tablaControl.ajax.reload(null, false);
                }else{
                    notificarError(resp);
                }
                console.log("Respuesta del servidor : " + resp);
            },
            error : function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }
});

function  validarSelects(){
    let selectModulo = document.getElementById("selectModulo");
    let selectCard = document.getElementById("selectCard");
    let selectConexion = document.getElementById("selectConexion");
    let selectFormato = document.getElementById("selectFormato");
    
    if(selectModulo.value === "default"){
        notificarError("Selecciona un tipo de Modulo");
        return false;
    }else if(selectCard.value === "default"){
        notificarError("Selecciona un tipo de tarjeta");
        return false;
    }else if(selectConexion.value === "default"){
        notificarError("Selecciona un tipo de conexión");
        return false;
    }else if(selectFormato.value === "default"){
        notificarError("Selecciona un tipo de formato");
        return false;
    }
    
    return true;
}

$(document).on('click', '.elegirIcono', function (e){
    var span = e.target;
    var clases = span.classList;
    
    let claseIcono = clases[0] + " " + clases[1];
    $("#i_icono").removeAttr('class');
    $("#i_icono").addClass(claseIcono);
    $("#input_icono").val(claseIcono);
    
});


function notificacionExitosa(mensaje){
    Swal.fire(
        mensaje,
        '',
        'success'
    ).then(result => {
         $('#modalAgregarControl').modal('hide');
    });
}

function notificarError(mensaje){
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    });
}

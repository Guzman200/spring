const btnAddControl = document.getElementById('btnAddControl');
const formAddControl = document.getElementById('formAddControl');
var tablaControl;
var option; // 1 es agregar, 2 es editar
var id_t; // id control
var id_e; // id elemento 
var id_p; // id posicion
var mensaje;

/* Inicializamos la datatables */
function init () {
   tablaControl = $('#example1').DataTable({
        "responsive": true,
         "autoWidth": false,
        "ajax": "select_controlDos.do",
        "columns": [
            { "data": "id_t",
              "visible" : false},
            { "data": "id_tt",
              "visible" : false},
            { "data" : "id_m",
              "visible" : false},
            { "data" : "id_e",
              "visible" : false},
            { "data" : "id_co",
              "visible" : false},
            { "data" : "modulo"},
            { "data" : "tipo"},
            { "data" : "altura"},
            { "data" : "anchura"},
            { "data" : "color_1"},
            { "data" : "color_2"},
            { "data" : "titulo"},
            { "data" : "descripcion"},
            { "data" : "posicion_x"},
            { "data" : "posicion_y"},
            { "data" : "type"},
            { "data" : "url"},    
            { "data" : "encabezados"},
            { "data" : "id_p",
              "visible" : false},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    });
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
        "url" : "select_tabla.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            let selectTabla = document.getElementById("selectTabla");
            for( let item of data.data ){
                let option = document.createElement("option");
                option.text = item.type;
                option.value = item.id_tt;
                selectTabla.appendChild(option);     
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
    
}

init();
llenarSelects();

btnAddControl.addEventListener('click', () => {
     option = 1;
     mensaje = "Alta exitosa";
     $("#encabezado").val("");
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
     $("#selectTabla").val("default");
     $("#selectConexion").val("default");
     
});

$(document).on('click', '.btnEditar', function () {
    option = 2;
    mensaje = "Modificación exitosa";
    if(tablaControl.row(this).child.isShown()){
        var data = tablaControl.row(this).data();
    }else{
        var data = tablaControl.row($(this).parents("tr")).data();
    }
    
    id_t = data['id_t'];
    id_p = data['id_p'];
    id_e = data['id_e'];
    $('#posX').val(data['posicion_x']);
    $('#posY').val(data['posicion_x']);
    $('#altura').val(data['altura']);
    $('#anchura').val(data['anchura']);
    $('#colorUno').val(data['color_1']);
    $('#colorDos').val(data['color_2']);
    $('#tipo').val(data['tipo']);
    $('#titulo').val(data['titulo']);
    $('#descripcion').val(data['descripcion']);
    $("#selectModulo").val(data['id_m']);
    $("#selectTabla").val(data['id_tt']);
    $("#encabezado").val(data['encabezados']);
    $("#selectConexion").val(data['id_co']);
    
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
                url : "delete_controlDos.do",
                type : "POST",
                data: { 
                    id_t : data['id_t']
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
           url = "insert_controlDos.do";
           id_t = 0;
           id_e = 0;
           id_p = 0;
       }else if(option === 2){
           url = "update_controlDos.do";
       }
        
       $.ajax({
            url : url,
            type : "POST",
            data: { 
                id_t : id_t,
                modulo : $("#selectModulo").val(),
                tabla : $("#selectTabla").val(),
                conexion : $("#selectConexion").val(),
                pos_x : $("#posX").val(),
                pos_y:$("#posY").val(),
                altura : $("#altura").val(),
                anchura : $("#anchura").val(),
                colorUno : $("#colorUno").val(),
                colorDos : $("#colorDos").val(),
                tipo : $("#tipo").val(),
                titulo : $("#titulo").val(),
                descripcion : $("#descripcion").val(),
                encabezado : $("#encabezado").val(),
                id_p : id_p,
                id_e : id_e
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
    let selectTabla = document.getElementById("selectTabla");
    let selectConexion = document.getElementById("selectConexion");
    
    if(selectModulo.value === "default"){
        notificarError("Selecciona un tipo de Modulo");
        return false;
    }else if(selectTabla.value === "default"){
        notificarError("Selecciona un tipo de tabla");
        return false;
    }else if(selectConexion.value === "default"){
        notificarError("Selecciona un tipo de conexión");
        return false;
    }
    
    return true;
}

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

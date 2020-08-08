var tablaConexion;
var idConexion;

/* Inicializamos la datatables */
function init () {
   tablaConexion = $('#example1').DataTable({
        "responsive": true,
         "autoWidth": false,
        "ajax": "select_conexion.do",
        "columns": [
            { "data": "id_co" },
            { "data": "url" },
            { "data" : "login" },
            { "data" : "password" },
            { "data" : "bd" },
            { "data" : "nombre" },
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    });
}

init();

function llenarSelect (){
    $.ajax({
        "url" : "select_bd.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            
            let selectAdd = document.getElementById("conexionTipoBD");
            let selectEdit = document.getElementById("conexionTipoBDEdit");
           
            for(let item of data.data){
                let option = document.createElement("option");
                let option2 = document.createElement("option");
                option.text = item.nombre;
                option.value = item.id_tbd;
                option2.text = item.nombre;
                option2.value = item.id_tbd;
                selectAdd.appendChild(option);
                selectEdit.appendChild(option2);
            }
            
            
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
}

llenarSelect();


const formAddConexion = document.getElementById('formAddConexion');
const formEditConexion = document.getElementById('formEditConexion');

formAddConexion.addEventListener('submit',  (e) => {
    e.preventDefault();
    let selectAdd = document.getElementById("conexionTipoBD");
    
    if( selectAdd.value === "default"){
        notificarError("Selecciona un tipo de BD");
    }else{
        $.ajax({
            url : 'add_conexion.do',
            type : "POST",
            data: {
                url:$("#url").val(),
                login : $("#login").val(),
                pass : $("#pass").val(),
                bd : $("#bd").val(),
                id_tbd : selectAdd.value
            },
            beforeSend : function(xhr) {
            },
            success : function(resp, textStatus, jqXHR) {
                if(resp === "OK"){
                    notificacionExitosa("¡Alta exitosa!");
                    tablaConexion.ajax.reload(null, false);
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

formEditConexion.addEventListener('submit', (e) => {
    e.preventDefault();
    
    let selectEdit = document.getElementById("conexionTipoBDEdit");
    
    if(selectEdit.value === "default"){
        notificarError("Selecciona un tipo de BD");
    }else{
        $.ajax({
            url : 'edit_conexion.do',
            type : "POST",
            data: { 
                url : $("#urlEdit").val(),
                login:$("#loginEdit").val(),
                pass : $("#passEdit").val(),
                bd : $("#bdEdit").val(),
                id_tbd : selectEdit.value,
                id_co : idConexion
            },
            beforeSend : function(xhr) {
            },
            success : function(resp, textStatus, jqXHR) {
                if(resp === "OK"){
                    notificacionExitosa("¡Modificación exitosa!");
                    tablaConexion.ajax.reload(null, false);

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


$(document).on('click', '.btnEditar', function () {

    if(tablaConexion.row(this).child.isShown()){
        var data = tablaConexion.row(this).data();
    }else{
        var data = tablaConexion.row($(this).parents("tr")).data();
    }
    
    /* Cargamos los datos obtenidos al modal editar */
    idConexion = data["id_co"];
    console.log("Id del tipo de BD a editar = " + idConexion);
    $("#urlEdit").val(data["url"]);
    $("#loginEdit").val(data["login"]);
    $("#passEdit").val(data["password"]);
    $("#bdEdit").val(data["bd"]);
    
    let idTypeBD = getIdTypeBD(idConexion);
    
    $('#modalEditarConexion').modal('show');
    
});

function getIdTypeBD(id_co){
    $.ajax({
        url : 'selectTypeBD_conexion.do',
        type : "POST",
        data: { 
            id : id_co
        },
        dataType: 'json',
        success : function(data, textStatus, jqXHR) {
            let id = data.data[0]['id_tbd'];
            let selectEdit = document.getElementById("conexionTipoBDEdit");
    
            console.log(id)
            for(let i = 0; i<selectEdit.length; i++){
                let option = selectEdit[i];
                if(option.value == id){
                    selectEdit.value = option.value;
                }
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
}

$(document).on('click', '.btnBorrar', async function () {
    
    if(tablaConexion.row(this).child.isShown()){
        var data = tablaConexion.row(this).data();
    }else{
        var data = tablaConexion.row($(this).parents("tr")).data();
    }

    idConexion = data["id_co"];
    console.log("id a eliminar " + idConexion);

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR LA CONEXIÓN?',
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
                url : 'delete_conexion.do',
                type : "POST",
                data: { 
                    id : idConexion
                },
                beforeSend : function(xhr) {
                },
                success : function(resp, textStatus, jqXHR) {
                    if(resp === "OK"){
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaConexion.ajax.reload(null, false);

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

$(document).on('click', '#btnAddConexion', () => {
    
    $("#login").val = "";
    $("#url").val = "";
    $("#pass").val = "";
    $("#bd").val = "";
    
});

function notificacionExitosa(mensaje){
    Swal.fire(
        mensaje,
        '',
        'success'
    ).then(result => {
         $('#modalEditarConexion').modal('hide');
         $('#modalAgregarConexion').modal('hide');
    });
}

function notificarError(mensaje){
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    })
}



   

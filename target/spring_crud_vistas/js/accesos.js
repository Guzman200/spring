/* Variables para el CRUD de perfil */
var tablaPerfil;
var formAddPerfil = document.getElementById("formAddPerfil");
var btnFormCancelarPerfil = document.getElementById("btnFormCancelarPerfil");
var tituloModalPerfil = document.getElementById("tituloModalPerfil");
var collapseTablaPerfil = document.getElementById("collapseTablaPerfil");
var btnNuevoPerfil = document.getElementById("btnNuevoPerfil");
var id_perfil; // 1 -> insert, 2 -> update
var opcion_perfil;

/* Variables para el CRUD de modulo*/
var tablaModulo;
var btnNuevoModulo = document.getElementById("btnNuevoModulo");
var formAddModulo = document.getElementById("formAddModulo");
var btnFormCancelarModulo = document.getElementById("btnFormCancelarModulo");
var tituloModalModulo = document.getElementById("tituloModalModulo");
var id_modulo; // 1 -> insert, 2 -> update
var opcion_modulo;

/* Variables para el CRUD de permiso*/
var tablaPermiso;
var btnNuevoPermiso = document.getElementById("btnNuevoPermiso");
var formAddPermiso = document.getElementById("formAddPermiso");
var btnFormCancelarPermiso = document.getElementById("btnFormCancelarPermiso");
var tituloModalPermiso = document.getElementById("tituloModalPermiso");
var id_permiso; // 1 -> insert, 2 -> update
var opcion_permiso;

/* Variables para el CRUD de usuario */
var tablaUsuario;
var btnNuevoUsuario = document.getElementById("btnNuevoUsuario");
var formAddUsuario = document.getElementById("formAddUsuario");
var btnFormCancelarUsuario = document.getElementById("btnFormCancelarUsuario");
var tituloModalUsuario = document.getElementById("tituloModalUsuario");
var id_usuario; // 1 -> insert, 2 -> update
var opcion_usuario;

/* Variables para el CURD de permisos modulos */

var tablaPermisoModulo;
var btnNuevoPermisoModulo = document.getElementById("btnNuevoPermisoModulo");
var formAddPermisoModulo = document.getElementById("formAddPermisoModulo");
var btnFormCancelarPermisoModulo = document.getElementById("btnFormCancelarPermisoModulo");
var tituloModalPermisoModulo = document.getElementById("tituloModalPermisoModulo");
var id_pm; // 1 -> insert, 2 -> update
var opcion_pm;
var selectModulo = document.getElementById("selectModulo_pm");
var selectPermiso = document.getElementById("selectPermiso_pm");
var descripcionModuloLabel = document.getElementById("descripcionModuloLabel");
var descripcionPermisoLabel = document.getElementById("descripcionPermisoLabel");

/* Variables para modulo configuracion de perfil */

var selectConfigPerfil = document.getElementById("selectConfigPerfil");
var selectConfigModulo = document.getElementById("selectConfigModulo");
var selectConfigPermiso = document.getElementById("selectConfigPermiso");
var tablaPermisosPerfil = document.getElementById("tablaPermisosPerfil");
var btnAddPermiso = document.getElementById("btnAddPermiso");
var formGuardarPermisos = document.getElementById("formGuardarPermisos");
var permisosPerfil = [];

/* Inicializamos la datatables */
function init() {

    tablaPerfil = $('#tablaPerfil').DataTable({
        "responsive": true,
        "autoWidth": false,
        "ajax": "select_perfil.do",
        "columns": [
            {"data": "id_pe"},
            {"data": "nombre"},
            {"data": "status", "visible": false},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditarPerfil'>EDIT</button><button class='btn btn-danger btn-sm btnBorrarPerfil'>DELETE</button></div></div>"}
        ]
    });

    tablaModulo = $('#tablaModulo').DataTable({
        "responsive": true,
        "autoWidth": false,
        "ajax": "select_modulo_sistema.do",
        "columns": [
            {"data": "id_mo"},
            {"data": "nombre"},
            {"data": "descripcion"},
            {"data": "status", "visible": false},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditarModulo'>EDIT</button><button class='btn btn-danger btn-sm btnBorrarModulo'>DELETE</button></div></div>"}
        ]
    });

    tablaPermiso = $('#tablaPermiso').DataTable({
        "responsive": true,
        "autoWidth": false,
        "ajax": "select_permiso.do",
        "columns": [
            {"data": "id_p"},
            {"data": "nombre"},
            {"data": "descripcion"},
            {"data": "status", "visible": false},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditarPermiso'>EDIT</button><button class='btn btn-danger btn-sm btnBorrarPermiso'>DELETE</button></div></div>"}
        ]
    });

    tablaUsuario = $('#tablaUsuario').DataTable({
        "responsive": true,
        "autoWidth": false,
        "ajax": "select_usuarios.do",
        "columns": [
            {"data": "id_u"},
            {"data": "login"},
            {"data": "password"},
            {"data": "id_pe", "visible": false},
            {"data": "nombre"},
            {"data": "status", "visible": false},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditarUsuario'>EDIT</button><button class='btn btn-danger btn-sm btnBorrarUsuario'>DELETE</button></div></div>"}
        ]
    });

    // LLenamos el select de perfil
    $.ajax({
        "url": "select_perfil.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            let selectPerfil = document.getElementById("selectPerfil");
            for (let item of data.data) {
                let option = document.createElement("option");
                option.text = item.nombre;
                option.value = item.id_pe;
                selectPerfil.appendChild(option);
            }

            selectConfigPerfil.innerHTML = selectPerfil.innerHTML;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });

    // LLenamos el select de modulos
    $.ajax({
        "url": "select_modulo_sistema.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {

            for (let item of data.data) {
                let option = document.createElement("option");
                option.text = item.nombre;
                option.value = item.id_mo;
                option.setAttribute("data-descripcion", item.descripcion);
                selectModulo.appendChild(option);
            }
            selectConfigModulo.innerHTML = selectModulo.innerHTML;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });

    tablaPermisoModulo = $('#tablaPermisoModulo').DataTable({
        "responsive": true,
        "autoWidth": false,
        "ajax": "select_permiso_modulo.do",
        "columns": [
            {"data": "id_pm"},
            {"data": "nombre_m"},
            {"data": "id_mo"},
            {"data": "nombre_p"},
            {"data": "id_p"},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditarPermisoModulo'>EDIT</button><button class='btn btn-danger btn-sm btnBorrarPermisoModulo'>DELETE</button></div></div>"}
        ]
    });


    btnNuevoPerfil.click();
    btnNuevoModulo.click();
    btnNuevoPermiso.click();
    btnNuevoUsuario.click();
    btnNuevoPermisoModulo.click();
}

init();

/* Funciones para el CRUD de perfil */

formAddPerfil.addEventListener("submit", function (e) {
    e.preventDefault();

    let url;
    let mensaje;
    if (opcion_perfil === 1) {
        url = "add_perfil.do";
        mensaje = "¡Alta exitosa!";
    } else if (opcion_perfil === 2) {
        url = "update_perfil.do";
        mensaje = "¡Modificación exitosa!";
    }

    $.ajax({
        url: url,
        type: "POST",
        data: {
            id: id_perfil,
            nombre: $("#nombrePerfil").val()
        },
        success: function (resp, textStatus, jqXHR) {
            if (resp === "OK") {
                notificacionExitosa(mensaje);
                tablaPerfil.ajax.reload(null, false);
                btnFormCancelarPerfil.click();
            } else {
                notificarError(resp);
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
});

btnFormCancelarPerfil.addEventListener("click", function () {
    $("#nombrePerfil").val("");
    btnNuevoPerfil.click();
});

btnNuevoPerfil.addEventListener("click", function () {
    opcion_perfil = 1;
    tituloModalPerfil.innerText = "Creación de perfil";
    btnFormCancelarPerfil.click();
});

$(document).on('click', '.btnEditarPerfil', function () {
    btnNuevoPerfil.click();
    tituloModalPerfil.innerText = "Editanto perfil";
    opcion_perfil = 2;

    if (tablaPerfil.row(this).child.isShown()) {
        var data = tablaPerfil.row(this).data();
    } else {
        var data = tablaPerfil.row($(this).parents("tr")).data();
    }
    id_perfil = data['id_pe'];
    $("#nombrePerfil").val(data["nombre"]);

});

$(document).on('click', '.btnBorrarPerfil', async function () {
    if (tablaPerfil.row(this).child.isShown()) {
        var data = tablaPerfil.row(this).data();
    } else {
        var data = tablaPerfil.row($(this).parents("tr")).data();
    }

    id_perfil = data["id_pe"];

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL PERFIL?',
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
                url: 'delete_perfil.do',
                type: "POST",
                data: {
                    id: id_perfil
                },
                success: function (resp, textStatus, jqXHR) {
                    if (resp === "OK") {
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaPerfil.ajax.reload(null, false);
                    } else {
                        notificarError(resp);
                    }
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

/* Funciones para el CRUD de modulo*/

formAddModulo.addEventListener("submit", function (e) {
    e.preventDefault();

    let url;
    let mensaje;
    if (opcion_modulo === 1) {
        url = "add_modulo_sistema.do";
        mensaje = "¡Alta exitosa!";
    } else if (opcion_modulo === 2) {
        url = "update_modulo_sistema.do";
        mensaje = "¡Modificación exitosa!";
    }

    $.ajax({
        url: url,
        type: "POST",
        data: {
            id: id_modulo,
            nombre: $("#nombreModulo").val(),
            descripcion: $("#descripcionModulo").val()
        },
        success: function (resp, textStatus, jqXHR) {
            if (resp === "OK") {
                notificacionExitosa(mensaje);
                tablaModulo.ajax.reload(null, false);
                btnFormCancelarModulo.click();
            } else {
                notificarError(resp);
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
});

btnFormCancelarModulo.addEventListener("click", function () {
    $("#nombreModulo").val("");
    $("#descripcionModulo").val("");
    btnNuevoModulo.click();
});

btnNuevoModulo.addEventListener("click", function () {
    opcion_modulo = 1;
    tituloModalModulo.innerText = "Creación de modulo";
    btnFormCancelarModulo.click();
});

$(document).on('click', '.btnEditarModulo', function () {
    btnNuevoModulo.click();
    tituloModalModulo.innerText = "Editanto perfil";
    opcion_modulo = 2;

    if (tablaModulo.row(this).child.isShown()) {
        var data = tablaModulo.row(this).data();
    } else {
        var data = tablaModulo.row($(this).parents("tr")).data();
    }
    id_modulo = data['id_mo'];
    $("#nombreModulo").val(data["nombre"]);
    $("#descripcionModulo").val(data["descripcion"]);

});

$(document).on('click', '.btnBorrarModulo', async function () {
    if (tablaModulo.row(this).child.isShown()) {
        var data = tablaModulo.row(this).data();
    } else {
        var data = tablaModulo.row($(this).parents("tr")).data();
    }

    id_modulo = data["id_mo"];

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL MODULO?',
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
                url: 'delete_modulo_sistema.do',
                type: "POST",
                data: {
                    id: id_modulo
                },
                success: function (resp, textStatus, jqXHR) {
                    if (resp === "OK") {
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaModulo.ajax.reload(null, false);
                    } else {
                        notificarError(resp);
                    }
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


/* Funciones para el CRUD de permiso*/

formAddPermiso.addEventListener("submit", function (e) {
    e.preventDefault();

    let url;
    let mensaje;
    if (opcion_permiso === 1) {
        url = "add_permiso.do";
        mensaje = "¡Alta exitosa!";
    } else if (opcion_permiso === 2) {
        url = "update_permiso.do";
        mensaje = "¡Modificación exitosa!";
    }

    $.ajax({
        url: url,
        type: "POST",
        data: {
            id: id_permiso,
            nombre: $("#nombrePermiso").val(),
            descripcion: $("#descripcionPermiso").val()
        },
        success: function (resp, textStatus, jqXHR) {
            if (resp === "OK") {
                notificacionExitosa(mensaje);
                tablaPermiso.ajax.reload(null, false);
                btnFormCancelarPermiso.click();
            } else {
                notificarError(resp);
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
});

btnFormCancelarPermiso.addEventListener("click", function () {
    $("#nombrePermiso").val("");
    $("#descripcionPermiso").val("");
    btnNuevoPermiso.click();
});

btnNuevoPermiso.addEventListener("click", function () {
    opcion_permiso = 1;
    tituloModalPermiso.innerText = "Creación de permiso";
    btnFormCancelarPermiso.click();
});

$(document).on('click', '.btnEditarPermiso', function () {
    btnNuevoPermiso.click();
    tituloModalPermiso.innerText = "Editanto permiso";
    opcion_permiso = 2;

    if (tablaPermiso.row(this).child.isShown()) {
        var data = tablaPermiso.row(this).data();
    } else {
        var data = tablaPermiso.row($(this).parents("tr")).data();
    }
    id_permiso = data['id_p'];
    $("#nombrePermiso").val(data["nombre"]);
    $("#descripcionPermiso").val(data["descripcion"]);

});

$(document).on('click', '.btnBorrarPermiso', async function () {
    if (tablaPermiso.row(this).child.isShown()) {
        var data = tablaPermiso.row(this).data();
    } else {
        var data = tablaPermiso.row($(this).parents("tr")).data();
    }

    id_permiso = data["id_p"];

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL PERMISO?',
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
                url: 'delete_permiso.do',
                type: "POST",
                data: {
                    id: id_permiso
                },
                success: function (resp, textStatus, jqXHR) {
                    if (resp === "OK") {
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaPermiso.ajax.reload(null, false);
                    } else {
                        notificarError(resp);
                    }
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

/* Funciones para el CRUD de usuario */

formAddUsuario.addEventListener("submit", function (e) {
    e.preventDefault();
    if ($("#selectPerfil").val() !== "default") {
        let url;
        let mensaje;
        if (opcion_usuario === 1) {
            url = "add_usuarios.do";
            mensaje = "¡Alta exitosa!";
        } else if (opcion_usuario === 2) {
            url = "update_usuarios.do";
            mensaje = "¡Modificación exitosa!";
        }

        $.ajax({
            url: url,
            type: "POST",
            data: {
                id_u: id_usuario,
                login: $("#loginUsuario").val(),
                password: $("#passwordUsuario").val(),
                id_pe: $("#selectPerfil").val()
            },
            success: function (resp, textStatus, jqXHR) {
                if (resp === "OK") {
                    notificacionExitosa(mensaje);
                    tablaUsuario.ajax.reload(null, false);
                    btnFormCancelarUsuario.click();
                } else {
                    notificarError(resp);
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }
});

btnFormCancelarUsuario.addEventListener("click", function () {
    $("#loginUsuario").val("");
    $("#passwordUsuario").val("");
    $("#selectPerfil").val("default");

    btnNuevoUsuario.click();
});

btnNuevoUsuario.addEventListener("click", function () {
    opcion_usuario = 1;
    tituloModalUsuario.innerText = "Creación de usuario";
    btnFormCancelarUsuario.click();
});

$(document).on('click', '.btnEditarUsuario', function () {
    btnNuevoUsuario.click();
    tituloModalUsuario.innerText = "Editanto usuario";
    opcion_usuario = 2;

    if (tablaUsuario.row(this).child.isShown()) {
        var data = tablaUsuario.row(this).data();
    } else {
        var data = tablaUsuario.row($(this).parents("tr")).data();
    }
    id_usuario = data['id_u'];
    $("#loginUsuario").val(data["login"]);
    $("#passwordUsuario").val(data["password"]);
    $("#selectPerfil").val(data["id_pe"]);

});

$(document).on('click', '.btnBorrarUsuario', async function () {
    if (tablaUsuario.row(this).child.isShown()) {
        var data = tablaUsuario.row(this).data();
    } else {
        var data = tablaUsuario.row($(this).parents("tr")).data();
    }

    id_usuario = data["id_u"];

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL USUARIO?',
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
                url: 'delete_usuarios.do',
                type: "POST",
                data: {
                    id_u: id_usuario
                },
                success: function (resp, textStatus, jqXHR) {
                    if (resp === "OK") {
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaUsuario.ajax.reload(null, false);
                    } else {
                        notificarError(resp);
                    }
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


/* Funciones para el CRUD de permiso modulo */

formAddPermisoModulo.addEventListener("submit", function (e) {
    e.preventDefault();
    if ($("#selectPermiso_pm").val() !== "default" && $("#selectModulo_pm").val() !== "default") {
        let url;
        let mensaje;
        if (opcion_pm === 1) {
            url = "add_permiso_modulo.do";
            mensaje = "¡Alta exitosa!";
        } else if (opcion_pm === 2) {
            url = "update_permiso_modulo.do";
            mensaje = "¡Modificación exitosa!";
        }

        $.ajax({
            url: url,
            type: "POST",
            data: {
                id_pm: id_pm,
                id_mo: $("#selectModulo_pm").val(),
                id_p: $("#selectPermiso_pm").val()
            },
            success: function (resp, textStatus, jqXHR) {
                if (resp === "OK") {
                    notificacionExitosa(mensaje);
                    tablaPermisoModulo.ajax.reload(null, false);
                    btnFormCancelarPermisoModulo.click();
                } else {
                    notificarError(resp);
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }
});

btnFormCancelarPermisoModulo.addEventListener("click", function () {
    $("#selectModulo_pm").val("default");
    $("#selectPermiso_pm").val("default");
    btnNuevoPermisoModulo.click();
});

btnNuevoPermisoModulo.addEventListener("click", function () {
    opcion_pm = 1;
    tituloModalPermisoModulo.innerText = "Creación de permiso modulo";
    btnFormCancelarPermisoModulo.click();
    limpiarSelect(selectPermiso, "Selecciona un permiso");
});

$(document).on('click', '.btnEditarPermisoModulo', function () {
    if (tablaPermisoModulo.row(this).child.isShown()) {
        var data = tablaPermisoModulo.row(this).data();
    } else {
        var data = tablaPermisoModulo.row($(this).parents("tr")).data();
    }

    btnNuevoPermisoModulo.click();
    llenarSelectPermisosDisponibles(data['id_mo']);
    tituloModalPermisoModulo.innerText = "Editanto permiso modulo";
    opcion_pm = 2;

    let option_ = document.createElement("option");
    option_.text = data['nombre_p'];
    console.log(data['nombre_p']);
    option_.value = data['id_p'];
    console.log(data['id_p']);
    console.log(option_);
    selectPermiso.appendChild(option_);

    id_pm = data['id_pm'];
    $("#selectModulo_pm").val(data["id_mo"]);
    $("#selectPermiso_pm").val(data["id_p"]);
});

$(document).on('click', '.btnBorrarPermisoModulo', async function () {
    if (tablaPermisoModulo.row(this).child.isShown()) {
        var data = tablaPermisoModulo.row(this).data();
    } else {
        var data = tablaPermisoModulo.row($(this).parents("tr")).data();
    }

    id_pm = data["id_pm"];


    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR ESTE PERMISO PARA EL MODULO?',
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
                url: 'delete_permiso_modulo.do',
                type: "POST",
                data: {
                    id_pm: id_pm,
                    id_mo: data['id_mo']
                },
                success: function (resp, textStatus, jqXHR) {
                    if (resp === "OK") {
                        notificacionExitosa("¡ Eliminación exitosa !");
                        tablaPermisoModulo.ajax.reload(null, false);
                    } else {
                        notificarError(resp);
                    }
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

function llenarSelectPermisosDisponibles(id_mo) {
    limpiarSelect(selectPermiso, 'Selecciona un permiso');
    $.ajax({
        "url": "select_pemisos_disponibles_modulo.do",
        dataType: 'json',
        data: {
            id_mo: id_mo
        },
        success: function (data, textStatus, jqXHR) {

            for (let item of data.data) {
                let option = document.createElement("option");
                option.text = item.nombre;
                option.value = item.id_p;
                option.setAttribute("data-descripcion", item.descripcion);
                selectPermiso.appendChild(option);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
}

selectModulo.addEventListener('change', function (e) {
    descripcionModuloLabel.innerText = selectModulo.options[selectModulo.selectedIndex].dataset.descripcion;
    console.log(selectModulo.options[selectModulo.selectedIndex].dataset.descripcion);
    if (selectModulo.value !== "default") {
        // LLenamos el select de permisos
        llenarSelectPermisosDisponibles(selectModulo.value);
    }else{
        descripcionModuloLabel.innerText = "";
    }
});

selectPermiso.addEventListener("change", function (e){
    //console.log(selectPermiso.options[selectPermiso.selectedIndex].dataset.descripcion);
    if (selectPermiso.value !== "default") {
        descripcionPermisoLabel.innerText = selectPermiso.options[selectPermiso.selectedIndex].dataset.descripcion;
    }else{
        descripcionPermisoLabel.innerText = "";
    }
});

function limpiarSelect(select, mensaje) {
    select.innerHTML = "";
    let optionDefault = document.createElement("option");
    optionDefault.text = mensaje;
    optionDefault.value = "default";
    select.appendChild(optionDefault);
}


/* Funciones para el modulo configuracion de pefil */

selectConfigPerfil.addEventListener("change", () => {
    $("#tablaPermisosPerfil tbody").children().remove();
    permisosPerfil = [];
    if (selectConfigPerfil.value !== "default") {
        $.ajax({
            "url": "select_permisos_perfil.do",
            dataType: 'json',
            data: {
                id_pe: selectConfigPerfil.value
            },
            success: function (data, textStatus, jqXHR) {

                for (let item of data.data) {
                    $("#tablaPermisosPerfil").find("tbody").append(`
                        <tr>    
                            <td>${item.nombreModulo}</td>
                            <td>${item.nombrePermiso}</td>
                            <td class="text-center">
                                <button data-id_pm="${item.id_pm}" data-id_mo="${item.id_mo}" type="button" class="btn btn-danger btn-sm btnEliminarPermiso">Eliminar</button>
                            </td>
                        </tr>
                    `);  
                    
                     permisosPerfil.push({
                        id_pm : item.id_pm,
                        id_mo : item.id_mo
                    });
                   
                }
                console.log(permisosPerfil);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }
});

selectConfigModulo.addEventListener("change", () => {
    limpiarSelect(selectConfigPermiso, 'Selecciona un permiso');
    if (selectConfigModulo.value !== "default") {
        $.ajax({
            "url": "select_permisos_modulo.do",
            dataType: 'json',
            data: {
                id_mo: selectConfigModulo.value
            },
            success: function (data, textStatus, jqXHR) {
               // console.log(data);

                for (let item of data.data) {
                    let option = document.createElement("option");
                    option.text = item.nombre;
                    option.value = item.id_pm;
                    console.log(option);
                    selectConfigPermiso.appendChild(option);
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }
});

btnAddPermiso.addEventListener('click', function (){
   if(selectConfigPerfil.value === "default"){
        notificarError("Selecciona un perfil");
   }else if(selectConfigModulo.value === "default"){
        notificarError("Selecciona un modulo");
   }else if(selectConfigPermiso.value === "default"){
        notificarError("Selecciona un permiso");
   }else{
       let ban = agregarPermiso(selectConfigPermiso.value,selectConfigModulo.value);
       if(ban){
           $("#tablaPermisosPerfil").find("tbody").append(`
            <tr>    
                <td>${selectConfigModulo.options[selectConfigModulo.selectedIndex].text}</td>
                <td>${selectConfigPermiso.options[selectConfigPermiso.selectedIndex].text}</td>
                <td class="text-center">
                    <button data-id_pm="${selectConfigPermiso.value}" data-id_mo="${selectConfigModulo.value}" type="button" class="btn btn-danger btn-sm btnEliminarPermiso">Eliminar</button>
                </td>
            </tr>
        `); 
       }
       console.log(permisosPerfil);
   }
});

formGuardarPermisos.addEventListener('submit', function (e){
    e.preventDefault();
    if(selectConfigPerfil.value === "default"){
        notificarError("Selecciona un perfil");
    }else{ 
        let cadena = formarCadenaPermisos();
        console.log(cadena);
        $.ajax({
            "url": "modificar_permisos_perfil.do",
            type : "POST",
            data : {
              id_pe : selectConfigPerfil.value,
              cadena_permisos : cadena
            },
            success: function (data, textStatus, jqXHR) {
                if(data === "OK"){
                    notificacionExitosa("Modificación de permisos exitosa");
                }else{
                    notificarError(data);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }
});

$(document).on('click', '.btnEliminarPermiso', function (e){
    eliminarPermiso(e.target.dataset.id_pm,e.target.dataset.id_mo);
    e.target.parentNode.parentNode.remove();
});

function eliminarPermiso(id_pm, id_mo){
    let pos = 0;
    for(let item of permisosPerfil){
        if(item !== undefined){
            if( parseInt(item.id_pm) === parseInt(id_pm) &&  parseInt(item.id_mo) === parseInt(id_mo) ){
                delete permisosPerfil[pos];
            }
        }   
        pos++;
    }
    console.log(permisosPerfil);
}

function  agregarPermiso(id_pm, id_mo){
    for(let item of permisosPerfil){
        if(item !== undefined){
            if( parseInt(item.id_pm) === parseInt(id_pm) &&  parseInt(item.id_mo) === parseInt(id_mo) ){
                return false;
            }
        }   
    }   
    permisosPerfil.push({
        id_pm : parseInt(id_pm),
        id_mo : parseInt(id_mo)
    });
    return true;
    
}

function formarCadenaPermisos(){
    let cadena = "";
    let ban = 0;
    for(let item of permisosPerfil){
        if(item !== undefined){
            if(ban === 1){
                cadena += "-";
            }
            cadena+= item.id_pm + ",";
            cadena+= item.id_mo;
            ban = 1;
        }   
    }
    return cadena;
}

/* FUNCIONES PARA LA NOTIFICACIONES DE MENSAJES */

function notificacionExitosa(mensaje) {
    Swal.fire(
            mensaje,
            '',
            'success'
            ).then(result => {
        $("#nombrePerfil").val("");
    });
}

function notificarError(mensaje) {
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    });
}



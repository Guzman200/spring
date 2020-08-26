const btnAddControl1 = document.getElementById('btnAddControl1');
const btnAddControl2 = document.getElementById('btnAddControl2');
const btnAddControl3 = document.getElementById('btnAddControl3');
const btnAddControl = document.getElementById('btnAddControl');
const selectModulo = document.getElementById("selectModulo");
const selectCampo = document.getElementById("selectCampo");
const selectConexion = document.getElementById("selectConexion");

const formMnemotecnico = document.getElementById('formMnemotecnico');

const selectControl1 = document.getElementById("selectControl1");
const selectControl2 = document.getElementById("selectControl2");
const selectControl3 = document.getElementById("selectControl3");

var tableMnemotecnico;
var controles1 = [];
var controles1_string = "";
var controles2 = [];
var controles2_string = "";
var controles3 = [];
var controles3_string = "";

var opcion; // 1 es agregar, 2 es editar

var id_e;
var id_p;
var id_mge;

/* Inicializamos la datatables */
function init() {
    tableMnemotecnico = $('#tableMnemotecnico').DataTable({
        "responsive": true,
        "autoWidth": false,
        "ajax": "select_mnemotecnico.do",
        "columns": [
            {"data": "id_mge"},
            {"data": "id_tca"},
            {"data": "nombre"},
            {"data": "mnemotecnico"},
            {"data": "label"},
            {"data": "valor_default"},
            {"data": "id_m"},
            {"data": "id_p"},
            {"data": "posicion_x"},
            {"data": "posicion_y"},
            {"data": "id_e"},
            {"data": "valor_query"},
            {"data": "id_co"},
            {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-info btn-sm btnEditar'>EDIT</button><button class='btn btn-danger btn-sm btnBorrar'>DELETE</button></div></div>"}
        ]
    });
}

function llenarSelects() {
    // Llenamos el select de modulos
    $.ajax({
        "url": "select_modulo.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
                let option = document.createElement("option");
                option.text = item.nombre;
                option.value = item.id_m;
                selectModulo.appendChild(option);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });

    // Llenamos el select de tipo campos
    $.ajax({
        "url": "select_tipoCampo.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
                let option = document.createElement("option");
                option.text = item.nombre;
                option.value = item.id_tca;
                selectCampo.appendChild(option);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
    
    // Llenamos el select de conexion
    $.ajax({
        "url": "select_conexion.do",
        dataType: 'json',
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
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

function inicializarControles(ban) {
    controles1_string = "";
    controles2_string = "";
    controles3_string = "";
    if (ban === 0) {
        controles1 = [];
        controles2 = [];
        controles3 = [];
        $("#tableControles tbody").children().remove();
    }
}

/* Formo las cadenas de String que enviare*/
function  formarControles() {
    let ban = 0;
    for (let item of controles1) {
        if (item !== undefined) {
            if (ban !== 0) {
                controles1_string += ",";
            }
            controles1_string += item.control;
            ban = 1;
        }
    }
    ban = 0;
    for (let item of controles2) {
        if (item !== undefined) {
            if (ban !== 0) {
                controles2_string += ",";
            }
            controles2_string += item.control;
            ban = 1;
        }
    }
    ban = 0;
    for (let item of controles3) {
        if (item !== undefined) {
            if (ban !== 0) {
                controles3_string += ",";
            }
            controles3_string += item.control;
            ban = 1;
        }
    }
}

/* Para limpiar el formulario cada vez que se de click para agregar uno nuevo */
btnAddControl.addEventListener('click', () => {
    opcion = 1;
    selectModulo.value = "default";
    selectCampo.value = "default";
    selectConexion.value = "default";
    $("#mnemotecnico").val("");
    $("#label").val("");
    $("#valor_defaultl").val("");
    $("#posX").val("");
    $("#posY").val("");
    $("#valor_query").val("");
    limpiarSelect(selectControl1, "Seleccione control 1");
    limpiarSelect(selectControl2, "Seleccione control 2");
    limpiarSelect(selectControl3, "Seleccione control 3");
    $("#tableControles tbody").children().remove();
    inicializarControles(0);
});

formMnemotecnico.addEventListener('submit', (e) => {
    e.preventDefault();
    let ban = validar();
    if (ban === true) {
        formarControles();
        let url;
        let mensaje;
        if (opcion === 1) {
            url = "insert_mnemotecnico.do";
            mensaje = "Alta exitosa";
        } else {
            url = "update_mnemotecnico.do";
            mensaje = "Modificación exitosa";
        }
        $.ajax({
            url: url,
            type: "POST",
            data: {
                id_tca: selectCampo.value,
                mnemotecnico: $("#mnemotecnico").val(),
                label: $("#label").val(),
                valor_default: $("#valor_default").val(),
                posx: $("#posX").val(),
                posy: $("#posY").val(),
                id_m: selectModulo.value,
                controles_1: controles1_string,
                controles_2: controles2_string,
                controles_3: controles3_string,
                id_e: id_e,
                id_p: id_p,
                id_mge: id_mge,
                id_co : selectConexion.value,
                valor_query : $("#valor_query").val()
            },
            beforeSend: function (xhr) {
            },
            success: function (resp, textStatus, jqXHR) {
                if (resp === "OK") {
                    notificacionExitosa(mensaje);
                    tableMnemotecnico.ajax.reload(null, false);
                    inicializarControles(0);
                    $("#modalAgregarMnemotecnicol").modal("hide");
                } else {
                    notificarError(resp);
                    inicializarControles(1);
                }
                console.log("Respuesta del servidor : " + resp);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }
});

function contarElementosControl(control) {
    let contador = 0;
    for (let item of control) {
        if (item !== undefined) {
            contador++;
        }
    }
    return contador;
}

function  validar() {
    if (selectCampo.value === "default") {
        notificarError("Seleeciona un tipo de campo");
        return false;
    } else if (selectModulo.value === "default") {
        notificarError("Selecciona un modulo");
        return false;
    }else if(selectConexion.value === "default"){
        notificarError("Selecciona un tipo de conexión");
        return false;
    } else {
        // Empezamos a validar que por lo menos añada un control
        let contador1 = contarElementosControl(controles1);
        let contador2 = contarElementosControl(controles2);
        let contador3 = contarElementosControl(controles3);
        if (contador1 === 0 && contador2 === 0 && contador3 === 0) {
            notificarError("Agrega por lo menos un control");
            return false;
        }
    }
    return true;
}

function llenarSelectControles1() {
    $.ajax({
        "url": "selectControlesUno_modulo.do",
        dataType: 'json',
        data: {
            id_modulo: selectModulo.value
        },
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
                let option = document.createElement("option");
                option.text = item.titulo;
                option.value = item.id_c;
                selectControl1.appendChild(option);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
}

function llenarSelectControles2() {
    $.ajax({
        "url": "selectControlesDos_modulo.do",
        dataType: 'json',
        data: {
            id_modulo: selectModulo.value
        },
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
                let option = document.createElement("option");
                option.text = item.titulo;
                option.value = item.id_t;
                selectControl2.appendChild(option);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
}

function llenarSelectControles3() {
    $.ajax({
        "url": "selectControlesTres_modulo.do",
        dataType: 'json',
        data: {
            id_modulo: selectModulo.value
        },
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
                let option = document.createElement("option");
                option.text = item.titulo;
                option.value = item.id_g;
                selectControl3.appendChild(option);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
}

/* Cuando se cambia de modulo */
selectModulo.addEventListener('change', () => {
    limpiarSelect(selectControl1, "Seleccione control 1");
    limpiarSelect(selectControl2, "Seleccione control 2");
    limpiarSelect(selectControl3, "Seleccione control 3");

    controles1 = [];
    controles2 = [];
    controles3 = [];

    $("#tableControles tbody").children().remove();

    if (selectModulo.value !== "default") {
        // Select control 1
        llenarSelectControles1();
        // Select control 2
        llenarSelectControles2();
        // Select control 3
        llenarSelectControles3();
    }
});

function limpiarSelect(select, mensaje) {
    select.innerHTML = "";
    let optionDefault = document.createElement("option");
    optionDefault.text = mensaje;
    optionDefault.value = "default";
    select.appendChild(optionDefault);
}

btnAddControl1.addEventListener('click', () => {
    if (selectControl1.value !== "default") {
        let ban = verificar(controles1, selectControl1.value);
        if (ban === true) {
            controles1.push({
                control: selectControl1.value
            });
            $("#tableControles").find("tbody").append(`
                <tr>
                    <td>
                        <button type="button" id="${selectControl1.value}" class="btn btn-danger btn-sm btnEliminarControl1">Eliminar</button>
                    </td>
                    <td>Control 1</td>
                    <td>${selectControl1.options[selectControl1.selectedIndex].text}</td>
                </tr>
            `);
            console.log(controles1);
        }
    }
});

btnAddControl2.addEventListener('click', () => {
    if (selectControl2.value !== "default") {
        let ban = verificar(controles2, selectControl2.value);
        if (ban === true) {
            controles2.push({
                control: selectControl2.value
            });
            $("#tableControles").find("tbody").append(`
                <tr>
                    <td>
                        <button type="button" id="${selectControl2.value}" class="btn btn-danger btn-sm btnEliminarControl2">Eliminar</button>
                    </td>
                    <td>Control 2</td>
                    <td>${selectControl2.options[selectControl2.selectedIndex].text}</td>
                </tr>
            `);
            console.log(controles2);
        }
    }
});

btnAddControl3.addEventListener('click', () => {
    if (selectControl3.value !== "default") {
        let ban = verificar(controles3, selectControl3.value);
        if (ban === true) {
            controles3.push({
                control: selectControl3.value
            });
            $("#tableControles").find("tbody").append(`
                <tr>
                    <td>
                        <button type="button" id="${selectControl3.value}" class="btn btn-danger btn-sm btnEliminarControl3">Eliminar</button>
                    </td>
                    <td>Control 3</td>
                    <td>${selectControl3.options[selectControl3.selectedIndex].text}</td>
                </tr>
            `);
            console.log(controles3);
        }
    }
});

$(document).on('click', '.btnEliminarControl1', function (e) {
    let pos = eliminar(controles1, e.target.id);
    delete controles1[pos];
    e.target.parentNode.parentNode.remove();
});

$(document).on('click', '.btnEliminarControl2', function (e) {
    let pos = eliminar(controles2, e.target.id);
    delete controles2[pos];
    e.target.parentNode.parentNode.remove();
});

$(document).on('click', '.btnEliminarControl3', function (e) {
    let pos = eliminar(controles3, e.target.id);
    delete controles3[pos];
    e.target.parentNode.parentNode.remove();
});

/* Cuando se presiona el boton editar */
$(document).on('click', '.btnEditar', function () {
    if (tableMnemotecnico.row(this).child.isShown()) {
        var data = tableMnemotecnico.row(this).data();
    } else {
        var data = tableMnemotecnico.row($(this).parents("tr")).data();
    }

    id_e = data['id_e'];
    id_p = data['id_p'];
    id_mge = data['id_mge'];

    // Limpiamos el modal
    btnAddControl.click();
    opcion = 2;

    selectCampo.value = data['id_tca'];
    selectModulo.value = data['id_m'];
    selectConexion.value = data['id_co'];
    $("#valor_query").val(data['valor_query']);
    $("#label").val(data['label']);
    $("#mnemotecnico").val(data['mnemotecnico']);
    $("#valor_default").val(data['valor_default']);
    $("#posX").val(data['posicion_x']);
    $("#posY").val(data['posicion_y']);
    $("#modalAgregarMnemotecnicol").modal("show");

    // Cargo en la table los controles 1
    $.ajax({
        "url": "select_controles1.do",
        dataType: 'json',
        data: {
            id_mge: id_mge
        },
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
                $("#tableControles").find("tbody").append(`
                    <tr>
                        <td>
                            <button type="button" id="${item.id_c}" class="btn btn-danger btn-sm btnEliminarControl1">Eliminar</button>
                        </td>
                        <td>Control 1</td>
                        <td>${item.titulo}</td>
                    </tr>
                `);
                controles1.push({
                    control: "" + item.id_c
                });
            }
            console.log(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });

    // Cargo en la table los controles 2
    $.ajax({
        "url": "select_controles2.do",
        dataType: 'json',
        data: {
            id_mge: id_mge
        },
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
                $("#tableControles").find("tbody").append(`
                    <tr>
                        <td>
                            <button type="button" id="${item.id_t}" class="btn btn-danger btn-sm btnEliminarControl2">Eliminar</button>
                        </td>
                        <td>Control 2</td>
                        <td>${item.titulo}</td>
                    </tr>
                `);
                controles2.push({
                    control: "" + item.id_t
                });
            }
            console.log(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });

    // Cargo en la table los controles 3
    $.ajax({
        "url": "select_controles3.do",
        dataType: 'json',
        data: {
            id_mge: id_mge
        },
        success: function (data, textStatus, jqXHR) {
            for (let item of data.data) {
                $("#tableControles").find("tbody").append(`
                    <tr>
                        <td>
                            <button type="button" id="${item.id_g}" class="btn btn-danger btn-sm btnEliminarControl3">Eliminar</button>
                        </td>
                        <td>Control 3</td>
                        <td>${item.titulo}</td>
                    </tr>
                `);
                controles3.push({
                    control: "" + item.id_g
                });
            }
            console.log(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });

    // Llenos los select de controles
    llenarSelectControles1();
    llenarSelectControles2();
    llenarSelectControles3();

});

/* Cuandos se presiona el boton eliminar */
$(document).on('click', '.btnBorrar',async  function () {
    if (tableMnemotecnico.row(this).child.isShown()) {
        var data = tableMnemotecnico.row(this).data();
    } else {
        var data = tableMnemotecnico.row($(this).parents("tr")).data();
    }

    const result = await Swal.fire({
        title: '¿ESTA SEGURO DE ELIMINAR EL MNEMOTECNICO?',
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
                url: "delete_mnemotecnico.do",
                type: "POST",
                data: {
                    id_mge: data['id_mge']
                },
                beforeSend: function (xhr) {
                },
                success: function (resp, textStatus, jqXHR) {
                    if (resp === "OK") {
                        notificacionExitosa("¡Baja exitosa!");
                        tableMnemotecnico.ajax.reload(null, false);
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

function verificar(controles, id_control) {
    for (let item of controles) {
        if (item !== undefined) {
            if (item.control === id_control) {
                return false;
            }
        }
    }
    return true;
}

function  eliminar(controles, id_control) {
    let pos = 0;
    for (let item of controles) {
        if (item !== undefined) {
            if (item.control === id_control) {
                return pos;
            }
        }
        pos++;
    }
}

function notificacionExitosa(mensaje) {
    Swal.fire(
            mensaje,
            '',
            'success'
            ).then(result => {
        $('#modalAgregarControl').modal('hide');
    });
}

function notificarError(mensaje) {
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: mensaje
    });
}


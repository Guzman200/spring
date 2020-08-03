const formAddModulo = document.getElementById('formAddModulo');
const formEditModulo = document.getElementById('formEditModulo');
const formDeleteModulo = document.getElementById('formDeleteModulo');

/** ========================================================
 *  EVENTO QUE SE EJECUTA CUANDO SE GUARDA UN NUEVO MODULO
  ========================================================== */

formAddModulo.addEventListener('submit', (e) => {
    e.preventDefault();
    alert('Agregando modulo')
})

/** ==================================================================
 *  EVENTO QUE SE EJECUTA CUANDO SE GUARDAN LOS CAMBIOS DE UN MODULO
  ==================================================================== */

formEditModulo.addEventListener('submit', (e) => {
    e.preventDefault();
    alert('Editando modulo (guardando cambios)')
})

/** ========================================================
 *  EVENTO QUE SE EJECUTA CUANDO SE ELIMINA UN MODULO
  ========================================================== */

formDeleteModulo.addEventListener('submit', (e) => {
    e.preventDefault();
    alert('Eliminando modulo definitivamente')
})

/* ===============================================================
    EVENTO QUE SE EJECUTA CUANDO SE PRESIONA EL BOTON EDITAR
 ================================================================= */

$('.tablaModulos').on('click', '.btnEdit', () => {
    alert('Editando modulo (peticion de datos)')
})


/* ===============================================================
    EVENTO QUE SE EJECUTA CUANDO SE PRESIONA EL BOTON ELIMINAR
 ================================================================= */

$('.tablaModulos').on('click', '.btnDelete', () => {
    alert('Eliminando modulo (obtenemos el id a eliminar)')
})

function initDataTable(){
    
    $(document).ready(function() {
        $("#example1").DataTable({
        "responsive": true,
        "autoWidth": false
        })
    });
        
}

initDataTable();
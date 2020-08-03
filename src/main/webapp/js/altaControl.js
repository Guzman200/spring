const formAddControl = document.getElementById('formAddControl');
const formEditControl = document.getElementById('formEditControl');
const formDeleteControl = document.getElementById('formEliminarControl');

/* ============================================================
    ENVENTO QUE SE EJECUTA CUANDO SE GUARDA UN NUEVO CONTROL
 ============================================================== */

formAddControl.addEventListener('submit', (e) => {
    e.preventDefault(); // Evita que se refresque la pagina

    alert('Agregando nuevo control');
});

/* =====================================================================
    ENVENTO QUE SE EJECUTA CUANDO SE GUARDAN LOS CAMBIOS DE UN CONTROL
 ======================================================================= */

formEditControl.addEventListener('submit', (e) => {
    e.preventDefault();

    alert('Editando control')
})

/* =====================================================================
    ENVENTO QUE SE EJECUTA CUANDO SE ELIMINAR UN CONTROL
 ======================================================================= */

formDeleteControl.addEventListener('submit', (e) => {
    e.preventDefault();
    alert('Eliminando control definitivamente')
})


/* =================================================================
    EVENTO CUANDO SE PRESIONA EL BOTON EDITAR DE LA TABLA CONTROL
 =================================================================== */

$('.tablaControl').on('click', '.btnEdit', () => {
    alert('Editando control (peticion de datos)')
})

/* =================================================================
    EVENTO CUANDO SE PRESIONA EL BOTON ELIMINAR DE LA TABLA CONTROL
 =================================================================== */

$('.tablaControl').on('click', '.btnDelete', () => {
    alert('Eliminando control (obtenemos el id)')
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
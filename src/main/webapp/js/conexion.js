const formAddConexion = document.getElementById('formAddConexion');
const formEditConexion = document.getElementById('formEditConexion');
const formDeleteConexion = document.getElementById('formEliminarConexion');

formAddConexion.addEventListener('submit', (e) => {
    e.preventDefault(),
    alert('Agregando conexion')
})

formEditConexion.addEventListener('submit', (e) => {
    e.preventDefault(),
    alert('Guardando cambios conexion')
})

formDeleteConexion.addEventListener('submit', (e) => {
    e.preventDefault(),
    alert('Eliminando conexion definitivamente')
})


$('.tablaConexion').on('click', '.btnEdit', () => {
    alert('Editando conexion (petiocion de datos)')
})

$('.tablaConexion').on('click', '.btnDelete', () => {
    alert('Eliminando conexion (obtenemos el id)')
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
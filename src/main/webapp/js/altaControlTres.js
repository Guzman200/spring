const formAddControl = document.getElementById('formAddControl');
const formEditControl = document.getElementById('formEditControl');
const formDeleteControl = document.getElementById('formEliminarControl');

formAddControl.addEventListener('submit', (e) => {
    e.preventDefault();

    alert('Guardando control');
})

formEditControl.addEventListener('submit', (e) => {
    e.preventDefault();

    alert('Editando control');
})

formDeleteControl.addEventListener('submit', (e) => {
    e.preventDefault();

    alert('Eliminando control');
})

$(".tablaControlTres").on('click', '.btnEdit', () => {
    alert('Precargando datos para editar')
})

$(".tablaControlTres").on('click', '.btnDelete', () => {
    alert('Obteniendo id para eliminar')
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
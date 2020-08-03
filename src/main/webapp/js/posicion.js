const btnAddPosicion = document.getElementById('addPosicion');

btnAddPosicion.addEventListener('click', () => {
    alert('Agregando modulo')
})


$('.tablaPosicion').on('click', '.btnEdit', () => {
    alert('Editando posicion')
})

$('.tablaPosicion').on('click', '.btnDelete', () => {
    alert('Eliminando posicion')
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
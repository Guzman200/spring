const btnAddElemento = document.getElementById('addElemento');

btnAddElemento.addEventListener('click', () => {
    alert('Agregando elementos')
})


$('.tablaElementos').on('click', '.btnEdit', () => {
    alert('Editando elemento')
})

$('.tablaElementos').on('click', '.btnDelete', () => {
    alert('Eliminando elemento')
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
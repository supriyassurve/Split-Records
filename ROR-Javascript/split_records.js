function split_entries( id ){
  var newrecrd;
  var new_record_val = jQuery("#new_duration_"+id).val();  
  var old_record_val = jQuery("#old_duration_"+id).val();
  
  var actual = $("#actual_duration"+id).val();
  var total = parseFloat(old_record_val) + parseFloat(new_record_val);
  
  if(parseFloat(actual) < total ) {
    alert("Total duration for OLD and New records can not be greater than original value");
    jQuery("#old_duration_"+id).val(actual);
    jQuery("#new_duration_"+id).val(0);
    return false; 
  }else if(parseFloat(old_record_val) < 24){
    if(new_record_val==0 || new_record_val==""){
      newrecrd = false
    }else{
      newrecrd = true
    }

    cancel_split_entry(id);

    jQuery.ajax({
      type: 'GET',
      url: '/time_records/split_entries',
      data:{
        'newrecrd' : newrecrd,
        'old_id' : id,
        'old_duration': parseFloat(old_record_val).toFixed(2),
        'new_record_val' : parseFloat(new_record_val).toFixed(2)
      },
      success: function(transport){
        window.location.reload();
      }
    });
  }else {
    alert("Duration can not be greater than 24 hrs. Enter valid duration");
    return false;
  }
}

/* this is for spliting the duration */
function split_duration_for_entry( div, id ){
  var divid = "#"+div
  var classes = jQuery(".split_box");

  jQuery(classes).each(function(){
    var thisid = $(this).parent('td').attr('id')
    var v = jQuery("#"+thisid).next().val();
    jQuery("#"+thisid).html("<a href='#' onClick=\"split_duration_for_entry('"+thisid+"', "+id+")\">Split</a>")
  });

  actual_duration = $('#split_'+id).prev('td').html();
  jQuery.ajax({
    type: 'GET',
    url: '/time_records/split_entries_div',
    data:{'record_id' : id, 'actual_duration': actual_duration},
    success: function(transform){
      jQuery(divid).html(transform);
    }
  });
}

// For canceling the entry
function cancel_split_entry( id ){
  var thisid = "split_"+id
  var v = jQuery("#"+thisid).next().val();
  jQuery("#"+thisid).html("<a href='#' onClick=\"split_duration_for_entry('"+thisid+"', "+id+")\">Split</a>")
  
}
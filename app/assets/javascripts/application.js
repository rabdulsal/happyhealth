// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs


$(function() {

	$("#tabs").tabs();

	$("#accordion").accordion({
		collapsible: true,
		active: false
	});

	$("#new_note.new_note").hide();

	$("a.createButton").on("click", function() {
		$("form").toggle("slow");
		$(".reminder").hide();
	});

	$('select#appointment_doctor').change(function(e){
		$('.row3').fadeIn("slow");
	});

	$('#appointment_appt_date').change(function(e){
		$('.row4').fadeIn("slow");
	});

	$("#appointment_appt_date").datepicker({ minDate: +0 });

	$('select#appointment_office_id').change(function(e){
	    getDoctors($(this).val());
	});

	// Rendering the individual office PDFs in the background

	// GET request for list of doctors

	function getDoctors(val){
	  if (val != '')
	  {
		var doctor = [];
		$.ajax({
		        url: "/appointment/doctors",
		        dataType:'json',
		        data: {'office_id': val},
		 		type: 'GET',
		    success: function(data){
				doctor.push("Select a doctor")
		        $.each(data, function(key, value) {
		            doctor.push(value.title);
		        });
				$('select#appointment_doctor').html('');
				$.each(doctor,function(i,o){
				        $('<option>' + o + '</option>').appendTo('select#appointment_doctor');
				    });
				$('.row2').fadeIn("slow");
		    },
		    error: function(){
		        alert('error');
		    }
		});
	  }
	}

	// Auto-closes all the dialog boxes that are rendered ******** CAN BE DRYER!! ********

	$(".mada").dialog({
		autoOpen: false,
		show: "blind",
		hide: "slide",
		modal: true
	});

	$(".clsma").dialog({
		autoOpen: false,
		show: "blind",
		hide: "slide",
		modal: true
	});

	$(".mhc").dialog({
		autoOpen: false,
		show: "blind",
		hide: "slide",
		modal: true
	});

	$(".sawlani_demographics").dialog({
		autoOpen: false,
		show: "blind",
		hide: "slide",
		modal: true
	});

	// ************** JQUERY PDF FETCH ******************

	// GET http-request for pdf name and opens it

	function getPdf(val){
	  if (val != '')
	  {
		$.ajax({
		        url: "/appointment/pdf",
		        dataType:'json', // => .mada.to_json or ._office_form.to_json etc.
		        data: {'office_id': val},
		 		type: 'GET',
		    success: function(data){
				$(data).dialog("open");
		    },
		    error: function(){
		        alert('error');
		    }
		});
	  }
	}

	// When View Form is clicked, find the id and render the pdf

	$("button#appt.createButton").on("click", function() {
		// Real Button 
		// $('p#edit-form').fadeIn("slow");
		// ********************

		// Test Button
		$(this).after(function () {
			var dnldBtn = $('p#edit-form');
			$(dnldBtn).fadeIn("slow");
		}); // Why does this open the Download button in all Accordions?!?
		// ********************

		$('.appt_tab').fadeIn("slow");
		// $('input#appt.createButton').fadeIn("slow");
		if($('select#appointment_office_id').val() != null){
			var officeId = $('select#appointment_office_id').val();
			// Used in the form process
		}
		else{
			// Real
			//$('p#edit-form').fadeIn("slow");
			// Test

			var officeId = this.value; // Accessing value attribute of button
		}
    	getPdf(officeId);
		return false;
	});

	// TOS and Privacy Policy Dialog -> Opens annoying ghost backgrounds :-(

	// $("button.pdfButton.office-form-download").click(function() {
	//     $( "p#TOS.legal" ).dialog({
	//       	// autoOpen: false,
	//       	modal: true,
	//       	buttons: [
	// 	      	{
	// 	        	text: "I agree",
	// 	        	click: function() {
	// 	          		$( this ).dialog( "close" );
	// 	          	}
	// 	        }
	// 	    ]	     
	//     });
	// });

	// PDF 'Continue' button functionality

	// $("pdf-close").on("click", function () {
	// 	{
	// 	$.ajax({
	// 	        url: "/users/:id/appointment/new",
	// 	        dataType:'json', // => .mada.to_json or ._office_form.to_json etc.
	// 	        data: {'office_id': val},
	// 	 		type: 'POST',
	// 	    success: function(data){
	// 			$(this).dialog("close");
	// 	    },
	// 	    error: function(){
	// 	        alert('error');
	// 	    }
	// 	});
	//   }

	// $( "<div>Confirmation</div>" ).dialog({
	// 	   modal:true,
	// 	   buttons: {
	// 	        "OK": function() {
	// 	             sendAjax(); //Your ajax function
	// 	             $(this).dialog( "close" );
	// 	         },
	// 	         "Cancel": function() {
	// 	             $(this).dialog( "close" );
	// 	         }
	// 	   }
	// 	});

	// ****************************************************


});
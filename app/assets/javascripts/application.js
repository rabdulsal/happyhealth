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
//= require jquery_nested_form

$(function() {

	$("#tabs").tabs();

	$("#accordion").accordion({
		collapsible: true,
		active: false
	});

	// NOTES TOGGLES *****************************

	// $("#new_note.new_note").hide();

	// $("a.createButton").on("click", function() {
	// 	$("form").toggle("slow");
	// 	$(".reminder").hide();
	// });

	// ********************************************

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

	// Close Form Dialog by clicking 'Continue' button

	$('a#continue').on("click", function() {
		$('.ui-dialog-content').dialog('close');
	});

	// Open up TOS and Privacy Policy Agreement when 'Download' button is clicked

	$('.office-form-download').on("click", function(){
		console.log(this.id);
		id = this.id.split("_")[1]
		$('div.accordion_' + id)[0].style.height = "258px";
		$('input#tos_' + id)[0].checked = false;
		$('.tos_agreement#office_' + id).fadeIn("slow");
	});

	// After checkbox is checked and 'I Agree' clicked, convert 'Downlaod' to 'Downloading...'

	$('input.submit_tos').on("click", function(){
		id = this.id;
		if($('input#tos_' + id)[0].checked){
			$('div#office_' + id).hide();
			$('button#office_' + id)[0].innerHTML = "Downloading...";
		}
		$('div.accordion_' + this.id)[0].style.height = "199px";

	});

	// Auto-closes all the Form Dialog boxes that are rendered

	$("#accordion a").on("click", function() {
		var formABRV = $(this).data("abrv");	
			$("#pdf_container." + formABRV).dialog({
				autoOpen: false,
				show: "blind",
				hide: "slide",
				modal: true
		});
	});
	
	// $(".mada").dialog({
	// 	autoOpen: false,
	// 	show: "blind",
	// 	hide: "slide",
	// 	modal: true
	// });
	
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
		    	console.log(data);
				$('.' + data).dialog("open");
		    },
		    error: function(){
		        alert('error');
		    }
		});
	  }
	}

	// When View Form is clicked, find the id and render the pdf

	$("button#appt.createButton").on("click", function() {
		if($('select#appointment_office_id').val() != null){
			var officeId = $('select#appointment_office_id').val();
			// Used in the form process
		}
		else{
			var officeId = this.value; // Accessing value attribute of button
		}
    	getPdf(officeId);
		return false;
	});

	// Close Alerts and Warnings

	$(".close").on("click", function() {
		$("#notice").fadeOut("slow");
	});

	// ************************* GENERIC DROPDOWN PANEL ***************************

	// Insurance Form logic => open Form if Profile-owner is != Insurance Policy Holder

    $('.panel-tab').on('click', function(event){
	  event.preventDefault(); 
	  $(this).closest('.panel').find('.panel-stage').slideToggle('slow', function(event){
		var panel = $(this).closest('.panel').find('.panel-text');
		var button = $(this).closest(".panel").find("#insurance-relationship-radio");
		if($(this).is(':visible')){					
			panel.html('Close');
			button.attr({"disabled": true, "checked": false});
		} else {
			panel.html('Open');
			button.removeAttr('disabled');			
		}
	  });
	});	

    // TOOLTIPS

    $(".tooltip").tooltip({    	
    	content: "Awesome title!"
    });

});
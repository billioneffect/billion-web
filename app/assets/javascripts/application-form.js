(function() {
  'use strict';

  function ApplicationForm(form) {
    setupValidation(form);
  }

  function setupValidation(form) {
    var $form = $(form);
    $form.validate();
  }

  window.ApplicationForm = ApplicationForm;

}())

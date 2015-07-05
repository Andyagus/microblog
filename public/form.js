// Running when page is loaded
window.onload = function() {
  if (!Modernizr.input.autofocus) {
    var inputs = document.getElementsByTagName('input');
    inputs[0].focus();
  };
  if (Modernizr.input.placeholder) {
    var labels = document.getElementsByTagName('label');
    for (var i = 0, j = labels.length; i < j; i++) {
      labels[i].classList.add('js-hidden');
    };
  };
  // If 'required' attribute is not supported
  if (!Modernizr.input.required) {
    var form = document.getElementById('js-form');
    var name = document.getElementById('js-name');
    var mail = document.getElementById('js-email');
    var phone = document.getElementById('js-tel');
    if (name.value.length < 1 || mail.value.length < 1 || phone.value.length < 1) {
      form.onsubmit = function() {
        return false;
      };
    };
    form.onchange = function() {
      if (name.value.length > 1 && mail.value.length > 1 && phone.value.length > 1) {
        form.onsubmit = function() {
          return true;
        };
      };
    };
    // fallback for input validation
    mail.onblur = function() {
      var mailTest = /^(([^<>()[]\.,;:s@"]+(.[^<>()[]\.,;:s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$/;
      if (mail.value == '' || !mailTest.test(mail.value)) {
        alert('Please enter valid email address.');
      }
    };
    phone.onblur = function() {
      var phoneTest = /^\(?[0-9]{3}(\-|\)) ?[0-9]{3}-[0-9]{4}$/;
      if (phone.value == '' || !phoneTest.test(phone.value)) {
        alert('Please enter valid phone.');
      }
    };
  };
};
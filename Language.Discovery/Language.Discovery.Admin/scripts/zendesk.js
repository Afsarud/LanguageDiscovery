



$(function () {
    //Change the title using Zendesk api
  
    if (window.location.pathname.substr(1).toLowerCase() != "admin/login.aspx" && window.location.pathname.substr(1).toLowerCase() != "admin/" && window.location.pathname.substr(1).toLowerCase() != "admin/login") {
       
        //Change the position using Zendesk api
        window.zESettings = {
            webWidget: {
                position: { horizontal: 'right', vertical: 'top' },
                offset: { horizontal: '220px', vertical: '-2px' },
                contactForm: {
                    title: {
                        '*': 'お問合せ・メディア投稿/Contact Us'
                    }
                }
            }
        };
    }
    else
    {
        //Change the position using Zendesk api
        window.zESettings = {
            webWidget: {
                contactForm: {
                    title: {
                        '*': 'お問合せ・メディア投稿/Contact Us'
                    }
                }
            }
        };
    }

    //Hack
    var supportWidgetExists = setInterval(function () {
        /* Wait until widget is loaded */
        if ($('#webWidget').length) {
            //Find the name field , if found hide the parent
            $("#webWidget")
                .contents()
                .find('#garden-text-field-0--input').parent().hide();

            //find the teachers field
            var text =
            $("#webWidget")
                .contents()
                .find('#garden-text-field-8--input').parent();

            //if found move to first
            $("#webWidget")
                .contents()
                .find('.src-component-submitTicket-SubmitTicketForm-formWrapper').prepend(text);

            //override the padding-left of the title so that the long text will be fit in
            $("#webWidget")
               .contents()
               .find('.u-paddingHL').attr("style", "padding-left:0px !important");

            var style = $('#launcher').attr('style'); 
            style += ';position:absolute !important;';
            $('#launcher').attr('style', style);

            clearInterval(supportWidgetExists);
        }

    }, 1000);
   
   
});
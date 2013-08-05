$(document).ready(function() {
    $("#addurl").submit(function(event){
        event.preventDefault();

        if( $("#url").val() != "" ) {
            $.ajax({
                type: "POST",
                url: "/url",
                dataType: "json",
                data: {
                    url: $("#url").val()
                }
            }).done(function( resp ) {
                if( resp && resp.result && resp.result == "success" ) {
                    if( resp.url && resp.url != null ) {
                        $("p").text( resp.url ).delay(250).fadeOut(3000,function(){
                            $("p").text("").show();
                        });
                        $("#url").val("");
                    }
                }
            });
        }
    });
});
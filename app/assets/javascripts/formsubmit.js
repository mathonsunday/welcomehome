$(function () {
  $("#guess").click(function () {
    $("#guess").toggleClass('locating');

    getCurrent(function (pos) {
      $('.currentLocationButton').removeClass('currentLocationButtonLocating');

      guessPosition(pos.coords, function (results) {
        if(results && results.length > 0){
          $.ajax({
            type: 'GET',
            url: '/homes/new',
            data: {guess: true, home: {latitude: pos.coords.latitude, longitude: pos.coords.longitude}},
            success: function(data, textStatus) {
              $(".form-container").html(data);

              $.ajax({
                type: 'GET',
                url: '/homes',
                data: {search: 'true', nearby: true, lat: pos.coords.latitude, long: pos.coords.longitude},
                success: function(data, textStatus) {
                  $('#nearby').html(data);
                }
              });
            }
          })
        }
      });
    })
  });
});

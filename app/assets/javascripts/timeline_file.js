function update_last_requests(){
  $.get("requests", function( data ) {
    var s = ''
    $.each(data, function( index, value ) {
      if (value.entities) {
        s += "<a class = 'keyword'>"+value.entities+"</a>" + '; ';
      }
    });
    s = s.substring(0, s.length - 2);
    $('.last-requests').html( s );
    $('.keyword').click(function() {
      keywords = $( this ).text();
      show_chronology(keywords);
    });
  });
};

function show_chronology(keywords) {
  document.body.style.cursor  = 'wait';
  $.post('requests',
    { request_string:keywords },
    function(data) {
      document.body.style.cursor  = 'default';
      if (data) {
        var timeline = {
          "timeline":
           {
           "headline":"Results for comparison",
           "type":"default",
           "text":"request entities",
           "startDate":"2012,1,26",
           "asset":
              {
                  "media":"/time-1.jpg",
                  "credit":"",
                  "caption":""
              },
               "date": [ ]
           }
        };

        timeline.timeline.date =  $.parseJSON(data);

        $("#time_line").empty();

        createStoryJS({
          type: 'timeline',
          width: '100%',
          height: '500',
          source:  timeline,
          embed_id: 'time_line'
        });
        update_last_requests();
      }
    },
    'json'
  );
};

$(document).ready(function() {
  var d = new Date();
  var today = d.getFullYear().toString() + "," + (d.getMonth() +1 ).toString() + "," + d.getDate().toString()

  timeline = {
      "timeline":
       {
           "headline":"Chronoscope",
           "type":"default",
            "text":"Try it!",
            "startDate":today,
            "asset":
              {
                  "media":"/time-1.jpg",
                  "credit":"",
                  "caption":""
              },
           "date": [
               {
                   "startDate":today,
                   "headline":"Great day",
                   "text":"<p>for experiments with chronoscope</p>",
                   "asset":
                   {
                       "media":"/time-2.jpg",
                       "credit":"",
                       "caption":""
                   }
               },
            ]
       }
  };



    $('.show-chronology').click(function() {
      keywords = $('#timeline form textarea').val();
      show_chronology(keywords);
      return false;
    });

    createStoryJS({
      type: 'timeline',
      width: '100%',
      height: '500',
      font: 'Lekton-Molengo',
      source: timeline, //get the events.json format from https://github.com/VeriteCo/TimelineJS#file-formats
      embed_id: 'time_line'
    });

    update_last_requests();

});

function update_last_requests(){
  $.get("requests", function( data ) {
    var s = '';
    $.each(data, function( index, value ) {
      var id = value['id'];
      if (value.entities) {
        s += "<a class = 'keyword' id="+id+">"+value.entities+"</a>" + '<br>';
      }
    });
    s = s.substring(0, s.length - 2);
    $('.last-requests').html( s );
    $('.keyword').click(function() {
      var id = $(this).attr('id');
      get_chronology(id);
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

function get_chronology(id) {
  $.get("requests/"+id, function( data ) {
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
  });
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
